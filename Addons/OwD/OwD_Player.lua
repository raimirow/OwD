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
--> Player Frame Element      
--- ----------------------------------------------------------------------------

local Num1 = {
	[0] =	{14,26,   7/256, 21/256,  25/64,51/64},
	[1] =	{14,26,  25/256, 39/256,  24/64,50/64},
	[2] =	{14,26,  42/256, 56/256,  23/64,49/64},
	[3] =	{14,26,  62/256, 76/256,  22/64,48/64},
	[4] =	{14,26,  80/256, 94/256,  20/64,46/64},
	[5] =	{14,26, 100/256,114/256,  19/64,45/64},
	[6] =	{14,26, 119/256,133/256,  17/64,43/64},
	[7] =	{14,26, 137/256,151/256,  16/64,42/64},
	[8] =	{14,26, 155/256,169/256,  15/64,41/64},
	[9] =	{14,26, 174/256,188/256,  14/64,40/64},
	["K"] =	{14,26, 193/256,207/256,  12/64,38/64},
	["M"] =	{14,26, 210/256,224/256,  11/64,37/64},
	["G"] =	{14,26, 227/256,241/256,  10/64,36/64},
	["."] =	{ 5, 5, 244/255,249/255,  30/64,35/64},
}

local Num2 = {
	[0] =	{12,22,  13/256, 25/256, 29/64,51/64},
	[1] =	{12,22,  28/256, 40/256, 28/64,50/64},
	[2] =	{12,22,  42/256, 54/256, 27/64,49/64},
	[3] =	{12,22,  58/256, 70/256, 26/64,48/64},
	[4] =	{12,22,  74/256, 86/256, 25/64,47/64},
	[5] =	{12,22,  90/256,102/256, 24/64,46/64},
	[6] =	{12,22, 105/256,117/256, 23/64,45/64},
	[7] =	{12,22, 120/256,132/256, 21.6/64,43.6/64},
	[8] =	{12,22, 135/256,147/256, 20.6/64,42.6/64},
	[9] =	{12,22, 150/256,162/256, 19.6/64,41.6/64},
	["K"] =	{12,22, 166/256,178/256, 19/64,41/64},
	["M"] =	{12,22, 181/256,193/256, 18/64,40/64},
	["G"] =	{12,22, 197/256,209/256, 17/64,39/64},
	["."] =	{ 6, 5, 213/256,219/256, 32/64,37/64},
	["/"] =	{15,25, 228/256,243/256, 13/64,38/64},
}

local Num3 = {
	[1] =	{12,28,  48/256, 58/256, 2/32,30/32},
	[2] =	{15,28,  59/256, 74/256, 2/32,30/32},
	[3] =	{14,28,  76/256, 90/256, 2/32,30/32},
	[4] =	{13,28,  92/256,105/256, 2/32,30/32},
	[5] =	{14,28, 107/256,121/256, 2/32,30/32},
	[6] =	{14,28, 123/256,137/256, 2/32,30/32},
	[7] =	{13,28, 139/256,152/256, 2/32,30/32},
	[8] =	{14,28, 153/256,167/256, 2/32,30/32},
	[9] =	{14,28, 169/256,183/256, 2/32,30/32},
	[0] =	{14,28, 185/256,199/256, 2/32,30/32},
	["%"] =	{11,28, 202/256,213/256, 2/32,30/32},
}

local Num4 = {
	[1] =	{ 9,18,  43/256, 52/256, 6/32,24/32},
	[2] =	{12,18,  53/256, 65/256, 6/32,24/32},
	[3] =	{12,18,  65/256, 77/256, 6/32,24/32},
	[4] =	{12,18,  77/256, 89/256, 6/32,24/32},
	[5] =	{12,18,  89/256,101/256, 6/32,24/32},
	[6] =	{12,18, 101/256,113/256, 6/32,24/32},
	[7] =	{12,18, 113/256,125/256, 6/32,24/32},
	[8] =	{12,18, 124/256,136/256, 6/32,24/32},
	[9] =	{12,18, 136/256,148/256, 6/32,24/32},
	[0] =	{12,18, 149/256,161/256, 6/32,24/32},
	[" "] =	{ 1,18,   1/256,  2/256, 6/32,24/32},
	["*"] =	{14,18,  30/256, 44/256, 6/32,24/32},
	["."] =	{ 6,18, 161/256,167/256, 6/32,24/32},
	["s"] =	{ 8,18, 170/256,178/256, 6/32,24/32},
	["k"] =	{ 9,18, 180/256,189/256, 6/32,24/32},
	["m"] =	{11,18, 191/256,202/256, 6/32,24/32},
	["g"] =	{ 9,18, 203/256,212/256, 6/32,24/32},
	["%"] =	{11,18, 214/256,225/256, 6/32,24/32},
}

local Num5 = {
	[1] =	{ 9,16,  42/256, 51/256, 8/32,24/32},
	[2] =	{10,16,  52/256, 62/256, 8/32,24/32},
	[3] =	{10,16,  64/256, 74/256, 8/32,24/32},
	[4] =	{10,16,  76/256, 86/256, 8/32,24/32},
	[5] =	{10,16,  88/256, 98/256, 8/32,24/32},
	[6] =	{10,16, 100/256,110/256, 8/32,24/32},
	[7] =	{10,16, 112/256,122/256, 8/32,24/32},
	[8] =	{10,16, 123/256,133/256, 8/32,24/32},
	[9] =	{10,16, 135/256,145/256, 8/32,24/32},
	[0] =	{10,16, 146/256,156/256, 8/32,24/32},
	[" "] =	{ 1,16,   1/256,  2/256, 8/32,24/32},
	["X"] =	{16,16,  23/256, 39/256, 8/32,24/32},
	["."] =	{ 5,16, 158/256,163/256, 8/32,24/32},
	["K"] =	{10,16, 168/256,178/256, 8/32,24/32},
	["M"] =	{12,16, 180/256,192/256, 8/32,24/32},
	["G"] =	{10,16, 193/256,203/256, 8/32,24/32},
	["%"] =	{10,16, 206/256,216/256, 8/32,24/32},
	["/"] =	{15,16, 219/256,234/256, 8/32,24/32},
}

local HP_Coord = {
	[11] =	{32,18,   0/512, 32/512, 7/32,25/32},
	[10] =	{32,18,  32/512, 64/512, 7/32,25/32},
	[9] =	{32,18,  64/512, 96/512, 7/32,25/32},
	[8] =	{32,18,  96/512,128/512, 7/32,25/32},
	[7] =	{32,18, 128/512,160/512, 7/32,25/32},
	[6] =	{32,18, 160/512,192/512, 7/32,25/32},
	[5] =	{32,18, 192/512,224/512, 7/32,25/32},
	[4] =	{32,18, 224/512,256/512, 7/32,25/32},
	[3] =	{32,18, 256/512,288/512, 7/32,25/32},
	[2] =	{32,18, 288/512,320/512, 7/32,25/32},
	[1] =	{32,18, 320/512,352/512, 7/32,25/32},
	[0] =	{32,18, 352/512,384/512, 7/32,25/32},
}

local PP_Coord = {
	[11] =	{32,18,   0/512, 32/512, 7/32,25/32},
	[10] =	{32,18,  32/512, 64/512, 7/32,25/32},
	[9] =	{32,18,  64/512, 96/512, 7/32,25/32},
	[8] =	{32,18,  96/512,128/512, 7/32,25/32},
	[7] =	{32,18, 128/512,160/512, 7/32,25/32},
	[6] =	{32,18, 160/512,192/512, 7/32,25/32},
	[5] =	{32,18, 192/512,224/512, 7/32,25/32},
	[4] =	{32,18, 224/512,256/512, 7/32,25/32},
	[3] =	{32,18, 256/512,288/512, 7/32,25/32},
	[2] =	{32,18, 288/512,320/512, 7/32,25/32},
	[1] =	{32,18, 320/512,352/512, 7/32,25/32},
	[0] =	{32,18, 352/512,384/512, 7/32,25/32},
}

local create_Texture = function(f, texture, x,y, x1,x2,y1,y2, color,a, p1,p2,p3,p4,p5)
	f: SetTexture(F.Media..texture)
	f: SetSize(x,y)
	f: SetTexCoord(x1,x2, y1,y2)
	f: SetVertexColor(color[1], color[2], color[3])
	f: SetAlpha(a)
	f: SetPoint(p1,p2,p3,p4,p5)
end

