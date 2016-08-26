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
local HEATHBAR_WIDE = 19
local CPOWER_SCALE = 0.9
 
--[[
local myIncomingHeal = UnitGetIncomingHeals(frame.unit, "player") or 0
local allIncomingHeal = UnitGetIncomingHeals(frame.unit) or 0

local totalAbsorb = UnitGetTotalAbsorbs(unit) or 0

local healAbsorb = UnitGetTotalHealAbsorbs(unit) or 0
--]] 

--- ----------------------------------------------------------------------------
--> Player Frame Element      
--- ----------------------------------------------------------------------------

local Num_Left_30 = {
	[0] =	{27,39,   0/512, 27/512,  12/64,51/64},
	[1] =	{27,39,  27/512, 54/512,  12/64,51/64},
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
	["B"] =	{12,39-0.8, 500/512,512/512,  12/64,51/64},
}

local Num_Left_20 = {
	[0] =	{21,31,   0/512, 21/512, 1/32,1},
	[1] =	{21,31,  21/512, 42/512, 1/32,1},
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
	["B"] =	{11,31-0.7, 501/512,512/512, 1/32,1},
}

local Num_Center_24 = {
	[0] =	{21,30,   0/512, 21/512, 2/32,1},
	[1] =	{21,30,  21/512, 42/512, 2/32,1},
	[2] =	{21,30,  42/512, 63/512, 2/32,1},
	[3] =	{21,30,  63/512, 84/512, 2/32,1},
	[4] =	{21,30,  84/512,105/512, 2/32,1},
	[5] =	{21,30, 105/512,126/512, 2/32,1},
	[6] =	{21,30, 126/512,147/512, 2/32,1},
	[7] =	{21,30, 147/512,168/512, 2/32,1},
	[8] =	{21,30, 168/512,189/512, 2/32,1},
	[9] =	{21,30, 189/512,210/512, 2/32,1},
	["."] =	{21,30, 210/512,231/512, 2/32,1},
	["%"] =	{21,30, 231/512,252/512, 2/32,1},
	["-"] =	{21,30, 252/512,273/512, 2/32,1},
	["B"] =	{21,30, 273/512,294/512, 2/32,1},
}

local HP_Coord = {
	[1]	=	{39,30, 3/64, 42/64,   5/1024,  35/1024},
	[2]	=	{39,30, 3/64, 42/64,  36/1024,  66/1024},
	[3]	=	{39,30, 3/64, 42/64,  67/1024,  97/1024},
	[4]	=	{39,30, 3/64, 42/64,  98/1024, 128/1024},
	[5]	=	{39,30, 3/64, 42/64, 129/1024, 159/1024},
	[6]	=	{39,30, 3/64, 42/64, 160/1024, 190/1024},
	[7]	=	{39,30, 3/64, 42/64, 191/1024, 221/1024},
	[8]	=	{39,30, 3/64, 42/64, 222/1024, 252/1024},
	[9] =	{39,30, 3/64, 42/64, 253/1024, 283/1024},
	[10] =	{39,30, 3/64, 42/64, 284/1024, 314/1024},
	[11] =	{39,30, 3/64, 42/64, 315/1024, 345/1024},
	[12] =	{39,30, 3/64, 42/64, 346/1024, 376/1024},
	[13] =	{39,30, 3/64, 42/64, 377/1024, 407/1024},
	[14] =	{39,30, 3/64, 42/64, 408/1024, 438/1024},
	[15] =	{39,30, 3/64, 42/64, 439/1024, 469/1024},
	[16] =	{39,30, 3/64, 42/64, 470/1024, 500/1024},
	[17] =	{39,30, 3/64, 42/64, 501/1024, 531/1024},
	[18] =	{39,30, 3/64, 42/64, 532/1024, 562/1024},
	[19] =	{39,30, 3/64, 42/64, 563/1024, 593/1024},
	[20] =	{39,30, 3/64, 42/64, 594/1024, 624/1024},
	[21] =	{39,30, 3/64, 42/64, 625/1024, 655/1024},
	[22] =	{39,30, 3/64, 42/64, 656/1024, 686/1024},
	[23] =	{39,30, 3/64, 42/64, 687/1024, 717/1024},
	[24] =	{39,30, 3/64, 42/64, 718/1024, 748/1024},
	[25] =	{39,30, 3/64, 42/64, 749/1024, 779/1024},
	[26] =	{39,30, 3/64, 42/64, 780/1024, 810/1024},
	[0] =	{39,30, 3/64, 42/64, 811/1024, 841/1024},
}

local PP_Coord = {
	[36] =	{80,80,    1/4096,  81/4096, 24/128,104/128},
	[35] =	{80,80,   83/4096, 163/4096, 24/128,104/128},
	[34] =	{80,80,  165/4096, 245/4096, 24/128,104/128},
	[33] =	{80,80,  247/4096, 327/4096, 24/128,104/128},
	[32] =	{80,80,  329/4096, 409/4096, 24/128,104/128},
	[31] =	{80,80,  411/4096, 491/4096, 24/128,104/128},
	[30] =	{80,80,  493/4096, 573/4096, 24/128,104/128},
	[29] =	{80,80,  575/4096, 655/4096, 24/128,104/128},
	[28] =	{80,80,  657/4096, 737/4096, 24/128,104/128},
	[27] =	{80,80,  739/4096, 819/4096, 24/128,104/128},
	[26] =	{80,80,  821/4096, 901/4096, 24/128,104/128},
	[25] =	{80,80,  903/4096, 983/4096, 24/128,104/128},
	[24] =	{80,80,  985/4096,1065/4096, 24/128,104/128},
	[23] =	{80,80, 1067/4096,1147/4096, 24/128,104/128},
	[22] =	{80,80, 1149/4096,1229/4096, 24/128,104/128},
	[21] =	{80,80, 1231/4096,1311/4096, 24/128,104/128},
	[20] =	{80,80, 1313/4096,1393/4096, 24/128,104/128},
	[19] =	{80,80, 1395/4096,1475/4096, 24/128,104/128},
	[18] =	{80,80, 1477/4096,1557/4096, 24/128,104/128},
	[17] =	{80,80, 1559/4096,1639/4096, 24/128,104/128},
	[16] =	{80,80, 1641/4096,1721/4096, 24/128,104/128},
	[15] =	{80,80, 1723/4096,1803/4096, 24/128,104/128},
	[14] =	{80,80, 1805/4096,1885/4096, 24/128,104/128},
	[13] =	{80,80, 1887/4096,1967/4096, 24/128,104/128},
	[12] =	{80,80, 1969/4096,2049/4096, 24/128,104/128},
	[11] =	{80,80, 2051/4096,2131/4096, 24/128,104/128},
	[10] =	{80,80, 2133/4096,2213/4096, 24/128,104/128},
	[9] =	{80,80, 2215/4096,2295/4096, 24/128,104/128},
	[8] =	{80,80, 2297/4096,2377/4096, 24/128,104/128},
	[7] =	{80,80, 2379/4096,2459/4096, 24/128,104/128},
	[6] =	{80,80, 2461/4096,2541/4096, 24/128,104/128},
	[5] =	{80,80, 2543/4096,2623/4096, 24/128,104/128},
	[4] =	{80,80, 2625/4096,2705/4096, 24/128,104/128},
	[3] =	{80,80, 2707/4096,2787/4096, 24/128,104/128},
	[2] =	{80,80, 2789/4096,2869/4096, 24/128,104/128},
	[1] =	{80,80, 2871/4096,2951/4096, 24/128,104/128},
	[0] =	{80,80, 2953/4096,3033/4096, 24/128,104/128},
}


