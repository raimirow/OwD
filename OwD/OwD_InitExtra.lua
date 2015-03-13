local C, F, L = unpack(select(2, ...))

---- ----------------------------------
-->> SavedVariables
---- ----------------------------------

L.DB = {
	["Pos"] = {
		["Player"] = {["x"] = -620, ["y"] = -320,},
		["FCS"] = {["y"] = -250,},
		["Minimap"] = {["x"] = -70, ["y"] = -20,},
	},
	["Hide_Blizzard"] = true,
	["Hide_TopBottomBorder"] = false,
	["Hide_Minimap"] = false,
	["WTF_AuraWatch"] = true,
}

OwD_DB = L.DB
local OwD_Config = CreateFrame("Frame", nil, UIParent)
OwD_Config:RegisterEvent("ADDON_LOADED")
OwD_Config:SetScript("OnEvent", function(self, event, addon)
	if addon == "OwD" then
		for key, value in pairs(L.DB) do
			if OwD_DB[key] == nil then
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
		if OwD_DB["AuraFilter"] == nil then
			OwD_DB["AuraFilter"] = {}
			for k1, v1 in pairs(L.AuraFilter) do
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
		------------------------------------------------------------------
		L.Minimap(OwD)
		L.init_Config(OwD)
	end
end)