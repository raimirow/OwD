local C, F, L = unpack(select(2, ...))

local sqrt = math.sqrt

L.Gun = {
	[1] = {"Endothermic_Blaster",	 82,73, 87/256,169/256, 27/128,100/128},
	[2] = {"Sonic_Amplifier",		 92,66, 82/256,174/256, 31/128, 98/128},
	[3] = {"Light_Gun",				102,73, 77/256,179/256, 27/128,100/128},
	[4] = {"Fusion_Cannons",		122,68, 67/256,189/256, 30/128, 98/128},
	[5] = {"Shuriken",				142,70, 57/256,199/256, 29/128, 99/128},
	[6] = {"RocketLauncher",		152,64, 52/256,204/256, 32/128, 96/128},
	[7] = {"Storm_Bow",				189,59, 34/256,223/256, 34/128, 93/128},
}

L.Num_Center_20 = {
	[0] =	{21,31,   0/512, 21/512, 1/32,1},
	[1] =	{19,31,  22/512, 41/512, 1/32,1},
	[2] =	{21,31,  42/512, 63/512, 1/32,1},
	[3] =	{21,31,  63/512, 84/512, 1/32,1},
	[4] =	{21,31,  84/512,105/512, 1/32,1},
	[5] =	{21,31, 105/512,126/512, 1/32,1},
	[6] =	{21,31, 126/512,147/512, 1/32,1},
	[7] =	{21,31, 147/512,168/512, 1/32,1},
	[8] =	{21,31, 168/512,189/512, 1/32,1},
	[9] =	{21,31, 189/512,210/512, 1/32,1},
	["."] =	{21,31, 210/512,231/512, 1/32,1},
	["/"] =	{21,31, 231/512,252/512, 1/32,1},
	["k"] =	{21,31, 252/512,273/512, 1/32,1},
	["m"] =	{21,31, 273/512,294/512, 1/32,1},
	["g"] =	{21,31, 294/512,314/512, 1/32,1},
	["%"] =	{21,31, 314/512,335/512, 1/32,1},
	["s"] =	{21,31, 335/512,356/512, 1/32,1},
	["B"] =	{11,31, 501/512,512/512, 1/32,1},
}

L.Num_Center_24 = {
	[0] =	{21,30,   0/512, 21/512, 2/32,1},
	[1] =	{17,30,  23/512, 40/512, 2/32,1},
	[2] =	{21,30,  42/512, 63/512, 2/32,1},
	[3] =	{21,30,  63/512, 84/512, 2/32,1},
	[4] =	{21,30,  84/512,105/512, 2/32,1},
	[5] =	{21,30, 105/512,126/512, 2/32,1},
	[6] =	{21,30, 126/512,147/512, 2/32,1},
	[7] =	{21,30, 147/512,168/512, 2/32,1},
	[8] =	{21,30, 168/512,189/512, 2/32,1},
	[9] =	{21,30, 189/512,210/512, 2/32,1},
	["."] =	{21,30, 210/512,231/512, 2/32,1},
	["%"] =	{18,30, 232/512,250/512, 2/32,1},
	["-"] =	{21,30, 252/512,273/512, 2/32,1},
	["B"] =	{11,30, 273/512,294/512, 2/32,1},
}

L.Num_Center_30 = {
	[0] =	{27,39,   0/512, 27/512,  12/64,51/64},
	[1] =	{23,39,  29/512, 52/512,  12/64,51/64},
	[2] =	{27,39,  54/512, 81/512,  12/64,51/64},
	[3] =	{27,39,  81/512,108/512,  12/64,51/64},
	[4] =	{27,39, 108/512,135/512,  12/64,51/64},
	[5] =	{27,39, 135/512,162/512,  12/64,51/64},
	[6] =	{27,39, 162/512,189/512,  12/64,51/64},
	[7] =	{27,39, 189/512,216/512,  12/64,51/64},
	[8] =	{27,39, 216/512,243/512,  12/64,51/64},
	[9] =	{27,39, 243/512,270/512,  12/64,51/64},
	["."] =	{27,39, 270/255,297/255,  12/64,51/64},
	["k"] =	{27,39, 297/512,324/512,  12/64,51/64},
	["m"] =	{27,39, 324/512,351/512,  12/64,51/64},
	["g"] =	{27,39, 351/512,378/512,  12/64,51/64},
	["%"] =	{27,39, 378/512,405/512,  12/64,51/64},
	["B"] =	{15,39, 500/512,512/512,  12/64,51/64},
}