local Ring = {
	["PVP"] = {32, 16, 20},
	["cPower"] = {32*CPOWER_SCALE, 16*CPOWER_SCALE, 21*CPOWER_SCALE},
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
	f.Health: SetSize(248, 46)
	f.Health: SetPoint("BOTTOMLEFT", f, "BOTTOMRIGHT", 14,32)
	
	L.init_Smooth(f.Health)
	
	f.Health.Border_horizontal = L.create_Texture(f.Health, "BACKGROUND", "PlayerHealthBorder", 245,22, 6/256,251/256,5/32,27/32, C.Color.White,0.3, "TOPLEFT", f.Health, "BOTTOMLEFT", -3,7)
	
	f.Health.Border_vertical = f.Health:CreateTexture(nil, "ARTWORK")
	create_Texture(f.Health.Border_vertical, "PlayerHealthBorderRight", 21,46, 6/32,27/32,9/64,55/64, C.Color.Blue,0.75, "BOTTOMLEFT", f.Health, "BOTTOMRIGHT", -2,-3)
	
	for i = 1,10 do
		f.Health[i] = f:CreateTexture(nil, "ARTWORK")
		f.Health[i]: SetTexture(F.Media.."PlayerHealthBlock")
		f.Health[i]: SetSize(HP_Coord[HEATHBAR_WIDE][1],HP_Coord[HEATHBAR_WIDE][2])
		f.Health[i]: SetTexCoord(HP_Coord[HEATHBAR_WIDE][3],HP_Coord[HEATHBAR_WIDE][4], HP_Coord[HEATHBAR_WIDE][5],HP_Coord[HEATHBAR_WIDE][6])
		f.Health[i]: SetVertexColor(unpack(C.Color.White))
		f.Health[i]: SetAlpha(0.9)
		if i == 1 then
			f.Health[i]: SetPoint("BOTTOMLEFT", f.Health, "BOTTOMLEFT", 0,0)
		else
			f.Health[i]: SetPoint("BOTTOMLEFT", f.Health[i-1], "BOTTOMRIGHT", -34+HEATHBAR_WIDE,2*(HEATHBAR_WIDE/25))
		end
		
		f.Health[i].Bg = f:CreateTexture(nil, "BACKGROUND")
		f.Health[i].Bg: SetTexture(F.Media.."PlayerHealthBlock")
		f.Health[i].Bg: SetSize(HP_Coord[HEATHBAR_WIDE][1],HP_Coord[HEATHBAR_WIDE][2])
		f.Health[i].Bg: SetTexCoord(HP_Coord[HEATHBAR_WIDE][3],HP_Coord[HEATHBAR_WIDE][4], HP_Coord[HEATHBAR_WIDE][5],HP_Coord[HEATHBAR_WIDE][6])
		f.Health[i].Bg: SetVertexColor(unpack(C.Color.White))
		f.Health[i].Bg: SetAlpha(0.3)
		f.Health[i].Bg: SetPoint("LEFT", f.Health[i], "LEFT", 0,0)
		
		f.Health[i].Extra = f:CreateTexture(nil, "OVERLAY")
		f.Health[i].Extra: SetTexture(F.Media.."PlayerHealthBarExtra")
		f.Health[i].Extra: SetSize(16,32)
		f.Health[i].Extra: SetVertexColor(unpack(C.Color.Red))
		f.Health[i].Extra: SetAlpha(0)
		f.Health[i].Extra: SetPoint("LEFT", f.Health[i], "LEFT", 0,0)
		f.Health[i].Extra.a = 0
		f.Health[i].Extra.t = 0
	end
end

local create_Portrait = function(f)
	f.Portrait = CreateFrame("Frame", nil, f)
	f.Portrait: SetSize(112, 128)
	f.Portrait: SetPoint("BOTTOM", f, "BOTTOM", 0,0)
	
	f.Portrait.P = CreateFrame("PlayerModel", nil, f.Portrait)
	f.Portrait.P: SetFrameLevel(f.Portrait:GetFrameLevel()-1)
	f.Portrait.P: SetSize(108, 200)--82，68 --108,200
	f.Portrait.P: SetPoint("BOTTOM", f.Portrait, "BOTTOM", 0, 28)
	f.Portrait.P: SetAlpha(1)
	f.Portrait.P: SetUnit(f.unit)
	f.Portrait.P.guid = UnitGUID(f.unit)
	
	f.Portrait.help = CreateFrame("Frame", nil, f.Portrait)
	f.Portrait.help: SetFrameLevel(f.Portrait:GetFrameLevel()-2)
	
	f.Portrait.Border_Low = f.Portrait:CreateTexture(nil, "ARTWORK")
	create_Texture(f.Portrait.Border_Low, "PlayerPortraitBorderLow", 128,128, 0,1, 0,1, C.Color.Blue, 0.9, "BOTTOM",f.Portrait,"BOTTOM",0,0)
	
	f.Portrait.Border_Up = f.Portrait.help:CreateTexture(nil, "ARTWORK")
	create_Texture(f.Portrait.Border_Up, "PlayerPortraitBorderUp", 128,128, 0,1, 0,1, C.Color.Blue, 0.9, "BOTTOM",f.Portrait.Border_Low,"BOTTOM",0,0)
	
	f.Portrait.Border_Bottom = f.Portrait:CreateTexture(nil, "ARTWORK")
	create_Texture(f.Portrait.Border_Bottom, "PlayerPortraitBorderBottom", 128,64, 0,1, 0,1, C.Color.White, 0, "BOTTOM",f.Portrait.Border_Low,"BOTTOM",0,-28)
	
	f.Portrait.Border_Center = f.Portrait:CreateTexture(nil, "ARTWORK")
	create_Texture(f.Portrait.Border_Center, "PlayerPortraitBorderCenter", 128,64, 0,1, 0,1, C.Color.White, 0.9, "BOTTOM",f.Portrait.Border_Low,"BOTTOM",0,-2)
	
	f.Portrait.Border_Background = f.Portrait.help:CreateTexture(nil, "BACKGROUND")
	create_Texture(f.Portrait.Border_Background, "PlayerPortraitBorderBackground", 128,128, 0,1, 0,1, C.Color.White, 0.9, "BOTTOM",f.Portrait.Border_Low,"BOTTOM",0,0)
	
	f.Portrait.P: RegisterEvent("PLAYER_ENTERING_WORLD")
	f.Portrait.P: RegisterEvent("UNIT_MODEL_CHANGED")
	f.Portrait.P: RegisterEvent("UNIT_PORTRAIT_UPDATE")
	f.Portrait.P: SetScript("OnEvent", function(self,event)
		f.Portrait.P: ClearModel()
		f.Portrait.P: SetUnit(f.unit)
		f.Portrait.P.guid = UnitGUID(f.unit)
		local race, raceEn = UnitRace(f.unit)
		f.Portrait.P: SetCamDistanceScale(1)
		local s = UIParent:GetScale()
		f.Portrait.P: SetModelScale(0.66/(OwD_DB["OwD_Scale"]*s)) 
		f.Portrait.P: SetPortraitZoom(0.6)
		f.Portrait.P: SetPosition(0,0,-0.25)
		--f.Portrait.P: SetRotation(rad(20))
		f.Portrait.P: SetRotation(rad(30))
		--[[	
		if raceEn == "Human" then

			
			--f.Portrait.P: SetRotation(rad(25))
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
	--]]
	end)
	
	-->>PVP Flag
	f.Portrait.PVP = CreateFrame("Frame", nil, f.Portrait)
	f.Portrait.PVP: SetFrameLevel(f.Portrait:GetFrameLevel()+1)
	f.Portrait.PVP: SetSize(64, 64)
	f.Portrait.PVP: SetPoint("BOTTOM",f.Portrait,"BOTTOM",-2,-16)
	
	f.Portrait.PVP.Bg = f.Portrait.PVP:CreateTexture(nil, "BACKGROUND")
	create_Texture(f.Portrait.PVP.Bg, "PlayerPortraitPVPBg", 64,64, 0,1, 0,1, C.Color.Black, 0.75, "BOTTOM",f.Portrait.PVP,"BOTTOM",0,0)
	f.Portrait.PVP.Gloss = f.Portrait.PVP:CreateTexture(nil, "BACKGROUND")
	create_Texture(f.Portrait.PVP.Gloss, "PlayerPortraitPVPGloss", 64,64, 0,1, 0,1, C.Color.Black, 0.5, "BOTTOM",f.Portrait.PVP,"BOTTOM",0,0)
	f.Portrait.PVP.Icon = f.Portrait.PVP:CreateTexture(nil, "ARTWORK")
	create_Texture(f.Portrait.PVP.Icon, "PlayerPortraitPVPAlliance", 64,64, 0,1, 0,1, C.Color.White, 0.9, "BOTTOM",f.Portrait.PVP,"BOTTOM",0,0)
	
	f.Portrait.PVP.Direction = 1
	
	L.create_Ring(f.Portrait.PVP, Ring["PVP"], "PlayerPortraitPVPRing", "slicer0", "slicer1", C.Color.Blue, 0.9)
	f.Portrait.PVP[1] = L.create_Texture(f.Portrait.PVP, "OVERLAY", "PlayerPortraitPVPRing", 32,32, 0,1,0,1, C.Color.Blue,0.9, "BOTTOMLEFT",f.Portrait.PVP,"CENTER",0,0)
	f.Portrait.PVP[2] = L.create_Texture(f.Portrait.PVP, "OVERLAY", "PlayerPortraitPVPRing", 32,32, 0,1,1,0, C.Color.Blue,0.9, "TOPLEFT",f.Portrait.PVP,"CENTER",0,0)
	f.Portrait.PVP[3] = L.create_Texture(f.Portrait.PVP, "OVERLAY", "PlayerPortraitPVPRing", 32,32, 1,0,1,0, C.Color.Blue,0.9, "TOPRIGHT",f.Portrait.PVP,"CENTER",0,0)
	
	--
	f.Portrait.PVP: RegisterEvent("PLAYER_ENTERING_WORLD")
	f.Portrait.PVP: RegisterEvent("UNIT_FACTION")
	f.Portrait.PVP: SetScript("OnEvent", function(self,event)
		local factionGroup = UnitFactionGroup("player")
		if factionGroup == "Alliance" then
			f.Portrait.PVP.Icon: SetTexture(F.Media.."PlayerPortraitPVPAlliance")
		elseif factionGroup == "Horde" then
			f.Portrait.PVP.Icon: SetTexture(F.Media.."PlayerPortraitPVPHorde")
		else
			f.Portrait.PVP.Icon: SetTexture()
		end
		if UnitIsPVP("player") then
			--f.Portrait.PVP.Icon: SetVertexColor(unpack(C.Color.Blue))
			f.Portrait.PVP:SetAlpha(1)
			f.Portrait.PVP: SetScript("OnUpdate", function(self, elapsed)
				local sec = GetPVPTimer()/1000
				if sec < 300 and sec >=0 then
					local d = sec*1.2
					if d < 90 then
						self.Interval = 1
						F.Ring_Update(f.Portrait.PVP, d)
						if f.Portrait.PVP[1] then f.Portrait.PVP[1]: Hide() end
						if f.Portrait.PVP[2] then f.Portrait.PVP[2]: Hide() end
						if f.Portrait.PVP[3] then f.Portrait.PVP[3]: Hide() end
					elseif d >= 90 and d < 180 then
						self.Interval = 4
						F.Ring_Update(f.Portrait.PVP, (d - 90))
						if f.Portrait.PVP[1] then f.Portrait.PVP[1]: Show() end
						if f.Portrait.PVP[2] then f.Portrait.PVP[2]: Hide() end
						if f.Portrait.PVP[3] then f.Portrait.PVP[3]: Hide() end
					elseif d >= 180 and d < 270 then
						self.Interval = 3
						F.Ring_Update(f.Portrait.PVP, (d - 180))
						if f.Portrait.PVP[1] then f.Portrait.PVP[1]: Show() end
						if f.Portrait.PVP[2] then f.Portrait.PVP[2]: Show() end
						if f.Portrait.PVP[3] then f.Portrait.PVP[3]: Hide() end
					elseif d >= 270 then
						self.Interval = 2
						F.Ring_Update(f.Portrait.PVP, (d - 270))
						if f.Portrait.PVP[1] then f.Portrait.PVP[1]: Show() end
						if f.Portrait.PVP[2] then f.Portrait.PVP[2]: Show() end
						if f.Portrait.PVP[3] then f.Portrait.PVP[3]: Show() end
					end
				else
					self.Interval = 2
					F.Ring_Update(f.Portrait.PVP, 90)
					if f.Portrait.PVP[1] then f.Portrait.PVP[1]: Show() end
					if f.Portrait.PVP[2] then f.Portrait.PVP[2]: Show() end
					if f.Portrait.PVP[3] then f.Portrait.PVP[3]: Show() end
				end
			end)
		else
			--f.Portrait.PVP.Icon: SetVertexColor(unpack(C.Color.White))
			f.Portrait.PVP:SetAlpha(0)
			f.Portrait.PVP: SetScript("OnUpdate", function(self) return end)
			--self.Interval = 1
			--F.Ring_Update(f.Portrait.PVP, 90)
			--if f.Portrait.PVP[1] then f.Portrait.PVP[1]: Show() end
			--if f.Portrait.PVP[2] then f.Portrait.PVP[2]: Show() end
			--if f.Portrait.PVP[3] then f.Portrait.PVP[3]: Show() end
		end
	end)
end

local create_Num = function(f)
	f.Num = CreateFrame("Frame", nil, f)
	for i = 1,11 do
		f.Num[i] =  f.Num:CreateTexture(nil, "ARTWORK")
		f.Num[i]: SetVertexColor(unpack(C.Color.White))
		f.Num[i]: SetAlpha(0.9)
		if i < 6 then
			f.Num[i]: SetTexture(F.Media.."NumLeft30")
			f.Num[i]: SetSize(Num_Left_30[0][1], Num_Left_30[0][2])
			f.Num[i]: SetTexCoord(Num_Left_30[0][3],Num_Left_30[0][4], Num_Left_30[0][5],Num_Left_30[0][6])
		elseif i == 6 then
			f.Num[i]: SetTexture(F.Media.."NumLeft20")
			f.Num[i]: SetSize(Num_Left_20["/"][1], Num_Left_20["/"][2])
			f.Num[i]: SetTexCoord(Num_Left_20["/"][3],Num_Left_20["/"][4], Num_Left_20["/"][5],Num_Left_20["/"][6])
			f.Num[i]: SetVertexColor(unpack(C.Color.Blue))
		elseif i > 6 then
			f.Num[i]: SetTexture(F.Media.."NumLeft20")
			f.Num[i]: SetSize(Num_Left_20[0][1], Num_Left_20[0][2])
			f.Num[i]: SetTexCoord(Num_Left_20[0][3],Num_Left_20[0][4], Num_Left_20[0][5],Num_Left_20[0][6])
		end
		if i == 1 then
			f.Num[i]: SetPoint("TOPLEFT", f.Health, "TOPLEFT", 6,22)
		elseif i < 6 then
			f.Num[i]: SetPoint("BOTTOMLEFT", f.Num[i-1], "TOPRIGHT", -12,-39+0.8)
		elseif i == 6 then
			f.Num[i]: SetPoint("BOTTOMLEFT", f.Num[i-1], "BOTTOMRIGHT", -10,0)
		elseif i == 7 then
			f.Num[i]: SetPoint("BOTTOMLEFT", f.Num[i-1], "BOTTOMRIGHT", -11,0)
		else
			f.Num[i]: SetPoint("BOTTOMLEFT", f.Num[i-1], "TOPRIGHT", -11,-31+0.7)
		end
	end
end

local create_Threat = function(f)
	f.Threat = CreateFrame("Frame", nil, f)
	f.Threat: SetSize(245,22)
	f.Threat: SetPoint("TOPLEFT", f.Health, "BOTTOMLEFT", -3,7)
	
	f.Threat.Bar = L.create_Texture(f.Threat, "ARTWORK", "PlayerHealthBorder", 245,22, 6/256,251/256,5/32,27/32, C.Color.White,0.9, "TOPLEFT", f.Health, "BOTTOMLEFT", -3,7)
	
	f.Threat: RegisterEvent("PLAYER_ENTERING_WORLD")
	f.Threat: RegisterEvent("PLAYER_TARGET_CHANGED")
	f.Threat: RegisterEvent("UNIT_THREAT_SITUATION_UPDATE")
	f.Threat: RegisterEvent("UNIT_THREAT_LIST_UPDATE")
	f.Threat: SetScript("OnEvent", function(self,event)
		if UnitExists("target") and UnitAffectingCombat("player") then
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
		
		f.Threat.Bar: SetSize(245*d, 22)
		f.Threat.Bar: SetTexCoord(6/256,(6+245*d+F.Debug)/256,5/32,27/32)
		
		if status == 0 then
			f.Threat.Bar: SetVertexColor(unpack(C.Color.White))
		elseif status == 1 then
			f.Threat.Bar: SetVertexColor(unpack(C.Color.Yellow))
		else
			f.Threat.Bar: SetVertexColor(unpack(C.Color.Red))
		end
	end)
end

--- ----------------------------------------------------------------------------
--> Player Frame             
--- ----------------------------------------------------------------------------

L.Player_Frame = function(f)
	f.Player = CreateFrame("Frame", nil, f)
	f.Player: SetSize(112, 128)
	f.Player: SetClampedToScreen(true)
	--f.Player: SetPoint("BOTTOMLEFT", f, "CENTER", -580, -320)
	--f.Player: SetPoint("BOTTOMLEFT", f, "CENTER", OwD_DB.Pos.Player.x, OwD_DB.Pos.Player.y)
	f.Player.unit = "player"
	f.Player: SetAlpha(0.95)
	
	create_Health(f.Player)
	--create_Power(f.Player)
	create_Portrait(f.Player)
	create_Num(f.Player)
	create_Threat(f.Player)
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
	
	local h,h1,h2,h3,h4,h5
	h = maxHealth
	
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
	
	if self.Num then
		self.Num[7]: SetSize(Num_Left_20[h1][1], Num_Left_20[h1][2])
		self.Num[7]: SetTexCoord(Num_Left_20[h1][3],Num_Left_20[h1][4], Num_Left_20[h1][5],Num_Left_20[h1][6])
		self.Num[8]: SetSize(Num_Left_20[h2][1], Num_Left_20[h2][2])
		self.Num[8]: SetTexCoord(Num_Left_20[h2][3],Num_Left_20[h2][4], Num_Left_20[h2][5],Num_Left_20[h2][6])
		self.Num[9]: SetSize(Num_Left_20[h3][1], Num_Left_20[h3][2])
		self.Num[9]: SetTexCoord(Num_Left_20[h3][3],Num_Left_20[h3][4], Num_Left_20[h3][5],Num_Left_20[h3][6])
		self.Num[10]: SetSize(Num_Left_20[h4][1], Num_Left_20[h4][2])
		self.Num[10]: SetTexCoord(Num_Left_20[h4][3],Num_Left_20[h4][4], Num_Left_20[h4][5],Num_Left_20[h4][6])
		self.Num[11]: SetSize(Num_Left_20[h5][1], Num_Left_20[h5][2])
		self.Num[11]: SetTexCoord(Num_Left_20[h5][3],Num_Left_20[h5][4], Num_Left_20[h5][5],Num_Left_20[h5][6])
	end
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
		--update_Power(f, f.unit)
		f.Portrait.P: SetUnit(f.unit)
		f.Portrait.P.guid = UnitGUID(f.unit)
	end
	
	if event == "UNIT_HEALTH_FREQUENT" or event == "UNIT_MAXHEALTH" then
		update_Health(f, f.unit)
	end
	
	if event == "UNIT_POWER_FREQUENT" or event == "UNIT_MAXPOWER" then
		--update_Power(f, f.unit)
	end
end

L.OnUpdate_Player = function(f, elapsed)
	local step = floor(1/(GetFramerate())*1e3)/1e3
	local d1,d2, d3,d4
	
	d1 = f.Health.Cur*10 or 0
	for i = 1,10 do
		if d1 >= i then
			f.Health[i]: SetTexCoord(HP_Coord[HEATHBAR_WIDE][3],HP_Coord[HEATHBAR_WIDE][4], HP_Coord[HEATHBAR_WIDE][5],HP_Coord[HEATHBAR_WIDE][6])
			f.Health[i]: Show()
			
			f.Health[i].Extra.a = 0
			f.Health[i].Extra:SetAlpha(0)
			f.Health[i].Extra:SetSize(16,32)
			f.Health[i].Extra.t = 0
		elseif d1 < i and (d1+1) >= i then
			d2 = floor((d1 + 1 - i) * HEATHBAR_WIDE + 0.5)
			f.Health[i]: SetTexCoord(HP_Coord[d2][3],HP_Coord[d2][4], HP_Coord[d2][5],HP_Coord[d2][6])
			f.Health[i]: Show()
			
			f.Health[i].Extra.a = 0
			f.Health[i].Extra:SetAlpha(0)
			f.Health[i].Extra:SetSize(16,32)
			f.Health[i].Extra.t = 0
		else
			if f.Health[i]:IsShown() then
				if f.Health[i].Extra.a < 1 then
					f.Health[i].Extra.a = min(f.Health[i].Extra.a + 6*step, 1)
					f.Health[i].Extra: SetAlpha(0.8)
					f.Health[i].Extra: SetSize(16+16*4*f.Health[i].Extra.a, 32+32*4*f.Health[i].Extra.a)
				else
					--if f.Health[i].Extra.t < 0.2 then
						--f.Health[i].Extra.t = f.Health[i].Extra.t + step
					--else
						f.Health[i]:Hide()
						f.Health[i].Extra.a = 0
						f.Health[i].Extra.t = 0
					--end
				end
			else
				f.Health[i].Extra.a = 0
				f.Health[i].Extra:SetAlpha(0)
				f.Health[i].Extra:SetSize(16,32)
				f.Health[i].Extra.t = 0
			end
		end
	end
	
	local h,hm,h1,h2,h3,h4,h5,h7,h8,h9,h10,h11, p,p1,p2,p3,p4,p5,p6
	h = f.Health.Cur * f.Health.Max
	hm = f.Health.Max
	--p = f.Power.Cur * f.Power.Max
	
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
	
	f.Num[1]: SetSize(Num_Left_30[h1][1], Num_Left_30[h1][2])
	f.Num[1]: SetTexCoord(Num_Left_30[h1][3],Num_Left_30[h1][4], Num_Left_30[h1][5],Num_Left_30[h1][6])
	f.Num[2]: SetSize(Num_Left_30[h2][1], Num_Left_30[h2][2])
	f.Num[2]: SetTexCoord(Num_Left_30[h2][3],Num_Left_30[h2][4], Num_Left_30[h2][5],Num_Left_30[h2][6])
	f.Num[3]: SetSize(Num_Left_30[h3][1], Num_Left_30[h3][2])
	f.Num[3]: SetTexCoord(Num_Left_30[h3][3],Num_Left_30[h3][4], Num_Left_30[h3][5],Num_Left_30[h3][6])
	f.Num[4]: SetSize(Num_Left_30[h4][1], Num_Left_30[h4][2])
	f.Num[4]: SetTexCoord(Num_Left_30[h4][3],Num_Left_30[h4][4], Num_Left_30[h4][5],Num_Left_30[h4][6])
	f.Num[5]: SetSize(Num_Left_30[h5][1], Num_Left_30[h5][2])
	f.Num[5]: SetTexCoord(Num_Left_30[h5][3],Num_Left_30[h5][4], Num_Left_30[h5][5],Num_Left_30[h5][6])
	
	if f.Portrait.Border_Background then
		if UnitAffectingCombat("player") then
			f.Portrait.Border_Background: SetVertexColor(unpack(C.Color.Red))
			f.Portrait.Border_Background: SetAlpha(0.2 + 0.4 * F.Alpha)
		elseif IsResting() then
			f.Portrait.Border_Background: SetVertexColor(253/255, 218/255, 4/255)
			f.Portrait.Border_Background: SetAlpha(0.2 + 0.4 * F.Alpha)
		else
			f.Portrait.Border_Background: SetVertexColor(unpack(C.Color.White))
			f.Portrait.Border_Background: SetAlpha(0.2)
		end
	end
end

--- ----------------------------------------------------------------------------
--> FCS
--- ----------------------------------------------------------------------------

local update_Aura = function(unit,id,filter)
	local auraname = GetSpellInfo(id)
	local name, rank, icon, count, dispelType, duration, expires, caster = UnitAura(unit, auraname, nil, filter)
	count = count or 0
	if caster and caster == "player" then
        return count, expires, duration
    else
		return 0,0,0 
	end
end



local create_FCS_Power = function(f)
	--> Power Bar
	f.Power = CreateFrame("Frame", nil, f)
	f.Power: SetSize(80, 80)
	f.Power: SetPoint("CENTER", f, "CENTER", 0,0)
	f.Power: SetAlpha(1)
	
	L.init_Smooth(f.Power)
	
	f.Power.Bar = L.create_Texture(f.Power, "ARTWORK", "FCSPowerBlock", PP_Coord[36][1],PP_Coord[36][2], PP_Coord[36][3],PP_Coord[36][4],PP_Coord[36][5],PP_Coord[36][6], C.Color.Orange, 1, "CENTER",f.Power,"CENTER", 0,0)
	f.Power.BarBg = L.create_Texture(f.Power, "BACKGROUND", "FCSPowerBlock", PP_Coord[36][1],PP_Coord[36][2], PP_Coord[36][3],PP_Coord[36][4],PP_Coord[36][5],PP_Coord[36][6], C.Color.White2, 0.6, "CENTER",f.Power,"CENTER", 0,0)
	
	f.Power.Border = L.create_Texture(f.Power, "ARTWORK", "FCSPowerBorder", 64,64, 0,1,0,1, C.Color.Orange, 0.5, "CENTER",f.Power,"CENTER", 0,0)
	f.Power.Back = L.create_Texture(f.Power, "BACKGROUND", "FCSPowerBack", 64,64, 0,1,0,1, C.Color.Black, 0.2, "CENTER",f.Power,"CENTER", 0,0)
	f.Power.B0 = L.create_Texture(f.Power, "BORDER", "FCSCasterBorder", 128,128, 0,1,0,1, C.Color.White,0.2, "CENTER",f.Power,"CENTER",0,0)
	
	--> Number
	f.PowerNum = {}
	f.PowerNum.Help = CreateFrame("Frame", nil, f.Power)
	f.PowerNum.Help: SetPoint("CENTER", f, "CENTER", 0,0)
	
	for i = 1,6 do
		f.PowerNum[i] = f.Power:CreateTexture(nil, "ARTWORK")
		f.PowerNum[i]: SetTexture(F.Media.."NumCenter24")
		f.PowerNum[i]: SetVertexColor(unpack(C.Color.White))
		f.PowerNum[i]: SetAlpha(0.9)
		f.PowerNum[i]: SetSize(Num_Center_24[0][1], Num_Center_24[0][2])
		f.PowerNum[i]: SetTexCoord(Num_Center_24[0][3],Num_Center_24[0][4], Num_Center_24[0][5],Num_Center_24[0][6])
		if i == 1 then
			f.PowerNum[i]: SetPoint("LEFT", f.PowerNum.Help, "LEFT", 0,0)
		elseif i == 5 then
			f.PowerNum[i]: SetPoint("BOTTOMLEFT", f, "TOPRIGHT", 20,10)
		else
			f.PowerNum[i]: SetPoint("LEFT", f.PowerNum[i-1], "RIGHT", -10,0)
		end
	end
	
	f.PowerNum[4]: SetSize(Num_Center_24["%"][1], Num_Center_24["%"][2])
	f.PowerNum[4]: SetTexCoord(Num_Center_24["%"][3],Num_Center_24["%"][4], Num_Center_24["%"][5],Num_Center_24["%"][6])
	f.PowerNum[4]: SetVertexColor(unpack(C.Color.Orange))
	
	f.PowerNum[5]: Hide()
	f.PowerNum[6]: Hide()
end

local color_Ring = function(f, color)
	f.t0: SetVertexColor(unpack(color))
	f.t1: SetVertexColor(unpack(color))
	f.t2: SetVertexColor(unpack(color))
	f.R1: SetVertexColor(unpack(color))
	f.R2: SetVertexColor(unpack(color))
	f.R3: SetVertexColor(unpack(color))
end

-->> Rune
--[[
local runeColor = {
		[1]	= { 0.8, 0.1, 0.0 },	-- blood
		[2]	= { 0.3, 0.6, 0.0 },	-- unholy
		[3]	= { 0.0, 0.4, 0.6 },	-- frost
		[4]	= { 0.6, 0.0, 0.7 },	-- death
}

local runeColor = {
		[1]	= { 223/255, 111/255,  55/255 },	-- blood
		[2]	= { 133/255, 199/255,  55/255 },	-- unholy
		[3]	= {  55/255, 133/255, 211/255 },	-- frost
		[4]	= { 199/255,  50/255, 233/255 },	-- death
}

local undate_Rune = function(f)
	if f then
		for i = 1,6 do
			f[i].start, f[i].duration, f[i].runeReady = GetRuneCooldown(i)
			f[i].start = f[i].start or 0
			f[i].timer = GetTime() - f[i].start
			f[i].runeType = GetRuneType(i)
		end
	end
end

local function sort_Rune(f,a,b)
	if not ((a.runeType > 0) and (b.runeType > 0)) then return end
	if b.runeReady then
		update_Ring(f, a.timer/a.duration)
		color_Ring(f, runeColor[a.runeType])
		f.B3: SetAlpha(0.9)
		f.B3: SetVertexColor(unpack(runeColor[b.runeType]))
	elseif a.runeReady then
		update_Ring(f, b.timer/b.duration)
		color_Ring(f, runeColor[b.runeType])
		f.B3: SetAlpha(0.9)
		f.B3: SetVertexColor(unpack(runeColor[a.runeType]))
	elseif a.timer >= 0 then
		update_Ring(f, a.timer/a.duration)
		color_Ring(f, runeColor[a.runeType])
		f.B3: SetAlpha(0.2)
		f.B3: SetVertexColor(unpack(runeColor[b.runeType]))
	elseif b.timer >= 0 then
		update_Ring(f, b.timer/b.duration)
		color_Ring(f, runeColor[b.runeType])
		f.B3: SetAlpha(0.2)
		f.B3: SetVertexColor(unpack(runeColor[a.runeType]))
	end
end
--]]

local update_Point_Num = function(f)
	if f.p and f.p > 0 then
		if f.p == f.pMax then
			f.Num: SetVertexColor(unpack(C.Color.Black))
			f.B3: SetAlpha(0.8)
		else
			f.Num: SetVertexColor(unpack(C.Color.White))
			f.B3: SetAlpha(0)
		end
		f.p = f.p-floor(f.p/10)*10
		f.Num: SetSize(L.Num_Center_24[f.p][1]*CPOWER_SCALE,L.Num_Center_24[f.p][2]*CPOWER_SCALE)
		f.Num: SetTexCoord(L.Num_Center_24[f.p][3],L.Num_Center_24[f.p][4], L.Num_Center_24[f.p][5],L.Num_Center_24[f.p][6])
	else
		f.Num: SetSize(L.Num_Center_24[0][1]*CPOWER_SCALE,L.Num_Center_24[0][2]*CPOWER_SCALE)
		f.Num: SetTexCoord(L.Num_Center_24[0][3],L.Num_Center_24[0][4], L.Num_Center_24[0][5],L.Num_Center_24[0][6])
		f.Num: SetVertexColor(unpack(C.Color.White))
		f.B3: SetAlpha(0)
	end
end

local update_Point_Ring = function(f, d)
	if not d then d = 1 end
	d = min(max(d, 0), 1)
	if d < 0.5 then
		f.LR.Ring:SetRotation(math.rad(f.LR.Base+0))
		f.RR.Ring:SetRotation(math.rad(f.RR.Base-180*d*2))
	else
		f.LR.Ring:SetRotation(math.rad(f.LR.Base-180*(d*2-1)))
		f.RR.Ring:SetRotation(math.rad(f.RR.Base+180))
	end
end

local Ring_Artwork = function(f, size)
	f.C = CreateFrame("Frame", nil, f)
	f.C: SetSize(size, size)
	f: SetScrollChild(f.C)
	
	f.Ring = f.C:CreateTexture(nil, "BACKGROUND", nil, -2)
	f.Ring: SetTexture(F.Media.."FCSPointRing")
	f.Ring: SetSize(sqrt(2)*size, sqrt(2)*size)
    f.Ring: SetPoint("CENTER")
    f.Ring: SetVertexColor(unpack(C.Color.White))
	f.Ring: SetAlpha(0.9)
	f.Ring: SetBlendMode("BLEND")
	f.Ring: SetRotation(math.rad(f.Base+180))
end

local Create_Ring = function(f, size)
	if f.LR then return end
	
	f.LR = CreateFrame("ScrollFrame", nil, f)
	f.LR: SetFrameLevel(f:GetFrameLevel()+1)
	f.LR: SetSize(size/2, size)
	f.LR: SetPoint("LEFT", f, "LEFT", 0,0)
	f.LR.Base = -180
	Ring_Artwork(f.LR, size)
	
	f.RR = CreateFrame("ScrollFrame", nil, f)
	f.RR: SetFrameLevel(f:GetFrameLevel()+1)
	f.RR: SetSize((size)/2, size)
	f.RR: SetPoint("RIGHT", f, "RIGHT", 0,0)
	f.RR: SetHorizontalScroll(size/2)
	f.RR.Base = 0
	Ring_Artwork(f.RR, size)
end

local create_Point = function(f)
	f.Point = CreateFrame("Frame", nil, f)
	f.Point: SetSize(64*CPOWER_SCALE,64*CPOWER_SCALE)
	f.Point: SetPoint("CENTER", f, "CENTER", 0,70+16*CPOWER_SCALE)
	
	f.Point.B0 = L.create_Texture(f.Point, "BACKGROUND", "FCSPointB0", 256,256, 0,1,0,1, C.Color.White, 0.2, "CENTER",f,"CENTER",0,0)
	f.Point.B1 = L.create_Texture(f.Point, "BACKGROUND", "FCSPointB1", 64*CPOWER_SCALE,64*CPOWER_SCALE, 0,1,0,1, C.Color.Black, 0.2, "CENTER", f.Point, "CENTER", 0,0)
	f.Point.B2 = L.create_Texture(f.Point, "BORDER", "FCSPointB2", 64*CPOWER_SCALE,64*CPOWER_SCALE, 0,1,0,1, C.Color.White, 0.2, "CENTER", f.Point, "CENTER", 0,0)
	f.Point.B3 = L.create_Texture(f.Point, "ARTWORK", "FCSPointB3", 64*CPOWER_SCALE,64*CPOWER_SCALE, 0,1,0,1, C.Color.White, 0.8, "CENTER", f.Point, "CENTER", 0,0)
	f.Point.Num = L.create_Texture(f.Point, "OVERLAY", "NumCenter24", L.Num_Center_24[0][1]*CPOWER_SCALE,L.Num_Center_24[0][2]*CPOWER_SCALE, L.Num_Center_24[0][3],L.Num_Center_24[0][4],L.Num_Center_24[0][5],L.Num_Center_24[0][6], C.Color.White, 1, "CENTER", f.Point, "CENTER", -0.5,0.5)
		
	Create_Ring(f.Point, 64*CPOWER_SCALE)
	
	local event = {
		"PLAYER_ENTERING_WORLD",
		
		"PLAYER_SPECIALIZATION_CHANGED",
		"PLAYER_TALENT_UPDATE",
		
		"UNIT_ENTERED_VEHICLE",
		"UNIT_EXITED_VEHICLE",
		
		"PLAYER_REGEN_DISABLED",
		"PLAYER_REGEN_ENABLED",
		
		"PLAYER_TARGET_CHANGED",
		"UNIT_POWER_FREQUENT"
	}
	F.rEvent(f.Point, event)
	f.Point: SetScript("OnEvent", function(self,event)
		f.Point.class = select(2, UnitClass("player"))
		f.Point.specID = GetSpecialization()
		f.Point.form = GetShapeshiftFormID()
		f.Point.pMax = 0
		f.Point.p = nil
		f.Point.Remain = 0
		f.Point.Duration = 0
		f.Point.Start = 0
		f.Point.Expires = 0
		f.Point.Per = 0
		if UnitInVehicle("player") then
			f.Point.p = GetComboPoints("vehicle", "target")
			f.Point.pMax = MAX_COMBO_POINTS
			update_Point_Ring(f.Point, 1)
		else
			if f.Point.class == 'WARLOCK' then
				if event == "PLAYER_ENTERING_WORLD" then
					self: RegisterEvent("SPELLS_CHANGED")
					self: RegisterUnitEvent("UNIT_MAXPOWER", "player")
				end
				f.Point.p = UnitPower("player", SPELL_POWER_SOUL_SHARDS)
				f.Point.pMax = UnitPowerMax("player", SPELL_POWER_SOUL_SHARDS)
				update_Point_Ring(f.Point, 1)
			elseif f.Point.class == 'MONK' then
				if event == "PLAYER_ENTERING_WORLD" then
					self: RegisterEvent("SPELLS_CHANGED")
					self: RegisterUnitEvent("UNIT_MAXPOWER", "player")
				end
				if f.Point.specID == 3 then -->Windwalker
					f.Point.p = UnitPower("player", SPELL_POWER_CHI)
					f.Point.pMax = UnitPowerMax("player", SPELL_POWER_CHI)
					update_Point_Ring(f.Point, 1)
				end
			elseif f.Point.class == 'DRUID' then
				if event == "PLAYER_ENTERING_WORLD" then
					self: RegisterEvent("UPDATE_SHAPESHIFT_FORM")
				end
				if f.Point.form == CAT_FORM then
					f.Point.p = GetComboPoints("player", "target")
					f.Point.pMax = MAX_COMBO_POINTS
					update_Point_Ring(f.Point, 1)
				else
					
				end
			elseif f.Point.class == 'DEATHKNIGHT' then
				if event == "PLAYER_ENTERING_WORLD" then
					self:RegisterEvent("RUNE_POWER_UPDATE")
					self:RegisterEvent("RUNE_TYPE_UPDATE")
					f.Point.r = {}
					for i = 1,6 do
						f.Point.r[i] = {start = 0, timer = 0, duration = 0, runeReady = 0}
					end
				end
				local rune = 0
				for i = 1,6 do
					start, duration, runeReady = GetRuneCooldown(i)
					if runeReady then
						rune = rune + 1
					end
					if f.Point.r then
						f.Point.r[i].start = start or 0
						f.Point.r[i].duration = duration
						f.Point.r[i].runeReady = runeReady
						if runeReady then
							f.Point.r[i].timer = 0
						else
							f.Point.r[i].timer = GetTime() - f.Point.r[i].start
						end
					end
				end
				f.Point.p = rune
				f.Point.pMax = 6
				update_Point_Ring(f.Point, 1)
			elseif f.Point.class == 'PALADIN'then
				if event == "PLAYER_ENTERING_WORLD" then
					self: RegisterEvent("SPELLS_CHANGED")
					self: RegisterUnitEvent("UNIT_MAXPOWER", "player")
				end
				if f.Point.specID == 3 then -->惩戒
					f.Point.p = UnitPower("player", SPELL_POWER_HOLY_POWER)
					f.Point.pMax = UnitPowerMax("player", SPELL_POWER_HOLY_POWER)
					update_Point_Ring(f.Point, 1)
				end
			elseif f.Point.class == 'ROGUE' then
				if event == "PLAYER_ENTERING_WORLD" then
					self: RegisterEvent("SPELLS_CHANGED")
					self: RegisterUnitEvent("UNIT_MAXPOWER", "player")
				end
				f.Point.p =  GetComboPoints("player", "target")
				f.Point.pMax = MAX_COMBO_POINTS
				update_Point_Ring(f.Point, 1)
			elseif f.Point.class == 'MAGE' then
				if f.Point.specID == 1 then -->奥术
					f.Point.p = UnitPower("player", SPELL_POWER_ARCANE_CHARGES)
					f.Point.pMax = UnitPowerMax("player", SPELL_POWER_ARCANE_CHARGES)
					update_Point_Ring(f.Point, 1)
				end
			end
		end
		
		if f.Point.p and f.Point.p >= 0 then
			f.Point.p = min(f.Point.p, 9)
			update_Point_Num(f.Point)
			
			if f.Point.class == 'WARLOCK' then
				if UnitAffectingCombat("player") or f.Point.p ~= 1 then
					f.Point: Show()
				else
					f.Point: Hide()
				end
			elseif f.Point.class == 'DEATHKNIGHT' then
				if UnitAffectingCombat("player") or f.Point.p ~= f.Point.pMax then
					f.Point: Show()
				else
					f.Point: Hide()
				end
			else
				if f.Point.p > 0 then
					f.Point: Show()
				else
					f.Point: Hide()
				end
			end
		else
			f.Point: Hide()
		end
	end)
	
	f.Point: SetScript("OnUpdate", function(self, elapsed)
		if f.Point.class == 'DEATHKNIGHT' then
			if self.r then
				local k,v = 1,0
				for i = 1,6 do
					if self.r[i].runeReady then
						self.r[i].timer = 0
					else
						self.r[i].timer = min(self.r[i].timer + elapsed, self.r[i].duration)
					end
					if v < self.r[i].timer then
						v = self.r[i].timer
						k = i
					end
				end
				if v == 0 then
					update_Point_Ring(self, 1)
				else
					update_Point_Ring(self, v/self.r[k].duration)
				end
			end
		end
	end)
	
	--[[
	f.Point = {}
	f.Point.Help = CreateFrame("Frame", nil, f)
	f.Point.B0 = L.create_Texture(f.Point.Help, "BACKGROUND", "FCSPointB0", 256,256, 0,1,0,1, C.Color.White, 0.2, "CENTER",f,"CENTER",0,0)
	f.Point.B0: Hide()
	for i = 1,5 do
		f.Point[i] = CreateFrame("Frame", nil, f.Point.Help)
		f.Point[i]: SetSize(64*CPOWER_SCALE,64*CPOWER_SCALE)
		L.create_Ring(f.Point[i], Ring["cPower"], "FCSPointRing", "slicer0", "slicer1", C.Color.White, 0.8)
		f.Point[i].Direction = 1
		f.Point[i]: Hide()
		
		f.Point[i].B2 = L.create_Texture(f.Point[i], "BORDER", "FCSPointB2", 64*CPOWER_SCALE,64*CPOWER_SCALE, 0,1,0,1, C.Color.White, 0.2, "CENTER", f.Point[i], "CENTER", 0,0)
		f.Point[i].B3 = L.create_Texture(f.Point[i], "ARTWORK", "FCSPointB3", 64*CPOWER_SCALE,64*CPOWER_SCALE, 0,1,0,1, C.Color.White, 0.8, "CENTER", f.Point[i], "CENTER", 0,0)
		
		f.Point[i].R1 = L.create_Texture(f.Point[i], "ARTWORK", "FCSPointRing", 32*CPOWER_SCALE,32*CPOWER_SCALE, 0,1,0,1, C.Color.White, 0.8, "BOTTOMLEFT", f.Point[i], "CENTER", 0,0)
		f.Point[i].R2 = L.create_Texture(f.Point[i], "ARTWORK", "FCSPointRing", 32*CPOWER_SCALE,32*CPOWER_SCALE, 0,1,1,0, C.Color.White, 0.8, "TOPLEFT", f.Point[i], "CENTER", 0,0)
		f.Point[i].R3 = L.create_Texture(f.Point[i], "ARTWORK", "FCSPointRing", 32*CPOWER_SCALE,32*CPOWER_SCALE, 1,0,1,0, C.Color.White, 0.8, "TOPRIGHT", f.Point[i], "CENTER", 0,0)
		
		if i == 1 then
			--f.Point[i]: SetPoint("CENTER", f, "CENTER", 40,74)
			f.Point[i]: SetPoint("CENTER", f, "CENTER", 0,70+10*CPOWER_SCALE)
			
			f.Point[i].B1 = L.create_Texture(f.Point[i], "BACKGROUND", "FCSPointB3", 64*CPOWER_SCALE,64*CPOWER_SCALE, 0,1,0,1, C.Color.Black, 0.2, "CENTER", f.Point[i], "CENTER", 0,0)
			f.Point[i].B3: Hide()
			
			f.Point[i].Num = L.create_Texture(f.Point[i], "OVERLAY", "NumCenter24", L.Num_Center_24[0][1]*CPOWER_SCALE,L.Num_Center_24[0][2]*CPOWER_SCALE, L.Num_Center_24[0][3],L.Num_Center_24[0][4],L.Num_Center_24[0][5],L.Num_Center_24[0][6], C.Color.White, 1, "CENTER", f.Point[i], "CENTER", -0.5,0.5)
		else
			f.Point[i].B1 = L.create_Texture(f.Point[i], "BACKGROUND", "FCSPointB3", 64*CPOWER_SCALE,64*CPOWER_SCALE, 0,1,0,1, C.Color.Black, 0.2, "CENTER", f.Point[i], "CENTER", 0,0)
			f.Point[i].B3:Show()
		end
	end
	
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
		
		"UNIT_POWER_FREQUENT",
		"UNIT_DISPLAYPOWER",
		
		"UPDATE_SHAPESHIFT_FORM",
		
		"UNIT_AURA",
		
		"PLAYER_REGEN_DISABLED",
		"PLAYER_REGEN_ENABLED",
	}
	
	F.rEvent(f.Point.Help, event)
	f.Point.Help: SetScript("OnEvent", function(self,event)
		f.Point.class = select(2, UnitClass("player"))
		f.Point.specID = GetSpecialization()
		f.Point.form = GetShapeshiftFormID()
		f.Point.pMax = 0
		f.Point.p = nil
		f.Point.combo = nil
		f.Point.Remain = 0
		f.Point.Duration = 0
		f.Point.Start = 0
		f.Point.Expires = 0
		f.Point.Per = 0
		
		if UnitInVehicle("player") then
			f.Point.combo =  GetComboPoints("vehicle", "target") --comboPoints, arg1, arg2, secondLayerPoints, secondBarPoints = GetComboPoints(unit)
		else
			f.Point.combo =  GetComboPoints("player", "target")
		end
		if UnitInVehicle("player") and f.Point.combo and f.Point.combo > 0 then
			update_Point_Num(f.Point)
		else
			if f.Point.class == "PALADIN" then-------------------------------------------PALADIN
				f.Point.p = UnitPower("player", SPELL_POWER_HOLY_POWER)
				f.Point.pMax = UnitPowerMax("player", SPELL_POWER_HOLY_POWER)
				update_Point_Num(f.Point)
				update_Ring(f.Point[1], 0)
				color_Ring(f.Point[1], C.Color.White)
			elseif f.Point.class == "HUNTER" then----------------------------------------HUNTER
				
			elseif f.Point.class == "ROGUE" then-----------------------------------------ROGUE
				f.Point.combo =  GetComboPoints("player", "target")
				update_Point_Num(f.Point)
				update_Ring(f.Point[1], 1)
				color_Ring(f.Point[1], C.Color.White)
				f.Point.p, f.Point.Expires, f.Point.Duration = update_Aura("player", 115189, "HELPFUL") -->预感
				if f.Point.p and f.Point.p > 0 then
					f.Point[1].Num: SetSize(L.Num_Center_24[f.Point.p][1]*CPOWER_SCALE,L.Num_Center_24[f.Point.p][2]*CPOWER_SCALE)
					f.Point[1].Num: SetTexCoord(L.Num_Center_24[f.Point.p][3],L.Num_Center_24[f.Point.p][4], L.Num_Center_24[f.Point.p][5],L.Num_Center_24[f.Point.p][6])
				end
			elseif f.Point.class == "PRIEST" then----------------------------------------PRIEST
				if f.Point.specID == 1 then
					
				elseif f.Point.specID == 2 then
					
				elseif f.Point.specID == 3 then
					f.Point.p = UnitPower("player", SPELL_POWER_SHADOW_ORBS)
					f.Point.pMax = UnitPowerMax("player", SPELL_POWER_SHADOW_ORBS)
					update_Point_Num(f.Point)
					update_Ring(f.Point[1], 1)
					color_Ring(f.Point[1], C.Color.White)
				end
			elseif f.Point.class == "DEATHKNIGHT" then-----------------------------------DEATHKNIGHT
				if event == "PLAYER_ENTERING_WORLD" then
					self:RegisterEvent("RUNE_POWER_UPDATE")
					self:RegisterEvent("RUNE_TYPE_UPDATE")
					f.Point.Rune = {}
					for i = 1,6 do
						f.Point.Rune[i] = {start = 0, timer = 0, duration = 0, runeReady = 0, runeType = 0}
					end
					f.Point[3]: SetPoint("CENTER", f, "CENTER", 0,80)
					f.Point[2]: SetPoint("CENTER", f, "CENTER", -50,64)
					f.Point[4]: SetPoint("CENTER", f, "CENTER", 50,64)
				end
				if event == "PLAYER_ENTERING_WORLD" or event == "RUNE_POWER_UPDATE" or event == "RUNE_TYPE_UPDATE" or event == "UNIT_ENTERED_VEHICLE" or event ==  "UNIT_EXITED_VEHICLE" then
					undate_Rune(f.Point.Rune)
				end
				
			elseif f.Point.class == "SHAMAN" then----------------------------------------SHAMAN
				
			elseif f.Point.class == "MAGE" then------------------------------------------MAGE
				
			elseif f.Point.class == "WARLOCK" then---------------------------------------WARLOCK
				if f.Point.specID == 1 then -->Affliction
					f.Point.p = UnitPower("player", SPELL_POWER_SOUL_SHARDS)
					f.Point.pMax = UnitPowerMax("player", SPELL_POWER_SOUL_SHARDS)
					update_Point_Num(f.Point)
					local name = GetSpellInfo(152109) -->灵魂燃烧：鬼影缠身
					if GetSpellInfo(name) then
						f.Point.Expires, f.Point.Duration = select(2, update_Aura("player", 157698, "HELPFUL")) -->鬼魅灵魂
						f.Point.Remain = max(f.Point.Expires - GetTime(), 0)
					end
				elseif f.Point.specID == 2 then -->Demonology
					local power = UnitPower("player", SPELL_POWER_DEMONIC_FURY, true) 
					local powerMax = UnitPowerMax("player", SPELL_POWER_DEMONIC_FURY, true)
					f.Point.p = floor(power/100)
					f.Point.pMax = 10
					update_Point_Num(f.Point)
					if powerMax and powerMax > 0 then
						f.Point.Per = power/powerMax
					else
						f.Point.Per = 0
					end
				elseif f.Point.specID == 3 then -->Destruction
					-->MAX_POWER_PER_EMBER = 10, powerMax =40
					local power = UnitPower("player", SPELL_POWER_BURNING_EMBERS, true) 
					local powerMax = UnitPowerMax("player", SPELL_POWER_BURNING_EMBERS, true)
					f.Point.p = floor(power/MAX_POWER_PER_EMBER)
					f.Point.pMax = floor(powerMax/MAX_POWER_PER_EMBER)
					update_Point_Num(f.Point)
					if powerMax and powerMax > 0 then
						f.Point.Per = (power-f.Point.p*MAX_POWER_PER_EMBER)/MAX_POWER_PER_EMBER
					else
						f.Point.Per = 0
					end
				end
			elseif f.Point.class == "MONK" then-------------------------------------------MONK
				f.Point.p = UnitPower("player", SPELL_POWER_CHI)
				f.Point.pMax = UnitPowerMax("player", SPELL_POWER_CHI)
				update_Point_Num(f.Point)
				update_Ring(f.Point[1], 1)
				color_Ring(f.Point[1], C.Color.White)
			elseif f.Point.class == "DRUID" then------------------------------------------DRUID
				--self: UnregisterEvent("UNIT_AURA")
				--self: UnregisterEvent("SPELL_UPDATE_CHARGES")
				f.Point.Remain = 0
				if f.Point.form == CAT_FORM then -->Feral
					--self: RegisterEvent("UNIT_AURA")
					f.Point.combo =  GetComboPoints("player", "target")
					update_Point_Num(f.Point)
					f.Point.Expires, f.Point.Duration = select(2, update_Aura("player", 774, "player")) -->回春术
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
						update_Point_Num(f.Point)
						f.Point.Remain = max(f.Point.Expires - GetTime(), 0)
					else
						
					end
				elseif f.Point.specID == 1 then -->Balance
					--
					if event == "PLAYER_ENTERING_WORLD" then
						self: RegisterEvent("SPELL_UPDATE_CHARGES")
					end
					
					local charges, maxCharges, start, duration = GetSpellCharges(78674)--星涌术
					f.Point.p = charges
					f.Point.pMax = maxCharges
					update_Point_Num(f.Point)
					--
				elseif f.Point.specID == 4 then -->Restoration
					
				end
			elseif f.Point.class == "WARRIOR" then------------------------------------------WARRIOR
				f.Point.Remain = 0
				if f.Point.specID == 2 then -->狂怒
					f.Point.p, f.Point.Expires, f.Point.Duration = update_Aura("player", 85739, "HELPFUL")--绞肉机
					f.Point.pMax = 3
					update_Point_Num(f.Point)
					f.Point.Remain = max(f.Point.Expires - GetTime(), 0)
				end
			end
		end
		if (f.Point.combo and f.Point.combo > 0) then
			f.Point[1]: Show()
			f.Point.B0: Show()
		else
			f.Point.B0: Hide()
			if f.Point.class == "WARLOCK" then
				if f.Point.specID == 1 then -->Affliction
					if (not UnitAffectingCombat("player")) and (f.Point.p == f.Point.pMax) then
						f.Point[1]: Hide()
						f.Point.B0: Hide()
					else
						f.Point[1]: Show()
						f.Point.B0: Show()
					end
				elseif f.Point.specID == 2 then -->Demonology
					if (not UnitAffectingCombat("player")) then
						f.Point[1]: Hide()
						f.Point.B0: Hide()
					else
						f.Point[1]: Show()
						f.Point.B0: Show()
					end
				elseif f.Point.specID == 3 then -->Destruction
					if (not UnitAffectingCombat("player")) and (f.Point.p == 1) then
						f.Point[1]: Hide()
						f.Point.B0: Hide()
					else
						f.Point[1]: Show()
						f.Point.B0: Show()
					end
				end
			elseif f.Point.class == "DEATHKNIGHT" then
				if (not f.Point.Rune) or (not UnitAffectingCombat("player")) and f.Point.Rune[1].runeReady and f.Point.Rune[2].runeReady and f.Point.Rune[3].runeReady and f.Point.Rune[4].runeReady and f.Point.Rune[5].runeReady and f.Point.Rune[6].runeReady then
					f.Point[2]: Hide()
					f.Point[3]: Hide()
					f.Point[4]: Hide()
					f.Point.B0: Hide()
				elseif OwD_DB["OwD_RuneBar"] then
					f.Point[2]: Show()
					f.Point[3]: Show()
					f.Point[4]: Show()
					f.Point.B0: Show()
				end
			elseif f.Point.class == "DRUID" and f.Point.specID == 1 then
				if UnitAffectingCombat("player") then
					f.Point[1]: Show()
					f.Point.B0: Show()
				else
					f.Point[1]: Hide()
					f.Point.B0: Hide()
				end
			else
				if (f.Point.p and f.Point.p > 0) or (f.Point.Remain and f.Point.Remain > 0)then
					f.Point[1]: Show()
					f.Point.B0: Show()
				else
					f.Point[1]: Hide()
					f.Point.B0: Hide()
				end
			end
		end
		
	end)
	--]]
