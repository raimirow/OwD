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
--> Focus    
--- ----------------------------------------------------------------------------

local HP_Coord = {
	[20] =	{28,25,   0/1024, 28/1024, 4/32,29/32},
	[19] =	{28,25,  28/1024, 56/1024, 4/32,29/32},
	[18] =	{28,25,  56/1024, 84/1024, 4/32,29/32},
	[17] =	{28,25,  84/1024,112/1024, 4/32,29/32},
	[16] =	{28,25, 112/1024,140/1024, 4/32,29/32},
	[15] =	{28,25, 140/1024,168/1024, 4/32,29/32},
	[14] =	{28,25, 168/1024,196/1024, 4/32,29/32},
	[13] =	{28,25, 196/1024,224/1024, 4/32,29/32},
	[12] =	{28,25, 224/1024,252/1024, 4/32,29/32},
	[11] =	{28,25, 252/1024,280/1024, 4/32,29/32},
	[10] =	{28,25, 280/1024,308/1024, 4/32,29/32},
	[9] =	{28,25, 308/1024,336/1024, 4/32,29/32},
	[8] =	{28,25, 336/1024,364/1024, 4/32,29/32},
	[7] =	{28,25, 364/1024,392/1024, 4/32,29/32},
	[6] =	{28,25, 392/1024,420/1024, 4/32,29/32},
	[5] =	{28,25, 420/1024,448/1024, 4/32,29/32},
	[4] =	{28,25, 448/1024,476/1024, 4/32,29/32},
	[3] =	{28,25, 476/1024,504/1024, 4/32,29/32},
	[2] =	{28,25, 504/1024,532/1024, 4/32,29/32},
	[1] =	{28,25, 532/1024,560/1024, 4/32,29/32},
	[0] =	{28,25, 560/1024,588/1024, 4/32,29/32},
}

local HEATHBAR_WIDE = 16

local create_Health = function(f)
	f.Health = CreateFrame("Frame", nil, f)
	f.Health: SetSize(28, 25)
	f.Health: SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0,0)
	--f.Health: SetFrameLevel(f:GetFrameLevel()+2)
	
	L.init_Smooth(f.Health)
	
	for i = 1,10 do
		f.Health[i] = f:CreateTexture(nil, "ARTWORK")
		f.Health[i]: SetTexture(F.Media.."FocusHealthBlock")
		f.Health[i]: SetSize(HP_Coord[HEATHBAR_WIDE][1],HP_Coord[HEATHBAR_WIDE][2])
		f.Health[i]: SetTexCoord(HP_Coord[HEATHBAR_WIDE][3],HP_Coord[HEATHBAR_WIDE][4], HP_Coord[HEATHBAR_WIDE][5],HP_Coord[HEATHBAR_WIDE][6])
		f.Health[i]: SetVertexColor(unpack(C.Color.White))
		f.Health[i]: SetAlpha(0.9)
		if i == 1 then
			f.Health[i]: SetPoint("BOTTOMLEFT", f.Health, "BOTTOMLEFT", 0,0)
		else
			f.Health[i]: SetPoint("BOTTOMLEFT", f.Health[i-1], "BOTTOMRIGHT", -26+HEATHBAR_WIDE,0.4*(HEATHBAR_WIDE/20))
		end
		
		f.Health[i].Bg = f:CreateTexture(nil, "BACKGROUND")
		f.Health[i].Bg: SetTexture(F.Media.."FocusHealthBlock")
		f.Health[i].Bg: SetSize(HP_Coord[HEATHBAR_WIDE][1],HP_Coord[HEATHBAR_WIDE][2])
		f.Health[i].Bg: SetTexCoord(HP_Coord[HEATHBAR_WIDE][3],HP_Coord[HEATHBAR_WIDE][4], HP_Coord[HEATHBAR_WIDE][5],HP_Coord[HEATHBAR_WIDE][6])
		f.Health[i].Bg: SetVertexColor(unpack(C.Color.White))
		f.Health[i].Bg: SetAlpha(0.3)
		f.Health[i].Bg: SetPoint("LEFT", f.Health[i], "LEFT", 0,0)
	end
end

local create_Power = function(f)
	f.Power = CreateFrame("Frame", nil, f)
	f.Power: SetSize(182,9)
	f.Power: SetPoint("TOPLEFT", f, "BOTTOMLEFT", 0,0)
	
	L.init_Smooth(f.Power)
	
	f.Power.Bar = L.create_Texture(f.Power, "ARTWORK", "FocusPowerBar", 182,9, 37/256,219/256,4/16,13/16, C.Color.White,0.9, "BOTTOMLEFT", f.Power, "BOTTOMLEFT", 0,0)
	f.Power.BarBg = L.create_Texture(f.Power, "BACKGROUND", "FocusPowerBar", 182,9, 37/256,219/256,4/16,13/16, C.Color.White,0.3, "BOTTOMLEFT", f.Power, "BOTTOMLEFT", 0,0)