--< Color >-----------------------------------------------------

L.Color = {}
L.Color.Class = {
	["DEATHKNIGHT"] =	{255/255,  49/255,  88/255},		--{247/255,  56/255,  84/255}
	["DRUID"] =			{255/255, 139/255,  36/255},		--{255/255, 125/255,  10/255}
	["HUNTER"] =		{206/255, 248/255,  74/255},		--{148/255, 219/255, 125/255}
	["MAGE"] =			{ 46/255, 208/255, 255/255},		--{  0/255, 194/255, 255/255}
	["PALADIN"] =		{255/255,  82/255, 204/255},		--{255/255,  56/255, 133/255}
	["PRIEST"] =		{218/255, 254/255, 254/255},		--{204/255, 252/255, 252/255}
	["ROGUE"] =			{255/255, 246/255,  14/255},		--{255/255, 232/255,  51/255}
	["SHAMAN"] =		{ 68/255, 148/255, 255/255},		--{  0/255, 153/255, 153/255}
	["WARLOCK"] =		{162/255, 144/255, 255/255},		--{153/255, 120/255, 217/255}
	["WARRIOR"] =		{242/255, 194/255, 160/255},		--{230/255, 166/255, 115/255}
	["MONK"] =			{ 96/255, 255/255, 194/255},		--{ 96/255, 255/255, 194/255}
	["DEMONHUNTER"] = 	{ 0.64, 0.19, 0.79},
}

L.Color.DebuffType = {
	["none"]	= { r = 0.05, g = 0.05, b = 0.05 },
	[""]		= { r = 0.05, g = 0.05, b = 0.05 },
	["Magic"]	= { r = 0.20, g = 0.60, b = 1.00 },
	["Curse"]	= { r = 0.60, g = 0.00, b = 1.00 },
	["Disease"]	= { r = 0.60, g = 0.40, b = 0 },
	["Poison"]	= { r = 0.00, g = 0.60, b = 0 },
	["Enchant"] = { r = 220/255, g = 100/255, b = 252/255 },
}

L.Color.Config = {
	Bar1 = {r = 170/255, g = 180/255, b = 190/255},
	Bar2 = {r = 114/255, g = 166/255, b = 222/255},
	--Exit = {r = 244/255, g =  20/255, b =  60/255},
	Exit = {r = 114/255, g = 166/255, b = 222/255},
	Back = {r =  24/255, g =  24/255, b =  24/255},
}

L.Color["Denied"] =		{ 87/255,  96/255, 105/255}
L.Color["Health"] = 	{255/255,  72/255,  72/255}
L.Color["Power"] = 		{ 51/255, 214/255, 255/255}
L.Color["White"] = 		{234/255, 234/255, 234/255}
L.Color["Back"] = 		{ 24/255,  24/255,  24/255}
L.Color["Buff"] =		{222/255, 222/255, 222/255}

----------------------------------------------------------------



--< Font >------------------------------------------------------
-- STANDARD_TEXT_FONT
-- UNIT_NAME_FONT
-- DAMAGE_TEXT_FONT

L.Font = {
	["Txt"] = 	F.Media.."Fonts\\Txt.ttf",
	--["Txt"] =	STANDARD_TEXT_FONT,
	["Num"] =	F.Media.."Fonts\\Num.ttf",
	--["Num"] =	STANDARD_TEXT_FONT,
}

----------------------------------------------------------------




L.init_Smooth = function(self)
	self.Per = 0
	self.Cur = 0
	self.Max = 100
