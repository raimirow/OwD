local C, F, L = unpack(select(2, ...))


--- ----------------------------------------------------------------------------
--> Function
--- ----------------------------------------------------------------------------



--- ----------------------------------------------------------------------------
--> AuraWatch_Config Frame
--- ----------------------------------------------------------------------------
local Spell_Card = function(f)
	f.Bg = f:CreateTexture(nil, "BACKGROUND")
	f.Bg: SetTexture(F.Media.."Bar")
	f.Bg: SetAllPoints(f)
	f.Bg: SetVertexColor(unpack(C.Color.Black))
	f.Bg: SetAlpha(0.75)
	
	f.Indicator3 = L.create_Texture(f, "ARTWORK", "Bar", 10,24, 0,1,0,1, C.Color.Gray,0.75, "RIGHT",f,"RIGHT",-4,0)
	f.Indicator2 = L.create_Texture(f, "ARTWORK", "Bar", 10,24, 0,1,0,1, C.Color.Gray,0.75, "RIGHT",f.Indicator3,"LEFT",-4,0)
	f.Indicator1 = L.create_Texture(f, "ARTWORK", "Bar", 10,24, 0,1,0,1, C.Color.White,0.75, "RIGHT",f.Indicator2,"LEFT",-4,0)
	
	f.Icon = L.create_Texture(f, "ARTWORK", "Icons\\OW_SonicArrow", 24,24, 0,1,0,1, C.Color.White,0.75, "LEFT",f,"LEFT",6,0)
	
	f.Spell = L.create_Fontstring(f, C.Font.Name, 12, nil)
	f.Spell: SetJustifyH("CENTER")
	f.Spell: SetWidth(90)
	f.Spell: SetPoint("LEFT", f, "LEFT", 40,0)
	f.Spell: SetText("旭日东升踢")
	
	f.Aura = L.create_Fontstring(f, C.Font.Name, 12, nil)
	f.Aura: SetJustifyH("CENTER")
	f.Aura: SetWidth(90)
	f.Aura: SetPoint("LEFT", f.Spell, "RIGHT", 10,0)
	f.Aura: SetText("旭日东升踢")

	f.Unit = L.create_Fontstring(f, C.Font.Name, 12, nil)
	f.Unit: SetJustifyH("CENTER")
	f.Unit: SetWidth(60)
	f.Unit: SetPoint("LEFT", f.Aura, "RIGHT", 0, 0)
	f.Unit: SetText("target")
end

local init_AW_Config = function(f)
	local classFileName = select(2, UnitClass("player"))
	local specID = GetSpecialization()
	local n1, n2, n3 = 0, 0, 0
	--n1 = #OwD_DB.AuraFilter[classFileName][specID][1]
	--n2 = #OwD_DB.AuraFilter[classFileName][specID][2]
	n1 = 8
	for i = 1, n1 do
		f[i] = CreateFrame("Frame", nil, f)
		f[i]: SetSize(340,28)
		Spell_Card(f[i])
		if i == 1 then
			f[i]: SetPoint("TOPLEFT", f, "BOTTOMLEFT", 0,-4)
		else
			f[i]: SetPoint("TOPLEFT", f[i-1], "BOTTOMLEFT", 0,-4)
		end
	end
	
	--f.AW_Config: SetSize(80*n1+, 20)
end

L.AuraWatch_Config = function(f)
	f.AW_Config = CreateFrame("Frame", nil, f)
	f.AW_Config: SetSize(340, 20)
	f.AW_Config: SetPoint("TOPLEFT", f, "CENTER", 180,80)
	f.AW_Config: SetFrameStrata("HIGH")
	f.AW_Config: Hide()
	
	init_AW_Config(f.AW_Config)
	
	f.AW_Config.Bg = f.AW_Config:CreateTexture(nil, "BACKGROUND")
	f.AW_Config.Bg: SetTexture(F.Media.."Bar")
	f.AW_Config.Bg: SetAllPoints(f.AW_Config)
	f.AW_Config.Bg: SetVertexColor(unpack(C.Color.Orange))
	f.AW_Config.Bg: SetAlpha(0.75)
	
	f.AW_Config.Spell = L.create_Fontstring(f.AW_Config, C.Font.Name, 12, nil)
	f.AW_Config.Spell: SetJustifyH("CENTER")
	f.AW_Config.Spell: SetWidth(90)
	f.AW_Config.Spell: SetPoint("LEFT", f.AW_Config, "LEFT", 40,0)
	f.AW_Config.Spell: SetShadowOffset(2,2)
	f.AW_Config.Spell: SetText("Spell")
	
	f.AW_Config.Aura = L.create_Fontstring(f.AW_Config, C.Font.Name, 12, nil)
	f.AW_Config.Aura: SetJustifyH("CENTER")
	f.AW_Config.Aura: SetWidth(90)
	f.AW_Config.Aura: SetPoint("LEFT", f.AW_Config.Spell, "RIGHT", 10,0)
	f.AW_Config.Aura: SetShadowOffset(2,2)
	f.AW_Config.Aura: SetText("Aura")

	f.AW_Config.Unit = L.create_Fontstring(f.AW_Config, C.Font.Name, 12, nil)
	f.AW_Config.Unit: SetJustifyH("CENTER")
	f.AW_Config.Unit: SetWidth(60)
	f.AW_Config.Unit: SetPoint("LEFT", f.AW_Config.Aura, "RIGHT", 0, 0)
	f.AW_Config.Unit: SetShadowOffset(2,2)
	f.AW_Config.Unit: SetText("Unit")
end

