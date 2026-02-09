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
local MODNAME 		= "Shinies-Data-Inventory"
local mod	 		= Shinies : NewModule( MODNAME, "WAR-AceTimer-3.0" )
ShiniesDataInventory	= mod
mod:SetModuleType( "Data" )
mod:SetName( T["Shinies Item Data Store"] )
mod:SetDescription( T["Provides a method of storing and retrieving current inventory and bank information."] )
mod:SetDefaults( 
{
	factionrealm =
	{
		chars = 
		{
			["**"] =									-- char slot
			{
				locs = 
				{
					["**"] =							-- item loc 
					{
						["**"] =						-- slot
						{
							uniqueID	= 0,
							stackCount	= 0,
						},
					},
				},
				items = 
				{
					["**"] =							-- item id
					{
						["**"] = 						-- item loc
						{
							["**"] = false				-- slot
						},
					
					},
				},
				totals 		= 
				{
					["**"] = 							-- itemLoc
					{
						["**"] =						-- item id
						{
							count		= 0,
						},
					},
				},
			},
		},
	},
} )

ShiniesDataInventory.callbacks = LibStub : GetLibrary( "WAR-CallbackHandler-1.0", true ) : New( ShiniesDataInventory )

local new, del, wipe = Shinies.new, Shinies.del, Shinies.wipe

local pairs 				= pairs
local ipairs				= ipairs
local tinsert				= table.insert

local ShiniesAPI		= Shinies : GetModule( "Shinies-API-Core" )

local allItemSets = {}
allItemSets[GameData.ItemLocs.INVENTORY] 		= { data = DataUtils.GetItems }						-- 3
allItemSets[GameData.ItemLocs.BANK] 			= { data = DataUtils.GetBankData }					-- 4
allItemSets[GameData.ItemLocs.CRAFTING_ITEM] 	= { data = DataUtils.GetCraftingItems }				-- 30
allItemSets[GameData.ItemLocs.CURRENCY_ITEM] 	= { data = DataUtils.GetCurrencyItems }				-- 31

--
--  The playerSets table and nonPlayerSets table are subsets of the allItemSets table.
-- 		An entry can only exist in the playerSets or nonPlayerSets
--
local playerSets = {}		-- These are the items on the player, and do not require a specific location to access
playerSets[GameData.ItemLocs.INVENTORY]			= allItemSets[GameData.ItemLocs.INVENTORY]
playerSets[GameData.ItemLocs.CRAFTING_ITEM]		= allItemSets[GameData.ItemLocs.CRAFTING_ITEM]
playerSets[GameData.ItemLocs.CURRENCY_ITEM]		= allItemSets[GameData.ItemLocs.CURRENCY_ITEM]

local nonPlayerSets = {}
nonPlayerSets[GameData.ItemLocs.BANK]			= allItemSets[GameData.ItemLocs.BANK]

local processItemSlotUpdated, processItemLoc, clearItemLoc

local invData

local pendingProcessing		= new()

local pendingTime			= 0.5

function mod:GetCharacterItemInfo( charSlot, itemId )
	local characterInventoryCount = 0
	local totalInventoryCount = 0
	
	-- Select the given characters database
	local chardb = self.db.factionrealm.chars[charSlot]
				   
	-- Get the count in the current player inventory count
	for itemLoc, _ in pairs( playerSets )
	do
		characterInventoryCount = characterInventoryCount + chardb.totals[itemLoc][itemId].count	
	end
	
	-- Get the current total inventory count
	totalInventoryCount = characterInventoryCount
	for itemLoc, _ in pairs( nonPlayerSets )
	do
		totalInventoryCount = totalInventoryCount + chardb.totals[itemLoc][itemId].count	
	end
	
	return characterInventoryCount, totalInventoryCount
end

function mod:OnInitialize()
end

function mod:OnEnable()
	RegisterEventHandler( SystemData.Events.INTERACT_OPEN_BANK, 				"ShiniesDataInventory.OnInteractBankOpen" )
	RegisterEventHandler( SystemData.Events.PLAYER_BANK_SLOT_UPDATED, 			"ShiniesDataInventory.OnPlayerBankSlotUpdated" )
	RegisterEventHandler( SystemData.Events.PLAYER_INVENTORY_SLOT_UPDATED, 		"ShiniesDataInventory.OnPlayerInventorySlotUpdated" )
	RegisterEventHandler( SystemData.Events.PLAYER_CRAFTING_SLOT_UPDATED, 		"ShiniesDataInventory.OnPlayerCraftingSlotUpdated" )
	RegisterEventHandler( SystemData.Events.PLAYER_CURRENCY_SLOT_UPDATED, 		"ShiniesDataInventory.OnPlayerCurrencySlotUpdated" )
	
	-- Create the basing pending processing tables we need
	for k, v in pairs( allItemSets )
	do
		pendingProcessing[k] = new()	
	end
	
	-- Update our database for easy access
	invData = self.db.factionrealm.chars[GameData.Account.SelectedCharacterSlot]

	-- Schedule a prlayer data update	
	ShiniesDataInventory:ScheduleTimer( "UpdatePlayerData", 1 )
end