end

L.update_Health = function(self, unit)
	local minHealth,maxHealth = UnitHealth(unit),UnitHealthMax(unit)
	local h,hv = 0,0
	if maxHealth == 0 or minHealth == 0 then
		h = 0
	else
		h = floor(minHealth/maxHealth*1e4)/1e4
	end
	self.Health.Per = h
	self.Health.Max = maxHealth
end

L.update_Power = function(self, unit)
	local minPower,maxPower = UnitPower(unit),UnitPowerMax(unit)
	local p,pv = 0,0
	if maxPower == 0 or minPower == 0 then
		p = 0
	else
		p = floor(minPower/maxPower*1e4)/1e4
	end
	self.Power.Per = p
	self.Power.Max = maxPower
end

L.create_Texture = function(f, level, texture, x,y, x1,x2,y1,y2, color,a, p1,p2,p3,p4,p5)
	local ft = f:CreateTexture(nil, level)
	ft: SetTexture(F.Media..texture)
	ft: SetSize(x,y)
	ft: SetTexCoord(x1,x2, y1,y2)
	ft: SetVertexColor(color[1], color[2], color[3])
	ft: SetAlpha(a)
	ft: SetPoint(p1,p2,p3,p4,p5)
	return ft
end

L.create_Fontstring = function(f, name, size, outline)
	local fs = f:CreateFontString(nil, "OVERLAY")
	fs:SetFont(name, size, outline)
	fs:SetShadowColor(0,0,0,0.9)
	fs:SetShadowOffset(1,-1)
	return fs
end  

L.create_Ring = function(f, ring, tex1, tex2, tex3, color, alpha)
	if not alpha then alpha = 1 end
	f.segmentsize = ring[1]
	f.inner_radius = ring[2]
	f.outer_radius = ring[3]
	
	f.t0 = f: CreateTexture(nil, "ARTWORK")
	f.t0: SetTexture(F.Media..tex1)
	f.t0: SetAlpha(alpha)
	f.t0: SetVertexColor(unpack(color))

	f.t1 = f: CreateTexture(nil, "ARTWORK")
	f.t1: SetTexture(F.Media..tex1)
	f.t1: SetAlpha(alpha)
	f.t1: SetVertexColor(unpack(color))

	f.t2 = f:CreateTexture(nil, "ARTWORK")
	if f.Direction == 0 then --> clockwise
		f.t2:SetTexture(F.Media..tex2)
	else --> anticlockwise
		f.t2:SetTexture(F.Media..tex3)
	end
	f.t2:SetAlpha(alpha)
	f.t2:SetVertexColor(unpack(color))
end

L.update_Ring = function(f, value)
	if value > 0.75 then
		f.Interval = 2
		F.Ring_Update(f, (360*(max(value-0.75-F.Debug, F.Debug))))
	elseif value <= 0.75 and value > 0.5 then
		f.Interval = 3
		F.Ring_Update(f, (360*(max(value-0.5-F.Debug, F.Debug))))
	elseif value <= 0.5 and value > 0.25 then
		f.Interval = 4
		F.Ring_Update(f, (360*(max(value-0.25-F.Debug, F.Debug))))
	elseif value <= 0.25 and value >= 0 then
		f.Interval = 1
		F.Ring_Update(f, (360*(max(value-F.Debug, F.Debug))))
	end
end

function L.update_OutCombat_Fade(f)
	if (not UnitAffectingCombat("player")) and OwD_DB["OutCombat_Fade"] then
		f.Player:SetAlpha(0.2)
		f.Right:SetAlpha(0.2)
		f.FCS:SetAlpha(0.3)
	else
		f.Player:SetAlpha(0.95)
		f.Right:SetAlpha(0.95)
		f.FCS:SetAlpha(1)
	end
end

--- ----------------------------------------------------------------------------
--> Artwork     
--- ----------------------------------------------------------------------------

