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

--
-- This function returns the auction deposit required for an item
--
function ShiniesAPI:Item_GetAuctionDeposit( itemData )
	local price = math.floor( itemData.sellPrice * GameData.Auction.DEPOSIT_MULTIPLIER )
	if price < 1 then price = 1 end 
	return price
end    

--
-- This function returns the minimal auctoin price for an item
-- required for the user to break even
--
function ShiniesAPI:Item_GetMimimalAuctionPrice( itemData )
	return self:Item_GetVendorPrice( itemData ) * GameData.Auction.DEPOSIT_MULTIPLIER
end

-- 
-- This funtion returns the profit potential of an item
-- based upon the given price
function ShiniesAPI:Item_GetProfitOverVendor( itemData, price )
	local depositPrice = self:Item_GetAuctionDeposit( itemData )   
    if depositPrice < 1 then depositPrice = 1 end
    local vendorPrice = ShiniesAPI:Item_GetVendorPrice( itemData ) 
	if( vendorPrice < 0 ) then vendorPrice = 0 end
	return ( price - vendorPrice - depositPrice )
end  

--
-- This function returns the price a vendor will pay for an item.
-- If it is not sellable it will return 0.
--
function ShiniesAPI:Item_GetVendorPrice( itemData )
	if( itemData ~= nil and self:Item_IsVendorSellable( itemData ) ) then
		return itemData.sellPrice
	end
	return 0	
end

function ShiniesAPI:Item_IsValid( itemData )
	-- Copied from EA_Window_Backpack.ValidItem
    return ( itemData ~= nil and ( (itemData.uniqueID ~= 0) or (itemData.type == GameData.ItemTypes.QUEST ) ) )
end

--
-- This function check if the given item comes from a valid cursor source
--
function ShiniesAPI:Item_IsValidCursorSource( source )
	return source == Cursor.SOURCE_INVENTORY or source == Cursor.SOURCE_CRAFTING_ITEM
end  

--
-- This function returns if the given item is sellable to a vendor
--
function ShiniesAPI:Item_IsVendorSellable( itemData )
	return itemData ~= nil and not itemData.flags[GameData.Item.EITEMFLAG_NO_SELL]
end    

--
-- This function returns if the given item is a crafting item
--                            
function ShiniesAPI:Item_IsCraftingItem( itemData )
	return itemData ~= nil and itemData.craftingBonus[1] ~= nil 
end 