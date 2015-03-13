local C, F, L = unpack(select(2, ...))

-->>Lua APIs
local min = math.min
local max = math.max
local format = string.format
local floor = math.floor
local sqrt = math.sqrt
local sin = math.sin
local cos = math.cos
local rad = math.rad

--- ----------------------------------------------------------------------------
--> Focus Frame Element      
--- ----------------------------------------------------------------------------

local create_Health_Power = function(f)
	f.BarBg = L.create_Texture(f, "BORDER", "Focus_Bar", 131,8, 62/256,193/256,0,1, C.Color.White,0.4, "BOTTOMLEFT",f,"BOTTOMLEFT",0,0)
	f.BarBorder1 = L.create_Texture(f, "ARTWORK", "Focus_BarBorder", 9,13, 3/16,12/16,1/16,14/16, C.Color.White,0.9, "BOTTOMRIGHT",f.BarBg,"BOTTOMLEFT",4,0)
	f.BarBorder2 = L.create_Texture(f, "ARTWORK", "Focus_BarBorder", 9,13, 3/16,12/16,1/16,14/16, C.Color.White,0.9, "BOTTOMLEFT",f.BarBg,"BOTTOMRIGHT",-3,0)
	f.Health = CreateFrame("Frame", nil, f)
	f.Health: SetSize(131, 8)
	f.Health: SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0,0)
	f.Health: SetFrameLevel(f:GetFrameLevel()+2)
	
	L.init_Smooth(f.Health)
	f.Health.Bar = L.create_Texture(f.Health, "BORDER", "Focus_Bar", 131,8, 62/256,193/256,0,1, C.Color.White,1, "BOTTOMLEFT",f.BarBg,"BOTTOMLEFT",0,0)
	
	f.Power = CreateFrame("Frame", nil, f)
	f.Power: SetSize(131, 8)
	f.Power: SetPoint("BOTTOMLEFT", f.Health, "BOTTOMLEFT", 0,0)
	f.Power: SetFrameLevel(f:GetFrameLevel()+1)
	
	L.init_Smooth(f.Power)
	f.Power.Bar = L.create_Texture(f.Power, "BORDER", "Focus_Bar", 131,8, 62/256,193/256,0,1, C.Color.Blue,1, "BOTTOMLEFT",f.BarBg,"BOTTOMLEFT",0,0)
end

local create_Name = function(f)
	f.Name = L.create_Fontstring(f, C.Font.Name, 14, nil)
	--f.Name: SetWidth(120)
	f.Name: SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 6,16)
	f.Name: SetText("暴风城测试员")
end

--- ----------------------------------------------------------------------------
--> Focus Frame     
--- ----------------------------------------------------------------------------

L.Focus_Frame = function(f)
	f.Focus = CreateFrame("Frame", nil, f)
	f.Focus: SetSize(131,16)
	f.Focus: SetPoint("CENTER", f, "CENTER", -290, 220)
	f.Focus.unit = "focus"
	
	create_Health_Power(f.Focus)
	create_Name(f.Focus)
end

L.ToF_Frame = function(f)
	f.ToF = CreateFrame("Frame", nil, f)
	f.ToF: SetSize(131,16)
	f.ToF: SetPoint("BOTTOMLEFT", f.Focus, "BOTTOMLEFT", -40, -50)
	f.ToF.unit = "focustarget"
	
	create_Health_Power(f.ToF)
	create_Name(f.ToF)
end

--- ----------------------------------------------------------------------------
--> Focus Frame Update          
--- ----------------------------------------------------------------------------

local update_Health = function(self, unit)
	local minHealth = UnitHealth(unit) or 0
	local maxHealth = UnitHealthMax(unit) or 0
	local h,hv = 0,0
	if maxHealth == 0 or minHealth == 0 then
		h = 0
	else
		h = floor(minHealth/maxHealth*1e4)/1e4
	end
	self.Health.Per = h
	self.Health.Max = maxHealth
end

local update_Power = function(self, unit)
	local minPower = UnitPower(unit) or 0
	local maxPower = UnitPowerMax(unit) or 0
	local p,pv = 0,0
	if maxPower == 0 or minPower == 0 then
		p = 0
	else
		p = floor(minPower/maxPower*1e4)/1e4
	end
	self.Power.Per = p
	self.Power.Max = maxPower
end

L.OnEvent_Focus = function(f, event)
	if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_FOCUS_CHANGED" then
		if UnitExists(f.unit) then
			f:Show()
			local eColor = {}
			if UnitIsPlayer(f.unit) then
				local eClass = select(2, UnitClass(f.unit))
				eColor = C.Color.Class[eClass]
			else
				local red, green, blue, alpha = UnitSelectionColor(f.unit)
				eColor[1] = red
				eColor[2] = green
				eColor[3] = blue
			end
			
			local name, realm = UnitName(f.unit)
			f.Name: SetText(F.Hex(eColor)..name.."|r")
		else
			f:Hide()
			f.Name: SetText("")
		end
		update_Health(f, f.unit)
		update_Power(f, f.unit)
	end
	
	if event == "UNIT_HEALTH_FREQUENT" or event == "UNIT_MAXHEALTH" then
		update_Health(f, f.unit)
	end
	
	if event == "UNIT_POWER_FREQUENT" or event == "UNIT_MAXPOWER" then
		update_Power(f, f.unit)
	end
end

L.OnUpdate_Focus = function(f)
	f.Health.Bar: SetSize(131*f.Health.Cur+F.Debug, 8)
	f.Health.Bar: SetTexCoord(62/256,(62+131*f.Health.Cur)/256,0,1)
		
	f.Power.Bar: SetSize(131*f.Power.Cur+F.Debug, 8)
	f.Power.Bar: SetTexCoord(62/256,(62+131*f.Power.Cur)/256,0,1)
	
	if f.Health.Per <= f.Power.Per then
		f.Power:SetFrameLevel(f.Health:GetFrameLevel()-1)
	else
		f.Power:SetFrameLevel(f.Health:GetFrameLevel()+1)
	end
end

L.OnUpdate_ToF_gap = function(f)
	update_Health(f, f.unit)
	update_Power(f, f.unit)
	if UnitExists(f.unit) then
		f:Show()
		local eColor = {}
		if UnitIsPlayer(f.unit) then
			local eClass = select(2, UnitClass(f.unit))
			eColor = C.Color.Class[eClass]
		else
			local red, green, blue, alpha = UnitSelectionColor(f.unit)
			eColor[1] = red
			eColor[2] = green
			eColor[3] = blue
		end
			
		local name, realm = UnitName(f.unit)
		f.Name: SetText(F.Hex(eColor)..name.."|r")
	else
		f:Hide()
	end
end

L.OnUpdate_ToF = function(f)
	f.Health.Bar: SetSize(131*f.Health.Cur+F.Debug, 8)
	f.Health.Bar: SetTexCoord(62/256,(62+131*f.Health.Cur)/256,0,1)
		
	f.Power.Bar: SetSize(131*f.Power.Cur+F.Debug, 8)
	f.Power.Bar: SetTexCoord(62/256,(62+131*f.Power.Cur)/256,0,1)
	
	if f.Health.Per <= f.Power.Per then
		f.Power:SetFrameLevel(f.Health:GetFrameLevel()-1)
	else
		f.Power:SetFrameLevel(f.Health:GetFrameLevel()+1)
	end
end