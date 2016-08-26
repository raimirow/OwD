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
--> Target Frame Element      
--- ----------------------------------------------------------------------------

local HP_Coord = {
	[29] = {47,30,   0/2048, 47/2048, 1/32,31/32},
	[28] = {47,30,  47/2048, 94/2048, 1/32,31/32},
	
}

local create_Texture = function(f, texture, x,y, x1,x2,y1,y2, color,a, p1,p2,p3,p4,p5)
	f: SetTexture(F.Media..texture)
	f: SetSize(x,y)
	f: SetTexCoord(x1,x2, y1,y2)
	f: SetVertexColor(color[1], color[2], color[3])
	f: SetAlpha(a)
	f: SetPoint(p1,p2,p3,p4,p5)
end

--- ----------------------------------------------------------------------------
--> Target Frame
--- ----------------------------------------------------------------------------

local create_Health = function(f)
	f.Health = CreateFrame("Frame", nil, f)
	f.Health: SetSize(390, 10)
	f.Health: SetPoint("CENTER", f, "CENTER", 0,0)
	
	L.init_Smooth(f.Health)
	
	f.Health.Bar = f.Health:CreateTexture(nil, "ARTWORK")
	create_Texture(f.Health.Bar, "TargetHealth", 390,10, 61/512,451/512,3/16,13/16, C.Color.White,0.9, "LEFT",f.Health,"LEFT",0,0)
	f.Health.Bar_Bg = f.Health:CreateTexture(nil, "ARTWORK")
	create_Texture(f.Health.Bar_Bg, "TargetHealth", 390,10, 61/512,451/512,3/16,13/16, C.Color.White,0.3, "LEFT",f.Health,"LEFT",0,0)
	f.Health.Bar_Left = f.Health:CreateTexture(nil, "ARTWORK")
	create_Texture(f.Health.Bar_Left, "TargetBorder", 15,38, 0/16,15/16,13/64,51/64, C.Color.White,0.9, "RIGHT",f.Health,"LEFT",-6,0)
	f.Health.Bar_Right = f.Health:CreateTexture(nil, "ARTWORK")
	create_Texture(f.Health.Bar_Right, "TargetBorder", 15,38, 0/16,15/16,13/64,51/64, C.Color.White,0.9, "LEFT",f.Health,"RIGHT",6,0)
end

local create_Power = function(f)
	f.Power = CreateFrame("Frame", nil, f)
	f.Power: SetSize(390, 10)
	f.Power: SetPoint("CENTER", f, "CENTER", 0,0)
	
	L.init_Smooth(f.Power)
	
	f.Power.Bar = f.Power:CreateTexture(nil, "ARTWORK")
	create_Texture(f.Power.Bar, "TargetPower", 15,34, 0/16,15/16,15/64,49/64, C.Color.Blue,0.9, "LEFT",f.Power,"LEFT",0,0)
end

