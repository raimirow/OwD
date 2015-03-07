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

local Num1 = {
	[1] =	{12,24,  60/256, 72/256,  4/32,28/32},
	[2] =	{13,24,  72/256, 85/256,  4/32,28/32},
	[3] =	{12,24,  86/256, 98/256,  4/32,28/32},
	[4] =	{12,24,  99/256,111/256,  4/32,28/32},
	[5] =	{12,24, 112/256,124/256,  4/32,28/32},
	[6] =	{12,24, 125/256,137/256,  4/32,28/32},
	[7] =	{12,24, 138/256,150/256,  4/32,28/32},
	[8] =	{12,24, 150/256,162/256,  4/32,28/32},
	[9] =	{12,24, 163/256,175/256,  4/32,28/32},
	[0] =	{12,24, 177/256,189/256,  4/32,28/32},
	["%"] =	{10,24, 191/256,201/256,  4/32,28/32},
}

local Num2 = {
	[1] =	{10,19,  60/256, 70/256,  6/32,25/32},
	[2] =	{10,19,  70/256, 80/256,  6/32,25/32},
	[3] =	{10,19,  81/256, 91/256,  6/32,25/32},
	[4] =	{10,19,  91/256,101/256,  6/32,25/32},
	[5] =	{10,19, 102/256,112/256,  6/32,25/32},
	[6] =	{10,19, 113/256,123/256,  6/32,25/32},
	[7] =	{ 9,19, 124/256,133/256,  6/32,25/32},
	[8] =	{ 9,19, 133/256,142/256,  6/32,25/32},
	[9] =	{10,19, 143/256,153/256,  6/32,25/32},
	[0] =	{10,19, 154/256,164/256,  6/32,25/32},
	["K"] =	{ 9,19, 167/256,176/256,  6/32,25/32},
	["M"] =	{10,19, 176/256,186/256,  6/32,25/32},
	["G"] =	{ 9,19, 186/256,195/256,  6/32,25/32},
	["."] =	{ 5, 5, 195/255,200/255, 21/32,25/32},
}

local hpBar = {
	[0] =	{2/64,62/64, 193/256,209/256,  60, 0},
	[1] =	{2/64,62/64, 193/256,209/256,  60,16},
	[2] =	{2/64,62/64, 177/256,193/256,  60,16},
	[3] =	{2/64,62/64, 161/256,177/256,  60,16},
	[4] =	{2/64,62/64, 145/256,161/256,  60,16},
	[5] =	{2/64,62/64, 129/256,145/256,  60,16},
	[6] =	{2/64,62/64, 113/256,129/256,  60,16},
	[7] =	{2/64,62/64,  97/256,113/256,  60,16},
	[8] =	{2/64,62/64,  81/256, 97/256,  60,16},
	[9] =	{2/64,62/64,  48/256, 81/256,  60,33},
	[10] =	{2/64,62/64,  48/256, 81/256,  60,33},
	[11] =	{2/64,62/64,  48/256, 81/256,  60, 0},
}

local create_Texture = function(f, texture, x,y, x1,x2,y1,y2, color,a, p1,p2,p3,p4,p5)
	f: SetTexture(F.Media..texture)
	f: SetSize(x,y)
	f: SetTexCoord(x1,x2, y1,y2)
	f: SetVertexColor(color[1], color[2], color[3])
	f: SetAlpha(a)
	f: SetPoint(p1,p2,p3,p4,p5)
end

local create_Health = function(f)
	f.Health = CreateFrame("Frame", nil, f)
	f.Health: SetSize(60, 161)
	f.Health: SetPoint("BOTTOMRIGHT", f, "RIGHT", -8,-3)
	
	L.init_Smooth(f.Health)
	
	f.Health.Bar = f.Health:CreateTexture(nil, "ARTWORK")
	create_Texture(f.Health.Bar, "Target_HP_Bar", 60,141, 2/64,62/64,68/256,209/256, C.Color.White,0.9, "BOTTOM",f.Health,"BOTTOM",0,0)
	f.Health.exBar = f.Health:CreateTexture(nil, "BORDER")
	create_Texture(f.Health.exBar, "Target_HP_Bar", 60,161, 2/64,62/64,48/256,209/256, C.Color.Red,0.9, "BOTTOM",f.Health.Bar,"TOP",0,0)
	f.Health.BarBg = f.Health:CreateTexture(nil, "BACKGROUND")
	create_Texture(f.Health.BarBg, "Target_HP_Bar", 60,161, 2/64,62/64,48/256,209/256, C.Color.White2,0.4, "BOTTOM",f.Health,"BOTTOM",0,0)