local create_Bar = function(f, texture, x,y, x1,x2, y1,y2)
	f.Bar = f:CreateTexture(nil, "ARTWORK")
	f.Bar: SetTexture(F.Media..texture)
	f.Bar: SetPoint("LEFT", f, "LEFT", 0,0)
	f.Bar: SetVertexColor(unpack(C.Color.White))
	f.Bar: SetSize(x,y)
	f.Bar: SetTexCoord(x1,x2, y1,y2)
	f.Bar: SetAlpha(0)
	
	f.BarGloss = f:CreateTexture(nil, "BORDER")
	f.BarGloss: SetTexture(F.Media..texture.."_Gloss")
	f.BarGloss: SetPoint("LEFT", f, "LEFT", 0,0)
	f.BarGloss: SetVertexColor(unpack(C.Color.White))
	f.BarGloss: SetSize(x,y)
	f.BarGloss: SetTexCoord(x1,x2, y1,y2)
	f.BarGloss: SetAlpha(0.5)
	
	f.BarBg = f:CreateTexture(nil, "BACKGROUND")
	f.BarBg:SetTexture(F.Media..texture.."_Gloss")
	f.BarBg:SetPoint("LEFT", f, "LEFT", -3,3)
	f.BarBg:SetVertexColor(unpack(C.Color.White))
	f.BarBg:SetSize(x,y)
	f.BarBg:SetTexCoord(x1,x2, y1,y2)
	f.BarBg:SetAlpha(0.5)
end

local create_Health = function(f)
	f.Health = CreateFrame("Frame", nil, f)
	f.Health: SetSize(203, 28)
	f.Health: SetPoint("BOTTOMLEFT", f, "BOTTOMRIGHT", 10,20)
	
	L.init_Smooth(f.Health)
	
	create_Bar(f.Health, "Player_HealthBar", 203,28, 27/256,230/256, 2/32,30/32)
	
	for i = 1,8 do
		f.Health[i] = f:CreateTexture(nil, "ARTWORK")
		f.Health[i]: SetTexture(F.Media.."Player_HealthBars")
		f.Health[i]: SetSize(HP_Coord[11][1],HP_Coord[11][2])
		f.Health[i]: SetTexCoord(HP_Coord[11][3],HP_Coord[11][4], HP_Coord[11][5],HP_Coord[11][6])
		f.Health[i]: SetVertexColor(unpack(C.Color.White))
		f.Health[i]: SetAlpha(0.9)
		if i == 1 then
			f.Health[i]: SetPoint("BOTTOMLEFT", f.Health, "BOTTOMLEFT", -2,-2)
		else
			f.Health[i]: SetPoint("BOTTOMLEFT", f.Health[i-1], "BOTTOMLEFT", 25,2)
		end
		
		f.Health[i].Extra = f:CreateTexture(nil, "OVERLAY")
		f.Health[i].Extra: SetTexture(F.Media.."Player_HealthBar_Extra")
		f.Health[i].Extra: SetSize(38,42)
		f.Health[i].Extra: SetTexCoord(13/64,51/64, 11/64,53/64)
		f.Health[i].Extra: SetVertexColor(unpack(C.Color.Red))
		f.Health[i].Extra: SetAlpha(0)
		f.Health[i].Extra: SetPoint("LEFT", f.Health[i], "LEFT", 4,0)
		f.Health[i].Extra.a = 0
		f.Health[i].Extra.t = 0
	end
end

local create_Power = function(f)
	f.Power = CreateFrame("Frame", nil, f)
	f.Power: SetSize(202, 24)
	f.Power: SetPoint("BOTTOMLEFT", f.Health, "BOTTOMLEFT", -4,-12)
	
	L.init_Smooth(f.Power)
	
	create_Bar(f.Power, "Player_PowerBar", 202,24, 27/256,229/256, 4/32,28/32)
	
	for i = 1,8 do
		f.Power[i] = f:CreateTexture(nil, "ARTWORK")
		f.Power[i]: SetTexture(F.Media.."Player_PowerBars")
		f.Power[i]: SetSize(PP_Coord[11][1],PP_Coord[11][2])
		f.Power[i]: SetTexCoord(PP_Coord[11][3],PP_Coord[11][4], PP_Coord[11][5],PP_Coord[11][6])
		f.Power[i]: SetVertexColor(unpack(C.Color.White))
		f.Power[i]: SetAlpha(0.9)
		if i == 1 then
			f.Power[i]: SetPoint("BOTTOMLEFT", f.Power, "BOTTOMLEFT", -3,-4)
		else
			f.Power[i]: SetPoint("BOTTOMLEFT", f.Power[i-1], "BOTTOMLEFT", 25,2)
		end
	end
end

local create_Portrait = function(f)
	f.Portrait = CreateFrame("Frame", nil, f)
	f.Portrait: SetSize(98, 113)
	f.Portrait: SetPoint("BOTTOM", f, "BOTTOM", 0,0)
	
	f.Portrait.P = CreateFrame("PlayerModel", nil, f.Portrait)
	f.Portrait.P: SetFrameLevel(f.Portrait:GetFrameLevel()-1)
	f.Portrait.P: SetSize(160, 200)--82，68
	f.Portrait.P: SetPoint("BOTTOM", f.Portrait, "BOTTOM", 0, 18)
	f.Portrait.P: SetCamDistanceScale(1.6)
	f.Portrait.P: SetPortraitZoom(0.6)
	f.Portrait.P: SetPosition(0,0,-0.45)
	f.Portrait.P: SetRotation(rad(25))
	f.Portrait.P: SetUnit(f.unit)
	f.Portrait.P.guid = UnitGUID(f.unit)
	
	f.Portrait.help = CreateFrame("Frame", nil, f.Portrait)
	f.Portrait.help: SetFrameLevel(f.Portrait:GetFrameLevel()-2)
	
	f.Portrait.B0 = f.Portrait:CreateTexture(nil, "ARTWORK")
	create_Texture(f.Portrait.B0, "Player_Portrait_0", 77,32, 26/128,103/128,17/64,49/64, C.Color.White,0.9, "BOTTOM",f.Portrait,"BOTTOM",0,-10)
	
	f.Portrait.B1 = f.Portrait:CreateTexture(nil, "ARTWORK")
	create_Texture(f.Portrait.B1, "Player_Portrait_1_1", 96,112, 16/128,112/128,8/128,120/128, C.Color.White,0.6, "BOTTOM",f.Portrait,"BOTTOM",0,0)
	
	f.Portrait.B1_ex = f.Portrait.help:CreateTexture(nil, "ARTWORK")
	create_Texture(f.Portrait.B1_ex, "Player_Portrait_1_2", 96,112, 16/128,112/128,8/128,120/128, C.Color.White,0.6, "BOTTOM",f.Portrait,"BOTTOM",0,1)
	
	f.Portrait.B2 = f.Portrait.help:CreateTexture(nil, "BACKGROUND")
	create_Texture(f.Portrait.B2, "Player_Portrait_2", 96,112, 16/128,112/128,8/128,120/128, C.Color.Black,0.6, "BOTTOM",f.Portrait,"BOTTOM",0,0)

	f.Portrait.B3 = f.Portrait:CreateTexture(nil, "OVERLAY")
	create_Texture(f.Portrait.B3, "Player_Portrait_3", 64,32, 0,1,0,1, C.Color.White,0, "BOTTOM",f.Portrait,"BOTTOM",-1,-5)
	
	f.Portrait.P: RegisterEvent("PLAYER_ENTERING_WORLD")
	f.Portrait.P: RegisterEvent("UNIT_MODEL_CHANGED")
	f.Portrait.P: RegisterEvent("UNIT_PORTRAIT_UPDATE")
	f.Portrait.P: SetScript("OnEvent", function(self,event)
		f.Portrait.P: ClearModel()
		f.Portrait.P: SetUnit(f.unit)
		f.Portrait.P.guid = UnitGUID(f.unit)
		local race, raceEn = UnitRace(f.unit)
		
		if raceEn == "Human" then
			f.Portrait.P: SetCamDistanceScale(1.4)
			f.Portrait.P: SetPortraitZoom(0.6)
			f.Portrait.P: SetPosition(0,0,-0.34)
			f.Portrait.P: SetRotation(rad(25))
		elseif raceEn == "NightElf" then
			f.Portrait.P: SetCamDistanceScale(1.6)
			f.Portrait.P: SetPortraitZoom(0.6)
			f.Portrait.P: SetPosition(0,0,-0.4)
			f.Portrait.P: SetRotation(rad(25))
		elseif raceEn == "Dwarve" then -->矮人
			f.Portrait.P: SetCamDistanceScale(1.6)
			f.Portrait.P: SetPortraitZoom(0.6)
			f.Portrait.P: SetPosition(0,0,-0.34)
			f.Portrait.P: SetRotation(rad(25))
		elseif raceEn == "Gnome" then -->
			f.Portrait.P: SetCamDistanceScale(1.6)
			f.Portrait.P: SetPortraitZoom(0.3)
			f.Portrait.P: SetPosition(0,0,-0.32)
			f.Portrait.P: SetRotation(rad(25))
		elseif raceEn == "Draenei" then -->德莱尼
			f.Portrait.P: SetCamDistanceScale(1.4)
			f.Portrait.P: SetPortraitZoom(0.6)
			f.Portrait.P: SetPosition(0,0,-0.42)
			f.Portrait.P: SetRotation(rad(25))
		elseif raceEn == "Worgen" then -->
			f.Portrait.P: SetCamDistanceScale(1.6)
			f.Portrait.P: SetPortraitZoom(0.3)
			f.Portrait.P: SetPosition(0,0,-0.72)
			f.Portrait.P: SetRotation(rad(25))
		elseif raceEn == "Pandaren" then -->
			f.Portrait.P: SetCamDistanceScale(1.6)
			f.Portrait.P: SetPortraitZoom(0.3)
			f.Portrait.P: SetPosition(0,0,-0.6)
			f.Portrait.P: SetRotation(rad(25))
		elseif raceEn == "BloodElf" then
			f.Portrait.P: SetCamDistanceScale(1.4)
			f.Portrait.P: SetPortraitZoom(0.6)
			f.Portrait.P: SetPosition(0,0,-0.36)
			f.Portrait.P: SetRotation(rad(25))
		elseif raceEn == "Tauren" then -->牛头
			f.Portrait.P: SetCamDistanceScale(1.6)
			f.Portrait.P: SetPortraitZoom(0.4)
			f.Portrait.P: SetPosition(0,0,-0.6)
			f.Portrait.P: SetRotation(rad(25))
		elseif raceEn == "Orc" then -->兽人
			f.Portrait.P: SetCamDistanceScale(1.6)
			f.Portrait.P: SetPortraitZoom(0.3)
			f.Portrait.P: SetPosition(0,0,-0.55)
			f.Portrait.P: SetRotation(rad(25))
		elseif raceEn == "Scourge" then -->不死
			f.Portrait.P: SetCamDistanceScale(1.6)
			f.Portrait.P: SetPortraitZoom(0.5)
			f.Portrait.P: SetPosition(0,0,-0.34)
			f.Portrait.P: SetRotation(rad(25))
		elseif raceEn == "Troll" then -->巨魔
			f.Portrait.P: SetCamDistanceScale(1.6)
			f.Portrait.P: SetPortraitZoom(0.6)
			f.Portrait.P: SetPosition(0,0,-0.4)
			f.Portrait.P: SetRotation(rad(25))
		elseif raceEn == "Goblin" then -->
			f.Portrait.P: SetCamDistanceScale(1.6)
			f.Portrait.P: SetPortraitZoom(0.6)
			f.Portrait.P: SetPosition(0.2,0,-0.4)
			f.Portrait.P: SetRotation(rad(25))
		end

	end)