end

local create_Name = function(f)
	f.Name = L.create_Fontstring(f, C.Font.Name, 16, nil)
	--f.Name: SetWidth(120)
	f.Name: SetShadowOffset(2,2)
	f.Name: SetPoint("BOTTOMRIGHT", f, "TOPRIGHT", 0,4)
	f.Name: SetText("暴风城测试员")
	f.Name: SetAlpha(0.9)
end

local create_Arrow = function(f)
	f.Arrow = CreateFrame("Frame", nil, f)
	f.Arrow: SetSize(82,82)
	f.Arrow: SetPoint("LEFT", f, "RIGHT", 2,0)
	
	f.Arrow.Tex = L.create_Texture(f.Arrow, "ARTWORK", "FocusArrow", 128,128, 0,1,0,1, C.Color.White,0.75, "CENTER", f.Arrow, "CENTER", 0,0)
	f.Arrow.B1 = L.create_Texture(f.Arrow, "BORDER", "FocusArrowB1", 128,128, 0,1,0,1, C.Color.Yellow,0.75, "CENTER", f.Arrow, "CENTER", 0,0)
	f.Arrow.B2 = L.create_Texture(f.Arrow, "BACKGROUND", "FocusArrowB2", 128,128, 0,1,0,1, C.Color.Yellow,0.6, "CENTER", f.Arrow, "CENTER", 0,0)
	
	f.Loop = CreateFrame("Frame", nil, f)
	f.Loop: SetSize(128,128)
	f.Loop: SetPoint("CENTER", f.Arrow, "CENTER", 0,0)
	
	f.Loop.Tex = L.create_Texture(f.Loop, "ARTWORK", "FocusArrowExtra", 128,128, 0,1,0,1, C.Color.White,0.75, "CENTER", f.Loop, "CENTER", 0,0)
	f.Loop.Tex: SetAllPoints(f.Loop)
	
	f.Loop.animationRotation = f.Loop:CreateAnimationGroup()
	f.Loop.Roation = f.Loop.animationRotation:CreateAnimation("Rotation")
	f.Loop.Roation: SetDegrees(-180)
	f.Loop.Roation: SetDuration(4)
	
	--f.Loop.animationRotation: 
	f.Loop.animationRotation: Play()
	f.Loop.animationRotation: SetLooping("REPEAT")  --NONE, REPEAT, BOUNCE
	
	--[[
	f.Num = CreateFrame("Frame", nil, f)
	f.Num: SetSize(2,2)
	f.Num: SetPoint("CENTER", f.Arrow, "CENTER", 0,1)
	--]]
	f.Num = {}
	f.Num.Help = CreateFrame("Frame", nil, f)
	f.Num.Help: SetPoint("CENTER", f.Arrow, "CENTER", 0,0)
	for i = 1,4 do
		f.Num[i] = f.Arrow:CreateTexture(nil, "ARTWORK")
		f.Num[i]: SetTexture(F.Media.."NumCenter24")
		f.Num[i]: SetVertexColor(unpack(C.Color.Black))
		f.Num[i]: SetAlpha(0.9)
		f.Num[i]: SetSize(L.Num_Center_24[0][1], L.Num_Center_24[0][2])
		f.Num[i]: SetTexCoord(L.Num_Center_24[0][3],L.Num_Center_24[0][4], L.Num_Center_24[0][5],L.Num_Center_24[0][6])
		if i == 1 then
			f.Num[i]: SetPoint("LEFT", f.Num.Help, "LEFT", 0,0)
		else
			f.Num[i]: SetPoint("LEFT", f.Num[i-1], "RIGHT", -10,0)
		end
		if i == 4 then
			f.Num[i]: SetSize(L.Num_Center_24["%"][1], L.Num_Center_24["%"][2])
			f.Num[i]: SetTexCoord(L.Num_Center_24["%"][3],L.Num_Center_24["%"][4], L.Num_Center_24["%"][5],L.Num_Center_24["%"][6])
		end
	end
	
	----------------------------------------------------------------------------
	-- Tanken from rTargetPointer(zork)
	local arrowSize = 128
	local WorldFrame = WorldFrame
	local hasFocus, lastPoint, namePlateIndex, plates = false, {}, nil, {}
	local onUpdateElapsed, onUpdateInterval = 0, 0.1
	
	local timer = CreateFrame("Frame")
	local sizer = CreateFrame("Frame", nil, WorldFrame)
	
	local rTP_RotateArrow = function()
		local x2,y2 = WorldFrame:GetCenter()
		local x3 = lastPoint.x-x2
		local y3 = lastPoint.y-y2
		local d = math.deg(math.atan(x3/y3))
		
		if x3 >= 0 and y3 >= 0 then
		d = d*(-1)
		elseif x3 >= 0 and y3 <= 0 then
		d = (-180-d)
		elseif x3 <= 0 and y3 >= 0 then
		d = d*(-1)
		elseif x3 <= 0 and y3 <= 0 then
		d = (180-d)
		end
		f.Arrow.Tex:SetRotation(math.rad(d))
	end
	
	local rTP_SizerOnSizeChanged = function(self, x, y)
		if self:IsShown() then
		lastPoint.x,lastPoint.y = x, y
		rTP_RotateArrow()
		end
	end
	
	local rTP_NamePlateTargetSearch = function()
		if not namePlateIndex then return end
		sizer:Hide()
		if not hasFocus then return end
		for plate, _ in next, plates do
			if plate:IsShown() and GetUnitName("focus", false) == plate.name:GetText() then
				sizer:ClearAllPoints()
				sizer:SetPoint("TOPRIGHT", plate, "CENTER")
				sizer:SetPoint("BOTTOMLEFT", WorldFrame)
				lastPoint.x,lastPoint.y = plate:GetCenter()
				rTP_RotateArrow()
				sizer:Show()
				f.Arrow.Tex:Show()
				f.Loop:Hide()
				break
			else
				f.Arrow.Tex:Hide()
				f.Loop:Show()
			end
		end
	end
	
	local rTP_NamePlateLookup = function()    
		if not namePlateIndex then return end
		local plate = _G["NamePlate"..namePlateIndex.."UnitFrame"]
		if not plate then return end
		if plates[plate] then return end
		plates[plate] = true
		namePlateIndex = namePlateIndex+1
	end
	
	local rTP_NamePlateIndexSearch = function()
		if namePlateIndex then return end
		--f.Arrow.Tex:Hide()
		for _, frame in next, { WorldFrame:GetChildren() } do
			local name = frame:GetName()
			if name and string.match(name, "^NamePlate%d+$") then
				namePlateIndex = string.gsub(name,"NamePlate","")
				break
			end
		end
	end
	
	local rTP_TimerOnUpdate = function(self,elapsed)
		onUpdateElapsed = onUpdateElapsed+elapsed
		if onUpdateElapsed > onUpdateInterval then
			if not namePlateIndex then rTP_NamePlateIndexSearch() end
			if namePlateIndex then rTP_NamePlateTargetSearch() end
			onUpdateElapsed = 0
		end
		if namePlateIndex then rTP_NamePlateLookup() end
	end

	local rTP_FocusChanged = function(...)
		sizer:Hide()
		f.Arrow.Tex:Hide()
		--if UnitExists("focus") and not UnitIsUnit("focus","player") and not UnitIsDead("focus") then
		if UnitExists("focus") and not UnitIsUnit("focus","player") then
			hasFocus = true
			timer:Show()
		else
			hasFocus = false
			timer:Hide()
		end
	end
	
	timer:SetScript("OnUpdate",rTP_TimerOnUpdate)
	timer:Hide()
	
	f.Arrow:RegisterEvent("PLAYER_FOCUS_CHANGED")
	f.Arrow:SetScript("OnEvent",rTP_FocusChanged)
  
	f.Arrow.Tex: SetSize(sqrt(2)*arrowSize,sqrt(2)*arrowSize)
	f.Arrow.Tex:SetBlendMode("ADD") --"ADD" or "BLEND"
	f.Arrow.Tex:SetRotation(math.rad(0))
	f.Arrow.Tex:Hide()
	
	sizer:SetScript("OnSizeChanged", rTP_SizerOnSizeChanged)
	sizer:Hide()
	--[[
	local t = sizer:CreateTexture()
	t:SetAllPoints()
	t:SetTexture(1,1,1)
	t:SetVertexColor(0,1,1,0.3)
	--]]
	----------------------------------------------------------------------------
