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
local T		    	= Shinies.T
local ShiniesAPI 	= Shinies : GetModule( "Shinies-API-Core" )

local tinsert 		= table.insert

local moveId		= 1

local function ripairs(t)
  local max = 1
  while t[max] ~= nil do
    max = max + 1
  end
  local function ripairs_it(t, i)
    i = i-1
    local v = t[i]
    if v ~= nil then
      return i,v
    else
      return nil
    end
  end
  return ripairs_it, t, max
end

--
-- This function attempts to create an item stack of the desired size. 
--
function ShiniesAPI:Inventory_CreateItemStack( itemData, desiredStackCount )
	Shinies:Debug( "ShiniesAPI:Inventory_CreateItemStack" )
	if( itemData == nil ) then
		d( "Inventory_CreateItemStack received nil item data" ) 
		return false 
	end
	
	-- Check to see if the desired stack count is allow for the item type
	if( desiredStackCount > itemData.capacity ) then
		return ShiniesAPI.STATE_FAILURE, T["The desired stack count exceeds what is allowed for the item."]
	end
	
	local itemId = itemData.uniqueID
	
	-- Check if the player has the items available in their inventory to get the destired stack count
	local totalCount = self:Inventory_TotalItemCount( itemId  )
	if( totalCount < desiredStackCount ) then
		return ShiniesAPI.STATE_FAILURE, T["Not enough space in the players inventory for the desired stacks size."]
	end
	
	-- Check to see if there is already an item w/ the proper stack count
	local currentSource, currentSlot, _ = self:Inventory_GetItemSlotByStackCount( itemId, desiredStackCount )
	if( currentSource > 0 and currentSlot > 0 ) then
		return ShiniesAPI.STATE_SUCCESS
	end
	
	-- If we have made it this far, we may have to do stack manipulation, so verify
	-- that we have enough available slots in the users inventory
	local availableSource, availableSlot = self:Inventory_GetAvailableSlot()
	if( availableSource == 0 or availableSlot == 0 ) then
		return ShiniesAPI.STATE_FAILURE, T["No available slots in the players inventory."]
	end
	
	-- Get the slots that the items are available in
	local items = self:Inventory_GetItemSlots( itemId )
	
	-- Handle the items accordingly
	if( #items > 0 ) then
		-- Order the items based upon stack size
		table.sort( items, function( a, b ) if a.stackCount == b.stackCount then return a.slot > b.slot end return a.stackCount < b.stackCount end )
		
		-- If the first stack has enough to cover the desired amount, unstack off of that
		if( items[1].stackCount > desiredStackCount ) then
			self:Inventory_MoveItem( items[1].loc, items[1].slot, availableSource, availableSlot, desiredStackCount )
			return ShiniesAPI.STATE_SUCCESS	
		elseif( #items > 1 ) then
			-- Check if the first 2 stacks exceed what we need for a stack count
			if( items[1].stackCount + items[2].stackCount > desiredStackCount ) then
				local difference = desiredStackCount - items[1].stackCount 
				-- Move the difference from item slot 2 to item slot 1
				self:Inventory_MoveItem( items[2].loc, items[2].slot, items[1].loc, items[1].slot, difference )
				return ShiniesAPI.STATE_SUCCESS
			else
				-- The 2 stacks didnt help so combine them
				self:Inventory_MoveItem( items[2].loc, items[2].slot, items[1].loc, items[1].slot, items[2].stackCount )
				return ShiniesAPI.STATE_SUCCESS
			end
		else
			return ShiniesAPI.STATE_FAILURE, T["ShiniesAPI:Inventory_CreateItemStack item check passed, but item query failed?"]
		end
	else
		return ShiniesAPI.STATE_FAILURE, T["Not able to find the desired item in the players inventory."]
	end
	
	return ShiniesAPI.STATE_FAILURE, T["Unknown error in ShiniesAPI:Inventory_CreateItemStack"]
end

--
-- This function returns the next available inventory slot
--
function ShiniesAPI:Inventory_GetAvailableSlot()
	local itemSets = {}
	tinsert( itemSets, { loc = GameData.ItemLocs.INVENTORY, data=DataUtils.GetItems() } )
	tinsert( itemSets, { loc = GameData.ItemLocs.CRAFTING_ITEM, data=DataUtils.GetCraftingItems() } )

	for _, set in ipairs( itemSets )
	do
		for slot, item in ripairs( set.data )
		do
			if( item.uniqueID == 0 ) then
				return set.loc, slot
			end
		end
	end
	
	return 0, 0
end

--
-- This function returns a list of slots containing the given item
--
function ShiniesAPI:Inventory_GetItemSlots( itemId )
	local foundItems = {}
	
	if( itemId == nil ) then
		d( "Inventory_GetItemSlots received nil item data" )
		return foundItems
	end

	local itemSets = {}
	tinsert( itemSets, { loc = GameData.ItemLocs.INVENTORY, data=DataUtils.GetItems() } )
	tinsert( itemSets, { loc = GameData.ItemLocs.CRAFTING_ITEM, data=DataUtils.GetCraftingItems() } )
	
	for _, set in ipairs( itemSets )
	do
		for slot, item in ipairs( set.data )
		do
			if( itemId == item.uniqueID ) then
				local foundItem = {}
				foundItem.loc	= set.loc
				foundItem.slot 	= slot
				foundItem.stackCount = item.stackCount
				table.insert( foundItems, foundItem )
			end
		end
	end

	return foundItems
end

--
-- This function attempts to find an inventory slot with the given item and stack size
--
function ShiniesAPI:Inventory_GetItemSlotByStackCount( itemId, stackCount )
	if( itemId == nil ) then
		d( "Inventory_GetItemSlotByStackCount received nil item data" )
		return 0, 0
	end
	
	local itemSets = {}
	tinsert( itemSets, { loc = GameData.ItemLocs.INVENTORY, data=DataUtils.GetItems() } )
	tinsert( itemSets, { loc = GameData.ItemLocs.CRAFTING_ITEM, data=DataUtils.GetCraftingItems() } )
	
	for _, set in ipairs( itemSets )
	do
		for slot, item in ripairs( set.data )
		do
			if( itemId == item.uniqueID and stackCount == item.stackCount ) then
				return set.loc, slot
			end
		end
	end
	
	return 0, 0
end

--
-- This function retrieves the total number of unused iventory slots in a players inventory
--
function ShiniesAPI:Inventory_TotalAvailableSlots()
	local count	= 0
	
	local itemSets = {}
	tinsert( itemSets, { loc = GameData.ItemLocs.INVENTORY, data=DataUtils.GetItems() } )
	--tinsert( itemSets, { loc = GameData.ItemLocs.CRAFTING_ITEM, data=DataUtils.GetCraftingItems() } )
	
	for _, set in ipairs( itemSets )
	do
		for slot, item in ipairs( set.data )
		do
			if( item.uniqueID == 0 ) then
			count = count + 1
			end
		end
	end
	return count
end

--
-- This function retrieves the total number of an item are in the players inventory
--
function ShiniesAPI:Inventory_TotalItemCount( itemId )
	if( itemId == nil ) then
		d( "Inventory_TotalItemCount received nil item data" ) 
		return 0 
	end
	
	local count	= 0
	
	local itemSets = {}
	tinsert( itemSets, { loc = GameData.ItemLocs.INVENTORY, data=DataUtils.GetItems() } )
	tinsert( itemSets, { loc = GameData.ItemLocs.CRAFTING_ITEM, data=DataUtils.GetCraftingItems() } )
	
	for _, set in ipairs( itemSets )
	do
		for slot, item in ipairs( set.data )
		do
			if( itemId == item.uniqueID ) then
				count = count + item.stackCount
			end
		end
	end
	
	return count
end

--
-- This function queues up the moving of an item from one slot to another in a players inventory
--
function ShiniesAPI:Inventory_MoveItem( currentSource, currentSlot, destinationSource, destinationSlot, stackCount )
	local move = {}
	
	moveId = moveId + 1
	
	move.currentSource 		= currentSource
	move.currentSlot 		= currentSlot
	move.destinationSource	= destinationSource
	move.destinationSlot	= destinationSlot
	move.slot				= destinationSlot 				-- this is used by the core engine
	move.source				= destinationSource             -- this might be used by the core engine in the future
	move.stackCount 		= stackCount
	move._identifier 		= moveId
	
	self:GetInventoryMoveQueue() : PushBack( move )
	
	return moveId
end

function ShiniesAPI:Inventory_Execute( move )
	Shinies:Debug( "ShiniesAPI:Inventory_Execute" )
	RequestMoveItem( move.currentSource, move.currentSlot, move.destinationSource, move.destinationSlot, move.stackCount )
	return ShiniesAPI.STATE_SUCCESS
end