end

L.OnEvent_FCS = function(f, event)
	local p = f:GetParent()
	if event == "PLAYER_ENTERING_WORLD" or event == "UNIT_POWER_FREQUENT" or event == "UNIT_MAXPOWER" then
		local pa = f:GetParent()
		L.update_Power(f, pa.Player.unit)
	end
	
	if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED" then
		if UnitAffectingCombat("player") then
			f:SetAlpha(1)
		else
			f:SetAlpha(1)
		end
	end
end

L.OnUpdate_FCS = function(f, elapsed)
	--> Power Bar
	local c = max(min(floor(f.Power.Cur*36), 36), 0)
	f.Power.Bar: SetTexCoord(PP_Coord[c][3],PP_Coord[c][4], PP_Coord[c][5],PP_Coord[c][6])
	
	--> Power Number
	local pa = f:GetParent()
	local powerType = UnitPowerType(pa.Player.unit)
	local p,p1,p2,p3 = 0,0,0,0
	if powerType == 0 then
		p = f.Power.Cur
		p1 = max(min(floor(p), 9), 0)
		p2 = max(min(floor(p*10)-p1*10, 9), 0)
		p3 = max(min(floor(p*100)-floor(p*10)*10, 9), 0)
		p4 = "%"
	else
		p = f.Power.Cur * f.Power.Max
		p1 = max(min(floor(p/100), 9), 0)
		p2 = max(min(floor(p/10)-p1*10, 9), 0)
		p3 = max(min(floor(p)-floor(p/10)*10, 9), 0)
		p4 = "B"
	end
	if p1 <= 0 then
		p1 = "B"
		if p2 <= 0 then
			p2 = "B"
		end
	end
	
	f.PowerNum.Help: SetSize(L.Num_Center_24[p1][1]+L.Num_Center_24[p2][1]+L.Num_Center_24[p3][1]+L.Num_Center_24[p4][1]-30, L.Num_Center_24[0][2])
	
	f.PowerNum[1]: SetSize(L.Num_Center_24[p1][1], L.Num_Center_24[p1][2])
	f.PowerNum[1]: SetTexCoord(L.Num_Center_24[p1][3],L.Num_Center_24[p1][4], L.Num_Center_24[p1][5],L.Num_Center_24[p1][6])
	f.PowerNum[2]: SetSize(L.Num_Center_24[p2][1], L.Num_Center_24[p2][2])
	f.PowerNum[2]: SetTexCoord(L.Num_Center_24[p2][3],L.Num_Center_24[p2][4], L.Num_Center_24[p2][5],L.Num_Center_24[p2][6])
	f.PowerNum[3]: SetSize(L.Num_Center_24[p3][1], L.Num_Center_24[p3][2])
	f.PowerNum[3]: SetTexCoord(L.Num_Center_24[p3][3],L.Num_Center_24[p3][4], L.Num_Center_24[p3][5],L.Num_Center_24[p3][6])
	f.PowerNum[4]: SetSize(L.Num_Center_24[p4][1], L.Num_Center_24[p4][2])
	f.PowerNum[4]: SetTexCoord(L.Num_Center_24[p4][3],L.Num_Center_24[p4][4], L.Num_Center_24[p4][5],L.Num_Center_24[p4][6])
	
	--[[
	-->
	if f.Point.class == "WARLOCK" then---------------------------------------WARLOCK
		if f.Point.specID == 1 then -->Affliction
			if f.Point.Remain > 0 then
				f.Point.Remain = max(f.Point.Remain - elapsed, 0)
				update_Ring(f.Point[1], f.Point.Remain/(f.Point.Duration+F.Debug))
				color_Ring(f.Point[1], C.Color.Blue)
			else
				update_Ring(f.Point[1], 1)
				color_Ring(f.Point[1], C.Color.White)
			end
		else
			if f.Point.Per > 0 and f.Point.Per < 360 then
				update_Ring(f.Point[1], f.Point.Per)
				color_Ring(f.Point[1], C.Color.White)
			else
				update_Ring(f.Point[1], 0)
				color_Ring(f.Point[1], C.Color.White)
			end
		end
	elseif f.Point.class == "DRUID" then------------------------------------------DRUID
		if f.Point.form == CAT_FORM then -->Feral
			if f.Point.Remain > 0 then
				f.Point.Remain = max(f.Point.Remain - elapsed, 0)
				update_Ring(f.Point[1], f.Point.Remain/(f.Point.Duration+F.Debug))
				color_Ring(f.Point[1], C.Color.Blue)
			else
				update_Ring(f.Point[1], 1)
				color_Ring(f.Point[1], C.Color.White)
			end	
		elseif (f.Point.form == BEAR_FORM) and (f.Point.specID == 3) then
			if f.Point.Remain > 0 then
				f.Point.Remain = max(f.Point.Remain - elapsed, 0)
				update_Ring(f.Point[1], f.Point.Remain/(f.Point.Duration+F.Debug))
				color_Ring(f.Point[1], C.Color.Blue)
			else
				update_Ring(f.Point[1], 1)
				color_Ring(f.Point[1], C.Color.White)
			end	
		else
			update_Ring(f.Point[1], 1)
			color_Ring(f.Point[1], C.Color.White)
		end
	elseif f.Point.class == "WARRIOR" then
		if f.Point.specID == 2 then
			f.Point.Remain = max(f.Point.Remain - elapsed, 0)
			update_Ring(f.Point[1], f.Point.Remain/(f.Point.Duration+F.Debug))
			color_Ring(f.Point[1], C.Color.White)
		end
	elseif f.Point.class == "DEATHKNIGHT" then-----------------------------------DEATHKNIGHT
		if OwD_DB["OwD_RuneBar"] then
			if not f.Point.Rune then return end
			for i = 1,6 do
				if f.Point.Rune[i].runeReady then
					f.Point.Rune[i].timer = f.Point.Rune[i].duration
				else
					f.Point.Rune[i].timer = min(f.Point.Rune[i].timer + elapsed, f.Point.Rune[i].duration)
				end
			end
			sort_Rune(f.Point[2],f.Point.Rune[1],f.Point.Rune[2])
			sort_Rune(f.Point[3],f.Point.Rune[5],f.Point.Rune[6])
			sort_Rune(f.Point[4],f.Point.Rune[3],f.Point.Rune[4])
		else
			f.Point[2]: Hide()
			f.Point[3]: Hide()
			f.Point[4]: Hide()
		end
	end
	--]]
