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
local MODNAME 		= "Shinies-API-Core"
local ShiniesAPI 	= Shinies : NewModule( MODNAME, "WAR-AceTimer-3.0" )
_G.ShiniesAPI 		= ShiniesAPI
ShiniesAPI:SetModuleType( "API" )
ShiniesAPI:SetName( T["Shinies API Core"] )
ShiniesAPI:SetDescription(T["Provides all of the necessary logic for Shinies"])
ShiniesAPI:SetDefaults( 
{
	factionrealm = {
	 	general =
		{
			throttle		= .3,
		},
		timeouts =
		{
			auction = 
			{
				["**"]			= 5,
				buy				= 5,
				cancel			= 5,
				create			= 5,
				query			= 15,				
			},
			inventory =
			{
				["**"]			= 5,
				move			= 5,
			},
		},
	},
} )
                               
ShiniesAPI.callbacks = LibStub : GetLibrary( "WAR-CallbackHandler-1.0", true ) : New( ShiniesAPI )

local tinsert 	= table.insert
local pairs		= pairs
local ipairs	= ipairs

local QUEUE_AUCTION_BUY			= 1
local QUEUE_AUCTION_CANCEL		= 2
local QUEUE_AUCTION_CREATE		= 3
local QUEUE_AUCTION_QUERY		= 4
local QUEUE_INVENTORY_MOVE		= 5

local configuration	= {
	m_InternalName 	= "ShiniesAPI",
	m_Name			= Shinies.T["Core"],
	m_WindowId		= "",
}

local generalThrottle			= 1

local serverAvailable			= nil

ShiniesAPI.STATE_SUCCESS 		= 1
ShiniesAPI.STATE_FAILURE 		= 2
ShiniesAPI.STATE_WAITING 		= 3

-- No longer used as of 0.9.5b - Zomega (2024-01-02)
local auctionHouseZones			= 
{
	[105]		= true, -- Praag
	[103]		= true, -- Chaos Wastes
	[109]		= true, -- Reikland
	[110]		= true, -- Reikwald
	[161]		= true, -- Inevitable City
	[162]		= true, -- Altdorf
	[104]		= true, -- The Maw
}

local Queues		= 
{
	[QUEUE_AUCTION_BUY]			= ShiniesQueue:Create( ShiniesAPI, "Auction_Execute_Buy", 		"Auction_Buy_Results_Check", 		"OnAuctionBuySuccess",		"OnAuctionBuyFailure", 		"OnAuctionBuyTimeout" 		),
	[QUEUE_AUCTION_CANCEL]		= ShiniesQueue:Create( ShiniesAPI, "Auction_Execute_Cancel", 	"Auction_Cancel_Results_Check", 	"OnAuctionCancelSuccess", 	"OnAuctionCancelFailure",	"OnAuctionCancelTimeout"	),
	[QUEUE_AUCTION_CREATE]		= ShiniesQueue:Create( ShiniesAPI, "Auction_Execute_Create", 	"Auction_Create_Results_Check", 	"OnAuctionCreateSuccess",	"OnAuctionCreateFailure",	"OnAuctionCreateTimeout"	),
	[QUEUE_AUCTION_QUERY]		= ShiniesQueue:Create( ShiniesAPI, "Query_Execute", 			nil, 								"OnAuctionQuerySuccess",	"OnAuctionQueryFailure", 	"OnAuctionQueryTimeout" 	),
	[QUEUE_INVENTORY_MOVE]		= ShiniesQueue:Create( ShiniesAPI, "Inventory_Execute", 		nil, 								"OnInventoryMoveSuccess",	"OnInventoryMoveFailure",	"OnInventoryMoveTimeout" 	),
}

local onUpdateTimeoutOrder = 
{
	[1]	= QUEUE_AUCTION_BUY,
	[2]	= QUEUE_AUCTION_CANCEL,
	[3]	= QUEUE_AUCTION_CREATE,
	[4]	= QUEUE_AUCTION_QUERY,
	[5]	= QUEUE_INVENTORY_MOVE,
}