end

--- ----------------------------------------------------------------------------
--> Focus    
--- ----------------------------------------------------------------------------

L.Focus_Frame = function(f)
	f.Focus = CreateFrame("Frame", nil, f)
	f.Focus: SetSize(187,26)
	f.Focus: SetClampedToScreen(true)
	f.Focus.unit = "focus"
	
	create_Health(f.Focus)
	create_Power(f.Focus)
	create_Name(f.Focus)
	create_Arrow(f.Focus)
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
			
			--f.Loop.animationRotation:Play()
			--f.Loop.animationRotation:SetLooping("REPEAT")
		else
			f:Hide()
			f.Name: SetText("")
		end
		L.update_Health(f, f.unit)
		L.update_Power(f, f.unit)
	end
	
	if event == "UNIT_HEALTH_FREQUENT" or event == "UNIT_MAXHEALTH" then
		L.update_Health(f, f.unit)
	end
	
	if event == "UNIT_POWER_FREQUENT" or event == "UNIT_MAXPOWER" then
		L.update_Power(f, f.unit)
	end
end

L.OnUpdate_Focus = function(f, elapsed)
	local step = floor(1/(GetFramerate())*1e3)/1e3
	local d1,d2, d3,d4
	
	d1 = f.Health.Cur*10 or 0
	for i = 1,10 do
		if d1 >= i then
			f.Health[i]: SetTexCoord(HP_Coord[HEATHBAR_WIDE][3],HP_Coord[HEATHBAR_WIDE][4], HP_Coord[HEATHBAR_WIDE][5],HP_Coord[HEATHBAR_WIDE][6])
			f.Health[i]: Show()
		elseif d1 < i and (d1+1) >= i then
			d2 = floor((d1 + 1 - i) * HEATHBAR_WIDE + 0.5)
			f.Health[i]: SetTexCoord(HP_Coord[d2][3],HP_Coord[d2][4], HP_Coord[d2][5],HP_Coord[d2][6])
			f.Health[i]: Show()
		else
			f.Health[i]:Hide()
		end
	end
	
	f.Power.Bar: SetSize(182*f.Power.Cur+F.Debug,9)
	f.Power.Bar: SetTexCoord(37/256,(37+182*f.Power.Cur+F.Debug)/256,4/16,13/16)
	
	if f.Num then
		local h,h1,h2,h3
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
		f.Num.Help: SetSize(L.Num_Center_24[h1][1]+L.Num_Center_24[h2][1]+L.Num_Center_24[h3][1]+L.Num_Center_24["%"][1]-30, L.Num_Center_24[0][2])
		
		f.Num[1]: SetSize(L.Num_Center_24[h1][1], L.Num_Center_24[h1][2])
		f.Num[1]: SetTexCoord(L.Num_Center_24[h1][3],L.Num_Center_24[h1][4], L.Num_Center_24[h1][5],L.Num_Center_24[h1][6])
		f.Num[2]: SetSize(L.Num_Center_24[h2][1], L.Num_Center_24[h2][2])
		f.Num[2]: SetTexCoord(L.Num_Center_24[h2][3],L.Num_Center_24[h2][4], L.Num_Center_24[h2][5],L.Num_Center_24[h2][6])
		f.Num[3]: SetSize(L.Num_Center_24[h3][1], L.Num_Center_24[h3][2])
		f.Num[3]: SetTexCoord(L.Num_Center_24[h3][3],L.Num_Center_24[h3][4], L.Num_Center_24[h3][5],L.Num_Center_24[h3][6])
		
	end