end

L.FCS_Frame = function(f)
	f.FCS = CreateFrame("Frame", nil, f)
	f.FCS: SetSize(80,80)
	--f.FCS: SetAlpha(1)
	f.FCS: SetFrameLevel(10)
	f.FCS: SetClampedToScreen(true)
	
	create_FCS_Power(f.FCS)
	create_Point(f.FCS)
end

--- ----------------------------------------------------------------------------
--> DEATHKNIGHT Rune Frame
--- ----------------------------------------------------------------------------
local undate_rune = function(f)
	for i = 1,6 do
		f[i].start, f[i].duration, f[i].runeReady = GetRuneCooldown(i)
		--print(i, f[i].start, f[i].duration)
	end
end

L.Rune = function(f)
	f.Rune = CreateFrame("Frame", nil, f)
	
	f.Rune:RegisterEvent("PLAYER_ENTERING_WORLD")
	f.Rune: SetScript("OnEvent", function(self, event)
		if select(2, UnitClass("player")) == "DEATHKNIGHT" then
			if event == "PLAYER_ENTERING_WORLD" then
				self:RegisterEvent("UNIT_ENTERED_VEHICLE")
				self:RegisterEvent("UNIT_EXITED_VEHICLE")
				self:RegisterEvent("RUNE_POWER_UPDATE")
				self:RegisterEvent("RUNE_TYPE_UPDATE")
				for i = 1,6 do
					f.Rune[i] = {start = 0, duration = 0, runeReady = 0}
				end
				undate_rune(f.Rune)
			end
			if event == "RUNE_POWER_UPDATE" or event == "RUNE_TYPE_UPDATE" then
				undate_rune(f.Rune)
			end
		end
	end)