end

local create_Power = function(f)
	f.Power = CreateFrame("Frame", nil, f)
	f.Power: SetSize(35, 95)
	f.Power: SetPoint("TOPRIGHT", f, "RIGHT", -8,-14)
	
	L.init_Smooth(f.Power)
	
	f.Power.Bar = f.Power:CreateTexture(nil, "ARTWORK")
	create_Texture(f.Power.Bar, "Target_PP_Bar", 35,75, 15/64,50/64,17/128,92/128, C.Color.White,0.9, "TOP",f.Power,"TOP",0,0)
	f.Power.BarBg = f.Power:CreateTexture(nil, "BACKGROUND")
	create_Texture(f.Power.BarBg, "Target_PP_Bar", 35,95, 15/64,50/64,17/128,112/128, C.Color.White2,0.4, "TOP",f.Power,"TOP",0,0)
end

local create_Threat = function(f)
	f.Threat = CreateFrame("Frame", nil, f)
	f.Threat: SetSize(35, 95)
	f.Threat: SetPoint("TOPLEFT", f.BorderThreat, "LEFT", 9,-14)
	
	f.Threat.Bar = f.Threat:CreateTexture(nil, "ARTWORK")
	create_Texture(f.Threat.Bar, "Target_Threat_Bar", 35,75, 15/64,50/64,17/128,92/128, C.Color.White,0.9, "TOP",f.Threat,"TOP",0,0)
	f.Threat.BarBg = f.Threat:CreateTexture(nil, "BACKGROUND")
	create_Texture(f.Threat.BarBg, "Target_Threat_Bar", 35,95, 15/64,50/64,17/128,112/128, C.Color.White2,0.4, "TOP",f.Threat,"TOP",0,0)
	
	f.Threat.Line = f.Threat:CreateTexture(nil, "ARTWORK")
	create_Texture(f.Threat.Line, "Target_HP_Line", 26,4, 3/32,29/32,2/8,6/8, C.Color.White,0.9, "TOPRIGHT",f.Threat,"TOPLEFT",0,0)
	
	for i = 1,4 do
		f.Threat[i] = f.Threat:CreateTexture(nil, "ARTWORK")
		f.Threat[i]: SetTexture(F.Media.."Target_Num1")
		f.Threat[i]: SetVertexColor(unpack(C.Color.White))
		f.Threat[i]: SetAlpha(0.9)
		f.Threat[i]: SetSize(Num1[0][1], Num1[0][2])
		f.Threat[i]: SetTexCoord(Num1[0][3],Num1[0][4], Num1[0][5],Num1[0][6])
	end
	f.Threat[4]: SetPoint("TOPRIGHT", f.Threat.Line, "TOPLEFT", -4,0)
	f.Threat[3]: SetPoint("BOTTOMRIGHT", f.Threat[4], "BOTTOMLEFT", -2,0)
	f.Threat[2]: SetPoint("BOTTOMRIGHT", f.Threat[3], "BOTTOMLEFT", 2,0)
	f.Threat[1]: SetPoint("BOTTOMRIGHT", f.Threat[2], "BOTTOMLEFT", 2,0)
	
	f.Threat[4]: SetSize(Num1["%"][1], Num1["%"][2])
	f.Threat[4]: SetTexCoord(Num1["%"][3],Num1["%"][4], Num1["%"][5],Num1["%"][6])
end