local create_Num = function(f)
	f.Num = CreateFrame("Frame", nil, f)
	
	for i = 1,15 do
		f.Num[i] =  f.Num:CreateTexture(nil, "ARTWORK")
		f.Num[i]: SetVertexColor(unpack(C.Color.White))
		f.Num[i]: SetAlpha(0.9)
		if i < 4 then
			f.Num[i]: SetTexture(F.Media.."NumCenter30")
			f.Num[i]: SetSize(L.Num_Center_30[0][1], L.Num_Center_30[0][2])
			f.Num[i]: SetTexCoord(L.Num_Center_30[0][3],L.Num_Center_30[0][4], L.Num_Center_30[0][5],L.Num_Center_30[0][6])
		elseif i == 4 then
			f.Num[i]: SetTexture(F.Media.."NumCenter20")
			f.Num[i]: SetSize(L.Num_Center_20["%"][1], L.Num_Center_20["%"][2])
			f.Num[i]: SetTexCoord(L.Num_Center_20["%"][3],L.Num_Center_20["%"][4], L.Num_Center_20["%"][5],L.Num_Center_20["%"][6])
			--f.Num[i]: SetVertexColor(unpack(C.Color.Blue))
		elseif i < 10 then
			f.Num[i]: SetTexture(F.Media.."NumCenter20")
			f.Num[i]: SetSize(L.Num_Center_20[0][1], L.Num_Center_20[0][2])
			f.Num[i]: SetTexCoord(L.Num_Center_20[0][3],L.Num_Center_20[0][4], L.Num_Center_20[0][5],L.Num_Center_20[0][6])
		elseif i == 10 then
			f.Num[i]: SetTexture(F.Media.."NumCenter20")
			f.Num[i]: SetSize(L.Num_Center_20["/"][1], L.Num_Center_20["/"][2])
			f.Num[i]: SetTexCoord(L.Num_Center_20["/"][3],L.Num_Center_20["/"][4], L.Num_Center_20["/"][5],L.Num_Center_20["/"][6])
			f.Num[i]: SetVertexColor(unpack(C.Color.Blue))
		elseif i > 10 then
			f.Num[i]: SetTexture(F.Media.."NumCenter20")
			f.Num[i]: SetSize(L.Num_Center_20[0][1], L.Num_Center_20[0][2])
			f.Num[i]: SetTexCoord(L.Num_Center_20[0][3],L.Num_Center_20[0][4], L.Num_Center_20[0][5],L.Num_Center_20[0][6])
		end
		if i == 1 then
			f.Num[i]: SetPoint("BOTTOMLEFT", f.Border, "LEFT", 24,-6)
		elseif i == 4 then
			f.Num[i]: SetPoint("BOTTOMLEFT", f.Num[i-1], "BOTTOMRIGHT", -10,0)
		elseif i < 5 then
			f.Num[i]: SetPoint("BOTTOMLEFT", f.Num[i-1], "BOTTOMRIGHT", -12,0)
		elseif i == 5 then
			f.Num[i]: SetPoint("TOPLEFT", f.Border, "LEFT", 19,-6)
		elseif i == 10 then
			f.Num[i]: SetPoint("BOTTOMLEFT", f.Num[i-1], "BOTTOMRIGHT", -9,0)
		elseif i == 11 then
			f.Num[i]: SetPoint("BOTTOMLEFT", f.Num[i-1], "BOTTOMRIGHT", -9,0)
		else
			f.Num[i]: SetPoint("BOTTOMLEFT", f.Num[i-1], "BOTTOMRIGHT", -11,0)
		end
	end
end

local create_Name = function(f)
	f.Name = L.create_Fontstring(f, C.Font.Name, 18, nil)
	f.Name: SetPoint("BOTTOMLEFT", f, "TOPLEFT", 16,6)
	f.Name: SetShadowOffset(2,2)
	f.Name: SetText("暴风城测试员")
	
	f.Lv = L.create_Fontstring(f, C.Font.Num, 12, nil)
	f.Lv: SetPoint("BOTTOMLEFT", f.Name, "BOTTOMRIGHT", 4,0)
	f.Lv: SetShadowOffset(2,2)
	f.Lv: SetText("100")
end

-->> Target Frame
L.Target_Frame = function(f)
	f.Target = CreateFrame("Frame", "OwD.Target", f)
	f.Target: SetSize(390,30)
	f.Target: SetPoint("TOP", UIParent, "TOP", 0, -60)
	f.Target.unit = "target"
	
	f.Target.Border = f.Target:CreateTexture(nil, "ARTWORK")
	create_Texture(f.Target.Border, "TargetNumBorder", 37,102, 13/64,50/64,13/128,115/128, C.Color.White,0.9, "LEFT",f.Target,"RIGHT",30,50)
	
	create_Health(f.Target)
	create_Power(f.Target)
	create_Num(f.Target)
	create_Name(f.Target)
end

--- ----------------------------------------------------------------------------
--> Target Frame Update          
--- ----------------------------------------------------------------------------

local update_Health = function(self, unit)
	local minHealth = UnitHealth(unit) or 0
	local maxHealth = UnitHealthMax(unit) or 0
	local h
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

