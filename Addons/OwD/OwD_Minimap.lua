local C, F, L = unpack(select(2, ...))

-->>Lua APIs
local min = math.min
local max = math.max
local format = string.format
local floor = math.floor
local sin = math.sin
local cos = math.cos
local tan = math.tan
local atan = math.atan
local rad = math.rad
-->>WoW APIs
local GetTime = GetTime
-->>Init
local Lv1,Lv2,Lv3 = 1,2,3


--- ----------------------------------------------------------------------------
--> Minimap Element      
--- ----------------------------------------------------------------------------

local Num1 = {
	[1] =	{7,18,  13/128, 20/128, 7/32,25/32},
	[2] =	{8,18,  21/128, 29/128, 7/32,25/32},
	[3] =	{8,18,  32/128, 40/128, 7/32,25/32},
	[4] =	{8,18,  41/128, 49/128, 7/32,25/32},
	[5] =	{8,18,  51/128, 59/128, 7/32,25/32},
	[6] =	{8,18,  61/128, 69/128, 7/32,25/32},
	[7] =	{9,18,  70/128, 78/128, 7/32,25/32},
	[8] =	{9,18,  80/128, 88/128, 7/32,25/32},
	[9] =	{8,18,  90/128, 98/128, 7/32,25/32},
	[0] =	{8,18, 100/128,108/128, 7/32,25/32},
	[":"] =	{5,16, 110/128,115/128, 7/32,25/32},
}

local create_Texture = function(f, texture, x,y, x1,x2,y1,y2, color,a, p1,p2,p3,p4,p5)
	f: SetTexture(F.Media..texture)
	f: SetSize(x,y)
	f: SetTexCoord(x1,x2, y1,y2)
	f: SetVertexColor(color[1], color[2], color[3])
	f: SetAlpha(a)
	f: SetPoint(p1,p2,p3,p4,p5)
end

local hide_Stuff = function()
	local dummy = function() end
	local _G = getfenv(0)

	local frames = {
	"MiniMapVoiceChatFrame",
	"MiniMapWorldMapButton",
	"MinimapZoneTextButton",
	--"MiniMapMailFrame",
	"MiniMapMailBorder",
	"MiniMapInstanceDifficulty",
	"MinimapNorthTag",
	"MinimapZoomOut",
	"MinimapZoomIn",
	"MinimapBackdrop",
	"GameTimeFrame",
	"GuildInstanceDifficulty",
	"MinimapBorderTop",
	}

	for i in pairs(frames) do
		_G[frames[i]]:Hide()
		_G[frames[i]].Show = dummy
	end

	GameTimeFrame:SetAlpha(0)
	GameTimeFrame:EnableMouse(false)

	LoadAddOn("Blizzard_TimeManager")
	TimeManagerClockButton.Show = TimeManagerClockButton.Hide
	TimeManagerClockButton:Hide()
	
	Minimap:SetArchBlobRingScalar(0);
	Minimap:SetQuestBlobRingScalar(0);
end

local Mouse_Wheel = function()
	Minimap:EnableMouseWheel(true)
	Minimap:SetScript("OnMouseWheel", function(self, d)
		local Zoom,maxZoom = Minimap:GetZoom(),Minimap:GetZoomLevels()
		if d > 0 then
			Minimap:SetZoom((Zoom+1 >= maxZoom and maxZoom) or Zoom+1)
		elseif d < 0 then
			Minimap:SetZoom((Zoom-1 <= 0 and 0) or Zoom-1)
		end
	end)
end

--- ----------------------------------------------------------------------------
--> Icon Collect
--- ----------------------------------------------------------------------------

local function isMinimapButton(frame)
	if frame and frame:GetObjectType() == "Button" and frame:GetNumRegions() >= 3 then
		return true
	end
end

local function addButton(button)
	if button:GetParent() ~= Minimap.Collect then
		button:SetParent(Minimap.Collect)
	end
end

local Minimap_Filter = {
	"MiniMapMailFrame",
	"QueueStatusMinimapButton",
	"MinimapBackdrop",	
}

function findButtons(frame)
	for i, child in ipairs({frame:GetChildren()}) do
		local name = child:GetName()
		local filter = nil
		for j = 1, #Minimap_Filter do
			if name == Minimap_Filter[j] then
				filter = true
			end
		end
		if isMinimapButton(child) and (not filter) then
			addButton(child)
		else
			findButtons(child)
		end	
	end