end

local create_Num = function(f)
	f.Num = CreateFrame("Frame", nil, f)
	
	for i = 1,9 do
		f.Num[i] =  f.Num:CreateTexture(nil, "ARTWORK")
		f.Num[i]: SetVertexColor(unpack(C.Color.White))
		f.Num[i]: SetAlpha(0.9)
		if i < 5 then
			f.Num[i]: SetTexture(F.Media.."Player_Num1")
			f.Num[i]: SetSize(Num1[0][1], Num1[0][2])
			f.Num[i]: SetTexCoord(Num1[0][3],Num1[0][4], Num1[0][5],Num1[0][6])
		elseif i == 5 then
			f.Num[i]: SetTexture(F.Media.."Player_Num2")
			f.Num[i]: SetSize(Num2["/"][1], Num2["/"][2])
			f.Num[i]: SetTexCoord(Num2["/"][3],Num2["/"][4], Num2["/"][5],Num2["/"][6])
		elseif i > 5 then
			f.Num[i]: SetTexture(F.Media.."Player_Num2")
			f.Num[i]: SetSize(Num2[0][1], Num1[0][2])
			f.Num[i]: SetTexCoord(Num2[0][3],Num2[0][4], Num2[0][5],Num2[0][6])
		end
	end
	f.Num[5]: SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 168,44)
	f.Num[4]: SetPoint("BOTTOMLEFT", f.Num[5], "BOTTOMLEFT", -13,0)
	f.Num[6]: SetPoint("BOTTOMLEFT", f.Num[5], "BOTTOMLEFT", 15,0)
	for i = 3,1, -1 do
		f.Num[i]: SetPoint("BOTTOMLEFT", f.Num[i+1], "BOTTOMLEFT", -13,-1)
	end
	for i = 7,9, 1 do
		f.Num[i]: SetPoint("BOTTOMLEFT", f.Num[i-1], "BOTTOMLEFT", 11,0.9)
	end
	
	f.Num.Dot1 = f.Num:CreateTexture(nil, "ARTWORK")
	create_Texture(f.Num.Dot1, "Player_Num1", Num1["."][1],Num1["."][2], Num1["."][3],Num1["."][4],Num1["."][5],Num1["."][6], C.Color.White,1, "BOTTOMLEFT",f.Num[3],"BOTTOMRIGHT",-4.5,-2)
	
	f.Num.Dot2 = f.Num:CreateTexture(nil, "ARTWORK")
	create_Texture(f.Num.Dot2, "Player_Num2", Num2["."][1],Num2["."][2], Num2["."][3],Num2["."][4],Num2["."][5],Num2["."][6], C.Color.White,1, "BOTTOMLEFT",f.Num[8],"BOTTOMRIGHT",-4.5,-2)
end

--- ----------------------------------------------------------------------------
--> Player Frame             
--- ----------------------------------------------------------------------------

L.Player_Frame = function(f)
	f.Player = CreateFrame("Frame", nil, f)
	f.Player: SetSize(98, 113)
	--f.Player: SetPoint("BOTTOMLEFT", f, "CENTER", -580, -320)
	--f.Player: SetPoint("BOTTOMLEFT", f, "CENTER", OwD_DB.Pos.Player.x, OwD_DB.Pos.Player.y)
	f.Player.unit = "player"
	
	create_Health(f.Player)
	create_Power(f.Player)
	create_Portrait(f.Player)
	create_Num(f.Player)
end

--- ----------------------------------------------------------------------------
--> Player Frame Update          
--- ----------------------------------------------------------------------------

local update_Health = function(self, unit)
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

local update_Power = function(self, unit)
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

L.OnEvent_Player = function(f, event)
	if event == "PLAYER_ENTERING_WORLD" or event == "UNIT_ENTERED_VEHICLE" or event == "UNIT_EXITED_VEHICLE" then
		if UnitInVehicle("player") then
			f.unit = "vehicle"
		else
			f.unit = "player"
		end
		
		update_Health(f, f.unit)
		update_Power(f, f.unit)
		f.Portrait.P: SetUnit(f.unit)
		f.Portrait.P.guid = UnitGUID(f.unit)
	end
	
	if event == "UNIT_HEALTH_FREQUENT" or event == "UNIT_MAXHEALTH" then
		update_Health(f, f.unit)
	end
	
	if event == "UNIT_POWER_FREQUENT" or event == "UNIT_MAXPOWER" then
		update_Power(f, f.unit)
	end
end