local onUpdateExecuteOrder = 
{
	[1]	= QUEUE_INVENTORY_MOVE,				-- Always perform item moves first
	[2]	= QUEUE_AUCTION_BUY,
	[3]	= QUEUE_AUCTION_CANCEL,
	[4]	= QUEUE_AUCTION_CREATE,
	[5]	= QUEUE_AUCTION_QUERY,
}

local playerInventorySlotUpdatedOrder =
{
	[1]	= QUEUE_INVENTORY_MOVE,
	[2]	= QUEUE_AUCTION_CREATE,
}

local auctionSearchResultsReceivedOrder =
{
	[1]	= QUEUE_AUCTION_QUERY,
}

local auctionBidResultsReceivedOrder = {}
auctionBidResultsReceivedOrder[GameData.Auction.BUYOUT_SUCCESS] = 
{
	[1]	= QUEUE_AUCTION_BUY,
}
auctionBidResultsReceivedOrder[GameData.Auction.CANCEL_SUCCESS] = 
{
	[1]	= QUEUE_AUCTION_CANCEL,
}
auctionBidResultsReceivedOrder[GameData.Auction.BID_FAIL_BAD_BUY_OUT_PRICE] = 
{
	[1]	= QUEUE_AUCTION_BUY,
}
auctionBidResultsReceivedOrder[GameData.Auction.CANCEL_FAIL_BIDDER_EXISTS] = 
{
	[1]	= QUEUE_AUCTION_CANCEL,
}
auctionBidResultsReceivedOrder[GameData.Auction.CANCEL_FAIL_NOT_OWNER] = 
{
	[1]	= QUEUE_AUCTION_CANCEL,
}
auctionBidResultsReceivedOrder[GameData.Auction.UNKNOWN_REASON] = 
{
	[1]	= QUEUE_AUCTION_BUY,
	[2]	= QUEUE_AUCTION_CANCEL,
	[3]	= QUEUE_AUCTION_CREATE,
	[4]	= QUEUE_AUCTION_QUERY,
}
auctionBidResultsReceivedOrder[GameData.Auction.CANCEL_FAIL_UNKNOWN_REASON] = 
{
	[1]	= QUEUE_AUCTION_CANCEL,
}
auctionBidResultsReceivedOrder[GameData.Auction.BID_FAIL_MISSING_ITEM] = 
{
	[1]	= QUEUE_AUCTION_BUY,
}
auctionBidResultsReceivedOrder[GameData.Auction.BID_FAIL_ITEM_SOLD] = 
{
	[1]	= QUEUE_AUCTION_BUY,
}
auctionBidResultsReceivedOrder[GameData.Auction.CANCEL_FAIL_ITEM_SOLD] = 
{
	[1]	= QUEUE_AUCTION_CANCEL,
}
auctionBidResultsReceivedOrder[GameData.Auction.SERVER_UNAVAILABLE] = 
{
	[1]	= QUEUE_AUCTION_BUY,
	[2]	= QUEUE_AUCTION_CANCEL,
	[3]	= QUEUE_AUCTION_CREATE,
	[4]	= QUEUE_AUCTION_QUERY,
}
auctionBidResultsReceivedOrder[GameData.Auction.CREATE_AUCTION_FAILED] = 
{
	[1]	= QUEUE_AUCTION_CREATE,
}

function ShiniesAPI:GetAuctionBuyQueue() 		return Queues[QUEUE_AUCTION_BUY] end
function ShiniesAPI:GetAuctionCancelQueue() 	return Queues[QUEUE_AUCTION_CANCEL] end
function ShiniesAPI:GetAuctionCreateQueue() 	return Queues[QUEUE_AUCTION_CREATE] end
function ShiniesAPI:GetAuctionQueryQueue() 		return Queues[QUEUE_AUCTION_QUERY] end
function ShiniesAPI:GetInventoryMoveQueue() 	return Queues[QUEUE_INVENTORY_MOVE] end
 
