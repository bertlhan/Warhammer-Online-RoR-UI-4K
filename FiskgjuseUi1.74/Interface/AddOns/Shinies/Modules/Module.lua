--[[
	Portions of this file are from Shinies/ModuleHandling/Modules.lua 
	with permission granted by ckknight under the MIT license.

	Copyright (c) 2010 ckknight -- curseforge.com
	
	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.
--]]

local _G = _G
local Shinies = _G.Shinies

local new, del, wipe = Shinies.new, Shinies.del, Shinies.wipe

-- dictionary of module type name to module type prototype
local module_types = {}

-- dictionary of module type name to module defaults
local module_types_to_module_defaults = {}

-- dictionary of script name to a dictionary of module to callback
local module_script_hooks = {}

-- dictionary of module to module defaults
local module_to_module_defaults = {}

local module_option_functions = {}
----------------------------------------------------------------------
--  Functionality that extends Ace3s module interface
----------------------------------------------------------------------

--
-- Local functions
--

-- generic deepcopy
local function deepcopy(object)
    local lookup_table = new()
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = new()
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return new_table
    end
    return _copy(object)
end

-- This function takes a defaults table and a settings table, and verifies that all 
-- keys that exist in the defaults exist in the settings.
local function updateSettings(defaults, settings)
	if type(defaults) ~= "table" or type(settings) ~= "table" then d( "updateSettings received non table" ) return end
	
	for key, value in pairs( defaults ) do
		if type(value) ~= "table" and value ~= nil then
			-- Check if the key exists in settings
			if settings[key] == nil then
				settings[key] = value
			end
		else
			-- Create the table if it doesnt exist, or if its type is not of table
			if settings[key] == nil or type(settings[key]) ~= "table" then
				settings[key] = new()
			end
			
			updateSettings( value, settings[key] )
		end
	end	
end

local function settingsMerge( defaults, settings )
	if type(defaults) ~= "table" or type(settings) ~= "table" then return {} end
	
	local y = deepcopy( settings )
	
	updateSettings( defaults, y )
	
	return y
end

-- set the db instance on the module with defaults handled
local function fix_db_for_module(module, module_defaults)
	local Shinies_db = Shinies.db
	local db = Shinies_db:RegisterNamespace(module.id, module_defaults )
	module.db = db

	-- AceDB-3.0 is supposed to keep the child profiles linked to the
	-- main db.  However, if a profile change happens while the child namespace
	-- isn't registered then it won't be kept in sync with the main db's
	-- profile.  A good example of this is seen with load on demand modules.
	-- Setup two profiles.  Enable the module in one and then go to the other
	-- and disable it (the order matters).  Once the module has been disabled
	-- reload the UI so you load back into the UI with the profile that doesn't have
	-- the module loaded.  Now select the other profile.  Without the following line
	-- the profile will change but the module will load with the namespace still
	-- set to the old profile.  
	Shinies_db.SetProfile(db, Shinies_db:GetCurrentProfile())

	if not db.global.enabled then
		module:Disable()
	end
end

local function iter(types, id)
	local id, module = next(Shinies.modules, id)
	if not id then
		del(types)
		return nil
	end
	
	if not types[module.module_type] then
		return iter(types, id)
	end
	
	return id, module
end

--
-- AceAddon-3.0 Extension Functionality
--
function Shinies:CallMethodOnModules(method_name, ...)
	for id, module in self:IterateModules() do
		if module[method_name] then
			module[method_name](module, ...)
		end
	end
end

function Shinies:CallMethodOnEnabledModules(method_name, ...)
	for id, module in self:IterateModules() do
		if module[method_name] then
			module[method_name](module, ...)
		end
	end
end

--- Iterate over all modules of a given type.
-- @param ... a tuple of module types, e.g. "bar", "indicator".
-- @usage for id, module in Shinies:IterateModulesOfType("bar") do
--     doSomethingWith(module)
-- end
-- @return iterator which returns the id and module
function Shinies:IterateModulesOfType(...)
	local types = new()
	local n = select('#', ...)
	for i = 1, n do
		local type = select(i, ...)
		types[type] = true
	end
	return iter, types, nil
end

--- Add a new module type.
-- @param name name of the module type
-- @param defaults a dictionary of default values that all modules will have that inherit from this module type
-- @param update_texts if texts on the frame should be updated along with :UpdateLayout
-- @usage MyModule:NewModuleType("mytype", { size = 50, verbosity = "lots" })
function Shinies:NewModuleType(name, defaults)
	module_types[name] = {}
	module_types_to_module_defaults[name] = defaults or {}
	return module_types[name]
end

function Shinies:OnModuleCreated(module)
	local id = module.moduleName
	module.id = id
	self[id] = module
end

------------------------------------------------------------------
-- Module Definition
------------------------------------------------------------------
local Module = {}
Shinies:SetDefaultModulePrototype(Module)

function Module:GetModuleDB()
	return self.db
end

function Module:SetDefaults(module_defaults)
	local module_defaults_copy = deepcopy(module_defaults)
	
	local better_module_defaults = settingsMerge( module_types_to_module_defaults[self.module_type], module_defaults_copy or {} )
	
	if not Shinies.db then
		-- full addon not loaded yet
		module_to_module_defaults[self] = better_module_defaults
	else
		fix_db_for_module(self, better_module_defaults)
	end
end

function Module:SetDescription(description)
	self.description = description
end

function Module:GetDescription()
	return self.description
end

function Module:SetModuleType(mType)
	self.module_type = mType
	
	for k, v in pairs(module_types[mType]) do
		if self[k] == nil then
			self[k] = v
		end
	end
end

function Module:SetName(name)
	self.name = towstring(name)
end

-- This function is here because the base GetName returns the module name, not
function Module:GetDisplayName()
	return self.name
end

--
-- This function is called by Shinies after all modules have been enabled by Ace
--
function Module:OnAllModulesEnabled()
end

do
	-- we need to hook OnInitialize so that we can handle the database stuff for modules
	local old_Shinies_OnInitialize = Shinies.OnInitialize
	Shinies.OnInitialize = function(self)
		if old_Shinies_OnInitialize then
			old_Shinies_OnInitialize(self)
		end
		
		for module, module_defaults in pairs(module_to_module_defaults) do
			fix_db_for_module(module, module_defaults)
		end
		-- no longer need these
		module_to_module_defaults = nil
	end
end