L.OnUpdate_Player = function(f, elapsed)
	local step = floor(1/(GetFramerate())*1e3)/1e3
	local d1,d2, d3,d4
	
	d1 = f.Health.Cur*8 or 0
	for i = 1,8 do
		if d1 >= i then
			f.Health[i]: SetTexCoord(HP_Coord[11][3],HP_Coord[11][4], HP_Coord[11][5],HP_Coord[11][6])
			f.Health[i]: Show()
			
			f.Health[i].Extra.a = 0
			f.Health[i].Extra:SetAlpha(f.Health[i].Extra.a)
			f.Health[i].Extra.t = 0
		elseif d1 < i and (d1+1) >= i then
			d2 = floor((d1 + 1 - i) * 11 + 0.5)
			f.Health[i]: SetTexCoord(HP_Coord[d2][3],HP_Coord[d2][4], HP_Coord[d2][5],HP_Coord[d2][6])
			f.Health[i]: Show()
			
			f.Health[i].Extra.a = 0
			f.Health[i].Extra:SetAlpha(f.Health[i].Extra.a)
			f.Health[i].Extra.t = 0
		else
			--f.Health[i]: Hide()
			if f.Health[i]:IsShown() then
				f.Health[i].Extra.a = f.Health[i].Extra:GetAlpha()
				if f.Health[i].Extra.a < 1 then
					f.Health[i].Extra.a = min(f.Health[i].Extra.a + 15*step, 1)
					f.Health[i].Extra:SetAlpha(f.Health[i].Extra.a)
				else
					if f.Health[i].Extra.t < 0.15 then
						f.Health[i].Extra.t = f.Health[i].Extra.t + step
					else
						f.Health[i]:Hide()
						f.Health[i].Extra.a = 0
						f.Health[i].Extra.t = 0
					end
				end
			else
				f.Health[i].Extra.a = 0
				f.Health[i].Extra:SetAlpha(f.Health[i].Extra.a)
				f.Health[i].Extra.t = 0
			end
		end
	end
	
	d3 = f.Power.Cur*8 or 0
	for i = 1,8 do
		if d3 >= i then
			f.Power[i]: SetTexCoord(PP_Coord[11][3],PP_Coord[11][4], PP_Coord[11][5],PP_Coord[11][6])
			f.Power[i]: Show()
		elseif d3 < i and (d3+1) >= i then
			d4 = floor((d3 + 1 - i) * 11 + 0.5)
			f.Power[i]: SetTexCoord(PP_Coord[d4][3],PP_Coord[d4][4], PP_Coord[d4][5],PP_Coord[d4][6])
			f.Power[i]: Show()
		else
			f.Power[i]: Hide()
		end
	end
	
	--f.Health.Bar: SetSize(203*f.Health.Cur+F.Debug, 28)
	--f.Health.Bar: SetTexCoord(27/256,(27+203*f.Health.Cur+F.Debug)/256, 2/32,30/32)
	
	--f.Power.Bar: SetSize(202*f.Power.Cur+F.Debug, 24)
	--f.Power.Bar: SetTexCoord(27/256,(27+202*f.Power.Cur+F.Debug)/256, 4/32,28/32)
	
	local h,h1,h2,h3,h4,h5,h6, p,p1,p2,p3,p4,p5,p6
	h = f.Health.Cur * f.Health.Max
	p = f.Power.Cur * f.Power.Max
	
	if h < 1e3 then
		h1 = floor(h/1000)
		h2 = floor(h/100)-h1*10
		h3 = floor(h/10)-h1*100-h2*10
		h4 = floor(h)-floor(h/10)*10
		
		if h1 <= 0 then
			f.Num[1]: SetAlpha(0.3)
		
			if h2 <= 0 then
				f.Num[2]: SetAlpha(0.3)
				if h3 <= 0 then
					f.Num[3]: SetAlpha(0.3)
				else
					f.Num[3]: SetAlpha(0.9)
				end
			else
				f.Num[2]: SetAlpha(0.9)
				f.Num[3]: SetAlpha(0.9)
			end
		else
			f.Num[1]: SetAlpha(0.9)
			f.Num[2]: SetAlpha(0.9)
			f.Num[3]: SetAlpha(0.9)
		end
		
		f.Num.Dot1: Hide()
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
		h1 = floor(h/100)
		h2 = floor(h/10)-h1*10
		h3 = floor(h)-h1*100-h2*10
		h5 = floor(abs(h*10-floor(h)*10))
		h6 = floor(abs(h*100-floor(h*10)*10))
		
		f.Num[1]: SetAlpha(0.9)
		f.Num[2]: SetAlpha(0.9)
		f.Num[3]: SetAlpha(0.9)
		
		if h2 <= 0 and h1 <= 0 then
			h1 = h3
			h2 = h5
			h3 = h6
			f.Num.Dot1: ClearAllPoints()
			f.Num.Dot1: SetPoint("BOTTOMLEFT", f.Num[1],"BOTTOMRIGHT", -4.5,-2)
			f.Num.Dot1: Show()
		elseif h1 <= 0 and h2 > 0 then
			h1 = h2
			h2 = h3
			h3 = h5
			f.Num.Dot1: ClearAllPoints()
			f.Num.Dot1: SetPoint("BOTTOMLEFT", f.Num[2],"BOTTOMRIGHT", -4.5,-2)
			f.Num.Dot1: Show()
		else
			f.Num.Dot1: Hide()
		end
	end
	
	if p < 1e4 then
		p1 = floor(p/1000)
		p2 = floor(p/100)-p1*10
		p3 = floor(p/10)-p1*100-p2*10
		p4 = floor(p)-floor(p/10)*10
		
		if p1 <= 0 then
			f.Num[6]: SetAlpha(0.3)
			if p2 <= 0 then
				f.Num[7]: SetAlpha(0.3)
				if p3 <= 0 then
					f.Num[8]: SetAlpha(0.3)
				else
					f.Num[8]: SetAlpha(0.9)
				end
			else
				f.Num[7]: SetAlpha(0.9)
				f.Num[8]: SetAlpha(0.9)
			end
		else
			f.Num[6]: SetAlpha(0.9)
			f.Num[7]: SetAlpha(0.9)
			f.Num[8]: SetAlpha(0.9)
		end
		
		f.Num.Dot2: Hide()
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
		p1 = floor(p/100)
		p2 = floor(p/10)-p1*10
		p3 = floor(p)-p1*100-p2*10
		p5 = floor(abs(p*10-floor(p)*10))
		p6 = floor(abs(p*100-floor(p*10)*10))
		
		f.Num[6]: SetAlpha(0.9)
		f.Num[7]: SetAlpha(0.9)
		f.Num[8]: SetAlpha(0.9)
		
		if p1 <= 0 and p2 <= 0 then
			p1 = p3
			p2 = p5
			p3 = p6
			f.Num.Dot2: ClearAllPoints()
			f.Num.Dot2: SetPoint("BOTTOMLEFT", f.Num[6],"BOTTOMRIGHT", -4.5,-2)
			f.Num.Dot2: Show()
		elseif p1 <= 0 and p2 > 0 then
			p1 = p2
			p2 = p3
			p3 = p5
			f.Num.Dot2: ClearAllPoints()
			f.Num.Dot2: SetPoint("BOTTOMLEFT", f.Num[7],"BOTTOMRIGHT", -4.5,-2)
			f.Num.Dot2: Show()
		else
			f.Num.Dot2: Hide()
		end
	end
	
	f.Num[1]: SetTexCoord(Num1[h1][3],Num1[h1][4], Num1[h1][5],Num1[h1][6])
	f.Num[2]: SetTexCoord(Num1[h2][3],Num1[h2][4], Num1[h2][5],Num1[h2][6])
	f.Num[3]: SetTexCoord(Num1[h3][3],Num1[h3][4], Num1[h3][5],Num1[h3][6])
	f.Num[4]: SetTexCoord(Num1[h4][3],Num1[h4][4], Num1[h4][5],Num1[h4][6])
	
	f.Num[6]: SetTexCoord(Num2[p1][3],Num2[p1][4], Num2[p1][5],Num2[p1][6])
	f.Num[7]: SetTexCoord(Num2[p2][3],Num2[p2][4], Num2[p2][5],Num2[p2][6])
	f.Num[8]: SetTexCoord(Num2[p3][3],Num2[p3][4], Num2[p3][5],Num2[p3][6])
	f.Num[9]: SetTexCoord(Num2[p4][3],Num2[p4][4], Num2[p4][5],Num2[p4][6])
	
	
	if UnitAffectingCombat("player") then
		f.Portrait.B2: SetVertexColor(unpack(C.Color.Red))
		f.Portrait.B2: SetAlpha(0.2 + 0.6 * F.Alpha)
	elseif IsResting() then
		f.Portrait.B2: SetVertexColor(253/255, 218/255, 4/255)
		f.Portrait.B2: SetAlpha(0.2 + 0.6 * F.Alpha)
	else
		f.Portrait.B2: SetVertexColor(0.09,0.09,0.09)
		f.Portrait.B2: SetAlpha(0.6)
	end
end

--- ----------------------------------------------------------------------------
--> Pet
--- ----------------------------------------------------------------------------

local create_Pet = function(f)
	f.Health = CreateFrame("Frame", nil, f)
	f.Health: SetSize(48, 48)
	f.Health: SetPoint("CENTER", f, "CENTER", 0,0)
	
	L.init_Smooth(f.Health)
	
	f.Health.B1 = L.create_Texture(f.Health, "ARTWORK", "Pet_Border", 24,64, 4/32,28/32,0,1, C.Color.White,0.9, "BOTTOMRIGHT", f.Health, "BOTTOMLEFT", 8,-4)
	
	f.Health.BarBg = L.create_Texture(f.Health, "BACKGROUND", "Pet_Bar", 48,48, 8/64,56/64,8/64,56/64, C.Color.White2,0.5, "BOTTOM", f.Health, "BOTTOM", 0,0)
	f.Health.Bar = L.create_Texture(f.Health, "ARTWORK", "Pet_Bar", 48,48, 8/64,56/64,8/64,56/64, C.Color.White,0.9, "BOTTOM", f.Health, "BOTTOM", 0,0)
	
	for i = 1,4 do
		f.Health[i] = f.Health:CreateTexture(nil, "ARTWORK")
		f.Health[i]: SetVertexColor(unpack(C.Color.White))
		f.Health[i]: SetAlpha(0.9)
		f.Health[i]: SetTexture(F.Media.."Pet_Num")
		f.Health[i]: SetSize(Num4[0][1], Num4[0][2])
		f.Health[i]: SetTexCoord(Num4[0][3],Num4[0][4], Num4[0][5],Num4[0][6])
		if i == 1 then
			f.Health[i]: SetPoint("BOTTOMLEFT", f.Health, "BOTTOMRIGHT", -2,4)
		else
			f.Health[i]: SetPoint("BOTTOMLEFT", f.Health[i-1], "BOTTOMRIGHT", -4,0.4)
		end
	end
	f.Health[1]: SetSize(Num4["*"][1], Num4["*"][2])
	f.Health[1]: SetTexCoord(Num4["*"][3],Num4["*"][4], Num4["*"][5],Num4["*"][6])