local GetRaidTargetIndex = GetRaidTargetIndex
local SetRaidTargetIconTexture = SetRaidTargetIconTexture
L.create_Icons = function(f)
	local Icon_Frame = CreateFrame("Frame", nil, f)
	Icon_Frame: SetFrameLevel(f:GetFrameLevel()+5)
	
	--> Raid Icon
	local RaidIcon = Icon_Frame:CreateTexture(nil, "OVERLAY")
	RaidIcon: SetSize(16, 16)
	RaidIcon: SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
	
	--> Phase Icon
	local PhaseIcon = Icon_Frame:CreateTexture(nil, "OVERLAY")
	PhaseIcon: SetSize(16, 16)
	PhaseIcon: SetTexture("Interface\\TargetingFrame\\UI-PhasingIcon")
	
	--> Quest Icon
	local QuestIcon = Icon_Frame:CreateTexture(nil, "OVERLAY")
	QuestIcon: SetSize(16, 16)
	QuestIcon: SetTexture("Interface\\TargetingFrame\\PortraitQuestBadge")
	
	if f.unit == "target" then
		QuestIcon: SetPoint("RIGHT", f.Name, "LEFT", -2,0)
		RaidIcon: SetPoint("RIGHT", f.Name, "LEFT", -2,0)
		PhaseIcon: SetPoint("LEFT", f.Lv, "RIGHT", 2,0)
		Icon_Frame: RegisterEvent("UNIT_CLASSIFICATION_CHANGED")
		Icon_Frame: RegisterEvent("PLAYER_TARGET_CHANGED")
	elseif f.unit == "player" then
		RaidIcon: SetSize(20, 20)
		RaidIcon: SetPoint("BOTTOM", f.Portrait, "BOTTOM", -1,4)
		PhaseIcon = nil
		QuestIcon = nil
	elseif f.unit == "focus" then
		RaidIcon: SetPoint("RIGHT", f.Name, "LEFT", -2,0)
		PhaseIcon: SetPoint("LEFT", f.Name, "RIGHT", 2,0)
		Icon_Frame: RegisterEvent("PLAYER_FOCUS_CHANGED")
	end
	
	Icon_Frame: RegisterEvent("PLAYER_ENTERING_WORLD")
	Icon_Frame: RegisterEvent("RAID_TARGET_UPDATE")
	Icon_Frame: RegisterEvent("UNIT_PHASE")
	Icon_Frame: SetScript("OnEvent", function(self, event, ...)
		if event == "PLAYER_TARGET_CHANGED" or event == "PLAYER_FOCUS_CHANGED" then
			event = "PLAYER_ENTERING_WORLD"
		end
		if RaidIcon then
			if event == "PLAYER_ENTERING_WORLD" or event == "RAID_TARGET_UPDATE" then
				local index = GetRaidTargetIndex(f.unit)
				--> 1-Star,2-Circle,3-Diamond,4-Triangle,5-Moon,6-Square,7-Cross,8-Skull,nil-No marker
				if (index) then
					SetRaidTargetIconTexture(RaidIcon, index)
					RaidIcon:Show()
				else
					RaidIcon:Hide()
				end
			end
		end
		
		if QuestIcon then
			if event == "PLAYER_ENTERING_WORLD" or event == "UNIT_CLASSIFICATION_CHANGED" then
				local isQuestBoss = UnitIsQuestBoss(f.unit)
				if(isQuestBoss) then
					QuestIcon:Show()
				else
					QuestIcon:Hide()
				end
			end
		end
		
		if PhaseIcon then
			if event == "PLAYER_ENTERING_WORLD" or event == "UNIT_PHASE" then
				local inPhase = UnitInPhase(f.unit)
				if(inPhase) then
					PhaseIcon:Hide()
				else
					PhaseIcon:Show()
				end
			end
		end
	end)
end