end

local function CollectButtons()
	findButtons(Minimap)
end

local Collect_Update = function(f)
	f.Help: SetScript("OnUpdate", function(self)
		local s = UIParent:GetScale()
		local w, h = Minimap:GetSize()
		local x0 = (Minimap:GetLeft()+w/2)*s*1
		local y0 = (Minimap:GetBottom()+h/2)*s*1
		local x1, y1 = GetCursorPosition()
		local x, y = x1, y1

		local r = sqrt((x-x0)*(x-x0)+(y-y0)*(y-y0))
		if (r < (w/2+30)*1*1*s) then
			f:Show()
		else
			f:Hide()
			f.Help:SetScript("OnUpdate", nil)
		end
	end)
end

local Icon_Collect = function(f)
	Minimap.Collect = CreateFrame("Frame", "Minimap.Collect", f)
	Minimap.Collect: SetSize(280,280)
	Minimap.Collect: SetPoint("CENTER", Minimap, "CENTER", 0,0)
	Minimap.Collect: SetAlpha(0.75)
	Minimap.Collect: SetScale(1)
	Minimap.Collect: Show()
	
	Minimap.Collect.Help = CreateFrame("Frame", nil, f)

	Minimap.Collect.Help:RegisterEvent("PLAYER_ENTERING_WORLD")
	Minimap.Collect.Help:SetScript("OnEvent", function(self, event, addon)
		CollectButtons()
		Minimap.Collect:Show()
		Collect_Update(Minimap.Collect)
	end)
end

--- ----------------------------------------------------------------------------
--> Clock  
--- ----------------------------------------------------------------------------

local create_Clock = function(f)
	if not f.Clock then
	f.Clock = CreateFrame("Frame", nil, f)
	f.Clock: SetSize(67,32)
	f.Clock: SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -7,-6)
	f.Clock: SetFrameLevel(f:GetFrameLevel()+1)
	f.Clock: EnableMouse(true)
	
	f.Clock.Border = L.create_Texture(f.Clock, "BORDER", "Minimap\\Border_2", 265,201, 124/512,389/512,28/256,229/256, C.Color.White,0.9, "BOTTOMRIGHT", f.Clock, "BOTTOMRIGHT", 0,0)
	
	f.Clock.Backdrop = L.create_Texture(f.Clock, "BACKGROUND", "Minimap\\Backdrop", 265,201, 124/512,389/512,28/256,229/256, C.Color.Black,0.3, "BOTTOMRIGHT", f.Clock, "BOTTOMRIGHT", 0,0)
	
	f.Clock.HL = f.Clock:CreateTexture(nil, "BACKGROUND")
	create_Texture(f.Clock.HL, "Minimap\\Clock_Fill", 67,32, 31/128,98/128,0,1, C.Color.White2,0.7, "BOTTOMRIGHT",f.Clock,"BOTTOMRIGHT",0,0)
	f.Clock.HL: Hide()
	
	for i = 1, 7, 1 do
		f.Clock[i] = f.Clock:CreateTexture(nil, "OVERLAY")
		f.Clock[i]: SetTexture(F.Media.."Minimap\\Num1")
		f.Clock[i]: SetSize(Num1[0][1], Num1[0][2])
		f.Clock[i]: SetTexCoord(Num1[0][3],Num1[0][4], Num1[0][5],Num1[0][6])
		f.Clock[i]: SetVertexColor(unpack(C.Color.White))
		f.Clock[i]: SetAlpha(1)
		--f.Clock[i]: SetPoint(p1,p2,p3,p4,p5)
	end
	f.Clock[3]: SetSize(Num1[":"][1], Num1[":"][2])
	f.Clock[3]: SetTexCoord(Num1[":"][3],Num1[":"][4], Num1[":"][5],Num1[":"][6])
	f.Clock[3]: SetPoint("BOTTOM", f.Clock, "BOTTOM", 0,6)
	f.Clock[4]: SetPoint("BOTTOMLEFT", f.Clock[3], "BOTTOMRIGHT", 1,0)
	f.Clock[5]: SetPoint("BOTTOMLEFT", f.Clock[4], "BOTTOMRIGHT", 0,0)
	f.Clock[2]: SetPoint("BOTTOMRIGHT", f.Clock[3], "BOTTOMLEFT", -1,0)
	f.Clock[1]: SetPoint("BOTTOMRIGHT", f.Clock[2], "BOTTOMLEFT", 0,0)
	
	f.Clock[7]: SetPoint("BOTTOMLEFT", f.Clock[3], "TOP", -1,3)
	f.Clock[6]: SetPoint("BOTTOMRIGHT", f.Clock[7], "BOTTOMLEFT", 0,0)
	f.Clock[6]: SetAlpha(0.75)
	f.Clock[7]: SetAlpha(0.75)
	
	f.Clock: SetScript("OnMouseUp", function(self, button)
		if button == "LeftButton" then
			ToggleCalendar()
		elseif button == "RightButton" then
			Stopwatch_Toggle()
		end
	end)
	
	f.Clock: SetScript("OnEnter", function(self)
		--f.Clock.HL: Show()
		for i = 1,5 do
			f.Clock[i]: SetVertexColor(unpack(C.Color.Yellow))
		end
	end)
	f.Clock: SetScript("OnLeave", function(self)
		--f.Clock.HL: Hide()
		for i = 1,5 do
			f.Clock[i]: SetVertexColor(unpack(C.Color.White))
		end
	end)
	end
