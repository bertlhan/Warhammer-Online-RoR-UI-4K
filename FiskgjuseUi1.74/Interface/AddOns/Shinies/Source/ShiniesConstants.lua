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

if not ShiniesConstants then ShiniesConstants = {} end

local towstring 		= towstring
local ShiniesConstants 	= ShiniesConstants
local pairs 			= pairs
local ipairs			= ipairs
local tsort				= table.sort
local tinsert			= table.insert
local string_format 	= string.format

local T 				= LibStub( "WAR-AceLocale-3.0" ) : GetLocale( "Shinies" )

function ShiniesConstants.Initialize()

	ShiniesConstants.MIN_ITEM_LEVEL			= 1
	ShiniesConstants.MAX_ITEM_LEVEL			= 40
	ShiniesConstants.MIN_TRADE_SKILL_LEVEL 	= 0
	ShiniesConstants.MAX_TRADE_SKILL_LEVEL 	= 200

	ShiniesConstants.ICON_CHECKED 		= L"<icon57>"
	ShiniesConstants.ICON_UNCHECKED 	= L"<icon58>"
	
	--
	-- This is used to convert item locations to backpack types.
	--
	ShiniesConstants.AUCTION_ITEMLOC_TO_BACKPACK =
	{
		[GameData.ItemLocs.INVENTORY] 		= EA_Window_Backpack.TYPE_INVENTORY,
		[GameData.ItemLocs.CRAFTING_ITEM]	= EA_Window_Backpack.TYPE_CRAFTING,
		--[GameData.ItemLocs.CURRENCY_ITEM]	= EA_Window_Backpack.TYPE_CURRENCY,   -- Not sure if this is needed for now
	}
	
	ShiniesConstants.AUCTION_DURATIONS = 
	{
		[0]	= {	text = L"2h" 	},	-- Not sure what this should be, however, I saw it once so setting it to 2h for shits and giggles.
		[1]	= {	text = L"8h"	},
		[2]	= {	text = L"24h" },
		[3]	= {	text = L"48h" },
		[4]	= {	text = L"72h"	},
	}
	
	--[[
		NOTE:  THE ORDER OF THESE ENTRIES MATTER.  ADD NEW ONES TO THE END
	--]]
	ShiniesConstants.AUCTION_RESTRICTIONS =
	{
		[1] = {	text = GetStringFromTable( "AuctionHouseStrings",  StringTables.AuctionHouse.CONTEXT_MENU_ADDITIONAL_FILTERS_UNRESTRICTED ),	value = GameData.Auction.RESTRICTION_NONE,    					},  
	    [2] = {	text = GetStringFromTable( "AuctionHouseStrings",  StringTables.AuctionHouse.CONTEXT_MENU_ADDITIONAL_FILTERS_ALLIANCE ),   		value = GameData.Auction.RESTRICTION_GUILD_ALLIANCE_ONLY,    	},  
	    [3] = {	text = GetStringFromTable( "AuctionHouseStrings",  StringTables.AuctionHouse.CONTEXT_MENU_ADDITIONAL_FILTERS_GUILD ),      		value = GameData.Auction.RESTRICTION_GUILD_ONLY,    			},
	}
	
	ShiniesConstants.AUCTION_RESTRICTIONS_LOOKUP = {}
	for k, v in pairs( ShiniesConstants.AUCTION_RESTRICTIONS )
	do
		ShiniesConstants.AUCTION_RESTRICTIONS_LOOKUP[v.value] = v.text	
	end
	
	--[[
		These are the localized definitions for the status provided
	--]]
	ShiniesConstants.AUCTION_RESULTS =
	{		
		[GameData.Auction.BID_SUCCESS]					= { success = true, 	text = T["Auction bid:  successful"] },
		[GameData.Auction.BUYOUT_SUCCESS]				= { success = true, 	text = T["Auction buyout:  successful"] },
		[GameData.Auction.CANCEL_SUCCESS]				= { success = true, 	text = T["Auction cancel:  successful"] },
		[GameData.Auction.BID_FAIL_BAD_BUY_OUT_PRICE]	= { success = false, 	text = T["Auction buyout failed:  bad buyout price"] },
		[GameData.Auction.CANCEL_FAIL_BIDDER_EXISTS]	= { success = false, 	text = T["Auction cancel failed:  auction has a bidder"] },
		[GameData.Auction.CANCEL_FAIL_NOT_OWNER]		= { success = false, 	text = T["Auction cancel failed:  not the owner of the auction"] },
		[GameData.Auction.UNKNOWN_REASON]				= { success = false, 	text = T["Unknown reason"] },
		[GameData.Auction.CANCEL_FAIL_UNKNOWN_REASON]	= { success = false, 	text = T["Auction cancel failed:  unknown reason"] },
		[GameData.Auction.BID_FAIL_MISSING_ITEM]		= { success = false, 	text = T["Auction bid failed:  missing item"] },
		[GameData.Auction.BID_FAIL_ITEM_SOLD]			= { success = false, 	text = T["Auction bid failed:  item was sold"] },
		[GameData.Auction.CANCEL_FAIL_ITEM_SOLD]		= { success = false, 	text = T["Auction cancel failed:  item was sold"] },
		[GameData.Auction.SERVER_UNAVAILABLE]			= { success = false, 	text = T["The auction house is not currently available in your region."] },
		[GameData.Auction.CREATE_AUCTION_FAILED]		= { success = false, 	text = T["Auction create failed:  unknown reason"] },
	}
	
	ShiniesConstants.RARITY =
	{
		[1]	= { text = T["-Any Rarity-"],											value = SystemData.ItemRarity.UTILITY, },
		[2]	= { text = GameDefs.ItemRarity[SystemData.ItemRarity.COMMON].desc,		value = SystemData.ItemRarity.COMMON, },
		[3]	= { text = GameDefs.ItemRarity[SystemData.ItemRarity.UNCOMMON].desc,	value = SystemData.ItemRarity.UNCOMMON, },
		[4]	= { text = GameDefs.ItemRarity[SystemData.ItemRarity.RARE].desc,		value = SystemData.ItemRarity.RARE, },
		[5]	= { text = GameDefs.ItemRarity[SystemData.ItemRarity.VERY_RARE].desc,	value = SystemData.ItemRarity.VERY_RARE, },
		[6]	= { text = GameDefs.ItemRarity[SystemData.ItemRarity.ARTIFACT].desc,	value = SystemData.ItemRarity.ARTIFACT, },
	}
	
	ShiniesConstants.RARITY_LOOKUP = {}
	for k, v in pairs( ShiniesConstants.RARITY )
	do
		ShiniesConstants.RARITY_LOOKUP[v.value] = v.text	
	end
	
	ShiniesConstants.CAREERS_ORDER =
	{
 		{   text = T["-Any Career-"],										value = 0, },
 		{   text = CareerNames[GameData.CareerLine.IRON_BREAKER].name,		value = GameData.CareerLine.IRON_BREAKER, },  
		{   text = CareerNames[GameData.CareerLine.RUNE_PRIEST].name,		value = GameData.CareerLine.RUNE_PRIEST, },  
		{   text = CareerNames[GameData.CareerLine.ENGINEER].name,			value = GameData.CareerLine.ENGINEER, },  
		{	text = CareerNames[GameData.CareerLine.KNIGHT].name,			value = GameData.CareerLine.KNIGHT, },
		{   text = CareerNames[GameData.CareerLine.WITCH_HUNTER].name,		value = GameData.CareerLine.WITCH_HUNTER, },  
		{   text = CareerNames[GameData.CareerLine.BRIGHT_WIZARD].name,		value = GameData.CareerLine.BRIGHT_WIZARD, },  
		{   text = CareerNames[GameData.CareerLine.WARRIOR_PRIEST].name,	value = GameData.CareerLine.WARRIOR_PRIEST, },  
		{   text = CareerNames[GameData.CareerLine.SWORDMASTER].name,		value = GameData.CareerLine.SWORDMASTER, },  
		{   text = CareerNames[GameData.CareerLine.SHADOW_WARRIOR].name,	value = GameData.CareerLine.SHADOW_WARRIOR, },  
		{   text = CareerNames[GameData.CareerLine.ARCHMAGE].name,			value = GameData.CareerLine.ARCHMAGE, },   
		{	text = CareerNames[GameData.CareerLine.WHITE_LION].name,		value = GameData.CareerLine.WHITE_LION, },
		{   text = CareerNames[GameData.CareerLine.SLAYER].name,			value = GameData.CareerLine.SLAYER, },
	}
	tsort( ShiniesConstants.CAREERS_ORDER, function( a, b ) return ( towstring(a.text) < towstring(b.text) ) end )
	
	ShiniesConstants.CAREERS_ORDER_LOOKUP = {}
	for k, v in pairs( ShiniesConstants.CAREERS_ORDER )
	do
		ShiniesConstants.CAREERS_ORDER_LOOKUP[v.value] = v.text	
	end
	
	ShiniesConstants.CAREERS_DESTRUCTION =
	{
		{   text = T["-Any Career-"],									value = 0, },
		{   text = CareerNames[GameData.CareerLine.BLACK_ORC].name,		value = GameData.CareerLine.BLACK_ORC, }, 
        {   text = CareerNames[GameData.CareerLine.SHAMAN].name,		value = GameData.CareerLine.SHAMAN, }, 
        {   text = CareerNames[GameData.CareerLine.SQUIG_HERDER].name,	value = GameData.CareerLine.SQUIG_HERDER, }, 
        {   text = CareerNames[GameData.CareerLine.MARAUDER].name,		value = GameData.CareerLine.MARAUDER, }, 
        {   text = CareerNames[GameData.CareerLine.CHOSEN].name,		value = GameData.CareerLine.CHOSEN, }, 
        {   text = CareerNames[GameData.CareerLine.ZEALOT].name,		value = GameData.CareerLine.ZEALOT, }, 
        {   text = CareerNames[GameData.CareerLine.WITCH_ELF].name,		value = GameData.CareerLine.WITCH_ELF, }, 
        {   text = CareerNames[GameData.CareerLine.DISCIPLE].name,		value = GameData.CareerLine.DISCIPLE, }, 
        {   text = CareerNames[GameData.CareerLine.SORCERER].name,		value = GameData.CareerLine.SORCERER, },  
        {	text = CareerNames[GameData.CareerLine.MAGUS].name,			value = GameData.CareerLine.MAGUS, },
        {	text = CareerNames[GameData.CareerLine.BLACKGUARD].name,	value = GameData.CareerLine.BLACKGUARD, },
        { 	text = CareerNames[GameData.CareerLine.CHOPPA].name,		value = GameData.CareerLine.CHOPPA, },
	}
	tsort( ShiniesConstants.CAREERS_DESTRUCTION, function( a, b ) return ( towstring(a.text) < towstring(b.text) ) end )
	
	ShiniesConstants.CAREERS_DESTRUCTION_LOOKUP = {}
	for k, v in pairs( ShiniesConstants.CAREERS_DESTRUCTION )
	do
		ShiniesConstants.CAREERS_DESTRUCTION_LOOKUP[v.value] = v.text	
	end
	
		
	--
	-- Build our modifiers from the full BonusTypes list
	--
	ShiniesConstants.MODIFIERS = {}
	for k,v in pairs( BonusTypes )
	do
		if( k == 0 ) then
			tinsert( ShiniesConstants.MODIFIERS, { text=T["-Any Modifier-"], value=k } )
		else
			tinsert( ShiniesConstants.MODIFIERS, { text=v.name, value=k } )
		end	
	end
	tsort( ShiniesConstants.MODIFIERS, function( a, b ) return ( towstring(a.text) < towstring(b.text) ) end )
	
	--
	-- Build our item types from the full ItemTypes list
	--
	ShiniesConstants.ITEM_TYPES = {}
	tinsert( ShiniesConstants.ITEM_TYPES, { text=T["-Any Item Type-"], value=0 } ) 
	for k,v in pairs( ItemTypes )
	do
		tinsert( ShiniesConstants.ITEM_TYPES, { text=v.name, value=k } )
	end
	tsort( ShiniesConstants.ITEM_TYPES, function( a, b ) return ( towstring(a.text) < towstring(b.text) ) end )
	
	--
	-- Build our item slots from the full ItemSlots list
	--
	ShiniesConstants.ITEM_SLOTS = {}
	tinsert( ShiniesConstants.ITEM_SLOTS, { text=T["-Any Item Slot-"], value=0 } ) 
	for k,v in pairs( ItemSlots )
	do
		tinsert( ShiniesConstants.ITEM_SLOTS, { text=v.name, value=k } )
	end
	tsort( ShiniesConstants.ITEM_SLOTS, function( a, b ) return ( towstring(a.text) < towstring(b.text) ) end )
end	