end

L.OnEvent_Pet = function(f, event)
	if event == "PLAYER_ENTERING_WORLD" or event == "UNIT_ENTERED_VEHICLE" or event == "UNIT_EXITED_VEHICLE" or event == "PET_UI_CLOSE" or event == "PET_UI_UPDATE"then
		if UnitInVehicle("player") then
			f.unit = "player"
		else
			f.unit = "pet"
		end
		update_Health(f, f.unit)
		--update_Power(f, f.unit)
	elseif event == "UNIT_HEALTH_FREQUENT" or event == "UNIT_MAXHEALTH" then
		update_Health(f, f.unit)
	elseif event == "UNIT_POWER_FREQUENT" or event == "UNIT_MAXPOWER" then
		--update_Power(f, f.unit)
	end
end

L.OnUpdate_Pet = function(f)
	if UnitExists(f.unit) then
		f:Show()
		f.Health.Bar: SetSize(48, 48*f.Health.Cur+F.Debug)
		f.Health.Bar: SetTexCoord(8/64,56/64,(8+48*abs(1-f.Health.Cur))/64,56/64)
		local h,h1,h2,h3,h4,h5,h6
		h = f.Health.Cur
		
		h1 = floor(abs(h))
		h2 = floor(abs(h*10-h1*10))
		h3 = floor(abs(h*100-floor(h*10)*10))
		
		if h1 <= 0 then
			f.Health[2]: SetAlpha(0.3)
			if h2 <=0 then
				f.Health[3]: SetAlpha(0.3)
			else
				f.Health[3]: SetAlpha(0.9)
			end
		else
			f.Health[2]: SetAlpha(0.9)
			f.Health[3]: SetAlpha(0.9)
		end
		f.Health[2]: SetSize(Num4[h1][1], Num4[h1][2])
		f.Health[2]: SetTexCoord(Num4[h1][3],Num4[h1][4], Num4[h1][5],Num4[h1][6])
		f.Health[3]: SetSize(Num4[h2][1], Num4[h2][2])
		f.Health[3]: SetTexCoord(Num4[h2][3],Num4[h2][4], Num4[h2][5],Num4[h2][6])
		f.Health[4]: SetSize(Num4[h3][1], Num4[h3][2])
		f.Health[4]: SetTexCoord(Num4[h3][3],Num4[h3][4], Num4[h3][5],Num4[h3][6])
	else
		f:Hide()
	end
end

L.Pet_Frame = function(f)
	f.Pet = CreateFrame("Frame", nil, f)
	f.Pet: SetSize(48, 48)
	--f.Pet: SetPoint("BOTTOMLEFT", f, "CENTER", -580, -320)
	f.Pet: SetPoint("BOTTOMLEFT", f.Player, "BOTTOMRIGHT", 240, 20)
	f.Pet.unit = "pet"
	
	create_Pet(f.Pet)
end

--- ----------------------------------------------------------------------------
--> FCS
--- ----------------------------------------------------------------------------

local update_Point = function(f, pMax, p)
	p = p or 0
	for i = 1,6 do
		f.Point[i]: SetVertexColor(unpack(C.Color.White))
		f.Point[i]: SetAlpha(1)
		if i <= p then
			f.Point[i]:Show()
		else
			f.Point[i]:Hide()
		end
	end
	if pMax == 0 then
		for i = 1,6 do
			f.Point[i]: Hide()
		end
	elseif pMax == 1 then
		f.Point[1]: SetTexture(F.Media.."Point_1")
	elseif pMax == 2 then
		f.Point[1]: SetTexture(F.Media.."Point_2_1")
		f.Point[2]: SetTexture(F.Media.."Point_2_2")
	elseif pMax == 3 then 
		f.Point[1]: SetTexture(F.Media.."Point_2_1")
		f.Point[2]: SetTexture(F.Media.."Point_2_2")
		f.Point[3]: SetTexture(F.Media.."Point_1")
		f.Point[3]: SetVertexColor(unpack(C.Color.Red))
		if p > 2 then
			f.Point[1]: Hide()
			f.Point[2]: Hide()
		end
	elseif pMax == 4 then
		f.Point[1]: SetTexture(F.Media.."Point_4_1")
		f.Point[2]: SetTexture(F.Media.."Point_4_2")
		f.Point[3]: SetTexture(F.Media.."Point_4_3")
		f.Point[4]: SetTexture(F.Media.."Point_4_4")
	elseif pMax == 5 then
		f.Point[1]: SetTexture(F.Media.."Point_4_1")
		f.Point[2]: SetTexture(F.Media.."Point_4_2")
		f.Point[3]: SetTexture(F.Media.."Point_4_3")
		f.Point[4]: SetTexture(F.Media.."Point_4_4")
		f.Point[5]: SetTexture(F.Media.."Point_1")
		f.Point[5]: SetVertexColor(unpack(C.Color.Red))
		if p > 4 then
			f.Point[1]: Hide()
			f.Point[2]: Hide()
			f.Point[3]: Hide()
			f.Point[4]: Hide()
		end
	elseif pMax == 6 then
		f.Point[1]: SetTexture(F.Media.."Point_4_1")
		f.Point[2]: SetTexture(F.Media.."Point_4_2")
		f.Point[3]: SetTexture(F.Media.."Point_4_3")
		f.Point[4]: SetTexture(F.Media.."Point_4_4")
		f.Point[5]: SetTexture(F.Media.."Point_2_1")
		f.Point[6]: SetTexture(F.Media.."Point_2_2")
		f.Point[5]: SetVertexColor(unpack(C.Color.Red))
		f.Point[6]: SetVertexColor(unpack(C.Color.Red))
		if p > 4 then
			f.Point[1]: Hide()
			f.Point[2]: Hide()
			f.Point[3]: Hide()
			f.Point[4]: Hide()
		end
	end
end

local update_Indicator = function(texture,angle)
	
end

local update_Aura = function(unit,id,filter)
	local auraname = GetSpellInfo(id)
	local name, rank, icon, count, dispelType, duration, expires, caster = UnitAura(unit, auraname, nil, filter)
	count = count or 0
	if caster == "player" then
        return count, expires, duration
    else
		return 0,0,0 
	end
	
end

local create_Center_PowNum = function(f)
	f.PowNum = CreateFrame("Frame", nil, f)
	f.PowNum: SetSize(32,28)
	f.PowNum: SetPoint("CENTER", f, "CENTER", 0,0)
	
	for i = 1,4 do
		f.PowNum[i] = f.PowNum:CreateTexture(nil, "ARTWORK")
		f.PowNum[i]: SetTexture(F.Media.."Player_Num3")
		f.PowNum[i]: SetVertexColor(unpack(C.Color.White))
		f.PowNum[i]: SetAlpha(0.9)
		f.PowNum[i]: SetSize(Num3[8][1], Num3[8][2])
		f.PowNum[i]: SetTexCoord(Num3[8][3],Num3[8][4], Num3[8][5],Num3[8][6])
	end
	f.PowNum[1]: SetPoint("BOTTOMRIGHT", f.PowNum, "BOTTOM", -3,0)
	f.PowNum[2]: SetPoint("BOTTOMLEFT", f.PowNum, "BOTTOM", -5,0)
	f.PowNum[3]: SetPoint("BOTTOMLEFT", f.PowNum, "BOTTOM", 10,0)
	f.PowNum[3]: SetSize(Num3["%"][1], Num3["%"][2])
	f.PowNum[3]: SetTexCoord(Num3["%"][3],Num3["%"][4], Num3["%"][5],Num3["%"][6])
	
	f.PowNum[4]: SetPoint("BOTTOMLEFT", f, "TOPRIGHT", 20,10)
	f.PowNum[4]: Hide()
end