local create_HP_perNum = function(f)
	f.PerNum = CreateFrame("Frame", nil, f)
	f.PerNum: SetSize(26,4)
	--f.Health.PerNum: SetPoint("LEFT", f, "CENTER", 319,0)
	
	f.PerNum.Line = f.PerNum:CreateTexture(nil, "ARTWORK")
	create_Texture(f.PerNum.Line, "Target_HP_Line", 26,4, 3/32,29/32,2/8,6/8, C.Color.White,0.9, "BOTTOMLEFT",f.PerNum,"BOTTOMLEFT",0,0)
	
	for i = 1,3 do
		f.PerNum[i] = f.PerNum:CreateTexture(nil, "ARTWORK")
		f.PerNum[i]: SetTexture(F.Media.."Target_Num1")
		f.PerNum[i]: SetVertexColor(unpack(C.Color.White))
		f.PerNum[i]: SetAlpha(0.9)
		f.PerNum[i]: SetSize(Num1[0][1], Num1[0][2])
		f.PerNum[i]: SetTexCoord(Num1[0][3],Num1[0][4], Num1[0][5],Num1[0][6])
	end
	f.PerNum[1]: SetPoint("BOTTOMLEFT", f.PerNum.Line, "BOTTOMRIGHT", 4,0)
	f.PerNum[2]: SetPoint("BOTTOMLEFT", f.PerNum[1], "BOTTOMRIGHT", -2,0)
	f.PerNum[3]: SetPoint("BOTTOMLEFT", f.PerNum[2], "BOTTOMRIGHT", 2,0)
	f.PerNum[3]: SetSize(Num1["%"][1], Num1["%"][2])
	f.PerNum[3]: SetTexCoord(Num1["%"][3],Num1["%"][4], Num1["%"][5],Num1["%"][6])
end

local create_Num = function(f, p1,p2,p3,p4,p5)
	f.Num = CreateFrame("Frame", nil, f)
	for i = 1,4 do
		f.Num[i] = f.Num:CreateTexture(nil, "ARTWORK")
		f.Num[i]: SetVertexColor(unpack(C.Color.White))
		f.Num[i]: SetAlpha(0.9)
		f.Num[i]: SetTexture(F.Media.."Target_Num2")
		f.Num[i]: SetSize(Num2[0][1], Num2[0][2])
		f.Num[i]: SetTexCoord(Num2[0][3],Num2[0][4], Num2[0][5],Num2[0][6])
		if i == 1 then
			f.Num[i]: SetPoint(p1,p2,p3,p4,p5)
		else
			f.Num[i]: SetPoint("BOTTOMLEFT",f.Num[i-1],"BOTTOMRIGHT",-1,0)
		end
	end
	f.Num.Dot = f.Num:CreateTexture(nil, "ARTWORK")
	create_Texture(f.Num.Dot, "Target_Num2", Num2["."][1],Num2["."][2], Num2["."][3],Num2["."][4],Num2["."][5],Num2["."][6], C.Color.White,1, "BOTTOMLEFT",f.Num[4],"BOTTOMRIGHT",-2.5,-4)
end

local create_Name = function(f)
	f.Classification = f:CreateTexture(nil, "ARTWORK")
	create_Texture(f.Classification, "Target_Classification_B1", 30,24, 1/32,31/32,5/32,29/32, C.Color.White2,0.9, "BOTTOMRIGHT",f.Border,"TOPLEFT",0,3)
	--f.Classification: Hide()
	
	f.Classification_Font = f:CreateTexture(nil, "ARTWORK")
	create_Texture(f.Classification_Font, "Target_Classification_RareElite", 52,17, 6/64,58/64,8/32,25/32, C.Color.White,1, "RIGHT",f.Classification,"LEFT",0,-1)
	f.Classification_Font: Hide()
	
	f.Name = L.create_Fontstring(f, C.Font.Name, 18, nil)
	--f.Name: SetWidth(120)
	f.Name: SetPoint("BOTTOMLEFT", f, "TOPLEFT", 16,9)
	f.Name: SetText("暴风城测试员")
	
	f.Lv = L.create_Fontstring(f, C.Font.Num, 12, nil)
	--f.Lv: SetWidth(120)
	f.Lv: SetPoint("BOTTOMLEFT", f.Name, "BOTTOMRIGHT", 4,-1)
	f.Lv: SetText("100")
end

--- ----------------------------------------------------------------------------
--> Target Frame
--- ----------------------------------------------------------------------------

