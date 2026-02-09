--[[
	This application is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    The applications is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with the applications.  If not, see <http://www.gnu.org/licenses/>.
--]]


local Shinies 		= _G.Shinies
local ShiniesAPI 	= Shinies : GetModule( "Shinies-API-Core" )
local T		    	= Shinies.T

local auctionId			= 1

--
-- This function creates an auction for the specified item, stack count,
-- price and restriction.
--
-- It performs no sanity checks on the data provided
--
-- The auctionId is returned to the user which they can use as a
-- reference on all applicable callbacks
--
--
function ShiniesAPI:Auction_Create( itemData, stackCount, price, restriction )
	if( not self:IsServerAvailable() ) then return 0 end
	
	local auction = {}
	
	auctionId 				= auctionId + 1
	
	auction.itemData		= itemData
	auction.stackCount		= stackCount
	auction.price		 	= price
	auction.restriction 	= restriction
	auction._identifier 	= auctionId
	
	self:GetAuctionCreateQueue() : PushBack( auction )
	
	return auctionId
end

--
-- This function cancels an auction with the specified auction data
--
function ShiniesAPI:Auction_Cancel( auctionData )
	if( not self:IsServerAvailable() ) then return 0 end
	
	local auction = {}
	
	auctionId 		= auctionId + 1
	
	auction.auctionIDHigherNum		= auctionData.auctionIDHigherNum
	auction.auctionIDLowerNum		= auctionData.auctionIDLowerNum
	auction.revision				= auctionData.revision
	auction._identifier 			= auctionId
	
	self:GetAuctionCancelQueue() : PushBack( auction )
	
	return auctionId
end

--
-- This function executes a buy for the specified auction data
--
function ShiniesAPI:Auction_Buy( auctionData )
	if( not self:IsServerAvailable() ) then return 0 end
	
	local auction = {}
	
	auctionId 		= auctionId + 1
	
	auction.auctionIDHigherNum		= auctionData.auctionIDHigherNum
	auction.auctionIDLowerNum		= auctionData.auctionIDLowerNum
	auction.revision				= auctionData.revision
	auction.buyOutPrice				= auctionData.buyOutPrice
	auction._identifier 			= auctionId
	
	self:GetAuctionBuyQueue() : PushBack( auction )
	
	return auctionId
end

--
-- This function compares two auctions to see if they are the same
--
function ShiniesAPI:Auction_Compare( a, b )
	if( a.auctionIDHigherNum == b.auctionIDHigherNum and a.auctionIDLowerNum == b.auctionIDLowerNum ) then
		return ShiniesAPI.STATE_SUCCESS
	end
	return ShiniesAPI.STATE_FAILURE
end

--
-- This function returns if there are currently queued buy auctions
--
function ShiniesAPI:Auction_HasQueuedBuyAuctions()
	return not self:GetAuctionBuyQueue() : IsEmpty()
end

--
-- This function returns if there are currently queued create auctions
--
function ShiniesAPI:Auction_HasQueuedCreateAuctions()
	return not self:GetAuctionCreateQueue() : IsEmpty()
end

--
-- This function returns if there are currently queued cancel auctions
--
function ShiniesAPI:Auction_HasQueuedCancelAuctions()
	return not self:GetAuctionCancelQueue() : IsEmpty()
end

--
-- This function executes an auction buy with the give auction object
--
function ShiniesAPI:Auction_Execute_Buy( ... )
	Shinies:Debug( "ShiniesAPI:Auction_Execute_Buy" )
	local auction = ...
	BuyAuction( auction.auctionIDHigherNum, auction.auctionIDLowerNum, auction.revision, auction.buyOutPrice )
	return ShiniesAPI.STATE_SUCCESS
end

--
-- This function executes an auction cancel with the give auction object
--
function ShiniesAPI:Auction_Execute_Cancel( ... )
	Shinies:Debug( "ShiniesAPI:Auction_Execute_Cancel" )
	local auction = ...
	CancelAuction( auction.auctionIDHigherNum, auction.auctionIDLowerNum, auction.revision )
	return ShiniesAPI.STATE_SUCCESS
end

--
-- This function executes an auction create with the give auction information.  This function
-- uses the provided auction information to create the proper inventory stacks for auctions
--
function ShiniesAPI:Auction_Execute_Create( ... )
	Shinies:Debug( "ShiniesAPI:Auction_Execute_Create" )
	-- Do not execute an auction create if there are pending moves
	if( not self:GetInventoryMoveQueue():IsEmpty() ) then return ShiniesAPI.STATE_WAITING, T["Auction_Execute_Create was called with an inventory move pending."] end
	
	local auction = ...

	-- Verify the player has enough money to cover the deposit for the auction
	if( Player.GetMoney() < ShiniesAPI:Item_GetAuctionDeposit( auction.itemData ) * auction.stackCount ) then
		return ShiniesAPI.STATE_FAILURE, T["Not enough gold to pay the auction deposit."]
	end 

	-- See if we have an item slotted of the proper stack size
	local source, slot = self:Inventory_GetItemSlotByStackCount( auction.itemData.uniqueID, auction.stackCount )

	-- If the slot is > 0 we have a slot
	if( source ~= nil and slot > 0 ) then
		auction.slot 		= slot
		auction.source 		= source
		Shinies:Debug( "(Auction_Execute_Create) Slot: " .. tostring( slot ) .. " Source: " .. tostring( source ) .. " Price: " .. tostring( auction.price ) .. " Restriction: " .. tostring( auction.restriction ) )
		CreateAuction( 		slot, 
							ShiniesConstants.AUCTION_ITEMLOC_TO_BACKPACK[source], 
							auction.price,
							auction.restriction )
	else
		-- Attempt to create the size stack we need
		local result, reason = self:Inventory_CreateItemStack( auction.itemData, auction.stackCount )
		
		if( result == ShiniesAPI.STATE_FAILURE ) then
			-- We arent able to achieve the destired stack, so pull the auction
			return ShiniesAPI.STATE_FAILURE, reason
		else
			return ShiniesAPI.STATE_WAITING
		end
	end
	
	return ShiniesAPI.STATE_SUCCESS
end

--
-- This function compares two auction buy results to see if they are the same
--
function ShiniesAPI:Auction_Buy_Results_Check( ... )
	local auction, results  = ...
	return ShiniesAPI:Auction_Compare( auction, results )
end

--
-- This function compares two auction cancel results to see if they are the same
--
function ShiniesAPI:Auction_Cancel_Results_Check( ... )
	local auction, results  = ...
	return ShiniesAPI:Auction_Compare( auction, results )
end

--
-- This function compares two auction create results to see if they are the same
--
function ShiniesAPI:Auction_Create_Results_Check( ... )
	return ShiniesAPI.STATE_SUCCESS
end