local create_Point = function(f)
	f.Point = CreateFrame("Frame", nil, f)
	f.Point: SetSize(128,128)
	f.Point: SetPoint("CENTER", f, "CENTER", 0,0)
	
	for i = 1,6 do
		f.Point[i] = f.Point:CreateTexture(nil, "ARTWORK")
		f.Point[i]: SetVertexColor(unpack(C.Color.White))
		f.Point[i]: SetSize(128,128)
		f.Point[i]: SetPoint("CENTER", f.Point, "CENTER", 0,0)
	end
	
	f.Point.Indicator = L.create_Texture(f.Point, "OVERLAY", "Point_Indicator2", 128,128, 0,1,0,1, C.Color.White,1, "CENTER", f.Point, "CENTER", 0,0)
	f.Point.Indicator: Hide()
	f.Point.Indicator.Direction = 0
	L.init_Smooth(f.Point.Indicator)
	
	local event = {
		"PLAYER_ENTERING_WORLD",
		
		"PLAYER_SPECIALIZATION_CHANGED",
		"ACTIVE_TALENT_GROUP_CHANGED",
		"SPELLS_CHANGED",
		
		"GROUP_ROSTER_UPDATE",
		"CHARACTER_POINTS_CHANGED",
		
		"PLAYER_TALENT_UPDATE",
		"PLAYER_TARGET_CHANGED",
		
		"UNIT_ENTERED_VEHICLE",
		"UNIT_EXITED_VEHICLE",
		
		"UNIT_COMBO_POINTS",
		
		--"UNIT_POWER",
		"UNIT_POWER_FREQUENT",
		"UNIT_DISPLAYPOWER",
		
		"UPDATE_SHAPESHIFT_FORM",
		
		"UNIT_AURA",
	}
	F.rEvent(f.Point, event)
	f.Point: SetScript("OnEvent", function(self,event)
		f.Point.classFileName = select(2, UnitClass("player"))
		f.Point.specID = GetSpecialization()
		f.Point.form = GetShapeshiftFormID()
		f.Point.pMax = 0
		f.Point.p = 0
		f.Point.combo = 0
		f.Point.Remain = 0
		f.Point.Duration = 0
		f.Point.Start = 0
		f.Point.Expires = 0
		
		if UnitInVehicle("player") then
			f.Point.combo =  GetComboPoints("vehicle", "target") --comboPoints, arg1, arg2, secondLayerPoints, secondBarPoints = GetComboPoints(unit)
		else
			f.Point.combo =  GetComboPoints("player", "target")
		end
		if UnitInVehicle("player") and f.Point.combo and f.Point.combo > 0 then
			f.Point.pMax = 5
			update_Point(f, f.Point.pMax, f.Point.combo)
		else
			for i = 1,6 do
				f.Point[i]: Hide()
			end
			if f.Point.classFileName == "PALADIN" then-------------------------------------------PALADIN
				f.Point.p = UnitPower("player", SPELL_POWER_HOLY_POWER)
				f.Point.pMax = UnitPowerMax("player", SPELL_POWER_HOLY_POWER)
				update_Point(f, f.Point.pMax, f.Point.p)
			elseif f.Point.classFileName == "HUNTER" then----------------------------------------HUNTER
				
			elseif f.Point.classFileName == "ROGUE" then-----------------------------------------ROGUE
				update_Point(f, f.Point.pMax, f.Point.combo)
				f.Point.p, f.Point.Expires, f.Point.Duration = update_Aura("player", 115189, "HELPFUL")
				if f.Point.p and f.Point.p > 0 then
					f.PowNum[4]: SetSize(Num3[f.Point.p][1], Num3[f.Point.p][2])
					f.PowNum[4]: SetTexCoord(Num3[f.Point.p][3],Num3[f.Point.p][4], Num3[f.Point.p][5],Num3[f.Point.p][6])
					f.PowNum[4]: Show()
				else
					f.PowNum[4]: Hide()
				end
			elseif f.Point.classFileName == "PRIEST" then----------------------------------------PRIEST
				if f.Point.specID == 1 then
					
				elseif f.Point.specID == 2 then
					
				elseif f.Point.specID == 3 then
					f.Point.p = UnitPower("player", SPELL_POWER_SHADOW_ORBS)
					f.Point.pMax = UnitPowerMax("player", SPELL_POWER_SHADOW_ORBS)
					update_Point(f, f.Point.pMax, f.Point.p)
				end
			elseif f.Point.classFileName == "DEATHKNIGHT" then-----------------------------------DEATHKNIGHT
				
			elseif f.Point.classFileName == "SHAMAN" then----------------------------------------SHAMAN
				
			elseif f.Point.classFileName == "MAGE" then------------------------------------------MAGE
				
			elseif f.Point.classFileName == "WARLOCK" then---------------------------------------WARLOCK
				if f.Point.specID == 1 then -->Affliction
					f.Point.p = UnitPower("player", SPELL_POWER_SOUL_SHARDS)
					f.Point.pMax = UnitPowerMax("player", SPELL_POWER_SOUL_SHARDS)
					update_Point(f, f.Point.pMax, f.Point.p)
					local name = GetSpellInfo(152109) -->灵魂燃烧：鬼影缠身
					if GetSpellInfo(name) then
						--self: RegisterEvent("UNIT_AURA")
						f.Point.Expires, f.Point.Duration = select(2, update_Aura("player", 157698, "HELPFUL")) -->鬼魅灵魂
						f.Point.Remain = max(f.Point.Expires - GetTime(), 0)
					end
				elseif f.Point.specID == 2 then -->Demonology
					f.Point.pMax = UnitPowerMax("player", SPELL_POWER_DEMONIC_FURY)
					f.Point.p = UnitPower("player", SPELL_POWER_DEMONIC_FURY)
					if powerMax and powerMax > 0 then
						f.Point.Indicator.Per = 360*power/powerMax
					else
						f.Point.Indicator.Per = 0
					end
				elseif f.Point.specID == 3 then -->Destruction
					-->MAX_POWER_PER_EMBER = 10, powerMax =40
					local power = UnitPower("player", SPELL_POWER_BURNING_EMBERS, true) 
					local powerMax = UnitPowerMax("player", SPELL_POWER_BURNING_EMBERS, true)
					f.Point.p = floor(power/MAX_POWER_PER_EMBER)
					f.Point.pMax = floor(powerMax/MAX_POWER_PER_EMBER)
					update_Point(f, f.Point.pMax, f.Point.p)
					if powerMax and powerMax > 0 then
						f.Point.Indicator.Per = 360*power/powerMax
					else
						f.Point.Indicator.Per = 0
					end
				end
			elseif f.Point.classFileName == "MONK" then-------------------------------------------MONK
				f.Point.p = UnitPower("player", SPELL_POWER_CHI)
				f.Point.pMax = UnitPowerMax("player", SPELL_POWER_CHI)
				update_Point(f, f.Point.pMax, f.Point.p)
			elseif f.Point.classFileName == "DRUID" then------------------------------------------DRUID
				--self: UnregisterEvent("UNIT_AURA")
				--self: UnregisterEvent("SPELL_UPDATE_CHARGES")
				f.Point.Remain = 0
				if f.Point.form == CAT_FORM then -->Feral
					--self: RegisterEvent("UNIT_AURA")
					f.Point.pMax = 5
					f.Point.combo =  GetComboPoints("player", "target")
					update_Point(f, f.Point.pMax, f.Point.combo)
					f.Point.Expires, f.Point.Duration = select(2, update_Aura("player", 774, "HELPFUL")) -->回春术
					f.Point.Remain = max(f.Point.Expires - GetTime(), 0)
				elseif f.Point.form == BEAR_FORM then
					if f.Point.specID == 3 then -->Guardian
						--self: RegisterEvent("UNIT_AURA")
						f.Point.p, f.Point.Expires, f.Point.Duration = update_Aura("target", 33745, "HARMFUL")--割伤
						local name = GetSpellInfo(80313) -->粉碎
						if GetSpellInfo(name) then
							f.Point.Expires, f.Point.Duration = select(2, update_Aura("player", 158792, "HELPFUL"))--粉碎
						end
						f.Point.pMax = 3
						update_Point(f, f.Point.pMax, f.Point.p)
						f.Point.Remain = max(f.Point.Expires - GetTime(), 0)
					else
						update_Point(f, 0, 0)
					end
				elseif f.Point.specID == 1 then -->Balance
					self: RegisterEvent("SPELL_UPDATE_CHARGES")
					local charges, maxCharges, start, duration = GetSpellCharges(78674)
					f.Point.p = charges
					f.Point.pMax = maxCharges
					update_Point(f, f.Point.pMax, f.Point.p)
					if f.Point.p < f.Point.pMax then
						f.Point.Remain = 1
					else
						f.Point.Remain = 0
					end
					f.Point.Duration = duration
					f.Point.Start = start					
				elseif f.Point.specID == 4 then -->Restoration
					
				end				
			end
		end	
	end)
end

local create_Background = function(f)
	f.B1 = f:CreateTexture(nil, "BACKGROUND")
	create_Texture(f.B1, "Point_0", 128,128, 0,1,0,1, C.Color.White2,0.4, "CENTER",f,"CENTER",0,0)
	
	f.B2 = f:CreateTexture(nil, "BACKGROUND")
	create_Texture(f.B2, "Point_4", 128,128, 0,1,0,1, C.Color.White2,0.4, "CENTER",f,"CENTER",0,0)
	
	f.Border = f:CreateTexture(nil, "BACKGROUND")
	create_Texture(f.Border, "Point_0", 128,128, 0,1,0,1, C.Color.White,0.9, "CENTER",f,"CENTER",0,0)
end

