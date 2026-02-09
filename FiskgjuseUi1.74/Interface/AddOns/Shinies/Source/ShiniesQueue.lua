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

ShiniesQueue = {}
ShiniesQueue.__index = ShiniesQueue

local function errorchecker(success, ...)
	if not success then
        d(...)
        return ShiniesAPI.STATE_FAILURE
    else
    	return ...
    end
end
 
local function safecall(func, ...)
	return errorchecker(pcall(func, ...))
end

function ShiniesQueue:Create( target, executeFunction, resultsCheckFunction, successCallback, failureCallback, timeoutCallback )
	local queue = {}
	
	local ShiniesAPI 	= _G.Shinies : GetModule( "Shinies-API-Core" )
	
    setmetatable( queue, ShiniesQueue )
    
    queue.m_first 			= 0
    queue.m_last 			= -1
    queue.m_count			= 0
    
    queue.m_executing		= false
    queue.m_executeTime		= 0
    queue.m_throttleRate	= .3
    queue.m_timeout			= 5
    
    if( executeFunction == nil ) then
    	queue.m_executeFunction = function() return ShiniesAPI.STATE_FAILURE end
    else
    	queue.m_executeFunction	= function(...) return target[executeFunction]( target, ... ) end
    end
    
    if( resultsCheckFunction == nil ) then
    	queue.m_resultsCheckFunction = function() return ShiniesAPI.STATE_FAILURE end
    else
    	queue.m_resultsCheckFunction = function(...) return target[resultsCheckFunction]( target, ... ) end
    end
    
    queue.m_successCallback			= successCallback
    queue.m_failureCallback			= failureCallback
    queue.m_timeoutCallback			= timeoutCallback
    
	return queue
end

function ShiniesQueue:GetExecuting() return self.m_executing end
function ShiniesQueue:SetExecuting( executing ) 
	self.m_executing = executing 
	self.m_executeTime = 0
end
function ShiniesQueue:IncrementExecuteTime( elapsed ) self.m_executeTime = self.m_executeTime + elapsed end
function ShiniesQueue:IsTimedOut() return self.m_executeTime > self.m_timeout end
function ShiniesQueue:GetThrottleRate() return self.m_throttleRate end
function ShiniesQueue:SetThrottleRate( rate ) self.m_throttleRate = rate end
function ShiniesQueue:GetTimeout() return self.m_timeout end
function ShiniesQueue:SetTimeout( time ) self.m_timeout = time end

function ShiniesQueue:Back() 	return self[self.m_last] end
function ShiniesQueue:Front() 	return self[self.m_first] end
function ShiniesQueue:Begin() 	return self.m_first end
function ShiniesQueue:End() 	return self.m_last end
function ShiniesQueue:IsEmpty() return self.m_first > self.m_last end

function ShiniesQueue:GetSuccessCallback() 			return self.m_successCallback end
function ShiniesQueue:GetFailureCallback() 			return self.m_failureCallback end
function ShiniesQueue:GetTimeoutCallback() 			return self.m_timeoutCallback end

function ShiniesQueue:CallExecuteFunction( ... ) 
	return safecall( self.m_executeFunction, ... )
end

function ShiniesQueue:CallResultsCheckFunction( ... ) 
	return safecall( self.m_resultsCheckFunction, ... )
end


function ShiniesQueue:Clear()
     self.m_first = 0
     self.m_last = -1
     self.m_count = 0
     
     self:SetExecuting( false )
end

function ShiniesQueue:PushBack( val )
    if( val ~= nil )
    then
        self.m_last = self.m_last + 1
        self[ self.m_last ] = val
        self.m_count = self.m_count + 1 
    end
end

function ShiniesQueue:PushFront( val )
    if( val ~= nil )
    then
        self.m_first = self.m_first - 1
        self[ self.m_first ] = val
        self.m_count = self.m_count + 1
    end
end

-- This should be a private function :(
local function PopAt( queue, index )
    if( queue:IsEmpty() )
    then
        return nil
    end
    
    local val = queue[ index ]
    queue[ index ] = nil
    return val
end

function ShiniesQueue:PopBack()
    local val = PopAt( self, self.m_last )
    
    if( val ~= nil )
    then
        self.m_last = self.m_last - 1
        self.m_count = self.m_count - 1
        if( self:IsEmpty() )
        then
            self:Clear()
        end
    end
    
    return val
end

function ShiniesQueue:PopFront()
    local val = PopAt( self, self.m_first )
    
    if( val ~= nil )
    then
        self.m_first = self.m_first + 1
        self.m_count = self.m_count - 1
        if( self:IsEmpty() )
        then
            self:Clear()
        end
    end
    
    self:SetExecuting( false )
    
    return val
end

function ShiniesQueue:GetCount()
	return self.m_count
end