end

--- ----------------------------------------------------------------------------
--> Indication
--- ----------------------------------------------------------------------------

local function sortdesc(a, b) 
	return a[2] > b[2] 
end	

local function formatmem(val,dec)
	return format(format("%%.%df %s",dec or 1,val > 1024 and "MB" or "KB"),val/(val > 1024 and 1024 or 1))
end
local Memo, Memory_Text, timer
local Memory_Tip = {}
local max_addons = 30

local OnEnter_Indicator = function(f)
	collectgarbage()
	local total = 0
	for i = 1, GetNumAddOns() do 
		total = total + GetAddOnMemoryUsage(i)
	end
	
	GameTooltip:SetOwner(f, "ANCHOR_BOTTOMLEFT", -4,10)
	GameTooltip:ClearLines()
	local r, down, up, lagHome, lagWorld = 500, GetNetStats()
	local rgb = {F.Gradient(lagWorld/r, C.Color.White, C.Color.Red)}
	GameTooltip:AddDoubleLine(
		format("|cffffffff%s|r %s, %s%s|r %s", floor(GetFramerate()), FPS_ABBR, F.Hex(rgb), lagWorld, MILLISECONDS_ABBR),
		format("%s: |cffffffff%s",ADDONS,formatmem(total)),0.40, 0.78, 1.00, 0.75, 0.90, 1.00)
	GameTooltip:AddLine(" ")
	if max_addons ~= 0 or IsAltKeyDown() then
		if not timer or timer + 5 < time() then
			timer = time()
			UpdateAddOnMemoryUsage()
			for i = 1, #Memory_Tip do Memory_Tip[i] = nil end
			for i = 1, GetNumAddOns() do
				local addon, name = GetAddOnInfo(i)
				if IsAddOnLoaded(i) then tinsert(Memory_Tip,{name or addon, GetAddOnMemoryUsage(i)}) end
			end
			table.sort(Memory_Tip, sortdesc)
		end
		local exmem = 0
		for i,t in ipairs(Memory_Tip) do
			if max_addons and i > max_addons and not IsAltKeyDown() then
				exmem = exmem + t[2]
			else
				local color = t[2] <= 102.4 and {0,1} -- 0 - 100
				or t[2] <= 512 and {0.75,1} -- 100 - 512
				or t[2] <= 1024 and {1,1} -- 512 - 1mb
				or t[2] <= 2560 and {1,0.75} -- 1mb - 2.5mb
				or t[2] <= 5120 and {1,0.5} -- 2.5mb - 5mb
				or {1,0.1} -- 5mb +
				GameTooltip:AddDoubleLine(t[1],formatmem(t[2]),1,1,1,color[1],color[2],0)
			end
		end
		if exmem > 0 and not IsAltKeyDown() then
			local more = #Memory_Tip - max_addons
			GameTooltip:AddDoubleLine(format("%d %s (%s)",more,"Hidden","ALT"),formatmem(exmem),0.40, 0.78, 1.00, 0.75, 0.90, 1.00)
		end
		GameTooltip:AddDoubleLine(" ","--------------",1,1,1,0.5,0.5,0.5)
	end
	GameTooltip:AddDoubleLine("Default UI Memory Usage"..":",formatmem(gcinfo() - total),0.40, 0.78, 1.00,1,1,1)
	GameTooltip:AddDoubleLine("Total Memory Usage"..":",formatmem(collectgarbage'count'),0.40, 0.78, 1.00,1,1,1)
	GameTooltip:Show()