L.OnEvent_FCS = function(f, event)
	local p = f:GetParent()
	if event == "PLAYER_ENTERING_WORLD" or event == "UNIT_POWER_FREQUENT" or event == "UNIT_MAXPOWER" then
		local minPower,maxPower = UnitPower(p.Player.unit),UnitPowerMax(p.Player.unit)
		local p,p1,p2 = 0,0,0
		if maxPower == 0 or minPower == 0 then
			p = 0
		else
			p = floor(minPower/maxPower*1e4)/1e4
		end
		if p < 1 then
			p1 = floor(p*10)
			p2 = floor(p*100)-p1*10
		else
			p1 = 0
			p2 = 0
		end
		f.PowNum[1]: SetSize(Num3[p1][1], Num3[p1][2])
		f.PowNum[1]: SetTexCoord(Num3[p1][3],Num3[p1][4], Num3[p1][5],Num3[p1][6])
		
		f.PowNum[2]: SetSize(Num3[p2][1], Num3[p2][2])
		f.PowNum[2]: SetTexCoord(Num3[p2][3],Num3[p2][4], Num3[p2][5],Num3[p2][6])
	end
	if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED" then
		if UnitAffectingCombat("player") then
			--f:Show()
			f:SetAlpha(1)
		else
			--f:Hide()
			f:SetAlpha(0.4)
		end
	end
end

L.OnUpdate_FCS = function(f, elapsed)
	if f.Point.classFileName == "DRUID" then
		f.Point.Indicator: Hide()
		if  UnitInVehicle("player") and f.Point.combo and f.Point.combo > 0 then
			--update_Point(f, pMax, combo)
		elseif f.Point.form == CAT_FORM then -->Feral
			if f.Point.specID == 2 then
				if f.Point.Remain > 0 then
					f.Point.Remain = max(f.Point.Remain - elapsed, 0)
					F.RotateTexture(f.Point.Indicator, 360*f.Point.Remain/(f.Point.Duration+F.Debug))
					f.Point.Indicator: Show()
				end
			end
		elseif f.Point.form == BEAR_FORM then
			if f.Point.specID == 3 then -->Guardian
				if f.Point.Remain > 0 then
					f.Point.Remain = max(f.Point.Remain - elapsed, 0)
					F.RotateTexture(f.Point.Indicator, 360*f.Point.Remain/(f.Point.Duration+F.Debug))
					f.Point.Indicator: Show()
				end
			end
		elseif f.Point.specID == 1 then -->Balance
			if f.Point.Remain > 0 then
				f.Point.Remain = max(f.Point.Duration - (GetTime()-f.Point.Start), 0)
				F.RotateTexture(f.Point.Indicator, 360*f.Point.Remain/(f.Point.Duration+F.Debug))
				f.Point.Indicator: Show()
			end
		end
	
	elseif f.Point.classFileName == "WARLOCK" then---------------------------------------WARLOCK
		if f.Point.specID == 1 then -->Affliction
			if f.Point.Remain > 0 then
				f.Point.Remain = max(f.Point.Remain - elapsed, 0)
				F.RotateTexture(f.Point.Indicator, 360*f.Point.Remain/(f.Point.Duration+F.Debug))
				f.Point.Indicator: Show()
			else
				f.Point.Indicator: Hide()
			end
		end
	else
		if f.Point.Indicator.Per > 0 and f.Point.Indicator.Per < 1 then
			f.Point.Indicator: Show()
			F.RotateTexture(f.Point.Indicator, f.Point.Indicator.Cur)
		else
			f.Point.Indicator: Hide()
		end
	end
end

L.FCS = function(f)
	f.FCS = CreateFrame("Frame", nil, f)
	f.FCS: SetSize(64,64)
	--f.FCS: SetPoint("CENTER", f, "CENTER", 0, -250)
	--f.FCS: SetPoint("CENTER", f, "CENTER", 0, OwD_DB.Pos.FCS.y)
	
	create_Background(f.FCS)
	create_Center_PowNum(f.FCS)
	create_Point(f.FCS)
end

--- ----------------------------------------------------------------------------
--> GCD Frame
--- ----------------------------------------------------------------------------

L.GCD = function(f)
	f.GCD = CreateFrame("Frame", nil, f)
	f.GCD: SetSize(194,206)
	f.GCD: SetPoint("CENTER", f, "CENTER", -187, 177)
	
	f.GCD.Border = L.create_Texture(f.GCD, "BORDER", "GCD_Border", 194,206, 31/256,225/256,25/256,231/256, C.Color.White2,0.9, "BOTTOMLEFT",f.GCD,"BOTTOMLEFT",0,0)
	f.GCD.Block = L.create_Texture(f.GCD, "ARTWORK", "GCD_Block", 1024,1024, 0,1,0,1, C.Color.White,1, "CENTER",f,"CENTER",0,0)
	
	f.GCD: RegisterEvent("SPELL_UPDATE_COOLDOWN")
	f.GCD: RegisterEvent("PLAYER_ENTERING_WORLD")
	f.GCD: SetScript("OnEvent", function(self,event)
		local start, duration, enabled = GetSpellCooldown(61304)
		f.GCD.CD = duration
		f.GCD.Start = start
		f.GCD.Remain = 1
		f.GCD: SetScript("OnUpdate", function(self, elapsed)
			if f.GCD.Remain > 0 and f.GCD.CD > 0 then
				f.GCD: SetAlpha(1)
				f.GCD.Remain = max(f.GCD.CD - (GetTime()-f.GCD.Start), 0)
				F.RotateTexture(f.GCD.Block, -54*abs(1-(f.GCD.Remain/f.GCD.CD)))
			else
				f.GCD: SetAlpha(0)
				f.GCD: SetScript("OnUpdate", nil)
				F.RotateTexture(f.GCD.Block, -54)
			end
		end)
	end)
end

--- ----------------------------------------------------------------------------
--> XP Frame
--- ----------------------------------------------------------------------------