end

--- ----------------------------------------------------------------------------
--> GCD Frame
--- ----------------------------------------------------------------------------
L.GCD = function(f)
	f.GCD = CreateFrame("Frame", nil, f)
	f.GCD: SetSize(194,206)
	f.GCD: SetPoint("CENTER", f, "CENTER", -187, 177)
	
	f.GCD.Border = L.create_Texture(f.GCD, "BORDER", "GCDBorder", 194,206, 31/256,225/256,25/256,231/256, C.Color.White2,0.9, "BOTTOMLEFT",f.GCD,"BOTTOMLEFT",0,0)
	f.GCD.Block = L.create_Texture(f.GCD, "ARTWORK", "GCDBlock", 1024,1024, 0,1,0,1, C.Color.White,1, "CENTER",f,"CENTER",0,0)
	
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
				f.XP.Num[9]: SetAlpha(0.3)
		
				if x2 <= 0 then
					f.XP.Num[8]: SetAlpha(0.3)
					if x3 <= 0 then
						f.XP.Num[7]: SetAlpha(0.3)
					else
						f.XP.Num[7]: SetAlpha(1)
					end
				else
					f.XP.Num[8]: SetAlpha(1)
					f.XP.Num[7]: SetAlpha(1)
				end
			else
				f.XP.Num[9]: SetAlpha(1)
				f.XP.Num[8]: SetAlpha(1)
				f.XP.Num[7]: SetAlpha(1)
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
			x1 = max(min(floor(XP/100),9),0)
			x2 = max(min(floor(XP/10-floor(XP/100)*10),9),0)
			x3 = max(min(floor(XP-floor(XP/10)*10),9),0)
			x5 = max(min(floor(XP*10-floor(XP)*10),9),0)
			x6 = max(min(floor(XP*100-floor(XP*10)*10),9),0)
			
			f.XP.Num[9]: SetAlpha(1)
			f.XP.Num[8]: SetAlpha(1)
			f.XP.Num[7]: SetAlpha(1)
		
			if x2 <= 0 and x1 <= 0 then
				x1 = x3
				x2 = x5
				x3 = x6
				f.XP.Dot1: ClearAllPoints()
				f.XP.Dot1: SetPoint("BOTTOMLEFT", f.XP.Num[9],"BOTTOMRIGHT", -6,-2)
				f.XP.Dot1: Show()
			elseif x1 <= 0 and x2 > 0 then
				x1 = x2
				x2 = x3
				x3 = x5
				f.XP.Dot1: ClearAllPoints()
				f.XP.Dot1: SetPoint("BOTTOMLEFT", f.XP.Num[8],"BOTTOMRIGHT", -6,-2)
				f.XP.Dot1: Show()
			else
				f.XP.Dot1: Hide()
			end
		end
		
		if maxXP < 1e3 then
			m1 = max(min(floor(maxXP/1000),9),0)
			m2 = max(min(floor(maxXP/100-floor(maxXP/1000)*10),9),0)
			m3 = max(min(floor(maxXP/10-floor(maxXP/100)*10),9),0)
			m4 = max(min(floor(maxXP-floor(maxXP/10)*10+0.5),9),0)
		
			if m1 <= 0 then
				f.XP.Num[4]: SetAlpha(0.3)
				if m2 <= 0 then
					f.XP.Num[3]: SetAlpha(0.3)
					if m3 <= 0 then
						f.XP.Num[2]: SetAlpha(0.3)
					else
						f.XP.Num[2]: SetAlpha(1)
					end
				else
					f.XP.Num[3]: SetAlpha(1)
					f.XP.Num[2]: SetAlpha(1)
				end
			else
				f.XP.Num[4]: SetAlpha(1)
				f.XP.Num[3]: SetAlpha(1)
				f.XP.Num[2]: SetAlpha(1)
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
		
			f.XP.Num[4]: SetAlpha(1)
			f.XP.Num[3]: SetAlpha(1)
			f.XP.Num[2]: SetAlpha(1)
		
			if m2 <= 0 and m1 <= 0 then
				m1 = m3
				m2 = m5
				m3 = m6
				f.XP.Dot2: ClearAllPoints()
				f.XP.Dot2: SetPoint("BOTTOMLEFT", f.XP.Num[4],"BOTTOMRIGHT", -6,-2)
				f.XP.Dot2: Show()
			elseif m1 <= 0 and m2 > 0 then
				m1 = m2
				m2 = m3
				m3 = m5
				f.XP.Dot2: ClearAllPoints()
				f.XP.Dot2: SetPoint("BOTTOMLEFT", f.XP.Num[3],"BOTTOMRIGHT", -6,-2)
				f.XP.Dot2: Show()
			else
				f.XP.Dot2: Hide()
			end
		end
		f.XP.Num[9]: SetSize(Num5[x1][1],Num5[x1][2])
		f.XP.Num[9]: SetTexCoord(Num5[x1][3],Num5[x1][4], Num5[x1][5],Num5[x1][6])
		f.XP.Num[8]: SetSize(Num5[x2][1],Num5[x2][2])
		f.XP.Num[8]: SetTexCoord(Num5[x2][3],Num5[x2][4], Num5[x2][5],Num5[x2][6])
		f.XP.Num[7]: SetSize(Num5[x3][1],Num5[x3][2])
		f.XP.Num[7]: SetTexCoord(Num5[x3][3],Num5[x3][4], Num5[x3][5],Num5[x3][6])
		f.XP.Num[6]: SetSize(Num5[x4][1],Num5[x4][2])
		f.XP.Num[6]: SetTexCoord(Num5[x4][3],Num5[x4][4], Num5[x4][5],Num5[x4][6])
	
		f.XP.Num[4]: SetSize(Num5[m1][1],Num5[m1][2])
		f.XP.Num[4]: SetTexCoord(Num5[m1][3],Num5[m1][4], Num5[m1][5],Num5[m1][6])
		f.XP.Num[3]: SetSize(Num5[m2][1],Num5[m2][2])
		f.XP.Num[3]: SetTexCoord(Num5[m2][3],Num5[m2][4], Num5[m2][5],Num5[m2][6])
		f.XP.Num[2]: SetSize(Num5[m3][1],Num5[m3][2])
		f.XP.Num[2]: SetTexCoord(Num5[m3][3],Num5[m3][4], Num5[m3][5],Num5[m3][6])
		f.XP.Num[1]: SetSize(Num5[m4][1],Num5[m4][2])
		f.XP.Num[1]: SetTexCoord(Num5[m4][3],Num5[m4][4], Num5[m4][5],Num5[m4][6])
	end
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

