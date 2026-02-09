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

local queryId		= 1

--
-- This function takes a query object and places it into the queue
-- to be executed against the auction house
-- The queryId is returned to the user which they can use as a
-- reference on all applicable callbacks
--
function ShiniesAPI:Query_Create( query )
	if( query == nil ) then return 0 end
	
	if( not self:IsServerAvailable() ) then return 0 end
	
	queryId = queryId + 1
	
	-- Store the info we will need when the results come in
	query._identifier 	= queryId
	
	-- Add the query to our queue
	self:GetAuctionQueryQueue() : PushBack( query )
	
	return queryId
end

--
-- This function creates a default query object
--
function ShiniesAPI:Query_CreateQueryObject()
	local queryData = {}
	
	queryData.minItemLevel			= ShiniesConstants.MIN_ITEM_LEVEL
	queryData.maxItemLevel    		= ShiniesConstants.MAX_ITEM_LEVEL
	
	queryData.career				= 0
	queryData.restrictionType		= GameData.Auction.RESTRICTION_NONE
	queryData.minTradeSkillLevel	= 0
	queryData.maxTradeSkillLevel 	= 0
	queryData.minRarity				= SystemData.ItemRarity.UTILITY
	
	queryData.itemTypes				= {}
	queryData.itemEquipSlots		= {}
	queryData.itemBonuses			= {}
	queryData.itemName				= L""
	queryData.sellerName			= L""
	
	return queryData
end

--
-- This function returns the identifier of a query, or nil if the query is invalid
--
function ShiniesAPI:Query_GetIdentifier( query )
	if( query ~= nil ) then return query._identifier end
	return nil
end

--
-- This function creates a query for the item name specified
-- The queryId is returned to the user which they can use as a
-- reference on all applicable callbacks
--
function ShiniesAPI:Query_SingleItem( itemName )
	local query 		= ShiniesAPI:Query_CreateQueryObject()
	query.itemName 		= itemName
	return self:Query_Create( query ) 
end

--
-- This function creates and queues a query for the current players auctions
-- The queryId is returned to the user which they can use as a
-- reference on all applicable callbacks
--
function ShiniesAPI:Query_PlayerAuctions()
	local query 		= ShiniesAPI:Query_CreateQueryObject()
	query.sellerName 	= GameData.Player.name
	return self:Query_Create( query ) 
end

--
-- This function executes a query with the give query object
--
function ShiniesAPI:Query_Execute( ... )
	Shinies:Debug( "ShiniesAPI:Query_Execute" )
	local query = ...
	
	SendAuctionSearch( 	query.minItemLevel, 
						query.maxItemLevel,    
						query.career, 
						query.restrictionType, 
						query.minTradeSkillLevel, 
						query.maxTradeSkillLevel,
						query.minRarity,
						 
						query.itemTypes, 
						query.itemEquipSlots, 
						query.itemBonuses,
						 
						query.itemName, 
						query.sellerName )
        	
    return ShiniesAPI.STATE_SUCCESS
end