L.Target_Frame = function(f)
	f.Target = CreateFrame("Frame", nil, f)
	f.Target: SetSize(112,402)
	f.Target: SetPoint("CENTER", f, "CENTER", 264, 1)
	f.Target.unit = "target"
	
	f.Target.Border = f.Target:CreateTexture(nil, "ARTWORK")
	create_Texture(f.Target.Border, "Target_Border", 112,402, 8/128,120/128,55/512,457/512, C.Color.White2,0.9, "CENTER",f.Target,"CENTER",0,0)
	--[[
	f.Target.B1 = f.Target:CreateTexture(nil, "ARTWORK")
	create_Texture(f.Target.B1, "Target_B1", 1024,512, 0,1,0,1, C.Color.White,0.9, "CENTER",f,"CENTER",0,0)
	--]]
	f.Target.B2 = f.Target:CreateTexture(nil, "OVERLAY")
	create_Texture(f.Target.B2, "Target_B2", 1024,8, 0,1,0,1, C.Color.White2,0.9, "CENTER",f,"CENTER",0,0)
	
	f.Target.BorderThreat = f.Target:CreateTexture(nil, "ARTWORK")
	create_Texture(f.Target.BorderThreat, "Target_Threat_Border", 112,402, 8/128,120/128,55/512,457/512, C.Color.White2,0.9, "CENTER", f, "CENTER", -264, 1)
	
	create_Health(f.Target)
	create_Power(f.Target)
	create_HP_perNum(f.Target.Health)
	create_Num(f.Target.Health, "BOTTOMLEFT",f.Target.Health,"TOPLEFT",-4,14)
	create_Num(f.Target.Power, "TOPLEFT",f.Target.Power,"BOTTOMLEFT",-4,-14)
	
	create_Name(f.Target)
	
	create_Threat(f.Target)
end

--- ----------------------------------------------------------------------------
--> Target Frame Update          
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

local update_Threat = function(f, unit)
	if UnitExists(unit) and UnitAffectingCombat("player") then
		f.Threat: Show()
	else
		f.Threat: Hide()
	end
	
	local status, threatpct = 0,0
	if UnitCanAttack("player", "target") and not(UnitIsDead("target") or UnitIsFriend("player", "target") or UnitPlayerControlled("target")) then
		_, status, threatpct = UnitDetailedThreatSituation("player", "target")
	elseif (not (UnitCanAttack("player", "target")) and UnitCanAttack("player", "targettarget") or UnitIsDead("targettarget") or UnitIsFriend("player", "targettarget") or UnitPlayerControlled("targettarget")) then
		_, status, threatpct = UnitDetailedThreatSituation("player", "targettarget")
	end
	
	local d
	if threatpct then
		d = min(threatpct/100, 1)
	else
		d = 0
	end
	
	f.Threat.Bar: SetSize(35,95*d+F.Debug)
	f.Threat.Bar: SetTexCoord(15/64,50/64,17/128,(17+95*d)/128)
	
	local gp = f:GetParent()
	f.Threat.Line: ClearAllPoints()
	f.Threat.Line: SetPoint("RIGHT", gp, "CENTER", -cos(rad(2.8+17.2*d))*319,-sin(rad(2.8+17.2*d))*319)
	
	status = status or 0
	if status == 0 then
		f.Threat.Bar: SetVertexColor(unpack(C.Color.White))
	elseif status == 1 then
		f.Threat.Bar: SetVertexColor(unpack(C.Color.Yellow))
	else
		f.Threat.Bar: SetVertexColor(unpack(C.Color.Red))
	end
	
	local ph1,ph2,ph3	
	ph1 = floor(abs(d))
	ph2 = floor(abs(d*10-ph1*10))
	ph3 = floor(abs(d*100-floor(d*10)*10))
	
	if ph1 <= 0 then
		f.Threat[1]: SetAlpha(0.3)
		if ph2 <=0 then
			f.Threat[2]: SetAlpha(0.3)
		else
			f.Threat[2]: SetAlpha(0.9)
		end
	else
		f.Threat[2]: SetAlpha(0.9)
		f.Threat[1]: SetAlpha(0.9)
	end
	
	f.Threat[1]: SetSize(Num1[ph1][1], Num1[ph1][2])
	f.Threat[1]: SetTexCoord(Num1[ph1][3],Num1[ph1][4], Num1[ph1][5],Num1[ph1][6])
	f.Threat[2]: SetSize(Num1[ph2][1], Num1[ph2][2])
	f.Threat[2]: SetTexCoord(Num1[ph2][3],Num1[ph2][4], Num1[ph2][5],Num1[ph2][6])
	f.Threat[3]: SetSize(Num1[ph3][1], Num1[ph3][2])
	f.Threat[3]: SetTexCoord(Num1[ph3][3],Num1[ph3][4], Num1[ph3][5],Num1[ph3][6])