local function WasSlotUpdated( slot, updatedSlots )
	for k,v in ipairs( updatedSlots )
	do
		if v == slot then return true end
	end
	return false
end

local function IsErrorStatus( status )
	return status == GameData.Auction.SERVER_UNAVAILABLE
            or status == GameData.Auction.CANCEL_FAIL_UNKNOWN_REASON
            or status == GameData.Auction.BID_FAIL_UNKNOWN_REASON
            or status == GameData.Auction.UNKNOWN_REASON
end

function ShiniesAPI:OnEnable()
	local db = self.db.factionrealm
	
	RegisterEventHandler( SystemData.Events.AUCTION_BID_RESULT_RECEIVED, 	"ShiniesAPI.Core_OnAuctionBidResultReceived" )
	RegisterEventHandler( SystemData.Events.AUCTION_SEARCH_RESULT_RECEIVED, "ShiniesAPI.Core_OnAuctionSearchResultReceived" )
	RegisterEventHandler( SystemData.Events.PLAYER_CRAFTING_SLOT_UPDATED, 	"ShiniesAPI.Core_OnPlayerCraftingSlotUpdated" )
	RegisterEventHandler( SystemData.Events.PLAYER_INVENTORY_SLOT_UPDATED, 	"ShiniesAPI.Core_OnPlayerInventorySlotUpdated" )
	RegisterEventHandler( SystemData.Events.PLAYER_ZONE_CHANGED, 			"ShiniesAPI.Core_OnPlayerZoneChanged" )
	
	-- Fire off the player zone changed event handler 
	ShiniesAPI.Core_OnPlayerZoneChanged()
	
	-- Cancel any of our outstanding times
	self:CancelAllTimers()
	
	--
	-- Update the timeouts on our queues
	--
	self:GetAuctionBuyQueue()		: SetTimeout( db.timeouts.auction.buy )
	self:GetAuctionCancelQueue()	: SetTimeout( db.timeouts.auction.cancel )
	self:GetAuctionCreateQueue()	: SetTimeout( db.timeouts.auction.create )
	self:GetAuctionQueryQueue()		: SetTimeout( db.timeouts.auction.query )
	self:GetInventoryMoveQueue()	: SetTimeout( db.timeouts.inventory.move )
	
	-- Set our general throttle
	generalThrottle = db.general.throttle
	
	-- Register for our update timer
	self:ScheduleRepeatingTimer( "OnUpdate", generalThrottle )
end

function ShiniesAPI:OnDisable()
	-- Cancel all of our queues
	self:ClearAllQueues()
	
	-- Cancel all of our outstanding timers
	self:CancelAllTimers()

	UnregisterEventHandler( SystemData.Events.AUCTION_BID_RESULT_RECEIVED, 		"ShiniesAPI.Core_OnAuctionBidResultReceived" )
	UnregisterEventHandler( SystemData.Events.AUCTION_SEARCH_RESULT_RECEIVED, 	"ShiniesAPI.Core_OnAuctionSearchResultReceived" )
	UnregisterEventHandler( SystemData.Events.PLAYER_CRAFTING_SLOT_UPDATED, 	"ShiniesAPI.Core_OnPlayerCraftingSlotUpdated" )
	UnregisterEventHandler( SystemData.Events.PLAYER_INVENTORY_SLOT_UPDATED, 	"ShiniesAPI.Core_OnPlayerInventorySlotUpdated" )
	UnregisterEventHandler( SystemData.Events.PLAYER_ZONE_CHANGED, 				"ShiniesAPI.Core_OnPlayerZoneChanged" )
end