end

local create_Indication = function(f)
	if not f.Indication then
	f.Indication = CreateFrame("Frame", nil, f)
	f.Indication: SetSize(25, 29)
	f.Indication: SetPoint("TOPLEFT", f.Clock.Border, "TOPLEFT", 0,-6)
	f.Indication: SetFrameLevel(f:GetFrameLevel()+3)
	f.Indication: EnableMouse(true)
	
	f.Indication.In = L.create_Texture(f.Indication, "BORDER", "Minimap\\Border_2_In", 25,29, 4/32,29/32,2/32,31/32, C.Color.White,0.7, "TOPLEFT", f.Indication, "TOPLEFT", 0,0)
	
	f.Indication: SetScript("OnEnter", function(self)
		f.Indication.In: SetAlpha(0.9)
		OnEnter_Indicator(self)
	end)
	f.Indication: SetScript("OnLeave", function(self)
		f.Indication.In: SetAlpha(0.7)
		GameTooltip:Hide()
	end)
	local p = f:GetParent()
	f.Indication: SetScript("OnMouseDown", function(self, button)
		GameTooltip:Hide()
		if button == "LeftButton" then
			ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, self, 0, 0)
		elseif button == "RightButton" then
			if p.Config:IsVisible() or UnitAffectingCombat("player") then
				p.Config:Hide()
			else
				p.Config:Show()
			end
		end
	end)
	end
end

--- ----------------------------------------------------------------------------
--> Compass
--- ----------------------------------------------------------------------------

local create_Compass = function(f)
	if not f.Compass then
	f.Compass = CreateFrame("Frame", nil, f)
	f.Compass: SetSize(244,64)
	f.Compass: SetPoint("TOP", f, "TOP", 0,42)
	f.Compass: SetFrameLevel(f:GetFrameLevel()+2)
	
	f.Compass.Point = f.Compass:CreateTexture(nil, "OVERLAY")
	create_Texture(f.Compass.Point, "Minimap\\Point", 16,8, 0,1,1/8,8/8, C.Color.White,0.9, "CENTER",f.Compass,"CENTER",0,-10)
	
	f.Compass.Bar = f.Compass:CreateTexture(nil, "BORDER")
	f.Compass.Bar: SetTexture(F.Media.."Minimap\\Compass")
	f.Compass.Bar: SetSize(244,64)
	--f.Compass.Bar: SetTexCoord(x1,x2, y1,y2)
	f.Compass.Bar: SetVertexColor(unpack(C.Color.White))
	f.Compass.Bar: SetAlpha(0.9)
	f.Compass.Bar: SetPoint("CENTER", f.Compass, "CENTER", 0,0)
	
	local adjCoord, currentFacing, interval, timer = 0
	local GetPlayerFacing = GetPlayerFacing
	local ADJ_FACTOR, DEG_TO_COORD, PI = 1/rad(720), 1/1440, rad(180)

	adjCoord, currentFacing, interval, timer = 270 * DEG_TO_COORD, nil, 0.1, 0.1

	f.Compass: SetScript("OnUpdate", function(self, elapsed)
		timer = timer + elapsed
		if timer < interval then return end
		timer = 0
		local facing = GetPlayerFacing()
		if facing ~= currentFacing then
			local coord = (facing < PI and 0.5 or 1) - (facing * ADJ_FACTOR)
			local coordH = coord + (0.5-coord)*64/1024
			local coordV = coord + (0.5-coord)*86/64
			f.Compass.Bar:SetTexCoord(coordH - 130/1024, coordH + 130/1024, coordV-32/64, coordV+32/64)
			currentFacing = facing
		end
	end)
	end
end

--- ----------------------------------------------------------------------------
--> Location
--- ----------------------------------------------------------------------------