L.create_AltPower = function(f, u)
	local RING = {32, 25,29}
	f.AltPower = CreateFrame("Frame", nil, f)
	f.AltPower: SetSize(64,64)
	
	if u == "player" then
		f.AltPower: SetPoint("BOTTOMLEFT", f, "TOPRIGHT", -20,20)
	elseif u == "target" then
		f.AltPower: SetPoint("RIGHT", f, "LEFT", -40,20)
	end
	
	f.AltPower.Border = L.create_Texture(f.AltPower, "BORDER", "AltPowerBar", 64,64, 0,1,0,1, C.Color.White,0.3, "CENTER",f.AltPower,"CENTER",0,0)
	f.AltPower.Back = L.create_Texture(f.AltPower, "BACKGROUND", "AltPowerBarBg", 64,64, 0,1,0,1, C.Color.Black,0.3, "CENTER",f.AltPower,"CENTER",0,0)
	
	f.AltPower.Ring = {}
	f.AltPower.Direction = 1
	L.create_Ring(f.AltPower, RING, "AltPowerRing", "slicer0", "slicer1", C.Color.White, 0.9)
	f.AltPower.Ring[1] = L.create_Texture(f.AltPower, "ARTWORK", "CastbarPlayerBar", 32,32, 0,1,0,1, C.Color.White,0.9, "BOTTOMLEFT",f.AltPower,"CENTER",0,0)
	f.AltPower.Ring[2] = L.create_Texture(f.AltPower, "ARTWORK", "CastbarPlayerBar", 32,32, 0,1,1,0, C.Color.White,0.9, "TOPLEFT",f.AltPower,"CENTER",0,0)
	f.AltPower.Ring[3] = L.create_Texture(f.AltPower, "ARTWORK", "CastbarPlayerBar", 32,32, 1,0,1,0, C.Color.White,0.9, "TOPRIGHT",f.AltPower,"CENTER",0,0)
	
	f.AltPower.Num = {}
	f.AltPower.Help = CreateFrame("Frame", nil, f)
	f.AltPower.Help: SetPoint("CENTER", f.AltPower, "CENTER", 0,0)
	for i = 1,3 do
		f.AltPower.Num[i] = f.AltPower:CreateTexture(nil, "ARTWORK")
		f.AltPower.Num[i]: SetTexture(F.Media.."NumCenter24")
		f.AltPower.Num[i]: SetVertexColor(unpack(C.Color.White))
		f.AltPower.Num[i]: SetAlpha(1)
		f.AltPower.Num[i]: SetSize(L.Num_Center_24[0][1], L.Num_Center_24[0][2])
		f.AltPower.Num[i]: SetTexCoord(L.Num_Center_24[0][3],L.Num_Center_24[0][4], L.Num_Center_24[0][5],L.Num_Center_24[0][6])
		if i == 1 then
			f.AltPower.Num[i]: SetPoint("LEFT", f.AltPower.Help, "LEFT", 0,0)
		else
			f.AltPower.Num[i]: SetPoint("LEFT", f.AltPower.Num[i-1], "RIGHT", -11,0)
		end
	end
end