--- ----------------------------------------------------------------------------
--> Pet
--- ----------------------------------------------------------------------------
local Num_Pet_Text = {
	["P"] =	{21,31,   0/256, 21/256, 1/32,1},
	["E"] =	{21,31,  21/256, 42/256, 1/32,1},
	["T"] =	{21,31,  42/256, 63/256, 1/32,1},
	["L"] =	{21,31,  63/256, 84/256, 1/32,1},
	["A"] =	{21,31,  84/256,105/256, 1/32,1},
	["Y"] =	{21,31, 105/256,126/256, 1/32,1},
	["R"] =	{21,31, 126/256,147/256, 1/32,1},
	["B"] =	{10,31-0.7, 245/256,256/256, 1/32,1},
}

L.OnEvent_Pet = function(f, event)
	if (event == "UNIT_PET" and arg1 == "player" ) or event == "PET_UI_UPDATE" or event == "PLAYER_ENTERING_WORLD" or event == "UNIT_ENTERED_VEHICLE" or event == "UNIT_EXITED_VEHICLE" or event == "PET_UI_CLOSE" then
		if UnitInVehicle("player") then
			f.unit = "player"
			f.Name[1]: SetSize(Num_Pet_Text["P"][1], Num_Pet_Text["P"][2])
			f.Name[1]: SetTexCoord(Num_Pet_Text["P"][3],Num_Pet_Text["P"][4], Num_Pet_Text["P"][5],Num_Pet_Text["P"][6])
			f.Name[2]: SetSize(Num_Pet_Text["L"][1], Num_Pet_Text["L"][2])
			f.Name[2]: SetTexCoord(Num_Pet_Text["L"][3],Num_Pet_Text["L"][4], Num_Pet_Text["L"][5],Num_Pet_Text["L"][6])
			f.Name[3]: SetSize(Num_Pet_Text["A"][1], Num_Pet_Text["A"][2])
			f.Name[3]: SetTexCoord(Num_Pet_Text["A"][3],Num_Pet_Text["A"][4], Num_Pet_Text["A"][5],Num_Pet_Text["A"][6])
			f.Name[4]: SetSize(Num_Pet_Text["Y"][1], Num_Pet_Text["Y"][2])
			f.Name[4]: SetTexCoord(Num_Pet_Text["Y"][3],Num_Pet_Text["Y"][4], Num_Pet_Text["Y"][5],Num_Pet_Text["Y"][6])
			f.Name[5]: SetSize(Num_Pet_Text["E"][1], Num_Pet_Text["E"][2])
			f.Name[5]: SetTexCoord(Num_Pet_Text["E"][3],Num_Pet_Text["E"][4], Num_Pet_Text["E"][5],Num_Pet_Text["E"][6])
			f.Name[6]: SetSize(Num_Pet_Text["R"][1], Num_Pet_Text["R"][2])
			f.Name[6]: SetTexCoord(Num_Pet_Text["R"][3],Num_Pet_Text["R"][4], Num_Pet_Text["R"][5],Num_Pet_Text["R"][6])
		else
			f.unit = "pet"
			f.Name[1]: SetSize(Num_Pet_Text["P"][1], Num_Pet_Text["P"][2])
			f.Name[1]: SetTexCoord(Num_Pet_Text["P"][3],Num_Pet_Text["P"][4], Num_Pet_Text["P"][5],Num_Pet_Text["P"][6])
			f.Name[2]: SetSize(Num_Pet_Text["E"][1], Num_Pet_Text["E"][2])
			f.Name[2]: SetTexCoord(Num_Pet_Text["E"][3],Num_Pet_Text["E"][4], Num_Pet_Text["E"][5],Num_Pet_Text["E"][6])
			f.Name[3]: SetSize(Num_Pet_Text["T"][1], Num_Pet_Text["T"][2])
			f.Name[3]: SetTexCoord(Num_Pet_Text["T"][3],Num_Pet_Text["T"][4], Num_Pet_Text["T"][5],Num_Pet_Text["T"][6])
			f.Name[4]: SetSize(Num_Pet_Text["B"][1], Num_Pet_Text["B"][2])
			f.Name[4]: SetTexCoord(Num_Pet_Text["B"][3],Num_Pet_Text["B"][4], Num_Pet_Text["B"][5],Num_Pet_Text["B"][6])
			f.Name[5]: SetSize(Num_Pet_Text["B"][1], Num_Pet_Text["B"][2])
			f.Name[5]: SetTexCoord(Num_Pet_Text["B"][3],Num_Pet_Text["B"][4], Num_Pet_Text["B"][5],Num_Pet_Text["B"][6])
			f.Name[6]: SetSize(Num_Pet_Text["B"][1], Num_Pet_Text["B"][2])
			f.Name[6]: SetTexCoord(Num_Pet_Text["B"][3],Num_Pet_Text["B"][4], Num_Pet_Text["B"][5],Num_Pet_Text["B"][6])
		end
		
		L.update_Health(f, f.unit)
		L.update_Power(f, f.unit)
	elseif event == "UNIT_HEALTH_FREQUENT" or event == "UNIT_MAXHEALTH" then
		L.update_Health(f, f.unit)
	elseif event == "UNIT_POWER_FREQUENT" or event == "UNIT_MAXPOWER" then
		L.update_Power(f, f.unit)
	end
