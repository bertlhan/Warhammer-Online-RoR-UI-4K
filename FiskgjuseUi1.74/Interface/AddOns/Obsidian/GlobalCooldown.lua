Obsidian.GlobalCooldown = Frame:Subclass("ObsidianGlobalCooldownBarTemplate");
Obsidian.GlobalCooldown.Position = { Top = 1, Bottom = 2, Free = 3 };

local HIDE_DURATION = 0.2;
local SPARK_WIDTH = 15;

local function IsColorEqual(colorA, colorB)
	if (not colorA or not colorB) then
		return false;
	end

	return (colorA.R == colorB.R and colorA.G == colorB.G and colorA.B == colorB.B);
end

local function SetAnchor(frame, anchorFrame, pointOnAnchor, pointOnSelf, xOffset, yOffset)
	WindowClearAnchors(frame);
	WindowAddAnchor(frame, pointOnAnchor, anchorFrame, pointOnSelf, xOffset, yOffset);
end

function Obsidian.GlobalCooldown:SetLayout()
	local castbarSettings = Obsidian.Settings.Castbar;	
	local gcdSettings = Obsidian.Settings.GlobalCooldown;	
	local layout = self.Layout;
	local windowName = self:GetName();
	local width, height = castbarSettings.Size.Width + (castbarSettings.Size.Border * 2), gcdSettings.Height;
	
	if (gcdSettings.Width) then
		if (type(gcdSettings.Width) == "string") then
			local percent = gcdSettings.Width:match("(%d*%.?%d*)%%");
			if (percent) then
				width = width * tonumber(percent) / 100;
			end
		else
			width = gcdSettings.Width;
		end
	end
	
	self.Size = { Width = width, Height = height };
	layout.Reverse = gcdSettings.Reverse;
	
	WindowSetDimensions(windowName, width, height);

	local color = gcdSettings.Background.Color;
	WindowSetAlpha(windowName .. "Background", gcdSettings.Background.Alpha);
	WindowSetTintColor(windowName .. "Background", color.R, color.G, color.B);
	
	layout.Background.Alpha = gcdSettings.Background.Alpha;
	
	color = gcdSettings.Fill.Color;
	WindowSetAlpha(windowName .. "Fill", gcdSettings.Fill.Alpha);
	WindowSetTintColor(windowName .. "Fill", color.R, color.G, color.B);
	
	if (layout.Reverse) then
		SetAnchor(windowName .. "Fill", windowName, "right", "right", 0, 0);
	else
		SetAnchor(windowName .. "Fill", windowName, "left", "left", 0, 0);
	end
	
	layout.Fill.Size = { Width = width, Height = height };
	layout.Fill.Alpha = gcdSettings.Fill.Alpha;
	
	color = gcdSettings.Spark.Color;
	WindowSetDimensions(windowName .. "Spark", SPARK_WIDTH, height);
	WindowSetAlpha(windowName .. "Spark", gcdSettings.Spark.Alpha);
	WindowSetTintColor(windowName .. "Spark", color.R, color.G, color.B);
	
	if (layout.Reverse) then
		SetAnchor(windowName .. "Spark", windowName .. "Fill", "left", "left", -8, 0);
	else
		SetAnchor(windowName .. "Spark", windowName .. "Fill", "right", "left", -8, 0);
	end
	
	layout.Spark.Alpha = gcdSettings.Spark.Alpha;
end

function Obsidian.GlobalCooldown:Create(name)

	frame = self:CreateFromTemplate(name, "Root");
	frame.Cooldown = nil;
	frame.Layout = 
	{
		Background = {},
		Fill = {},
		Spark = {},
	};
	frame.Values = 
	{
		Fill = {},
	};
	frame.Alpha = 1;
	
	frame:SetLayout();
	
	return frame;
	
end

function Obsidian.GlobalCooldown:RegisterLayoutEditor()
	if (self.isLayoutEditorRegistered) then return end
	LayoutEditor.RegisterWindow(self:GetName(), towstring(self:GetName()), "", false, false, false, nil);
	self.isLayoutEditorRegistered = true;
end

function Obsidian.GlobalCooldown:UnregisterLayoutEditor()
	if (not self.isLayoutEditorRegistered) then return end
	LayoutEditor.UnregisterWindow(self:GetName());
	self.isLayoutEditorRegistered = nil;
end

function Obsidian.GlobalCooldown:FadeOut(duration)
	if (self.Alpha == 0) then return end
	self.Alpha = 0;
	self:StopAlphaAnimation();
	self:StartAlphaAnimation(Window.AnimationType.SINGLE_NO_RESET, 1, 0, duration, 0, 0);
end

function Obsidian.GlobalCooldown:ResetAlpha()
	if (self.Alpha == 1) then return end
	self.Alpha = 1;
	self:StopAlphaAnimation();
	
	local layout = self.Layout;	
	local windowName = self:GetName();
	WindowSetAlpha(windowName, 1);
	WindowSetAlpha(windowName .. "Background", layout.Background.Alpha or 1);
	WindowSetAlpha(windowName .. "Fill", layout.Fill.Alpha or 1);
	WindowSetAlpha(windowName .. "Spark", layout.Spark.Alpha or 1);
end

function Obsidian.GlobalCooldown:SetScale(scale)
	local windowName = self:GetName();
	WindowSetScale(windowName, scale);
end

function Obsidian.GlobalCooldown:AnchorTo(anchorFrame, pointOnAnchor, pointOnSelf, xOffset, yOffset)
	WindowClearAnchors(self:GetName());
	WindowAddAnchor(self:GetName(), pointOnAnchor, anchorFrame, pointOnSelf, xOffset, yOffset);
end

local function ResizeFill(self, value, maximum)
	local percent = math.min(1, value / maximum);
	if (self.Values.Fill.Value == percent) then return end
	self.Values.Fill.Value = percent;
	
	WindowSetDimensions(self:GetName() .. "Fill", self.Layout.Fill.Size.Width * value / maximum, self.Layout.Fill.Size.Height);
end

function Obsidian.GlobalCooldown:Hide()
	self:FadeOut(HIDE_DURATION);
	self.Cooldown = nil;
end

function Obsidian.GlobalCooldown:Start(cooldown)
	if (cooldown == 0) then return end
	
	self.Cooldown = 
	{
		Current = 0,
		Maximum = cooldown,
	};

	ResizeFill(self, 0, cooldown);
	
	self:ResetAlpha();
	self:Show(true);
end

function Obsidian.GlobalCooldown:Update(elapsed)
	local cooldown = self.Cooldown;
	if (not cooldown) then return end
	
	cooldown.Current = cooldown.Current + elapsed;
	
	local value, maximum = cooldown.Current, cooldown.Maximum;

	if (value > maximum or value < 0) then
		ResizeFill(self, maximum, maximum);
		self:Hide();
	else
		ResizeFill(self, value, maximum);
	end
end