L.onevent_AltPower = function(f, u, event)
	if event == "PLAYER_ENTERING_WORLD" or event == "UNIT_POWER_BAR_SHOW" or event == "UNIT_POWER_BAR_HIDE" or event == "UNIT_POWER_FREQUENT" or event == "UNIT_MAXPOWER" then
		local barType, minPower, startInset, endInset, smooth, hideFromOthers, showOnRaid, opaqueSpark, opaqueFlash, powerName, powerTooltip, costString, barID = UnitAlternatePowerInfo(f.unit)
		if(barType and (showOnRaid and (UnitInParty(f.unit) or UnitInRaid(f.unit)) or not hideFromOthers or f.unit == 'player' or u == 'player')) then
			f.AltPower: Show()
			local _, r, g, b
			_, r, g, b = UnitAlternatePowerTextureInfo(f.unit, 2)
		
			local curPower = UnitPower(f.unit, ALTERNATE_POWER_INDEX)
			local maxPower = UnitPowerMax(f.unit, ALTERNATE_POWER_INDEX)
			
			local d,p,p1,p2,p3
			--
			d = curPower/(maxPower-minPower)
			p = curPower
			p1 = max(min(floor(p/100), 9), 0)
			p2 = max(min(floor(p/10)-p1*10, 9), 0)
			p3 = max(min(floor(p)-floor(p/10)*10, 9), 0)
			
			if p1 <= 0 then
				p1 = "B"
				if p2 <= 0 then
					p2 = "B"
				end
				--[[
				f.AltPower.Help: SetSize(L.Num_Center_30[p1][1]+L.Num_Center_30[p2][1]+L.Num_Center_30[p3][1]-28, L.Num_Center_30[0][2])
				f.AltPower.Num[2]: SetPoint("LEFT", f.AltPower.Num[1], "RIGHT", -14,0)
				f.AltPower.Num[3]: SetPoint("LEFT", f.AltPower.Num[2], "RIGHT", -14,0)
				
				f.AltPower.Num[1]: SetTexture(F.Media.."Num_Center_30")
				f.AltPower.Num[1]: SetSize(L.Num_Center_30[p1][1], L.Num_Center_30[p1][2])
				f.AltPower.Num[1]: SetTexCoord(L.Num_Center_30[p1][3],L.Num_Center_30[p1][4], L.Num_Center_30[p1][5],L.Num_Center_30[p1][6])
				f.AltPower.Num[2]: SetTexture(F.Media.."Num_Center_30")
				f.AltPower.Num[2]: SetSize(L.Num_Center_30[p2][1], L.Num_Center_30[p2][2])
				f.AltPower.Num[2]: SetTexCoord(L.Num_Center_30[p2][3],L.Num_Center_30[p2][4], L.Num_Center_30[p2][5],L.Num_Center_30[p2][6])
				f.AltPower.Num[3]: SetTexture(F.Media.."Num_Center_30")
				f.AltPower.Num[3]: SetSize(L.Num_Center_30[p3][1], L.Num_Center_30[p3][2])
				f.AltPower.Num[3]: SetTexCoord(L.Num_Center_30[p3][3],L.Num_Center_30[p3][4], L.Num_Center_30[p3][5],L.Num_Center_30[p3][6])
				--]]
			else
				--[[
				f.AltPower.Help: SetSize(L.Num_Center_24[0][1]*3-22, L.Num_Center_24[0][2])
				f.AltPower.Num[2]: SetPoint("LEFT", f.AltPower.Num[1], "RIGHT", -11,0)
				f.AltPower.Num[3]: SetPoint("LEFT", f.AltPower.Num[2], "RIGHT", -11,0)
			
				f.AltPower.Num[1]: SetTexture(F.Media.."Num_Center_24")
				f.AltPower.Num[1]: SetSize(L.Num_Center_24[0][1], L.Num_Center_24[0][2])
				f.AltPower.Num[1]: SetTexCoord(L.Num_Center_24[0][3],L.Num_Center_24[0][4], L.Num_Center_24[0][5],L.Num_Center_24[0][6])
				f.AltPower.Num[2]: SetTexture(F.Media.."Num_Center_24")
				f.AltPower.Num[2]: SetSize(L.Num_Center_24[0][1], L.Num_Center_24[0][2])
				f.AltPower.Num[2]: SetTexCoord(L.Num_Center_24[0][3],L.Num_Center_24[0][4], L.Num_Center_24[0][5],L.Num_Center_24[0][6])
				f.AltPower.Num[3]: SetTexture(F.Media.."Num_Center_24")
				f.AltPower.Num[3]: SetSize(L.Num_Center_24[0][1], L.Num_Center_24[0][2])
				f.AltPower.Num[3]: SetTexCoord(L.Num_Center_24[0][3],L.Num_Center_24[0][4], L.Num_Center_24[0][5],L.Num_Center_24[0][6])
				--]]
			end
			f.AltPower.Help: SetSize(L.Num_Center_30[p1][1]+L.Num_Center_30[p2][1]+L.Num_Center_30[p3][1]-28, L.Num_Center_30[0][2])
			f.AltPower.Num[2]: SetPoint("LEFT", f.AltPower.Num[1], "RIGHT", -14,0)
			f.AltPower.Num[3]: SetPoint("LEFT", f.AltPower.Num[2], "RIGHT", -14,0)
			
			f.AltPower.Num[1]: SetTexture(F.Media.."NumCenter30")
			f.AltPower.Num[1]: SetSize(L.Num_Center_30[p1][1], L.Num_Center_30[p1][2])
			f.AltPower.Num[1]: SetTexCoord(L.Num_Center_30[p1][3],L.Num_Center_30[p1][4], L.Num_Center_30[p1][5],L.Num_Center_30[p1][6])
			f.AltPower.Num[2]: SetTexture(F.Media.."NumCenter30")
			f.AltPower.Num[2]: SetSize(L.Num_Center_30[p2][1], L.Num_Center_30[p2][2])
			f.AltPower.Num[2]: SetTexCoord(L.Num_Center_30[p2][3],L.Num_Center_30[p2][4], L.Num_Center_30[p2][5],L.Num_Center_30[p2][6])
			f.AltPower.Num[3]: SetTexture(F.Media.."NumCenter30")
			f.AltPower.Num[3]: SetSize(L.Num_Center_30[p3][1], L.Num_Center_30[p3][2])
			f.AltPower.Num[3]: SetTexCoord(L.Num_Center_30[p3][3],L.Num_Center_30[p3][4], L.Num_Center_30[p3][5],L.Num_Center_30[p3][6])
			
			
			if d*360 < 90 then
				f.AltPower.Interval = 1
				F.Ring_Update(f.AltPower, (d*360 + F.Debug))
				f.AltPower.Ring[1]: Hide()
				f.AltPower.Ring[2]: Hide()
				f.AltPower.Ring[3]: Hide()
			elseif d*360 >= 90 and d*360 < 180 then
				f.AltPower.Interval = 4
				F.Ring_Update(f.AltPower, (d*360 - 90 + F.Debug))
				f.AltPower.Ring[1]: Show()
				f.AltPower.Ring[2]: Hide()
				f.AltPower.Ring[3]: Hide()
			elseif d*360 >= 180 and d*360 < 270 then
				f.AltPower.Interval = 3
				F.Ring_Update(f.AltPower, (d*360 - 180 + F.Debug))
				f.AltPower.Ring[1]: Show()
				f.AltPower.Ring[2]: Show()
				f.AltPower.Ring[3]: Hide()
			elseif d*360 >= 270 then
				f.AltPower.Interval = 2
				F.Ring_Update(f.AltPower, (d*360 - 270 + F.Debug))
				f.AltPower.Ring[1]: Show()
				f.AltPower.Ring[2]: Show()
				f.AltPower.Ring[3]: Show()
			end
			--[[
			altpowerbar.barType = barType
			altpowerbar.powerName = powerName
			altpowerbar.powerTooltip = powerTooltip
			altpowerbar:SetMinMaxValues(min, max)
			altpowerbar:SetValue(math.min(math.max(cur, min), max))
		--]]
			if(b) then
				--altpowerbar:SetStatusBarColor(r, g, b)
				for i = 1,3 do
					f.AltPower.Num[i]: SetVertexColor(r,g,b)
				end
			end
		else
			f.AltPower: Hide()
		end
	end