end

L.OnUpdate_Pet = function(f)
	if UnitExists(f.unit) then
		f:Show()
	else
		f:Hide()
	end
	
	-->Bar
	local d1,d2,d3,d4
	d1 = f.Health.Cur*10 or 0
	for i = 1,10 do
		if d1 >= i then
			f.Health[i]: SetAlpha(0.9)
		elseif d1 < i and (d1+1) >= i then
			d2 = (d1 + 1 - i)*0.9
			f.Health[i]: SetAlpha(d2)
		else
			f.Health[i]: SetAlpha(0)
		end
	end
	
	-->Number
	local h,hm,h1,h2,h3,h4,h5, p,p1,p2,p3,p4,p5
	h = f.Health.Cur * f.Health.Max
	p = f.Power.Cur * f.Power.Max
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
	f.Num[1]: SetSize(Num_Left_20[h1][1], Num_Left_20[h1][2])
	f.Num[1]: SetTexCoord(Num_Left_20[h1][3],Num_Left_20[h1][4], Num_Left_20[h1][5],Num_Left_20[h1][6])
	f.Num[2]: SetSize(Num_Left_20[h2][1], Num_Left_20[h2][2])
	f.Num[2]: SetTexCoord(Num_Left_20[h2][3],Num_Left_20[h2][4], Num_Left_20[h2][5],Num_Left_20[h2][6])
	f.Num[3]: SetSize(Num_Left_20[h3][1], Num_Left_20[h3][2])
	f.Num[3]: SetTexCoord(Num_Left_20[h3][3],Num_Left_20[h3][4], Num_Left_20[h3][5],Num_Left_20[h3][6])
	f.Num[4]: SetSize(Num_Left_20[h4][1], Num_Left_20[h4][2])
	f.Num[4]: SetTexCoord(Num_Left_20[h4][3],Num_Left_20[h4][4], Num_Left_20[h4][5],Num_Left_20[h4][6])
	f.Num[5]: SetSize(Num_Left_20[h5][1], Num_Left_20[h5][2])
	f.Num[5]: SetTexCoord(Num_Left_20[h5][3],Num_Left_20[h5][4], Num_Left_20[h5][5],Num_Left_20[h5][6])
	
	if p >= 1e10 then
		p = p/1e9
		p5 = "g"
	elseif p >= 1e7 then
		p = p/1e6
		p5 = "m"
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
	f.Num[7]: SetSize(Num_Left_20[p1][1], Num_Left_20[p1][2])
	f.Num[7]: SetTexCoord(Num_Left_20[p1][3],Num_Left_20[p1][4], Num_Left_20[p1][5],Num_Left_20[p1][6])
	f.Num[8]: SetSize(Num_Left_20[p2][1], Num_Left_20[p2][2])
	f.Num[8]: SetTexCoord(Num_Left_20[p2][3],Num_Left_20[p2][4], Num_Left_20[p2][5],Num_Left_20[p2][6])
	f.Num[9]: SetSize(Num_Left_20[p3][1], Num_Left_20[p3][2])
	f.Num[9]: SetTexCoord(Num_Left_20[p3][3],Num_Left_20[p3][4], Num_Left_20[p3][5],Num_Left_20[p3][6])
	f.Num[10]: SetSize(Num_Left_20[p4][1], Num_Left_20[p4][2])
	f.Num[10]: SetTexCoord(Num_Left_20[p4][3],Num_Left_20[p4][4], Num_Left_20[p4][5],Num_Left_20[p4][6])
	f.Num[11]: SetSize(Num_Left_20[p5][1], Num_Left_20[p5][2])
	f.Num[11]: SetTexCoord(Num_Left_20[p5][3],Num_Left_20[p5][4], Num_Left_20[p5][5],Num_Left_20[p5][6])