local create_Location = function(f)
	if not f.Location then
	local O = f:GetParent()
	f.Location = CreateFrame("Frame", nil, f)
	f.Location: SetSize(340,70)
	f.Location: SetPoint("BOTTOM", O, "CENTER", 0, 340)
	f.Location: EnableMouse(false)
	f.Location: Hide()
	
	f.Location.Bg = f.Location: CreateTexture(nil, "BACKGROUND")
	f.Location.Bg: SetAllPoints(f.Location)
	f.Location.Bg: SetTexture(F.Media.."Bar")
	f.Location.Bg: SetVertexColor(0.09,0.09,0.09)
	f.Location.Bg: SetAlpha(0.4)
	
	f.Location.Line = L.create_Texture(f.Location, "BORDER", "Bar", 280,2, 0,1,0,1, C.Color.White,0.9, "CENTER",f.Location,"CENTER",0,-6)
	
	f.Location.Text = L.create_Fontstring(f.Location, C.Font.Name, 24, nil)
	f.Location.Text: SetPoint("BOTTOM", f.Location.Line, "CENTER", 0, 6)
	f.Location.Text: SetText("暴风城")
	f.Location.Text: SetShadowColor(0,0,0, 0.8)
	f.Location.Text: SetAlpha(0.9)
	
	f.Location.exText = L.create_Fontstring(f.Location, C.Font.Name, 14, nil)
	f.Location.exText: SetPoint("TOPRIGHT", f.Location.Line, "CENTER", -20, -7)
	f.Location.exText: SetText("暴风城")
	f.Location.exText: SetShadowColor(0,0,0, 0.8)
	f.Location.exText: SetAlpha(0.9)
	
	f.Location.X = L.create_Fontstring(f.Location, C.Font.Num, 13, nil)
	f.Location.X: SetPoint("TOPLEFT", f.Location.Line, "CENTER", -2, -7)
	f.Location.X: SetText("x:00.0")
	f.Location.X: SetShadowColor(0,0,0, 0.8)
	f.Location.X: SetAlpha(0.9)
	
	f.Location.Y = L.create_Fontstring(f.Location, C.Font.Num, 13, nil)
	f.Location.Y: SetPoint("TOPLEFT", f.Location.Line, "CENTER", 44, -7)
	f.Location.Y: SetText("y:00.0")
	f.Location.Y: SetShadowColor(0,0,0, 0.8)
	f.Location.Y: SetAlpha(0.9)
	
	f.Location: RegisterEvent("PLAYER_ENTERING_WORLD")
	f.Location: RegisterEvent("MINIMAP_ZONE_CHANGED")
	f.Location: RegisterEvent("ZONE_CHANGED")
	f.Location: RegisterEvent("ZONE_CHANGED_INDOORS")
	f.Location: RegisterEvent("ZONE_CHANGED_NEW_AREA")
	f.Location: SetScript("OnEvent", function(self,event)
		local zone = GetZoneText()
		--local realzone = GetRealZoneText()
		--local subzone = GetSubZoneText()
		local minimapzone = GetMinimapZoneText()
		
		f.Location.Text: SetText(minimapzone)
		f.Location.exText: SetText(zone)
		
		local pvpType, isSubZonePvP, factionName = GetZonePVPInfo();
		if ( pvpType == "sanctuary" ) then
			f.Location.Text:SetTextColor(0.41, 0.8, 0.94);
		elseif ( pvpType == "arena" ) then
			f.Location.Text:SetTextColor(1.0, 0.1, 0.1);
		elseif ( pvpType == "friendly" ) then
			f.Location.Text:SetTextColor(0.1, 1.0, 0.1);
		elseif ( pvpType == "hostile" ) then
			f.Location.Text:SetTextColor(1.0, 0.1, 0.1);
		elseif ( pvpType == "contested" ) then
			f.Location.Text:SetTextColor(1.0, 0.7, 0.0);
		else
			f.Location.Text:SetTextColor(unpack(C.Color.White));
		end
	end)
	end
end