-->> Target OnEvent
L.OnEvent_Target = function(f, event)
	if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_TARGET_CHANGED" or event == "PLAYER_XP_UPDATE" or event == "UNIT_FACTION" then -->UNIT_FACTION is for Tapping
		if UnitExists("target") then
			f:Show()
			
			-->
			local eColor = {}
			if UnitIsPlayer("target") then
				local eClass = select(2, UnitClass("target"))
				eColor = C.Color.Class[eClass] or C.Color.White
			else
				--[[
				local canAttack = UnitCanAttack("player", "target")
				local reaction = UnitReaction("player", "target")
				print(UnitClassification("target"), reaction)
				
				if reaction < 4 then
					eColor = {255/255, 96/255, 96/255}
				elseif reaction > 4 then
					eColor = {108/255, 255/255, 96/255}
				else
					if canAttack then
						eColor = {255/255, 96/255, 96/255}
					else
						eColor = {252/255, 255/255, 120/255}
					end
				end
				--]]
				local red, green, blue, alpha = UnitSelectionColor("target")
				eColor[1] = red
				eColor[2] = green
				eColor[3] = blue
			end
			--f.B2: SetVertexColor(unpack(eColor))--职业颜色
			local name, realm = UnitName("target")
			f.Name: SetText(F.Hex(eColor)..name.."|r")
			if(not UnitPlayerControlled("target")) and UnitIsTapped("target") and (not UnitIsTappedByPlayer("target")) and (not UnitIsTappedByAllThreatList("target")) then
				f.Name: SetText(F.Hex(C.Color.Tapped)..name.."|r")
			else
				f.Name: SetText(F.Hex(eColor)..name.."|r")
			end
			
			-->
			local level = UnitLevel("target")
			local classification = UnitClassification(f.unit)
			--[[
			elite - Elite
			minus - Minion of another NPC; does not give experience or reputation.
			normal - Normal
			rare - Rare
			rareelite - Rare-Elite
			worldboss - World Boss
			--]]
			if level and level < 0 then
				f.Lv: SetText("Boss")
			else
				if classification == "elite" then
					f.Lv: SetText(level.." Elite")
				elseif classification == "rare" then
					f.Lv: SetText(level.." Rare")
				elseif classification == "rareelite" then
					f.Lv: SetText(level.." RareElite")
				elseif classification == "worldboss" then
					f.Lv: SetText(level.." WorldBoss")
				else
					f.Lv: SetText(level)
				end
			end
			
		else
			f:Hide()
		end
		L.update_Health(f, f.unit)
		L.update_Power(f, f.unit)
		--update_Threat(f, f.unit)
	end
	
	if event == "UNIT_HEALTH_FREQUENT" or event == "UNIT_MAXHEALTH" then
		L.update_Health(f, f.unit)
	end
	
	if event == "UNIT_POWER_FREQUENT" or event == "UNIT_MAXPOWER" then
		L.update_Power(f, f.unit)
	end
	
	if event == "UNIT_THREAT_SITUATION_UPDATE" or event == "UNIT_THREAT_LIST_UPDATE" or event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED" then
		--update_Threat(f, f.unit)
	end
end

