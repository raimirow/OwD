local C, F, L = unpack(select(2, ...))
local A = ...

-->>Lua APIs
local min = math.min
local max = math.max
local format = string.format
local floor = math.floor
local sqrt = math.sqrt
local sin = math.sin
local cos = math.cos
local rad = math.rad


----------------------------------------------------------------



--< Config >----------------------------------------------------

C.DB = {
	["ReloadUI"] = false,
	["OwD_RuneBar"] = true,
	["OwD_MinimapScale"] = 1,
	["OwD_Scale"] = 1,
	["OutCombat_Fade"] = false,
	["Pos"] = {
		["Player"]		= {["x"] = -830, ["y"] = -300,},
		["Target"]		= {["y"] = -100,},
		["Focus"]		= {["x"] = -450, ["y"] = -50,},
		["FCS"]			= {["y"] = -240,},
		["Bar"]			= {["y"] = -400,},
		["Minimap"]		= {["x"] = -244, ["y"] = -174,},
		["AuraWatch"]	= {["x"] = -158, ["y"] = 10},
		["BuffFrame"]	= {x = -10, y = -10},
	},
	["Hide_Blizzard"] = true,
	["TopBottomBorder"] = {
		["ON"] = true,
	},
	["Player"] = {
		["ON"] = true,
	},
	["Target"] = {
		["ON"] = true,
	},
	["Focus"] = {
		["ON"] = true,
	},
	["AuraWatch"] = {
		["ON"] = true,
		["WTF"] = true,
	},
	["ClassPower"] = {
		["ON"] = true,
	},
	["ActionBar"] = {
		["ON"] = true,
	},
	["BuffFrame"] = {
		["ON"] = true,
		["Size"] = 38,
	},
	["ActionBar"] = {
		["ON"] = true,
	},
	["Minimap"] = {
		["ON"] = true,
	},
	
}

----------------------------------------------------------------



--< SavedVariable >---------------------------------------------

OwD_DB = C.DB
local Init_SV = CreateFrame("Frame", nil, UIParent)
Init_SV: RegisterEvent("ADDON_LOADED")
Init_SV: SetScript("OnEvent", function(self, event, addon)
	if addon == A then
		for k1, v1 in pairs(C.DB) do
			if OwD_DB[k1] == nil then
				if type(v1) == "table" then
					OwD_DB[k1] = {}
					for k2, v2 in pairs(v1) do
						if OwD_DB[k1][k2] == nil then
							if type(v2) == "table" then
								OwD_DB[k1][k2] = {}
								for k3, v3 in pairs(v2) do
									if OwD_DB[k1][k2][k3] == nil then
										OwD_DB[k1][k2][k3] = v2[k3]
									end
								end
							else
								OwD_DB[k1][k2] = v1[k2]
							end
						else
							if type(v2) == "table" then
								for k3, v3 in pairs(v2) do
									if OwD_DB[k1][k2][k3] == nil then
										OwD_DB[k1][k2][k3] = v2[k3]
									end
								end
							end
						end
					end
				else
					OwD_DB[k1] = v1
				end
			else
				if type(v1) == "table" then
					for k2, v2 in pairs(v1) do
						if OwD_DB[k1][k2] == nil then
							if type(v2) == "table" then
								OwD_DB[k1][k2] = {}
								for k3, v3 in pairs(v2) do
									if OwD_DB[k1][k2][k3] == nil then
										OwD_DB[k1][k2][k3] = v2[k3]
									end
								end
							else
								OwD_DB[k1][k2] = v1[k2]
							end
						else
							if type(v2) == "table" then
								for k3, v3 in pairs(v2) do
									if OwD_DB[k1][k2][k3] == nil then
										OwD_DB[k1][k2][k3] = v2[k3]
									end
								end
							end
						end
					end
				end
			end
		end
		
		if C.AuraFilter then
			if OwD_DB["AuraFilter"] == nil then
				OwD_DB["AuraFilter"] = {}
			end
			for k1, v1 in pairs(C.AuraFilter) do
				if OwD_DB["AuraFilter"][k1] == nil then
					OwD_DB["AuraFilter"][k1] = {}
					if type(v1) == "table" then
						for k2, v2 in pairs(v1) do
							OwD_DB["AuraFilter"][k1][k2] = v1[k2]
						end
					else
						OwD_DB["AuraFilter"][k1] = v1
					end
				end
			end
		end
		L.Init()
		L.Minimap(OwD)
		L.init_Config(OwD)
	end
end)

L.Reset = function()
	OwD_DB = nil
	OwD_DB = {}
	for key, value in pairs(C.DB) do
		if type(value) == "table" then
			OwD_DB[key] = {}
			for k, v in pairs(value) do
				OwD_DB[key][k] = value[k]
			end
		else
			OwD_DB[key] = value
		end
	end
end
----------------------------------------------------------------