end

local create_Pet_Health = function(f)
	f.Health = CreateFrame("Frame", nil, f)
	f.Health: SetSize(18, 22)
	f.Health: SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0,0)
	
	L.init_Smooth(f.Health)
	
	for i = 1,10 do
		f.Health[i] = f.Health:CreateTexture(nil, "ARTWORK")
		f.Health[i]: SetVertexColor(unpack(C.Color.White))
		f.Health[i]: SetAlpha(0.9)
		f.Health[i]: SetTexture(F.Media.."PetBar")
		f.Health[i]: SetSize(17,22)
		f.Health[i]: SetTexCoord(8/32,25/32, 5/32,27/32)
		if i == 1 then
			f.Health[i]: SetPoint("BOTTOMLEFT", f.Health, "BOTTOMLEFT", 0,0)
		else
			f.Health[i]: SetPoint("BOTTOMLEFT", f.Health[i-1], "BOTTOMLEFT", 11,0.8)
		end
		
		f.Health[i].Bg = f.Health:CreateTexture(nil, "BACKGROUND")
		f.Health[i].Bg: SetVertexColor(unpack(C.Color.White))
		f.Health[i].Bg: SetAlpha(0.3)
		f.Health[i].Bg: SetTexture(F.Media.."PetBar")
		f.Health[i].Bg: SetSize(17,22)
		f.Health[i].Bg: SetTexCoord(8/32,25/32, 5/32,27/32)
		f.Health[i].Bg: SetPoint("BOTTOMLEFT", f.Health[i], "BOTTOMLEFT", 0,0)
	end
end

local create_Pet_Power = function(f)
	f.Power = CreateFrame("Frame", nil, f)
	
	L.init_Smooth(f.Power)
end

local create_Pet_Num = function(f)
	f.Num = CreateFrame("Frame", nil, f)
	for i = 1,11 do
		f.Num[i] =  f.Num:CreateTexture(nil, "ARTWORK")
		f.Num[i]: SetVertexColor(unpack(C.Color.White))
		f.Num[i]: SetAlpha(0.9)
		if i == 6 then
			f.Num[i]: SetTexture(F.Media.."NumLeft20")
			f.Num[i]: SetSize(Num_Left_20["/"][1], Num_Left_20["/"][2])
			f.Num[i]: SetTexCoord(Num_Left_20["/"][3],Num_Left_20["/"][4], Num_Left_20["/"][5],Num_Left_20["/"][6])
			f.Num[i]: SetVertexColor(unpack(C.Color.Blue))
		else
			f.Num[i]: SetTexture(F.Media.."NumLeft20")
			f.Num[i]: SetSize(Num_Left_20[0][1], Num_Left_20[0][2])
			f.Num[i]: SetTexCoord(Num_Left_20[0][3],Num_Left_20[0][4], Num_Left_20[0][5],Num_Left_20[0][6])
		end
		if i == 1 then
			f.Num[i]: SetPoint("TOPLEFT", f.Health, "TOPLEFT", 2,26)
		elseif i == 6 then
			f.Num[i]: SetPoint("BOTTOMLEFT", f.Num[i-1], "BOTTOMRIGHT", -10,1)
		elseif i == 7 then
			f.Num[i]: SetPoint("BOTTOMLEFT", f.Num[i-1], "BOTTOMRIGHT", -11,0)
		else
			f.Num[i]: SetPoint("BOTTOMLEFT", f.Num[i-1], "TOPRIGHT", -11,-31+0.7)
		end
	end
end

local create_Pet_Name = function(f)
	f.Name = CreateFrame("Frame", nil, f)
	for i = 1,6 do
		f.Name[i] =  f.Name:CreateTexture(nil, "ARTWORK")
		f.Name[i]: SetVertexColor(unpack(C.Color.White))
		f.Name[i]: SetAlpha(0.9)
		f.Name[i]: SetTexture(F.Media.."NumPetText")
		f.Name[i]: SetSize(Num_Pet_Text["P"][1], Num_Pet_Text["P"][2])
		f.Name[i]: SetTexCoord(Num_Pet_Text["P"][3],Num_Pet_Text["P"][4], Num_Pet_Text["P"][5],Num_Pet_Text["P"][6])
		if i == 1 then
			f.Name[i]: SetPoint("TOPLEFT", f.Health, "BOTTOMLEFT", -6,6)
		else
			f.Name[i]: SetPoint("BOTTOMLEFT", f.Name[i-1], "TOPRIGHT", -11,-31+0.7)
		end
	end
end

L.Pet_Frame = function(f)
	f.Pet = CreateFrame("Frame", nil, f.Player)
	f.Pet: SetSize(126, 32)
	f.Pet: SetClampedToScreen(true)
	f.Pet: SetPoint("BOTTOMLEFT", f.Player, "BOTTOMLEFT", 410,58)
	f.Pet.unit = "pet"
	--f.Pet: SetAlpha(0.95)
	
	create_Pet_Health(f.Pet)
	create_Pet_Power(f.Pet)
	create_Pet_Num(f.Pet)
	create_Pet_Name(f.Pet)
end