function ShiniesAPI:OnDebugHandler( event, itemId, item )
	Shinies:Debug( "[Shinies Core] - " .. event )
end

function ShiniesAPI:OnUpdate()
	--
	-- Check if any of our queues have timed out executions
	--
	for _, queueIdx in ipairs( onUpdateTimeoutOrder )
	do
		local queue = Queues[queueIdx]
		if( queue ~= nil ) then
			if( queue:GetExecuting() ) then
				queue:IncrementExecuteTime( generalThrottle )
				if( queue:IsTimedOut() ) then
					Shinies:Debug( L"Queue Timed Out: "  .. towstring( queueIdx ) )
					local item = queue:PopFront()
					if( item ~= nil ) then
						self.callbacks:Fire( queue:GetTimeoutCallback(), item._identifier, item )
					end
				end
			end
		end
	end
	
	-- 
	-- Check if any of our queues have something to execute
	-- 
	for _, queueIdx in ipairs( onUpdateExecuteOrder )
	do
		local queue = Queues[queueIdx]
		if( queue ~= nil ) then
			if( not queue:GetExecuting() and not queue:IsEmpty() ) then
				local item = queue:Front()
				
				local state, reason = queue:CallExecuteFunction( item )
				
				if( state == ShiniesAPI.STATE_SUCCESS ) then
					queue:SetExecuting( true )
					return
				elseif( state == ShiniesAPI.STATE_FAILURE ) then
					queue:PopFront()
					self.callbacks:Fire( queue:GetFailureCallback(), item._identifier, item, nil, reason ) 
				elseif( state == ShiniesAPI.STATE_WAITING ) then
					-- Do nothing
					if reason ~= nil then
						--[===[@debug@
						Shinies:Debug( L"Queue Waiting: "  .. towstring( reason ) )
						--@end-debug@]===]
					end
				else
					-- If this happens pop it from the queue so we dont continue to try to execute it
					queue:PopFront()
					Shinies:Debug( L"Unhandled ShiniesAPI State: "  .. towstring( state ) )
				end
			end
		end
	end
end

