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
local MODNAME 		= "Shinies-Data-Auction"
local mod	 		= Shinies : NewModule( MODNAME )
ShiniesDataAuction	= mod
mod:SetModuleType( "Data" )
mod:SetName( T["Shinies Auction Data Store"] )
mod:SetDescription(T["Provides a method of storing and retrieving historical auction data."])
mod:SetDefaults( 
{
	factionrealm =
	{
		general = 
		{
			retentiondays		= 120,
		},
		
		items = 
		{
			["*"] =
			{
				auctions 		= 
				{
					["*"] = 
					{
						price		= 0,
						stackCount	= 0,
						pricePer	= 0,
						selfAuction	= true,
						time		= nil,
					},
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

local getMedian, getMaxMin, getMean, getMode, getStdDev

local ShiniesAPI		= Shinies : GetModule( "Shinies-API-Core" )

function mod:OnInitialize()
end

function mod:OnEnable()
	ShiniesAPI.RegisterCallback( self, "OnAuctionQuerySuccess", 	"OnAuctionQuerySuccess" )
end

function mod:OnDisable()
	ShiniesAPI.UnregisterCallback( self, "OnAuctionQuerySuccess" )
end

function mod:OnAuctionQuerySuccess( eventName, identifier, query, results )
	local items 	= self.db.factionrealm.items
	
	for idx, auction in ipairs( results )
	do
		local item = items[auction.itemData.uniqueID]
		local aucData = item.auctions[auction.auctionIDLowerNum]
		
		-- We have already seen this auction, no need to process again
		if( aucData.time ~= nil ) then return end
		
		-- Store the data we need for stats
		aucData.price 			= auction.buyOutPrice
		aucData.stackCount		= auction.itemData.stackCount
		aucData.pricePer		= math.floor( aucData.price / aucData.stackCount )
		aucData.selfAuction		= ( WStringsCompare( GameData.Player.name, auction.sellerName ) == 0 )
		aucData.time			= ShiniesAPI:DateTime_GetCurrentDateTimePack()
	end
end