L.OnUpdate_Target = function(f)
	--> Update Bar
	f.Health.Bar: SetSize(390*f.Health.Cur+F.Debug, 10)
	f.Health.Bar: SetTexCoord(61/512,(61+390*f.Health.Cur)/512,3/16,13/16)
	--f.Power.Bar: ClearAllPoints()
	f.Power.Bar: SetPoint("LEFT",f.Power,"LEFT",382*f.Power.Cur-7+4,0)
	
	--> Health Percent
	local hPer = f.Health.Cur
	local hPer1,hPer2,hPer3
	hPer1 = floor(hPer)
	hPer2 = min(floor(hPer*10)-hPer1*10, 9)
	hPer3 = min(floor(hPer*100)-floor(hPer*10)*10, 9)
	if hPer1 <= 0 then
		hPer1 = "B"
		if hPer2 <= 0 then
			hPer2 = "B"
		end
	end
	if f.Num then
		f.Num[1]: SetSize(L.Num_Center_30[hPer1][1], L.Num_Center_30[hPer1][2])
		f.Num[1]: SetTexCoord(L.Num_Center_30[hPer1][3],L.Num_Center_30[hPer1][4], L.Num_Center_30[hPer1][5],L.Num_Center_30[hPer1][6])
		f.Num[2]: SetSize(L.Num_Center_30[hPer2][1], L.Num_Center_30[hPer2][2])
		f.Num[2]: SetTexCoord(L.Num_Center_30[hPer2][3],L.Num_Center_30[hPer2][4], L.Num_Center_30[hPer2][5],L.Num_Center_30[hPer2][6])
		f.Num[3]: SetSize(L.Num_Center_30[hPer3][1], L.Num_Center_30[hPer3][2])
		f.Num[3]: SetTexCoord(L.Num_Center_30[hPer3][3],L.Num_Center_30[hPer3][4], L.Num_Center_30[hPer3][5],L.Num_Center_30[hPer3][6])
	end
	
	--> Health Value
	local h = f.Health.Cur * f.Health.Max
	local h1,h2,h3,h4,h5
	if h >= 1e10 then
		h = h/1e9
		h5 = "g"
	elseif h >= 1e7 then
		h = h/1e6
		h5 = "m"
	elseif h >= 1e4 then
		h = h/1e3
		h5 = "k"
	else
		h5 = "B"
	end
	h1 = floor(h/1e3)
	h2 = floor(h/100)-h1*10
	h3 = floor(h/10)-h1*100-h2*10
	h4 = floor(h)-floor(h/10)*10
	if h1 <= 0 then
		h1 = "B"
		if h2 <= 0 then
			h2 = "B"
			if h3 <= 0 then
				h3 = "B"
			end
		end
	end
	if f.Num then
		f.Num[5]: SetSize(L.Num_Center_20[h1][1], L.Num_Center_20[h1][2])
		f.Num[5]: SetTexCoord(L.Num_Center_20[h1][3],L.Num_Center_20[h1][4], L.Num_Center_20[h1][5],L.Num_Center_20[h1][6])
		f.Num[6]: SetSize(L.Num_Center_20[h2][1], L.Num_Center_20[h2][2])
		f.Num[6]: SetTexCoord(L.Num_Center_20[h2][3],L.Num_Center_20[h2][4], L.Num_Center_20[h2][5],L.Num_Center_20[h2][6])
		f.Num[7]: SetSize(L.Num_Center_20[h3][1], L.Num_Center_20[h3][2])
		f.Num[7]: SetTexCoord(L.Num_Center_20[h3][3],L.Num_Center_20[h3][4], L.Num_Center_20[h3][5],L.Num_Center_20[h3][6])
		f.Num[8]: SetSize(L.Num_Center_20[h4][1], L.Num_Center_20[h4][2])
		f.Num[8]: SetTexCoord(L.Num_Center_20[h4][3],L.Num_Center_20[h4][4], L.Num_Center_20[h4][5],L.Num_Center_20[h4][6])
		f.Num[9]: SetSize(L.Num_Center_20[h5][1], L.Num_Center_20[h5][2])
		f.Num[9]: SetTexCoord(L.Num_Center_20[h5][3],L.Num_Center_20[h5][4], L.Num_Center_20[h5][5],L.Num_Center_20[h5][6])
	end
	
	--> Power Value
	local p = f.Power.Cur * f.Power.Max
	local p1,p2,p3,p4,p5
	if p >= 1e10 then
		p = p/1e9
		p5 = "g"
	elseif p >= 1e7 then
		p = p/1e6
		h5 = "m"
	elseif p >= 1e4 then
		p = p/1e3
		p5 = "k"
	else
		p5 = "B"
	end
	p1 = floor(p/1e3)
	p2 = floor(p/100)-p1*10
	p3 = floor(p/10)-p1*100-p2*10
	p4 = floor(p)-floor(p/10)*10
	if p1 <= 0 then
		p1 = "B"
		if p2 <= 0 then
			p2 = "B"
			if p3 <= 0 then
				p3 = "B"
			end
		end
	end
	if f.Num then
		f.Num[11]: SetSize(L.Num_Center_20[p1][1], L.Num_Center_20[p1][2])
		f.Num[11]: SetTexCoord(L.Num_Center_20[p1][3],L.Num_Center_20[p1][4], L.Num_Center_20[p1][5],L.Num_Center_20[p1][6])
		f.Num[12]: SetSize(L.Num_Center_20[p2][1], L.Num_Center_20[p2][2])
		f.Num[12]: SetTexCoord(L.Num_Center_20[p2][3],L.Num_Center_20[p2][4], L.Num_Center_20[p2][5],L.Num_Center_20[p2][6])
		f.Num[13]: SetSize(L.Num_Center_20[p3][1], L.Num_Center_20[p3][2])
		f.Num[13]: SetTexCoord(L.Num_Center_20[p3][3],L.Num_Center_20[p3][4], L.Num_Center_20[p3][5],L.Num_Center_20[p3][6])
		f.Num[14]: SetSize(L.Num_Center_20[p4][1], L.Num_Center_20[p4][2])
		f.Num[14]: SetTexCoord(L.Num_Center_20[p4][3],L.Num_Center_20[p4][4], L.Num_Center_20[p4][5],L.Num_Center_20[p4][6])
		f.Num[15]: SetSize(L.Num_Center_20[p5][1], L.Num_Center_20[p5][2])
		f.Num[15]: SetTexCoord(L.Num_Center_20[p5][3],L.Num_Center_20[p5][4], L.Num_Center_20[p5][5],L.Num_Center_20[p5][6])
	end
end


--- ----------------------------------------------------------------------------
--> Target of Target Frame
--- ----------------------------------------------------------------------------
local create_ToT_Health = function(f)
	f.Health = CreateFrame("Frame", nil, f)
	
	L.init_Smooth(f.Health)
