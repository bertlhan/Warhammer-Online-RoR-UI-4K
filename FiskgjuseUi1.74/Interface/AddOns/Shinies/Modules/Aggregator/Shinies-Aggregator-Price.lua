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
local MODNAME 		= "Shinies-Aggregator-Price"
local mod	 		= Shinies : NewModule( MODNAME )
mod:SetModuleType( "Aggregator" )
mod:SetName(T["Shinies Pricing Aggregator"] )
mod:SetDescription(T["Provides a general interface into pricing modules"] )
mod:SetDefaults( 
{
	factionrealm =
	{
		pricing =
		{
			modules	= 
			{
				["Shinies-Price-Match"] = 
				{
					priority 	= 1,
					enabled 	= true,
				},
				["Shinies-Price-Flat"] = 
				{
					priority 	= 2,
					enabled 	= true,
				},
				["Shinies-Price-Multiplier"] = 
				{
					priority 	= 3,
					enabled 	= true,
				},
				["**"] =
				{
					priority 	= 0,
					enabled 	= false,
				},
			},
		},
	},
} )

local new, del, wipe = Shinies.new, Shinies.del, Shinies.wipe

local rebuildLookupTables

-- We maintain a few lookup tables here to speed up processing of the data
local moduleLookup		= new()
local configLookup		= new()
local priorityToConfig	= new()
local priorityToModule	= new()

local function iter( modules, id )
	local id, config = next( modules, id )
	
	if not id then
		return nil
	end
	
	if( not config.enabled ) then
		return iter( modules, id )
	end
	
	local module = priorityToModule[id]
	
	if( module == nil ) then
		return iter( modules, id )
	end
	
	return id, module
end

function mod:ClearFixedItemPrice( item )
	for _,module in Shinies:IterateModulesOfType("Price") do
		if( module:IsFixedPriceModule() ) then
			module:ClearItemPrice( item )
			break
		end
	end
end

function mod:GetFixedItemPrice( item )
	for _,module in Shinies:IterateModulesOfType("Price") do
		if( module:IsFixedPriceModule() ) then
			return module:GetItemPrice( item )
		end
	end
	
	return 0
end

function mod:GetItemPrice( item, results )
	if( item == nil or item.uniqueID == nil or results == nil ) then
		Shinies:Debug( "GetItemPrice - Invalid arguments" ) 
		return 0, L"" 
	end
	
	local price 		= 0
	local name 			= L""
	local displayName 	= L""
	
	for priority, module in self:IterateConfiguredPriceModules()
	do
		price = module:GetItemPrice( item, results )
		
		if( price > 0 ) then
			name = module:GetName()
			displayName = module:GetDisplayName() 
			break 
		end
	end
	
	return price, name, displayName 
end

function mod:GetItemPriceForModule( item, results, modName )
	if( item == nil or item.uniqueID == nil or results == nil ) then return 0, L"" end
	
	local price 		= 0
	local name 			= L""
	local displayName 	= L""
	
	local module = moduleLookup[modName]
	
	if( module ~= nil ) then
		price = module:GetItemPrice( item, results )
		
		if( price > 0 ) then
			name = module:GetName()
			displayName = module:GetDisplayName() 
		end
	end
	
	return price, name, displayName
end

function mod:IterateConfiguredPriceModules()
	return iter, priorityToConfig 
end

function mod:GetItemPrices( item, results )
	if( item == nil or item.uniqueID == nil or results == nil ) then return {} end
	
	local prices = new()
	
	for _,module in Shinies:IterateModulesOfType("Price") do
		prices[module:GetName()] = module:GetItemPrice( item, results )		 				
	end 
	
	return prices
end

function mod:GetLowestPriority()
	return #priorityToConfig
end

function mod:GetModuleConfig( modName )
	if( configLookup[modName] ~= nil ) then
		return configLookup[modName].priority, configLookup[modName].enabled
	end
	
	return 0, false
end

function mod:SetModuleConfig( modName, priority, enabled )	
	if( configLookup[modName] ~= nil ) then
		configLookup[modName].priority = priority
		configLookup[modName].enabled = enabled
	end
end

function mod:SetItemPrice( item, price )
	for _,module in Shinies:IterateModulesOfType("Price") do
		module:SetItemPrice( item, price )
	end 
end

function mod:OnAllModulesEnabled()
	rebuildLookupTables()
end

function mod:SetFixedItemPrice( item, price )
	for _,module in Shinies:IterateModulesOfType("Price") do
		if( module:IsFixedPriceModule() ) then
			module:SetItemPrice( item, price )
			break
		end
	end 
end

----------------------------------
-- LOCAL FUNCTIONS
----------------------------------
function rebuildLookupTables()
	if( moduleLookup == nil ) 		then	moduleLookup 		= new() 	else wipe( moduleLookup ) 		end
	if( priorityToModule == nil ) 	then	priorityToModule 	= new() 	else wipe( priorityToModule ) 	end
	if( priorityToConfig == nil ) 	then	priorityToConfig 	= new() 	else wipe( priorityToConfig ) 	end
	if( configLookup == nil ) 		then	configLookup 		= new() 	else wipe( configLookup ) 		end
	
	local priorityCount = 0
	
	-- Iterate over the enabled pricing modules to build our runtime configuration
	for name, data in pairs( mod.db.factionrealm.pricing.modules ) 
	do
		-- Check if we have already loaded a module for this priority
			-- This should never happen, but just in case
		if( priorityToModule[data.priority] == nil ) then
			local module = Shinies:GetModule( name, true )
		
			-- If we were successful in getting the module, build our module
			-- and config lookups
			if( module ~= nil and module:IsEnabled() and not module:IsFixedPriceModule() ) then
				moduleLookup[name] 					= module
				configLookup[name] 					= data
				priorityToConfig[data.priority] 	= data
				priorityToModule[data.priority] 	= module
				priorityCount = priorityCount + 1 
			end
		else
			-- TODO: ADD DEBUGGING DISPLAY HERE
			d( "Two modules configured with the same priority!?!?" )
		end
	end
	
	-- Add configuration information for modules that do not exist
	for _,module in Shinies:IterateModulesOfType("Price") do
		if( not module:IsFixedPriceModule() ) then
			local modName = module:GetName()
			
			-- If there is no config for this module, lets make one
			if( configLookup[modName] == nil ) then
				priorityCount = priorityCount + 1
				
				local data = mod.db.factionrealm.pricing.modules[modName]
				-- Set the priority to the current count of the lookup table
				data.priority = priorityCount
				
				-- Add the config to our lookups
				moduleLookup[modName] 				= module
				configLookup[modName] 				= data
				priorityToConfig[data.priority] 	= data
				priorityToModule[data.priority] 	= module 
			end
		end
	end
end
