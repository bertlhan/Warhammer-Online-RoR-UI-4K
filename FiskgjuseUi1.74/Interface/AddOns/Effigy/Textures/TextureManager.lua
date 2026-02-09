
-- vim: sw=2 ts=2
if not Effigy then Effigy = {} end
local Addon = Effigy


Addon.texture_list_local = {
	["FiskgjuseUiCross"] = { scale = 1, width=1360, height=1360 },
	["FiskgjuseUiStar"] = { scale = 1, width=234, height=234 },
	["FiskgjuseGradientH"] = { scale = 1, width=520, height=4 },
	["FiskgjuseGradientV"] = { scale = 1, width=4, height=520 },
	["XPerl_StatusBar"] = { scale = 1, width=512, height=64 },
	["XPerl_StatusBar2"] = { scale = 1, width=512, height=64 },
	["XPerl_StatusBar3"] = { scale = 1, width=512, height=64 },
	["XPerl_StatusBar4"] = { scale = 1, width=128, height=128 },
	["XPerl_StatusBar5"] = { scale = 1, width=1024, height=128 },
	["XPerl_StatusBar6"] = { scale = 1, width=512, height=64 },
	["XPerl_StatusBar7"] = { scale = 1, width=1024, height=128 },
	["XPerl_StatusBar8"] = { scale = 1, width=512, height=64 },
	["XPerl_StatusBar9"] = { scale = 1, width=512, height=64 },
	["XPerl_StatusBar10"] = { scale = 1, width=512, height=64 }, 
	["Statusbar1"] = { scale = 1, width=512, height=64 }, 
	["Gloss"] = { scale = 1, width=128, height=128 }, 
	["Statusbar"] = { scale = 1, width=32, height=256 }, 
	["rothTex"] = { scale = 1, width=32, height=32 }, 
	["Statusbar2"] = { scale = 1, width=512, height=64 },
	
	["LiquidUFBG"] = { scale = 1, width=1024, height=256 }, 
	["LiquidUFFX"] = { scale = 1, width=1024, height=256 }, 
	["LiquidBar"] = { scale = 1, width=512, height=64 },
	["LiquidCBBarEnd"] = { scale = 1, width=40, height=50 },
	["LiquidCBBar"] = { scale = 1, width=422, height=20 },
	["LiquidCBBG"] = { scale = 1, width=450, height=40 },
	["LiquidCBFX"] = { scale = 1, width=450, height=40 },
	["LiquidIPBG"] = { scale = 1, width=1200, height=140 },
	["LiquidIPFX"] = { scale = 1, width=1200, height=140 },
	
	["GroupIcon Gloss"] = { scale = 1, width=100, height=100 }, 
	["GroupIcon Shape"] = { scale = 1, width=100, height=100 }, 
	
	["tint_square"] = { },
}

Addon.texture_list = Addon.texture_list_local

local LibSA = LibStub("LibSharedAssets")
Addon.TextureManager = {}

function Addon.TextureManager.GetTextureList()
	local tex = {}
	
	for k,v in pairs(Addon.texture_list_local) do tex[k]=v end
	
	a= LibSA:GetTextureList()
	for k,v in pairs (a)
	do
		local meta = LibSA:GetMetadata(v)
		
		tex[v] = {scale=1, width=meta.size[1], height=meta.size[2]}
	end
	return tex;
end

function  Addon.TextureManager.BuildTextureList()
	Addon.texture_list = Addon.TextureManager.GetTextureList()
end

function Addon.TextureManager.SetTextureFill(win_name,t, width, height, perc, direction, type )
	if (not Addon.texture_list[t] or not Addon.texture_list[t].width or not Addon.texture_list[t].height)
	then
		return nil
	end

	if (direction == "right")
	then
		if (type and type == "grow")
		then
			DynamicImageSetTexture(win_name, t, 
				Addon.texture_list[t].width - Addon.texture_list[t].width * perc,
				Addon.texture_list[t].height)
		else
			DynamicImageSetTexture(win_name, t, 
				Addon.texture_list[t].width,
				Addon.texture_list[t].height)
		end
		DynamicImageSetTextureDimensions(win_name, perc * Addon.texture_list[t].width , Addon.texture_list[t].height)
	elseif (direction == "left") 
	then
		if (type and type == "grow")
		then
			DynamicImageSetTexture(win_name, t, 
				Addon.texture_list[t].width,
				Addon.texture_list[t].height)
		else
			DynamicImageSetTexture(win_name, t, 
				Addon.texture_list[t].width - Addon.texture_list[t].width * perc,
				Addon.texture_list[t].height)	
		end
		DynamicImageSetTextureDimensions(win_name, perc * Addon.texture_list[t].width , Addon.texture_list[t].height)
	elseif (direction == "down") 
	then
		if (type and type == "grow")
		then
			DynamicImageSetTexture(win_name, t, 
				Addon.texture_list[t].width,
				Addon.texture_list[t].height - Addon.texture_list[t].height * perc)
		else
			DynamicImageSetTexture(win_name, t, 
				Addon.texture_list[t].width,
				Addon.texture_list[t].height)
		end
		DynamicImageSetTextureDimensions(win_name, Addon.texture_list[t].width , Addon.texture_list[t].height * perc )
	elseif (direction == "up") 
	then
		if (type and type == "grow")
		then
			DynamicImageSetTexture(win_name, t, 
				Addon.texture_list[t].width,
				Addon.texture_list[t].height)
		else
			DynamicImageSetTexture(win_name, t, 
				Addon.texture_list[t].width,
				Addon.texture_list[t].height - Addon.texture_list[t].height * perc)	
		end
		DynamicImageSetTextureDimensions(win_name, Addon.texture_list[t].width , Addon.texture_list[t].height * perc )
	end
end

function Addon.TextureManager.SetTexture(win_name, t)
	if (nil == Addon.texture_list[t]) then t = "tint_square" end

	if (nil ~= Addon.texture_list[t].real_texture) then
		DynamicImageSetTexture(win_name, Addon.texture_list[t].real_texture, 0, 0)
	else
		DynamicImageSetTexture(win_name, t, 
				Addon.texture_list[t].x or 0,
				Addon.texture_list[t].y or 0)
	end

	if (nil ~= Addon.texture_list[t].scale) then
		DynamicImageSetTextureScale(win_name, Addon.texture_list[t].scale)
	end

	if (nil ~= Addon.texture_list[t].width)and(nil ~= Addon.texture_list[t].height) then
		DynamicImageSetTextureDimensions(win_name, 
				Addon.texture_list[t].width, Addon.texture_list[t].height)
	end

	if (nil ~= Addon.texture_list[t].slice) then
		DynamicImageSetTextureSlice(win_name, Addon.texture_list[t].slice)
	end

end