end

local create_ToT_Name = function(f)
	f.Name = L.create_Fontstring(f, C.Font.Name, 18, nil)
	f.Name: SetPoint("TOPLEFT", f, "TOPLEFT", 0,0)
	f.Name: SetShadowOffset(2,2)
	f.Name: SetText("暴风城测试员")
	
	f.Lv = L.create_Fontstring(f, C.Font.Num, 12, nil)
	f.Lv: SetPoint("TOPRIGHT", f.Name, "BOTTOMRIGHT", 0,-2)
	f.Lv: SetShadowOffset(2,2)
	f.Lv: SetText("100")
end

local create_ToT_Num = function(f)
	f.Num = CreateFrame("Frame", nil, f)
	
	for i = 1,4 do
		f.Num[i] =  f.Num:CreateTexture(nil, "ARTWORK")
		f.Num[i]: SetVertexColor(unpack(C.Color.White))
		f.Num[i]: SetAlpha(0.9)
		f.Num[i]: SetTexture(F.Media.."NumCenter20")
		f.Num[i]: SetSize(L.Num_Center_20[0][1], L.Num_Center_20[0][2])
		f.Num[i]: SetTexCoord(L.Num_Center_20[0][3],L.Num_Center_20[0][4], L.Num_Center_20[0][5],L.Num_Center_20[0][6])
		
		if i == 4 then
			f.Num[i]: SetTexture(F.Media.."NumCenter20")
			f.Num[i]: SetSize(L.Num_Center_20["%"][1], L.Num_Center_20["%"][2])
			f.Num[i]: SetTexCoord(L.Num_Center_20["%"][3],L.Num_Center_20["%"][4], L.Num_Center_20["%"][5],L.Num_Center_20["%"][6])
			--f.Num[i]: SetVertexColor(unpack(C.Color.Blue))
		end
		
		if i == 1 then
			f.Num[i]: SetPoint("TOPLEFT", f.Name, "TOPRIGHT", 4,4)
		else
			f.Num[i]: SetPoint("BOTTOMLEFT", f.Num[i-1], "BOTTOMRIGHT", -11,0)
		end
	end
end

L.ToT_Frame = function(f)
	f.ToT = CreateFrame("Frame", nil, f)
	f.ToT: SetSize(120,20)
	f.ToT: SetPoint("TOPLEFT", f.Target, "BOTTOMRIGHT", 30, 0)
	f.ToT.unit = "targettarget"
	
	create_ToT_Health(f.ToT)
	create_ToT_Name(f.ToT)
	create_ToT_Num(f.ToT)
end

L.OnUpdate_ToT_gap = function(f)
	if not UnitExists(f.unit) then return end
	L.update_Health(f, f.unit)
	
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
		
	local level = UnitLevel(f.unit)
	if level and level < 0 then
		f.Lv: SetText("Boss")
	else
		f.Lv: SetText(level)
	end
end

L.OnUpdate_ToT = function(f, elapsed)
	if not UnitExists(f.unit) then f:Hide() return end
	f:Show()
	
	if f.Num then
		h = f.Health.Cur
		h1 = max(min(floor(h), 9), 0)
		h2 = max(min(floor(h*10)-h1*10, 9), 0)
		h3 = max(min(floor(h*100)-floor(h*10)*10, 9), 0)
		if h1 <= 0 then
			h1 = "B"
			if h2 <= 0 then
				h2 = "B"
			end
		end
		--h1 = "B"
		--h2 = "B"
		
		f.Num[1]: SetSize(L.Num_Center_20[h1][1], L.Num_Center_20[h1][2])
		f.Num[1]: SetTexCoord(L.Num_Center_20[h1][3],L.Num_Center_20[h1][4], L.Num_Center_20[h1][5],L.Num_Center_20[h1][6])
		f.Num[2]: SetSize(L.Num_Center_20[h2][1], L.Num_Center_20[h2][2])
		f.Num[2]: SetTexCoord(L.Num_Center_20[h2][3],L.Num_Center_20[h2][4], L.Num_Center_20[h2][5],L.Num_Center_20[h2][6])
		f.Num[3]: SetSize(L.Num_Center_20[h3][1], L.Num_Center_20[h3][2])
		f.Num[3]: SetTexCoord(L.Num_Center_20[h3][3],L.Num_Center_20[h3][4], L.Num_Center_20[h3][5],L.Num_Center_20[h3][6])
	end
end