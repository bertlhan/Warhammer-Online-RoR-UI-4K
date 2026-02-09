--##########################################################
--All Rights Reserved unless otherwise explicitly stated.
--You are not allowed to use any content of the .lua files from DAoCBuff without the permission of the authors.
--##########################################################


DAoCTooltips = {}

local TT_MAX_ITEMS			= 6
local TT_ICON_OFFSET		= 47
local TT_ICON_Y				= 10
local TT_SPACING_OFFSET		= 15

local SortFunction = DAoCBuff.CompareBuffs
local ipairs = ipairs
local LabelSetText = LabelSetText
local WindowGetDimensions = WindowGetDimensions
local WindowSetShowing = WindowSetShowing
local DynamicImageSetTexture = DynamicImageSetTexture
local WindowSetDimensions = WindowSetDimensions

local TT_THROTTLE_DELAY		= 0.5
local TT_ELAPSED_U_TIME		= 0

local TT_CONDENSED_NUMBER	= 0

function DAoCTooltips.Init()
	CreateWindow("DAoCBuffCondenseTooltip", false)
	DAoCTooltips.ThrottleDelay = TT_THROTTLEDELAY
end


local SortKeys=
{
	["permanentUntilDispelled"]		= { fallback = "duration" , sortOrder = DataUtils.SORT_ORDER_DOWN},
	["duration"] 					= { fallback = "name" , sortOrder = DataUtils.SORT_ORDER_DOWN},
	["name"]						= { sortOrder = DataUtils.SORT_ORDER_UP},
}

local function SortBuffs(buff1, buff2)
	return SortFunction(buff1, buff2, "permanentUntilDispelled",SortKeys)
end

function DAoCTooltips.CreateCondenseTooltip(title, text, condensetable, stackCount, mouseoverWindow, anchor)

	TT_ELAPSED_U_TIME	= 0
	TT_CONDENSED_NUMBER	= stackCount

	local width			= 0
	local height		= 0

	LabelSetText( "DAoCBuffCondenseTooltipTitle", title )
	local x, y = WindowGetDimensions( "DAoCBuffCondenseTooltipTitle" )
	width = math.max( width, x )
	height = height + y

	LabelSetText( "DAoCBuffCondenseTooltipText", text )
	local x, y = WindowGetDimensions( "DAoCBuffCondenseTooltipText" )
	width = math.max( width, x )
	height = height + y

	local sortedData={}
	for _,k in pairs(condensetable)
	do
		table.insert(sortedData,k)
	end
	table.sort(sortedData,SortBuffs)

	local index = 1

	for _,k in ipairs(sortedData) do
		if (index > TT_MAX_ITEMS) then
			break
		end
		WindowSetShowing( "DAoCBuffCondenseTooltipEffect"..index, true )

		local texture, xtex, ytex = GetIconData(k.iconNum)
		DynamicImageSetTexture("DAoCBuffCondenseTooltipEffect"..index.."Icon", texture, xtex, ytex)

		local text = k.name;

		if (k.permanentUntilDispelled) then
		elseif (k.stackCount > 1) then
			text = L"x" .. k.stackCount .. L" - " ..k.name
		else
			text = TimeUtils.FormatTimeCondensed(k.duration) .. L" - " .. k.name
		end

		LabelSetText( "DAoCBuffCondenseTooltipEffect"..index.."EffectName", text )

		local x, _ = WindowGetDimensions( "DAoCBuffCondenseTooltipEffect"..index.."EffectName" )
		local _, y = WindowGetDimensions( "DAoCBuffCondenseTooltipEffect"..index.."Icon" )
		width = math.max( width, x + TT_ICON_OFFSET)
		height = height + y + TT_ICON_Y
		WindowSetDimensions( "DAoCBuffCondenseTooltipEffect"..index, x + TT_ICON_OFFSET, y )
		index = index + 1
	end

	if (index <= TT_MAX_ITEMS) then
		for i = index, TT_MAX_ITEMS do
			WindowSetShowing( "DAoCBuffCondenseTooltipEffect"..i, false )
		end
	end

	width  = width + Tooltips.BORDER_SIZE.X * 2
	height = height + Tooltips.BORDER_SIZE.Y * 2 + TT_SPACING_OFFSET
	WindowSetDimensions( "DAoCBuffCondenseTooltip", width, height )

	-- Most important function call, this makes sure we don't need to write a completely new Tooltipclass
	-- THANKS for this Mythic ;-)
	Tooltips.CreateCustomTooltip(mouseoverWindow, "DAoCBuffCondenseTooltip");

	Tooltips.AnchorTooltip(anchor);
end

function DAoCTooltips.UpdateCondenseTooltip(condensetable, stackCount, elapsedTime)


	if (condensetable == nil) then
		WindowSetShowing("DAoCBuffCondenseTooltip", false)
		return
	end

	TT_ELAPSED_U_TIME = TT_ELAPSED_U_TIME + elapsedTime
	if (TT_ELAPSED_U_TIME > TT_THROTTLE_DELAY) then

		TT_ELAPSED_U_TIME = 0

		TT_CONDENSED_NUMBER = stackCount

		local width = 0
		local height = 0

		local x, y = WindowGetDimensions( "DAoCBuffCondenseTooltipTitle" )
		width = math.max( width, x )
		height = height + y

		local x, y = WindowGetDimensions( "DAoCBuffCondenseTooltipText" )
		width = math.max( width, x )
		height = height + y

		local sortedData={}
		for _,k in pairs(condensetable)
		do
			table.insert(sortedData,k)
		end
		table.sort(sortedData,SortBuffs)

		local index = 1

		for _,k in ipairs(sortedData) do
			if (index > TT_MAX_ITEMS) then
				break
			end
			WindowSetShowing( "DAoCBuffCondenseTooltipEffect"..index, true )

			local texture, xtex, ytex = GetIconData(k.iconNum)
			DynamicImageSetTexture("DAoCBuffCondenseTooltipEffect"..index.."Icon", texture, xtex, ytex)

			local text = k.name;

			if (k.permanentUntilDispelled) then
			elseif (k.stackCount > 1) then
				text = L"x" .. k.stackCount .. L" - " ..k.name
			else
				text = TimeUtils.FormatTimeCondensed(k.duration) .. L" - " .. k.name
			end

			LabelSetText( "DAoCBuffCondenseTooltipEffect"..index.."EffectName", text )

			local x, _ = WindowGetDimensions( "DAoCBuffCondenseTooltipEffect"..index.."EffectName" )
			local _, y = WindowGetDimensions( "DAoCBuffCondenseTooltipEffect"..index.."Icon" )
			width = math.max( width, x + TT_ICON_OFFSET)
			height = height + y + TT_ICON_Y
			WindowSetDimensions( "DAoCBuffCondenseTooltipEffect"..index, x + TT_ICON_OFFSET, y )
			index = index + 1
		end

		if (index <= TT_MAX_ITEMS) then
			for i = index, TT_MAX_ITEMS do
				WindowSetShowing( "DAoCBuffCondenseTooltipEffect"..i, false )
			end
		end

		width  = width + Tooltips.BORDER_SIZE.X * 2
		height = height + Tooltips.BORDER_SIZE.Y * 2 + TT_SPACING_OFFSET
		WindowSetDimensions( "DAoCBuffCondenseTooltip", width, height )
	end
end
