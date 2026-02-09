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
    
    
    Portions of this file are from:
    	http://lua-users.org/wiki/SimpleStats
--]]

local Shinies 		= _G.Shinies
local T		    	= Shinies.T
local MODNAME 		= "Shinies-Stat-Basic"
local mod	 		= Shinies : NewModule( MODNAME )
mod:SetModuleType( "Stat" )
mod:SetName( T["Shinies Basic Statistical Module"] )
mod:SetDescription(T["Provides basic statistical calculations on item prices."])
mod:SetDefaults( 
{
	factionrealm =
	{
		items = 
		{
			["**"] =
			{
				init				= false,
				auctions = 
				{
					["**"] = 
					{
						price		= 0,
						stackCount	= 0,
						pricePer	= 0,
						selfAuction	= true,
					},
				},
				stats = 
				{
					init			= false,
					median			= 0,
					max				= 0,
					min				= 0,
					mean			= 0,
					mode			= 0,
				},
			},
		},
	},
} )

local new, del, wipe = Shinies.new, Shinies.del, Shinies.wipe

local pairs 				= pairs
local ipairs				= ipairs
local tsort					= table.sort
local tinsert				= table.insert
local mfloor				= math.floor

local getMedian, getMaxMin, getMean, getMode, getStdDev

local ShiniesAPI		= Shinies : GetModule( "Shinies-API-Core" )

function mod:GetItemStats( itemData )
	-- Check if we have data for this item
	local item 	= self.db.factionrealm.items[itemData.uniqueID]
	
	if( item == nil or item.init == false ) then return nil end
	
	return item.stats
end

function mod:OnEnable()
	ShiniesAPI.RegisterCallback( self, "OnAuctionQuerySuccess", 	"OnAuctionQuerySuccess" )
end

function mod:OnDisable()
	ShiniesAPI.UnregisterCallback( self, "OnAuctionQuerySuccess" )
end

function mod:OnAuctionQuerySuccess( eventName, identifier, query, results )
	local updatedItems = new()
	
	local items 	= self.db.factionrealm.items
	
	for idx, auction in ipairs( results )
	do
		local aucData = items[auction.itemData.uniqueID].auctions[auction.auctionIDLowerNum]
		
		-- Verify the price is zero, otherwise we have already seen this auction so no need to process further
		if( aucData.price == 0 ) then
			-- Store the data we need for stats
			aucData.price 			= auction.buyOutPrice
			aucData.stackCount		= auction.itemData.stackCount
			aucData.pricePer		= math.floor( aucData.price / aucData.stackCount )
			aucData.selfAuction		= ( WStringsCompare( GameData.Player.name, auction.sellerName ) == 0 )
			
			-- Add this item to our list of updated items, so we can update the stats on them near the end
			updatedItems[auction.itemData.uniqueID] = true
		end
	end
	
	-- Process any updated items
	for itemId, _ in pairs( updatedItems )
	do
		-- Update the items stats
		self:UpdateItemStats( itemId )
	end
	
	del(updatedItems)
end

function mod:UpdateItemStats( itemId )
	local item 	= self.db.factionrealm.items[itemId]
	
	local totalCount = 0

	-- Flag that the stats for this item are viable
	item.init = true
	
	-- Create the tables we need
	local data = new()
	
	--
	-- Generate the statistical information
	--
	for _, auctions in pairs( item.auctions )
	do
		-- Perform our sum operations here
		totalCount = totalCount + 1		
		
		-- Perform our table operations here
		tinsert( data, auctions.pricePer )
	end
	
	item.stats.totalCount = totalCount
	
	-- Perform our aggregate calculations here
	item.stats.median 				= mfloor( getMedian( data ) )
	item.stats.max, item.stats.min 	= mfloor( getMaxMin( data ) )
	item.stats.mean					= mfloor( getMean( data ) )
	
	local mode 						= getMode( data )
	if( mode ~= nil and mode[1] ~= nil ) then
		item.stats.mode = mfloor( mode[1] )
		del(mode)
	else
		item.stats.mode = 0
	end
	
	-- Clean up our tables
	del(data)
end

function getMedian( numlist )
    if type(numlist) ~= 'table' then return 0 end
    table.sort(numlist)
    if #numlist %2 == 0 then return (numlist[#numlist/2] + numlist[#numlist/2+1]) / 2 end
    return numlist[math.ceil(#numlist/2)]
end

-- Get the mean value of a table
function getMean( t )
	local sum = 0
	local count= 0
	
	for k,v in pairs(t) do
		if type(v) == 'number' then
		  sum = sum + v
		  count = count + 1
		end
	end
	
	return (sum / count)
end

-- Get the mode of a table.  Returns a table of values.
-- Works on anything (not just numbers).
function getMode( t )
  local counts= new()

	for k, v in pairs( t ) do
		if counts[v] == nil then
		  	counts[v] = 1
		else
		  	counts[v] = counts[v] + 1
		end
	end
	
	local biggestCount = 0
	
	for k, v  in pairs( counts ) do
		if v > biggestCount then
		  	biggestCount = v
		end
	end
	
	local temp = new()
	
	for k,v in pairs( counts ) do
		if v == biggestCount then
		  	table.insert( temp, k )
		end
	end
	
	del(counts )
	
	return temp
end
    
-- Get the standard deviation of a table
function getStdDev( t )
  local m
  local vm
  local sum = 0
  local count = 0
  local result

  m = getMean( t )

  for k,v in pairs(t) do
    if type(v) == 'number' then
      vm = v - m
      sum = sum + (vm * vm)
      count = count + 1
    end
  end

  result = math.sqrt(sum / (count-1))

  return result
end

-- Get the max and min for a table
function getMaxMin( t )
  local max = -math.huge
  local min = math.huge

  for k,v in pairs( t ) do
    if type(v) == 'number' then
      max = math.max( max, v )
      min = math.min( min, v )
    end
  end

  return max, min
end