end

L.Artwork = function(f)
	f.Artwork = CreateFrame("Frame", nil, f)
	
end

L.OnUpdate_Artwork_gap = function(f)
	--[[
	if (f.Target:IsVisible()) or (f.GCD:GetAlpha() ~= 0) or (f.Focus.Castbar:IsVisible())then
		f.Artwork.B1: Show()
	else
		f.Artwork.B1: Hide()
	end
	--]]
end

L.Feedback = function(f)
	f.Feedback = CreateFrame("Frame", nil, f)
	f.Feedback.x = 0
	f.Feedback.x_offset = 0
	f.Feedback.y = 0
	f.Feedback.y_offset = 0
	f.Feedback.dir = -1
	
	local perHealth = UnitHealth("player")
	
	f.Feedback: RegisterEvent("UNIT_HEALTH_FREQUENT")
	f.Feedback: RegisterEvent("UNIT_COMBAT")
	f.Feedback: SetScript("OnEvent", function(self,event,arg1,arg2,arg3,arg4,arg5) --("UNIT_COMBAT", "unitID", "action", "descriptor", damage, damageType)
		--[[
		if event == "UNIT_COMBAT" then
			if arg1 == "player" then
				if arg2 == "WOUND" then
					if arg4 ~= 0 then
						local maxHealth = UnitHealthMax("player")
						local d = floor(abs(arg4/maxHealth)*100)/100
						if d > 0.02 then
							f.Feedback.x_offset = max(f.Feedback.x_offset, d*20+14)
							f.Feedback:SetScript("OnUpdate", function(self,elapsed)
								local step = floor(1/(GetFramerate())*1e3)/1e3
								if f.Feedback.x * f.Feedback.dir < f.Feedback.x_offset then
									f.Feedback.x = f.Feedback.x + 15*step * f.Feedback.x_offset * f.Feedback.dir
								else
									f.Feedback.dir = (0 - f.Feedback.dir)
									f.Feedback.x_offset = f.Feedback.x_offset/2
								end
								f.Player: SetPoint("BOTTOMLEFT", f, "CENTER", OwD_DB.Pos.Player.x+f.Feedback.x, OwD_DB.Pos.Player.y+0.7*f.Feedback.x)
								f.Right: SetPoint("BOTTOMRIGHT", f, "CENTER", -OwD_DB.Pos.Player.x-f.Feedback.x, OwD_DB.Pos.Player.y+0.7*f.Feedback.x)
								f.FCS: SetPoint("CENTER", f, "CENTER", 0, OwD_DB.Pos.FCS.y+0.6*f.Feedback.x)
								if abs(f.Feedback.x_offset) <= 1 then
									f.Feedback:SetScript("OnUpdate", nil)
								end
							end)
						end
					end
				end
			end
		end
		--]]
		if (event == "UNIT_HEALTH_FREQUENT") and (UnitAffectingCombat("player")) then
			local maxHealth = UnitHealthMax("player")
			local curHealth = UnitHealth("player")
			local wound, d
			if perHealth > curHealth then
				wound = perHealth - curHealth
				d = floor(abs(wound/maxHealth)*100)/100
				if d > 0.05 then
					f.Feedback.x_offset = max(f.Feedback.x_offset, sqrt(d)*36)
					f.Feedback:SetScript("OnUpdate", function(self,elapsed)
						local step = floor(1/(GetFramerate())*1e3)/1e3
						if f.Feedback.x * f.Feedback.dir < f.Feedback.x_offset then
							f.Feedback.x = f.Feedback.x + 42*step * f.Feedback.x_offset * f.Feedback.dir
						else
							f.Feedback.dir = (0 - f.Feedback.dir)
							f.Feedback.x_offset = f.Feedback.x_offset/2.4
						end
						f.Player: SetPoint("BOTTOMLEFT", f, "CENTER", OwD_DB.Pos.Player.x+f.Feedback.x, OwD_DB.Pos.Player.y+0.7*f.Feedback.x)
						f.Right: SetPoint("BOTTOMRIGHT", f, "CENTER", -OwD_DB.Pos.Player.x-f.Feedback.x, OwD_DB.Pos.Player.y+0.7*f.Feedback.x)
						f.FCS: SetPoint("CENTER", f, "CENTER", 0, OwD_DB.Pos.FCS.y+0.6*f.Feedback.x)
						if abs(f.Feedback.x_offset) <= 1 then
							f.Feedback:SetScript("OnUpdate", nil)
						end
					end)
				end
			end
			perHealth = curHealth or maxHealth
		end
	end)
end