end

L.OnEvent_Target = function(f, event)
	if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_TARGET_CHANGED" or event == "PLAYER_XP_UPDATE" or event == "UNIT_FACTION" then -->UNIT_FACTION is for Tapping
		if UnitExists("target") then
			f:Show()
			
			local eColor = {}
			if UnitIsPlayer("target") then
				local eClass = select(2, UnitClass("target"))
				eColor = C.Color.Class[eClass]
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
			f.B2: SetVertexColor(unpack(eColor))
			
			local name, realm = UnitName("target")
			--f.Name: SetText(F.Hex(eColor)..name.."|r")
			if(not UnitPlayerControlled("target")) and UnitIsTapped("target") and (not UnitIsTappedByPlayer("target")) and (not UnitIsTappedByAllThreatList("target")) then
				f.Name: SetText(F.Hex(C.Color.Tapped)..name.."|r")
			else
				f.Name: SetText(F.Hex(eColor)..name.."|r")
			end
			
			local level = UnitLevel("target")
			if level and level < 0 then
				f.Lv: SetText("Boss")
			else
				f.Lv: SetText(level)
			end

			local classification = UnitClassification(f.unit)
			--[[
			elite - Elite
			minus - Minion of another NPC; does not give experience or reputation.
			normal - Normal
			rare - Rare
			rareelite - Rare-Elite
			worldboss - World Boss
			--]]
			if classification == "elite" then
				--f.Classification: Show()
				f.Classification_Font: Show()
				f.Classification_Font: SetTexture(F.Media.."Target_Classification_Elite")
				f.Classification_Font: SetSize(23, 17)
				f.Classification_Font: SetTexCoord(4/32,27/32, 8/32,25/32)
			elseif classification == "rare" then
				--f.Classification: Show()
				f.Classification_Font: Show()
				f.Classification_Font: SetTexture(F.Media.."Target_Classification_Rare")
				f.Classification_Font: SetSize(26, 17)
				f.Classification_Font: SetTexCoord(3/32,29/32, 8/32,25/32)
			elseif classification == "rareelite" then
				--f.Classification: Show()
				f.Classification_Font: Show()
				f.Classification_Font: SetTexture(F.Media.."Target_Classification_RareElite")
				f.Classification_Font: SetSize(52, 17)
				f.Classification_Font: SetTexCoord(6/64,58/64,8/32,25/32)
			elseif classification == "worldboss" then
				--f.Classification: Show()
				f.Classification_Font: Show()
				f.Classification_Font: SetTexture(F.Media.."Target_Classification_Boss")
				f.Classification_Font: SetSize(26, 17)
				f.Classification_Font: SetTexCoord(3/32,29/32, 8/32,25/32)
			else
				--f.Classification: Hide()
				f.Classification_Font: Hide()
			end
	
		else
			f:Hide()
			f.Name: SetText("")
			f.Lv: SetText("")
			
			--f.Classification: Hide()
			f.Classification_Font: Hide()
		end
		update_Health(f, f.unit)
		update_Power(f, f.unit)
		update_Threat(f, f.unit)
	end
	
	if event == "UNIT_HEALTH_FREQUENT" or event == "UNIT_MAXHEALTH" then
		update_Health(f, f.unit)
	end
	
	if event == "UNIT_POWER_FREQUENT" or event == "UNIT_MAXPOWER" then
		update_Power(f, f.unit)
	end
	
	if event == "UNIT_THREAT_SITUATION_UPDATE" or event == "UNIT_THREAT_LIST_UPDATE" or event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED" then
		update_Threat(f, f.unit)
	end
end