function ShiniesAPI.Core_OnAuctionSearchResultReceived( resultsData )
	self = ShiniesAPI

	Shinies:Debug( "Core_OnAuctionSearchResultReceived:   results size: " .. tostring( #resultsData ) )
	
	for _, queueIdx in ipairs( auctionSearchResultsReceivedOrder )
	do
		local queue = Queues[queueIdx]
		if( queue ~= nil ) then
			if( queue:GetExecuting() and not queue:IsEmpty() ) then
				local item = queue:PopFront()
				if( item ~= nil ) then
					self.callbacks:Fire( queue:GetSuccessCallback(), item._identifier, item, resultsData )
				end
			end
		end
	end
end

function ShiniesAPI.Core_OnPlayerInventorySlotUpdated( updatedSlots )
	self = ShiniesAPI
	
	Shinies:Debug( "Core_OnPlayerInventorySlotUpdated" )
	
	for _, queueIdx in ipairs( playerInventorySlotUpdatedOrder )
	do
		local queue = Queues[queueIdx]
		if( queue ~= nil ) then
			if( queue:GetExecuting() and not queue:IsEmpty() ) then
				local item = queue:Front()
				if( item ~= nil ) then
					if( WasSlotUpdated( item.slot, updatedSlots ) ) then
						queue:PopFront()
						self.callbacks:Fire( queue:GetSuccessCallback(), item._identifier, item )
					end
				end
			end
		end
	end
end

function ShiniesAPI.Core_OnPlayerCraftingSlotUpdated( updatedSlots )
	ShiniesAPI.Core_OnPlayerInventorySlotUpdated( updatedSlots )
end

function ShiniesAPI.Core_OnAuctionBidResultReceived( resultsData )
	self = ShiniesAPI
	
	Shinies:Debug( "Core_OnAuctionBidResultReceived" )
	
	local queueOrder = auctionBidResultsReceivedOrder[resultsData.result]
	local resultInfo = ShiniesConstants.AUCTION_RESULTS[resultsData.result]
	
	if queueOrder == nil or resultInfo == nil then
		Shinies:Debug( "Core_OnAuctionBidResultReceived: received unhandled result:" .. towstring( resultsData.result ) )
		
		--
		-- This really should not happen, as all cases should be handled properly.  If this does happen
		-- all queues will be cleared and we will abort.
		--
		self:ClearAllQueues()
		
		return
	end
	
	local isErrorStatus = IsErrorStatus( resultsData.result )
	
	for _, queueIdx in ipairs( queueOrder )
	do
		local queue = Queues[queueIdx]
		if( queue ~= nil ) then
			if( queue:GetExecuting() and not queue:IsEmpty() ) then
				local item = queue:Front()
				
				-- Check to see if this result set matches our queued item
				local state, reason = queue:CallResultsCheckFunction( item, resultsData )
				
				-- If the results check passes or if the server is not available remove the item from the queue
				if( ( state == ShiniesAPI.STATE_SUCCESS ) or isErrorStatus ) then
					item = queue:PopFront()
				end
				
				-- Fire the appropriate callback
				if( resultInfo.success ) then
					self.callbacks:Fire( queue:GetSuccessCallback(), item._identifier, item )
				else
					self.callbacks:Fire( queue:GetFailureCallback(), item._identifier, item, resultsData, resultInfo.text )
				end
			end
			
			-- Regardless if the queue is executing, we want to clear any queues if we see an error status
			if( isErrorStatus ) then
				break
			end
		end
	end
	
	if( isErrorStatus ) then
		Shinies:Debug( "Core_OnAuctionBidResultReceived: SERVER_UNAVAILABLE   Queues have been cleared!" )
		self:ClearAllQueues()
	end
end

function ShiniesAPI:ClearAllQueues()
	for _, queue in ipairs( Queues )
	do
		-- Iterate all of the queued actions and call their failure callback
		while queue:GetCount() > 0
		do
			local item = queue:PopFront()
			self.callbacks:Fire( queue:GetFailureCallback(), item._identifier, item, nil, nil )	
		end
	end
	Shinies:Debug( "All queues have been cleared!" )
end

function ShiniesAPI:DeepCopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, _copy( getmetatable(object)))
    end
    return _copy(object)
end

function ShiniesAPI:DeepCopyWithMeta(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

function ShiniesAPI:IsServerAvailable()
	return serverAvailable == true
end

function ShiniesAPI.Core_OnPlayerZoneChanged( zoneId )
	self = ShiniesAPI
	
  --[[

  -- 0.9.6 - Zomega (2024-01-02)

  For some reason K8P on ROR still does not work and returns an empty
  GetCampaignZoneData table when loading. To fix this, the add-on is now being
  even more aggressive and just always saying the AH is enabled even in
  meaningless zones.

	local currentStatus = serverAvailable
	
	if( zoneId == nil ) then
		local zoneData = GetCampaignZoneData( GameData.Player.zone )
		
		if( zoneData ~= nil ) then
			zoneId = zoneData.zoneId
		end
	end
	
	-- If the zone ID is still nil, flag the AH as not available
	if( zoneId == nil ) then
		serverAvailable = false
	else
    -- No longer used as of 0.9.5b - Zomega (2024-01-02)
		--serverAvailable = auctionHouseZones[zoneId] ~= nil	

    -- Always available as of 0.9.5b
    serverAvailable = true
	end
	
	-- Only fire the callback if the status changed
	if( currentStatus ~=  serverAvailable ) then
		self.callbacks:Fire( "OnAuctionHouseAvailabilityChanged", serverAvailable )
	end

  ]]

  serverAvailable = true

  self.callbacks:Fire( "OnAuctionHouseAvailabilityChanged", serverAvailable )
  
end