--- ----------------------------------------------------------------------------
--> Minimap     
--- ----------------------------------------------------------------------------
--[[
L.OnEvent_Minimap = function(f, event)
	if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_XP_UPDATE" or event == "PLAYER_LEVEL_UP" then
		local XP, maxXP = UnitXP("player"), UnitXPMax("player")
		local restXP = GetXPExhaustion() or 0
		local d1,d2
		if maxXP == 0 then
			d1 = 0
			d2 = 0
		else
			d1 = floor(XP/maxXP*1e3)/1e3
			d2 = floor(restXP/maxXP*1e3)/1e3
		end
		if d2 + d1 >=1 then
			d2 = 1-d1
		end
		
		f.XP.Bar: SetSize(14,119*d1+F.Debug)
		f.XP.Bar: SetTexCoord(10/32,24/32,(124-119*d1)/128,124/128)
		f.XP.exBar: SetSize(14,119*d2+F.Debug)
		f.XP.exBar: SetTexCoord(10/32,24/32,(124-119*(d2+d1))/128,(124-119*d1)/128)
		f.XP.exBar: SetPoint("BOTTOM", f.XP, "BOTTOM", 0,d1*119)
	end
end
--]]
L.OnUpdate_Minimap_gap = function(f)
	if f then
	local hour,minute = GetGameTime()
	local h1 = max(floor(hour/10),0)
	local h2 = max(floor(hour)-h1*10,0)
	local m1 = max(floor(minute/10),0)
	local m2 = max(floor(minute)-m1*10,0)
	
	f.Clock[1]: SetSize(Num1[h1][1], Num1[h1][2])
	f.Clock[1]: SetTexCoord(Num1[h1][3],Num1[h1][4], Num1[h1][5],Num1[h1][6])
	f.Clock[2]: SetSize(Num1[h2][1], Num1[h2][2])
	f.Clock[2]: SetTexCoord(Num1[h2][3],Num1[h2][4], Num1[h2][5],Num1[h2][6])
	f.Clock[4]: SetSize(Num1[m1][1], Num1[m1][2])
	f.Clock[4]: SetTexCoord(Num1[m1][3],Num1[m1][4], Num1[m1][5],Num1[m1][6])
	f.Clock[5]: SetSize(Num1[m2][1], Num1[m2][2])
	f.Clock[5]: SetTexCoord(Num1[m2][3],Num1[m2][4], Num1[m2][5],Num1[m2][6])
	
	local weekday, month, day, year = CalendarGetDate()
	local dayColor = {}
	if weekday == 1 or weekday == 7 then
		dayColor = {255/255,  102/255,  132/255}
	else
		dayColor = {170/255,  170/255,  170/255}
	end
	
	local d1 = max(floor(day/10),0)
	local d2 = max(floor(day)-d1*10,0)
	
	f.Clock[6]: SetSize(Num1[d1][1], Num1[d1][2])
	f.Clock[6]: SetTexCoord(Num1[d1][3],Num1[d1][4], Num1[d1][5],Num1[d1][6])
	f.Clock[7]: SetSize(Num1[d2][1], Num1[d2][2])
	f.Clock[7]: SetTexCoord(Num1[d2][3],Num1[d2][4], Num1[d2][5],Num1[d2][6])
	
	f.Clock[6]: SetVertexColor(dayColor[1], dayColor[2], dayColor[3])
	f.Clock[7]: SetVertexColor(dayColor[1], dayColor[2], dayColor[3])
	
	-->Lag and FPS
	local framerate = floor(GetFramerate())
	local down, up, lagHome, lagWorld = GetNetStats()
	local late = max(lagHome, lagWorld)
	--print(framerate, late)
	if framerate < 24 or late > 150 then
		f.Indication.In: SetVertexColor(unpack(C.Color.Red))
	elseif framerate < 40 or late > 70 then
		f.Indication.In: SetVertexColor(unpack(C.Color.Yellow))
	else
		f.Indication.In: SetVertexColor(unpack(C.Color.Green2))
	end
	end
end

L.OnUpdate_Minimap = function(f)
	if f then
	-->Location
	local px,py=GetPlayerMapPosition("player")
	local fpx,fpy = floor(px*1e3)/10,floor(py*1e3)/10
	if f.Location and f.Location:IsShown() then
		f.Location.X: SetText("x:"..fpx)
		f.Location.Y: SetText("y:"..fpy)
	end
	end
end