L.OnUpdate_Target = function(f)
	local h = floor(f.Health.Cur*10)
	if h >= 8 and h < 10 then
		h = 8
	end
	
	f.Health.Bar: SetSize(60, 161*(h/10)+F.Debug)
	f.Health.Bar: SetTexCoord(2/64,62/64,(48+161*abs(1-h/10))/256,209/256)
	if f.Health.Cur == 0 then
		f.Health.exBar: SetSize(hpBar[11][5], hpBar[11][6]+F.Debug)
		f.Health.exBar: SetTexCoord(hpBar[11][1],hpBar[11][2],hpBar[11][3],hpBar[11][4])
	else
		f.Health.exBar: SetSize(hpBar[h+1][5], hpBar[h+1][6]+F.Debug)
		f.Health.exBar: SetTexCoord(hpBar[h+1][1],hpBar[h+1][2],hpBar[h+1][3],hpBar[h+1][4])
	end
	
	f.Power.Bar: SetSize(35,95*f.Power.Cur+F.Debug)
	f.Power.Bar: SetTexCoord(15/64,50/64,17/128,(17+95*f.Power.Cur)/128)
	
	local gp = f:GetParent()
	f.Health.PerNum: SetPoint("LEFT", gp, "CENTER", cos(rad(-0.4+30*f.Health.Cur))*319,sin(rad(-0.4+30*f.Health.Cur))*319)
	
	local perh,ph1,ph2
	perh = f.Health.Cur
	
	ph1 = min(floor(perh*10), 9)
	ph2 = min(floor(perh*100)-ph1*10, 9)
	
	if perh == 1 then
		f.Health.PerNum:Hide()
	else
		f.Health.PerNum:Show()
	end
	if ph1 <= 0 then
		f.Health.PerNum[1]: SetAlpha(0.3)
	else
		f.Health.PerNum[1]: SetAlpha(0.9)
	end
	
	f.Health.PerNum[1]: SetSize(Num1[ph1][1], Num1[ph1][2])
	f.Health.PerNum[1]: SetTexCoord(Num1[ph1][3],Num1[ph1][4], Num1[ph1][5],Num1[ph1][6])
	f.Health.PerNum[2]: SetSize(Num1[ph2][1], Num1[ph2][2])
	f.Health.PerNum[2]: SetTexCoord(Num1[ph2][3],Num1[ph2][4], Num1[ph2][5],Num1[ph2][6])
	
	local h,h1,h2,h3,h4,h5,h6, p,p1,p2,p3,p4,p5,p6
	h = f.Health.Cur * f.Health.Max
	p = f.Power.Cur * f.Power.Max
	
	if h < 1e3 then
		h1 = max(floor(h/1000), 0)
		h2 = max(floor(h/100)-h1*10, 0)
		h3 = max(floor(h/10)-h1*100-h2*10, 0)
		h4 = max(floor(h)-floor(h/10)*10, 0)
		
		if h1 <= 0 then
			f.Health.Num[1]: SetAlpha(0.3)
			if h2 <= 0 then
				f.Health.Num[2]: SetAlpha(0.3)
				if h3 <= 0 then
					f.Health.Num[3]: SetAlpha(0.3)
				else
					f.Health.Num[3]: SetAlpha(0.9)
				end
			else
				f.Health.Num[2]: SetAlpha(0.9)
				f.Health.Num[3]: SetAlpha(0.9)
			end
		else
			f.Health.Num[1]: SetAlpha(0.9)
			f.Health.Num[2]: SetAlpha(0.9)
			f.Health.Num[3]: SetAlpha(0.9)
		end
		f.Health.Num.Dot: Hide()
	else
		if h >= 1e3 and h < 1e6 then
			h = h/1e3
			h4 = "K"
		elseif h >= 1e6 and h < 1e9 then
			h = h/1e6
			h4 = "M"
		elseif h >= 1e9 and h < 1e12 then
			h = h/1e9
			h4 = "G"
		else
			h = 0
			h4 = 0
		end
		h1 = max(floor(h/100), 0)
		h2 = max(floor(h/10)-h1*10, 0)
		h3 = max(floor(h)-h1*100-h2*10, 0)
		h5 = floor(abs(h*10-floor(h)*10))
		h6 = floor(abs(h*100-floor(h*10)*10))
		
		f.Health.Num[1]: SetAlpha(0.9)
		f.Health.Num[2]: SetAlpha(0.9)
		f.Health.Num[3]: SetAlpha(0.9)
		
		if h2 <= 0 and h1 <= 0 then
			h1 = h3
			h2 = h5
			h3 = h6
			f.Health.Num.Dot: ClearAllPoints()
			f.Health.Num.Dot: SetPoint("BOTTOMLEFT", f.Health.Num[1],"BOTTOMRIGHT", -2.5,-4)
			f.Health.Num.Dot: Show()
		elseif h1 <= 0 and h2 > 0 then
			h1 = h2
			h2 = h3
			h3 = h5
			f.Health.Num.Dot: ClearAllPoints()
			f.Health.Num.Dot: SetPoint("BOTTOMLEFT", f.Health.Num[2],"BOTTOMRIGHT", -2.5,-4)
			f.Health.Num.Dot: Show()
		else
			f.Health.Num.Dot: Hide()
		end
	end
	
	if p < 1e4 then
		p1 = max(floor(p/1000), 0)
		p2 = max(floor(p/100)-p1*10, 0)
		p3 = max(floor(p/10)-p1*100-p2*10, 0)
		p4 = max(floor(p)-floor(p/10)*10, 0)
		
		if p1 <= 0 then
			f.Power.Num[1]: SetAlpha(0.3)
			if p2 <= 0 then
				f.Power.Num[2]: SetAlpha(0.3)
				if p3 <= 0 then
					f.Power.Num[3]: SetAlpha(0.3)
				else
					f.Power.Num[3]: SetAlpha(0.9)
				end
			else
				f.Power.Num[2]: SetAlpha(0.9)
				f.Power.Num[3]: SetAlpha(0.9)
			end
		else
			f.Power.Num[1]: SetAlpha(0.9)
			f.Power.Num[2]: SetAlpha(0.9)
			f.Power.Num[3]: SetAlpha(0.9)
		end
		
		f.Power.Num.Dot: Hide()
	else
		if p >= 1e4 and p < 1e6 then
			p = p/1e3
			p4 = "K"
		elseif p >= 1e6 and p < 1e9 then
			p = p/1e6
			p4 = "M"
		elseif p >= 1e9 and p < 1e12 then
			p = p/1e9
			p4 = "G"
		else
			p = 0
			p4 = 0
		end
		p1 = max(floor(p/100), 0)
		p2 = max(floor(p/10)-p1*10, 0)
		p3 = max(floor(p)-p1*100-p2*10, 0)
		p5 = floor(abs(p*10-floor(p)*10))
		p6 = floor(abs(p*100-floor(p*10)*10))
		
		f.Power.Num[1]: SetAlpha(0.9)
		f.Power.Num[2]: SetAlpha(0.9)
		f.Power.Num[3]: SetAlpha(0.9)
		
		if p2 <= 0 and p1 <= 0 then
			p1 = p3
			p2 = p5
			p3 = p6
			f.Power.Num.Dot: ClearAllPoints()
			f.Power.Num.Dot: SetPoint("BOTTOMLEFT", f.Power.Num[1],"BOTTOMRIGHT", -2.5,-4)
			f.Power.Num.Dot: Show()
		elseif p1 <= 0 and p2 > 0 then
			p1 = p2
			p2 = p3
			p3 = p5
			f.Power.Num.Dot: ClearAllPoints()
			f.Power.Num.Dot: SetPoint("BOTTOMLEFT", f.Power.Num[2],"BOTTOMRIGHT", -2.5,-4)
			f.Power.Num.Dot: Show()
		else
			f.Power.Num.Dot: Hide()
		end
	end
	
	f.Health.Num[1]: SetTexCoord(Num2[h1][3],Num2[h1][4], Num2[h1][5],Num2[h1][6])
	f.Health.Num[2]: SetTexCoord(Num2[h2][3],Num2[h2][4], Num2[h2][5],Num2[h2][6])
	f.Health.Num[3]: SetTexCoord(Num2[h3][3],Num2[h3][4], Num2[h3][5],Num2[h3][6])
	f.Health.Num[4]: SetTexCoord(Num2[h4][3],Num2[h4][4], Num2[h4][5],Num2[h4][6])
	
	f.Power.Num[1]: SetTexCoord(Num2[p1][3],Num2[p1][4], Num2[p1][5],Num2[p1][6])
	f.Power.Num[2]: SetTexCoord(Num2[p2][3],Num2[p2][4], Num2[p2][5],Num2[p2][6])
	f.Power.Num[3]: SetTexCoord(Num2[p3][3],Num2[p3][4], Num2[p3][5],Num2[p3][6])
	f.Power.Num[4]: SetTexCoord(Num2[p4][3],Num2[p4][4], Num2[p4][5],Num2[p4][6])