L.OnEvent_XP = function(f, event)
	if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_XP_UPDATE" or event == "UPDATE_FACTION" then
		local level,maxlevel = UnitLevel("Player"),GetMaxPlayerLevel()
		local x,y = 1,0
		local XP, maxXP = UnitXP("player"), UnitXPMax("player")
		local exXP = GetXPExhaustion() or 0
		local name, standingID, barMin, barMax, barValue = GetWatchedFactionInfo()
		if name then
			XP = barValue-barMin
			maxXP = barMax-barMin
			x = min(max(floor(XP/(maxXP+F.Debug)*1e3)/1e3, 0), 1)
			y = 0
			f.XP:Show()
			f.XP.Bar:SetVertexColor(unpack(C.Color.Green))
		else
			if level < maxlevel then
				x = min(max(floor(XP/(maxXP+F.Debug)*1e3)/1e3, 0), 1)
				y = min(max(floor((XP+exXP)/maxXP*1e3)/1e3, 0), 1)
				f.XP:Show()
				if exXP > 0 then
					f.XP.Bar:SetVertexColor(unpack(C.Color.Blue))
				else
					f.XP.Bar:SetVertexColor(unpack(C.Color.White))
				end
			else
				x = 1
				y = 0
				f.XP:Hide()
			end
		end
		f.XP.Bar: SetWidth(139*x+F.Debug)
		f.XP.Bar: SetTexCoord(59/256,(59+139*x)/256,7/32,25/32)
		
		local x1,x2,x3,x4,x5,x6, m1,m2,m3,m4,m5,m6
	
		if XP < 1e3 then
			x1 = floor(XP/1000)
			x2 = floor(XP/100-floor(XP/1000)*10)
			x3 = floor(XP/10-floor(XP/100)*10)
			x4 = floor(XP-floor(XP/10)*10+0.5)
		
			if x1 <= 0 then
				f.XP[9]: SetAlpha(0.3)
		
				if x2 <= 0 then
					f.XP[8]: SetAlpha(0.3)
					if x3 <= 0 then
						f.XP[7]: SetAlpha(0.3)
					else
						f.XP[7]: SetAlpha(1)
					end
				else
					f.XP[8]: SetAlpha(1)
					f.XP[7]: SetAlpha(1)
				end
			else
				f.XP[9]: SetAlpha(1)
				f.XP[8]: SetAlpha(1)
				f.XP[7]: SetAlpha(1)
			end
		
			f.XP.Dot1: Hide()
		else
			if XP >= 1e3 and XP < 1e6 then
				XP = XP/1e3
				x4 = "K"
			elseif XP >= 1e6 and XP < 1e9 then
				XP = XP/1e6
				x4 = "M"
			elseif XP >= 1e9 and XP < 1e12 then
				XP = XP/1e9
				x4 = "G"
			else
				XP = 0
				x4 = 0
			end	
			x1 = floor(XP/100)
			x2 = floor(XP/10-floor(XP/100)*10)
			x3 = floor(XP-floor(XP/10)*10)
			x5 = floor(XP*10-floor(XP)*10)
			x6 = floor(XP*100-floor(XP*10)*10+0.5)
			
			f.XP[9]: SetAlpha(1)
			f.XP[8]: SetAlpha(1)
			f.XP[7]: SetAlpha(1)
		
			if x2 <= 0 and x1 <= 0 then
				x1 = x3
				x2 = x5
				x3 = x6
				f.XP.Dot1: ClearAllPoints()
				f.XP.Dot1: SetPoint("BOTTOMLEFT", f.XP[9],"BOTTOMRIGHT", -6,-2)
				f.XP.Dot1: Show()
			elseif x1 <= 0 and x2 > 0 then
				x1 = x2
				x2 = x3
				x3 = x5
				f.XP.Dot1: ClearAllPoints()
				f.XP.Dot1: SetPoint("BOTTOMLEFT", f.XP[8],"BOTTOMRIGHT", -6,-2)
				f.XP.Dot1: Show()
			else
				f.XP.Dot1: Hide()
			end
		end
		
		if maxXP < 1e3 then
			m1 = floor(maxXP/1000)
			m2 = floor(maxXP/100-floor(maxXP/1000)*10)
			m3 = floor(maxXP/10-floor(maxXP/100)*10)
			m4 = floor(maxXP-floor(maxXP/10)*10+0.5)
		
			if m1 <= 0 then
				f.XP[4]: SetAlpha(0.3)
				if m2 <= 0 then
					f.XP[3]: SetAlpha(0.3)
					if m3 <= 0 then
						f.XP[2]: SetAlpha(0.3)
					else
						f.XP[2]: SetAlpha(1)
					end
				else
					f.XP[3]: SetAlpha(1)
					f.XP[2]: SetAlpha(1)
				end
			else
				f.XP[4]: SetAlpha(1)
				f.XP[3]: SetAlpha(1)
				f.XP[2]: SetAlpha(1)
			end
		
			f.XP.Dot2: Hide()
		else
			if maxXP >= 1e3 and maxXP < 1e6 then
				maxXP = maxXP/1e3
				m4 = "K"
			elseif maxXP >= 1e6 and XP < 1e9 then
				maxXP = maxXP/1e6
				m4 = "M"
			elseif maxXP >= 1e9 and maxXP < 1e12 then
				maxXP = maxXP/1e9
				m4 = "G"
			else
				XP = 0
				m4 = 0
			end	
			m1 = floor(maxXP/100)
			m2 = floor(maxXP/10-floor(maxXP/100)*10)
			m3 = floor(maxXP-floor(maxXP/10)*10)
			m5 = floor(maxXP*10-floor(maxXP)*10)
			m6 = floor(maxXP*100-floor(maxXP*10)*10+0.5)
		
			f.XP[4]: SetAlpha(1)
			f.XP[3]: SetAlpha(1)
			f.XP[2]: SetAlpha(1)
		
			if m2 <= 0 and m1 <= 0 then
				m1 = m3
				m2 = m5
				m3 = m6
				f.XP.Dot2: ClearAllPoints()
				f.XP.Dot2: SetPoint("BOTTOMLEFT", f.XP[4],"BOTTOMRIGHT", -6,-2)
				f.XP.Dot2: Show()
			elseif m1 <= 0 and m2 > 0 then
				m1 = m2
				m2 = m3
				m3 = m5
				f.XP.Dot2: ClearAllPoints()
				f.XP.Dot2: SetPoint("BOTTOMLEFT", f.XP[3],"BOTTOMRIGHT", -6,-2)
				f.XP.Dot2: Show()
			else
				f.XP.Dot2: Hide()
			end
		end
		f.XP[9]: SetSize(Num5[x1][1],Num5[x1][2])
		f.XP[9]: SetTexCoord(Num5[x1][3],Num5[x1][4], Num5[x1][5],Num5[x1][6])
		f.XP[8]: SetSize(Num5[x2][1],Num5[x2][2])
		f.XP[8]: SetTexCoord(Num5[x2][3],Num5[x2][4], Num5[x2][5],Num5[x2][6])
		f.XP[7]: SetSize(Num5[x3][1],Num5[x3][2])
		f.XP[7]: SetTexCoord(Num5[x3][3],Num5[x3][4], Num5[x3][5],Num5[x3][6])
		f.XP[6]: SetSize(Num5[x4][1],Num5[x4][2])
		f.XP[6]: SetTexCoord(Num5[x4][3],Num5[x4][4], Num5[x4][5],Num5[x4][6])
	
		f.XP[4]: SetSize(Num5[m1][1],Num5[m1][2])
		f.XP[4]: SetTexCoord(Num5[m1][3],Num5[m1][4], Num5[m1][5],Num5[m1][6])
		f.XP[3]: SetSize(Num5[m2][1],Num5[m2][2])
		f.XP[3]: SetTexCoord(Num5[m2][3],Num5[m2][4], Num5[m2][5],Num5[m2][6])
		f.XP[2]: SetSize(Num5[m3][1],Num5[m3][2])
		f.XP[2]: SetTexCoord(Num5[m3][3],Num5[m3][4], Num5[m3][5],Num5[m3][6])
		f.XP[1]: SetSize(Num5[m4][1],Num5[m4][2])
		f.XP[1]: SetTexCoord(Num5[m4][3],Num5[m4][4], Num5[m4][5],Num5[m4][6])
	end
end

L.XP = function(f)
	f.XP = CreateFrame("Frame", nil, f)
	f.XP: SetSize(139,18)
	f.XP: SetPoint("BOTTOMRIGHT", f.Right, "TOPRIGHT", 60, 20)
	
	f.XP.Bg = L.create_Texture(f.XP, "BACKGROUND", "XP_Bar", 139,18, 59/256,198/256,7/32,25/32, C.Color.White2,0.5, "BOTTOMLEFT", f.XP,"BOTTOMLEFT",0,0)
	f.XP.Bar = L.create_Texture(f.XP, "ARTWORK", "XP_Bar", 139,18, 59/256,198/256,7/32,25/32, C.Color.White,0.9, "BOTTOMLEFT", f.XP,"BOTTOMLEFT",0,0)
	
	for i = 1,9 do
		f.XP[i] =  f.XP:CreateTexture(nil, "ARTWORK")
		f.XP[i]: SetVertexColor(unpack(C.Color.White))
		f.XP[i]: SetAlpha(1)
		f.XP[i]: SetTexture(F.Media.."XP_Num")
		f.XP[i]: SetSize(Num5[0][1], Num5[0][2])
		f.XP[i]: SetTexCoord(Num5[0][3],Num5[0][4], Num5[0][5],Num5[0][6])
		if i == 1 then
			f.XP[i]: SetPoint("BOTTOMRIGHT", f.XP, "BOTTOMRIGHT", -4,12)
		else
			f.XP[i]: SetPoint("BOTTOMRIGHT", f.XP[i-1], "BOTTOMLEFT", 3,0.4)
		end
	end
	f.XP[5]: SetSize(Num5["/"][1], Num5["/"][2])
	f.XP[5]: SetTexCoord(Num5["/"][3],Num5["/"][4], Num5["/"][5],Num5["/"][6])
	
	f.XP.Dot1 = f.XP:CreateTexture(nil, "ARTWORK")
	create_Texture(f.XP.Dot1, "XP_Num", Num5["."][1],Num5["."][2], Num5["."][3],Num5["."][4],Num5["."][5],Num5["."][6], C.Color.White,1, "BOTTOMLEFT",f.XP[2],"BOTTOMRIGHT",-6,-2)
	
	f.XP.Dot2 = f.XP:CreateTexture(nil, "ARTWORK")
	create_Texture(f.XP.Dot2, "XP_Num", Num5["."][1],Num5["."][2], Num5["."][3],Num5["."][4],Num5["."][5],Num5["."][6], C.Color.White,1, "BOTTOMLEFT",f.XP[7],"BOTTOMRIGHT",-6,-2)
	
	--f.XP.XP = f.XP:CreateTexture(nil, "ARTWORK")
	--create_Texture(f.XP.XP, "XP_Num", Num5["X"][1],Num5["X"][2], Num5["X"][3],Num5["X"][4],Num5["X"][5],Num5["X"][6], C.Color.White,1, "BOTTOMRIGHT",f.XP[9],"BOTTOMLEFT",0,0)
end

--[[      
id = GetShapeshiftFormID()

Druids:

    Bear Form - 5 (BEAR_FORM constant)
    Cat Form - 1 (CAT_FORM constant)
    Aquatic Form - 4
    Travel Form - 3
    Moonkin Form - 31 (MOONKIN_FORM constant)
    Tree of Life - 2
    Flight Form - 27

Holy Priests:

    Chakra: Chastise - 1
    Chakra: Sanctuary - 2
    Chakra: Serenity - 3
    Spirit of Redemption - 4

Warriors:

    Battle Stance - 17
    Defensive Stance - 18
    Berserker Stance - 19

Warlocks:

    Metamorphosis - 22
--]]