function mod:OnDisable()
	UnregisterEventHandler( SystemData.Events.INTERACT_OPEN_BANK, 				"ShiniesDataInventory.OnInteractBankOpen" )
	UnregisterEventHandler( SystemData.Events.PLAYER_BANK_SLOT_UPDATED, 		"ShiniesDataInventory.OnPlayerBankSlotUpdated" )
	UnregisterEventHandler( SystemData.Events.PLAYER_INVENTORY_SLOT_UPDATED, 	"ShiniesDataInventory.OnPlayerInventorySlotUpdated" )
	UnregisterEventHandler( SystemData.Events.PLAYER_CRAFTING_SLOT_UPDATED, 	"ShiniesDataInventory.OnPlayerCraftingSlotUpdated" )
	UnregisterEventHandler( SystemData.Events.PLAYER_CURRENCY_SLOT_UPDATED, 	"ShiniesDataInventory.OnPlayerCurrencySlotUpdated" )
end

function ShiniesDataInventory.OnInteractBankOpen()
	-- We only clear the items we have stored here, as
	-- we will receive slot updates for all of the items in the bank
	-- right after this event which will handle the updates
	clearItemLoc( GameData.ItemLocs.BANK )
end

function ShiniesDataInventory.OnPlayerBankSlotUpdated( updatedSlots )
	-- Add the updated slots to the processing queue
	tinsert( pendingProcessing[GameData.ItemLocs.BANK], updatedSlots )
	
	ShiniesDataInventory:ScheduleTimer( "OnProcessingTimer", pendingTime )
end

function ShiniesDataInventory.OnPlayerInventorySlotUpdated( updatedSlots )
	-- Add the updated slots to the processing queue
	tinsert( pendingProcessing[GameData.ItemLocs.INVENTORY], updatedSlots )
	
	ShiniesDataInventory:ScheduleTimer( "OnProcessingTimer", pendingTime )
end

function ShiniesDataInventory.OnPlayerCraftingSlotUpdated( updatedSlots )
	-- Add the updated slots to the processing queue
	tinsert( pendingProcessing[GameData.ItemLocs.CRAFTING_ITEM], updatedSlots )
	
	ShiniesDataInventory:ScheduleTimer( "OnProcessingTimer", pendingTime )
end

function ShiniesDataInventory.OnPlayerCurrencySlotUpdated( updatedSlots )
	-- Add the updated slots to the processing queue
	tinsert( pendingProcessing[GameData.ItemLocs.CURRENCY_ITEM], updatedSlots )
	
	ShiniesDataInventory:ScheduleTimer( "OnProcessingTimer", pendingTime )
end

function mod:OnProcessingTimer()
	for itemLoc, locData in pairs( pendingProcessing )
	do
		for _, slots in ipairs( locData )
		do
			processItemSlotUpdated( itemLoc, slots )	
		end
		wipe(locData)
	end
end

function mod:UpdatePlayerData()
	for itemLoc, v in pairs( playerSets )
	do
		processItemLoc( itemLoc )	
	end
end

---------------------------------------------------------
-- LOCAL FUNCTIONS
---------------------------------------------------------

function clearItemLoc( itemLoc )
	-- Clear all tables for this item loc
	invData.totals[itemLoc] 	= nil
	invData.locs[itemLoc]		= nil
	for id, item in pairs( invData.items )
	do
		item[itemLoc] = nil
	end
end

function processItemLoc( itemLoc )
	-- Clear the info for this item loc
	clearItemLoc( itemLoc )

	-- Attempt to retrieve our data
	local data = allItemSets[itemLoc].data()
	if( data ~= nil ) then
		-- Iterate the data we received and process accordingly	
		for slot, item in ipairs( data )
		do
			processItemSlotUpdated( itemLoc, {slot} )
		end		
	end
end

function processItemSlotUpdated( itemLoc, updatedSlots )
	local oldItem
	local newItem

	-- Iterate the updated slots
	for idx, slot in ipairs( updatedSlots )
	do
		-- Get the old item id in the updated inventory slot
		oldItem = invData.locs[itemLoc][slot]
		
		-- Get the current item in the slot
		newItem = DataUtils.GetItemData( itemLoc, slot )
		
		local isOldValid = oldItem ~= nil and ShiniesAPI:Item_IsValid( oldItem )
		local isNewValid = newItem ~= nil and ShiniesAPI:Item_IsValid( newItem )
		
		-- If the old item is valid, remove the information for it
		if( isOldValid ) then
			-- Remove the old slot information
			invData.locs[itemLoc][slot] = nil
			invData.items[oldItem.uniqueID][itemLoc][slot] = nil
			invData.totals[itemLoc][oldItem.uniqueID].count = invData.totals[itemLoc][oldItem.uniqueID].count - oldItem.stackCount
		end	 
		
		-- If the new item is valid, add its slot information
		if( isNewValid ) then
			-- Update our location map
			invData.locs[itemLoc][slot].uniqueID 	= newItem.uniqueID
			invData.locs[itemLoc][slot].stackCount	= newItem.stackCount
			
			-- Update the item map
			invData.items[newItem.uniqueID][itemLoc][slot] = true

			-- Update the totals for each location
			invData.totals[itemLoc][newItem.uniqueID].count = invData.totals[itemLoc][newItem.uniqueID].count + newItem.stackCount				
		end
		
	end
end