L.Minimap = function(f)
	if not OwD_DB.Hide_Minimap then
	Minimap:SetSize(259, 259)
	Minimap:SetMaskTexture(F.Media.."Minimap\\Mask")
	Minimap:SetHitRectInsets(20, 20, 30, 30)
	Minimap:SetFrameLevel(2)
	Minimap:ClearAllPoints()
	--Minimap:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -70,-20)
	Minimap:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", OwD_DB.Pos.Minimap.x,OwD_DB.Pos.Minimap.y)
	Minimap:SetClampedToScreen(true)
	Minimap:SetScale(1)
	Minimap:SetAlpha(1)

	Minimap:SetPlayerTexture(F.Media.."Minimap\\Arrow")
	
	f.mMap = CreateFrame("Frame", nil, f)
	f.mMap:SetSize(265,201)
	f.mMap:SetPoint("CENTER", Minimap, "CENTER", 0,0)
	f.mMap:SetFrameLevel((Minimap:GetFrameLevel())+2)
		
	f.mMap.Border = L.create_Texture(f.mMap, "BORDER", "Minimap\\Border_1", 265,201, 124/512,389/512,28/256,229/256, C.Color.White,0.5, "CENTER", f.mMap, "CENTER", 0,0)
	
	-->>Move Frames
	-->任务追踪
	ObjectiveTrackerFrame: ClearAllPoints()	
	ObjectiveTrackerFrame.ClearAllPoints = function() end
	ObjectiveTrackerFrame: SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -100,-300)
	ObjectiveTrackerFrame. SetPoint = function() end
	ObjectiveTrackerFrame: SetClampedToScreen(true)
	ObjectiveTrackerFrame: SetHeight(600)
	
	-->地下城按钮
	QueueStatusMinimapButton: SetParent(Minimap)
	QueueStatusMinimapButton: ClearAllPoints()
	QueueStatusMinimapButton.ClearAllPoints = function() end
	QueueStatusMinimapButton: SetPoint("BOTTOMLEFT", Minimap, "BOTTOMLEFT", 4, 28)
	QueueStatusMinimapButton: SetFrameStrata("HIGH")
	QueueStatusMinimapButton: SetFrameLevel(6)
	QueueStatusMinimapButton.SetPoint = function() end
	
	-->耐久度
	DurabilityFrame: ClearAllPoints()
	DurabilityFrame.ClearAllPoints = function() end
	DurabilityFrame: SetPoint("TOPRIGHT", Minimap, "BOTTOMRIGHT", -10, -50)
	DurabilityFrame.SetPoint = function() end
	
	-->载具
	VehicleSeatIndicator: ClearAllPoints()
	VehicleSeatIndicator.ClearAllPoints = function() end
	VehicleSeatIndicator: SetPoint("RIGHT", Minimap,"LEFT", 0,0)
	VehicleSeatIndicator.SetPoint = function() end
	
	-->要塞按钮
	GarrisonLandingPageMinimapButton: ClearAllPoints()
	GarrisonLandingPageMinimapButton.ClearAllPoints = function() end
	GarrisonLandingPageMinimapButton: SetPoint("BOTTOMLEFT", Minimap,"BOTTOMLEFT", 70,10)
	GarrisonLandingPageMinimapButton.SetPoint = function() end
	
	-->Mail
	MiniMapMailFrame: ClearAllPoints()
	MiniMapMailFrame: SetPoint("TOPRIGHT", Minimap, -28, -30)
	MiniMapMailFrame: SetFrameStrata("HIGH")
	MiniMapMailIcon: SetTexture(F.Media.."Minimap\\Mail")
	MiniMapMailIcon: SetSize(32,32)
	MiniMapMailIcon: SetAlpha(0.4)
	MiniMapMailBorder: Hide()
	
	-->Aura Frame
	BuffFrame: ClearAllPoints()
	BuffFrame: SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -360,-10)
	
	-->>
	hide_Stuff()
	Mouse_Wheel()
	Icon_Collect(f.mMap)
	create_Clock(f.mMap)
	create_Indication(f.mMap)
	--create_XP(f.mMap)
	create_Compass(f.mMap)
	create_Location(f.mMap)
	
	Minimap:SetScript("OnEnter", function(self)
		CollectButtons()
		Minimap.Collect:Show()
		Collect_Update(Minimap.Collect)
		f.mMap.Location: Show()
	end)
	
	Minimap:SetScript("OnLeave", function(self)
		f.mMap.Location: Hide()
	end)
	end
end