end


--- ----------------------------------------------------------------------------
--> ToT Frame
--- ----------------------------------------------------------------------------

local Ring = {
	[1] = {512, 297, 309},
	[2] = {512, 288, 294},
}

L.ToT_Frame = function(f)
	f.ToT = CreateFrame("Frame", nil, f)
	f.ToT: SetSize(212,77)
	f.ToT: SetPoint("CENTER", f, "CENTER", 50, 286)
	f.ToT.unit = "targettarget"
	
	f.ToT.Border = f.ToT:CreateTexture(nil, "ARTWORK")
	create_Texture(f.ToT.Border, "ToT_Border", 212,77, 22/256,234/256, 26/128,103/128, C.Color.White2,0.9, "CENTER",f.ToT,"CENTER",0,0)
	--[[
	f.ToT.B = f.ToT:CreateTexture(nil, "ARTWORK")
	create_Texture(f.ToT.B, "Target_B", 1024,1024, 0,1,0,1, C.Color.White2,0.4, "CENTER",f,"CENTER",0,0)
	--]]
	f.ToT.Name = L.create_Fontstring(f.ToT, C.Font.Name, 18, nil)
	--f.Name: SetWidth(120)
	f.ToT.Name: SetPoint("LEFT", f.ToT, "RIGHT", -30,0)
	f.ToT.Name: SetText("暴风城测试员")
	
	f.ToT.Lv = L.create_Fontstring(f.ToT, C.Font.Num, 12, nil)
	--f.Lv: SetWidth(120)
	f.ToT.Lv: SetPoint("BOTTOMLEFT", f.ToT.Name, "BOTTOMRIGHT", 4,-1)
	f.ToT.Lv: SetText("100")
	
	-->Health
	f.ToT.Health = CreateFrame("Frame", nil, f.ToT)
	f.ToT.Health: SetSize(1024, 1024)
	f.ToT.Health: SetPoint("CENTER", f, "CENTER", -1,0)
	f.ToT.Health.Direction = 1
	L.init_Smooth(f.ToT.Health)
	L.create_Ring(f.ToT.Health, Ring[1], "ToT_Bar1", "slicer0", "slicer1", C.Color.White, 0.5)
	
	f.ToT.Health.BarBg = L.create_Texture(f.ToT, "BACKGROUND", "ToT_Bar1_B", 96,26, 16/128,112/128,3/32,29/32, C.Color.White,0.2, "CENTER",f.ToT,"CENTER",-4,11)
	
	-->Power
	f.ToT.Power = CreateFrame("Frame", nil, f.ToT)
	f.ToT.Power: SetSize(1024, 1024)
	f.ToT.Power: SetPoint("CENTER", f, "CENTER", -1,0)
	f.ToT.Power.Direction = 1
	L.init_Smooth(f.ToT.Power)
	L.create_Ring(f.ToT.Power, Ring[2], "ToT_Bar2", "slicer0", "slicer1", C.Color.White, 0.5)
	
	f.ToT.Power.BarBg = L.create_Texture(f.ToT, "BACKGROUND", "ToT_Bar2_B", 91,20, 19/128,110/128,6/32,26/32, C.Color.White,0.2, "CENTER",f.ToT,"CENTER",-7,-1)
end

L.OnUpdate_ToT_gap = function(f)
	update_Health(f, f.unit)
	update_Power(f, f.unit)
	if UnitExists(f.unit) then
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
end

L.OnUpdate_ToT = function(f)
	if UnitExists(f.unit) then
		f:Show()
		
		L.update_Ring(f.Health, f.Health.Cur*0.049)
		L.update_Ring(f.Power, f.Power.Cur*0.049)
	else
		f:Hide()
	end
end