end

--- ----------------------------------------------------------------------------
--> Target of Focus
--- ----------------------------------------------------------------------------

local create_ToF_Health = function(f)
	f.Health = CreateFrame("Frame", nil, f)
	
	L.init_Smooth(f.Health)
end

local create_ToF_Name = function(f)
	f.Name = L.create_Fontstring(f, C.Font.Name, 16, nil)
	f.Name: SetPoint("TOPLEFT", f, "TOPLEFT", 0,0)
	f.Name: SetShadowOffset(2,2)
	f.Name: SetText("暴风城测试员")
	
	f.Lv = L.create_Fontstring(f, C.Font.Num, 12, nil)
	f.Lv: SetPoint("TOPRIGHT", f.Name, "BOTTOMRIGHT", 0,-2)
	f.Lv: SetShadowOffset(2,2)
	f.Lv: SetText("100")
end

local create_ToF_Num = function(f)
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

L.ToF_Frame = function(f)
	f.ToF = CreateFrame("Frame", nil, f)
	f.ToF: SetSize(120,20)
	f.ToF: SetPoint("BOTTOMRIGHT", f.Focus, "TOP", 0, 100)
	f.ToF.unit = "focustarget"
	
	create_ToF_Health(f.ToF)
	create_ToF_Name(f.ToF)
	create_ToF_Num(f.ToF)
end

L.OnUpdate_ToF_gap = function(f)
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

L.OnUpdate_ToF = function(f, elapsed)
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

--- ----------------------------------------------------------------------------
--> Focus Frame Update          
--- ----------------------------------------------------------------------------
--[[

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
--]]