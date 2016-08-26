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
local CVAR_USE_LOCAL_TIME = "timeMgrUseLocalTime"
local localTime = GetCVar(CVAR_USE_LOCAL_TIME) == "1"

--- ----------------------------------------------------------------------------
--> Minimap Element      
--- ----------------------------------------------------------------------------

local Num_TopRight_20 = {
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
	[":"] =	{21,31, 231/512,252/512, 1/32,1},
	["B"] =	{11,31,   0/512,  1/512, 1/32,1},
}

local Num_TopRight_16 = {
	[0] =	{14,21,   3/512, 17/512, 6/32,27/32},
	[1] =	{11,21,  26/512, 37/512, 6/32,27/32},
	[2] =	{14,21,  45/512, 59/512, 6/32,27/32},
	[3] =	{14,21,  66/512, 80/512, 6/32,27/32},
	[4] =	{14,21,  87/512,101/512, 6/32,27/32},
	[5] =	{14,21, 108/512,122/512, 6/32,27/32},
	[6] =	{14,21, 129/512,143/512, 6/32,27/32},
	[7] =	{14,21, 150/512,164/512, 6/32,27/32},
	[8] =	{14,21, 171/512,185/512, 6/32,27/32},
	[9] =	{14,21, 192/512,206/512, 6/32,27/32},
	["."] =	{14,21, 213/512,227/512, 6/32,27/32},
	["H"] =	{16,21, 234/512,250/512, 6/32,27/32},
	["C"] =	{16,21, 255/512,271/512, 6/32,27/32},
	["M"] =	{18,21, 275/512,293/512, 6/32,27/32},
	["B"] =	{7,31,   0/512,  1/512, 6/32,27/32},
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
	"MiniMapTrackingButton",
	"MiniMapMailFrame",
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

local function addButton(f, button)
	if button:GetParent() ~= f then
		button:SetParent(f)
	end
end

local Minimap_Filter = {
	"MiniMapMailFrame",
	"QueueStatusMinimapButton",
	"QueueStatusMinimapButtonDropDownButton",
	"MinimapBackdrop",	
	
	"MiniMapWorldMapButton",
	"MiniMapTrackingDropDownButton",
	"MiniMapTrackingButton",
	"MinimapZoomIn",
	"MinimapZoomOut",
	"GameTimeFrame",
	"MiniMapVoiceChatFrame",
	"MiniMapVoiceChatDropDownButton",
	"TimeManagerClockButton",
}

function findButtons(f, frame)
	for i, child in ipairs({frame:GetChildren()}) do
		local name = child:GetName()
		local filter = nil
		for j = 1, #Minimap_Filter do
			if name == Minimap_Filter[j] then
				filter = true
			end
		end
		if isMinimapButton(child) and (not filter) then
			addButton(f, child)
		else
			findButtons(f, child)
		end	
	end
end

local function CollectButtons(f)
	findButtons(f, Minimap)
end

local function pos_Collect(f)
	local x,y
	for i, child in ipairs({f.Collect: GetChildren()}) do
		child: ClearAllPoints()
		child: SetScale(1)
		--child: SetSize(24,24)
		
		x = i - floor(i/11)*11
		y = floor(i/11)
		
		child: SetPoint("CENTER", f, "BOTTOMLEFT", 30+ x*30-y*30*0.25, 60+ (x*30)/40.57-y*30*0.25)
		--print(i ,child:GetName())
	end
end
--[[
local Collect_Update = function(f)
	f.Help: SetScript("OnUpdate", function(self)
		local s = UIParent:GetScale()
		local w, h = Minimap:GetSize()
		local ms = Minimap:GetScale()
		local r0 = max(w,h)/2*ms*s
		local x0,y0 = Minimap:GetCenter()
		x0, y0 = x0*ms*s, y0*ms*s
		local x1, y1 = GetCursorPosition()
		local r = sqrt((x1-x0)*(x1-x0)+(y1-y0)*(y1-y0))
		
		if r < (r0+30*s) then
			--f:Show()
		else
			--f:Hide()
			f.Help:SetScript("OnUpdate", nil)
		end
	end)
end
--]]
local Icon_Collect = function(f)
	f.Collect = CreateFrame("Frame", "Minimap_Collect", f)
	--f.Collect: SetSize(280,280)
	--f.Collect: SetPoint("CENTER", f, "CENTER", 0,0)
	f.Collect: SetAllPoints(f)
	f.Collect: SetAlpha(0.75)
	f.Collect: Hide()
	
	f.Collect.Help = CreateFrame("Frame", nil, f)

	f.Collect.Help:RegisterEvent("PLAYER_ENTERING_WORLD")
	f.Collect.Help:SetScript("OnEvent", function(self, event, addon)
		CollectButtons(f.Collect)
		--f.Collect:Show()
		--Collect_Update(f.Collect)
		pos_Collect(f)
	end)
end

--- ----------------------------------------------------------------------------
--> Clock  
--- ----------------------------------------------------------------------------

local create_Clock = function(f)
	if not f.Clock then
	f.Clock = CreateFrame("Frame", nil, f)
	f.Clock: SetSize(64,32)
	f.Clock: SetPoint("TOPRIGHT", f, "TOPRIGHT", -44,-59)
	f.Clock: SetFrameLevel(f:GetFrameLevel()+1)
	f.Clock: EnableMouse(true)
	
	f.Clock.Num = {}
	for i = 1, 7, 1 do
		f.Clock.Num[i] = f.Clock:CreateTexture(nil, "OVERLAY")
		f.Clock.Num[i]: SetTexture(F.Media.."NumTopRight20")
		f.Clock.Num[i]: SetSize(Num_TopRight_20[0][1], Num_TopRight_20[0][2])
		f.Clock.Num[i]: SetTexCoord(Num_TopRight_20[0][3],Num_TopRight_20[0][4], Num_TopRight_20[0][5],Num_TopRight_20[0][6])
		f.Clock.Num[i]: SetVertexColor(unpack(C.Color.White))
		f.Clock.Num[i]: SetAlpha(0.75)
	end
	f.Clock.Num[3]: SetSize(Num_TopRight_20[":"][1], Num_TopRight_20[":"][2])
	f.Clock.Num[3]: SetTexCoord(Num_TopRight_20[":"][3],Num_TopRight_20[":"][4], Num_TopRight_20[":"][5],Num_TopRight_20[":"][6])
	f.Clock.Num[3]: SetPoint("CENTER", f.Clock, "CENTER", 0,0)
	f.Clock.Num[4]: SetPoint("BOTTOMLEFT", f.Clock.Num[3], "BOTTOMRIGHT", -15,0.7)
	f.Clock.Num[5]: SetPoint("BOTTOMLEFT", f.Clock.Num[4], "BOTTOMRIGHT", -12,0.8)
	f.Clock.Num[2]: SetPoint("BOTTOMRIGHT", f.Clock.Num[3], "BOTTOMLEFT", 14,-0.6)
	f.Clock.Num[1]: SetPoint("BOTTOMRIGHT", f.Clock.Num[2], "BOTTOMLEFT", 12,-1)
	
	f.Clock.Num[7]: SetPoint("BOTTOMRIGHT", f.Clock.Num[3], "BOTTOMRIGHT", -32,-3)
	f.Clock.Num[6]: SetPoint("BOTTOMRIGHT", f.Clock.Num[7], "BOTTOMLEFT", 12,-1)
	f.Clock.Num[6]: SetAlpha(0)
	f.Clock.Num[7]: SetAlpha(0)
	
	f.Clock: SetScript("OnMouseUp", function(self, button)
		if button == "LeftButton" then
			ToggleCalendar()
		elseif button == "RightButton" then
			Stopwatch_Toggle()
		end
	end)
	
	f.Clock: SetScript("OnEnter", function(self)
		for i = 1,5 do
			f.Clock.Num[i]: SetVertexColor(unpack(C.Color.Blue))
		end
	end)
	f.Clock: SetScript("OnLeave", function(self)
		for i = 1,5 do
			f.Clock.Num[i]: SetVertexColor(unpack(C.Color.White))
		end
	end)
	end
end

--- ----------------------------------------------------------------------------
--> Compass
--- ----------------------------------------------------------------------------
--[[
local create_Compass = function(f)
	if not f.Compass then
	f.Compass = CreateFrame("Frame", nil, f)
	f.Compass: SetSize(244,64)
	f.Compass: SetPoint("TOP", f, "TOP", 0,42)
	f.Compass: SetFrameLevel(f:GetFrameLevel()+2)
	
	f.Compass.Point = f.Compass:CreateTexture(nil, "OVERLAY")
	create_Texture(f.Compass.Point, "Minimap\\Point", 16,8, 0,1,1/8,8/8, C.Color.White,0, "CENTER",f.Compass,"CENTER",0,-10)
	
	f.Compass.Bar = f.Compass:CreateTexture(nil, "BORDER")
	f.Compass.Bar: SetTexture(F.Media.."Minimap\\Compass")
	f.Compass.Bar: SetSize(244,64)
	--f.Compass.Bar: SetTexCoord(x1,x2, y1,y2)
	f.Compass.Bar: SetVertexColor(unpack(C.Color.White))
	f.Compass.Bar: SetAlpha(0)
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
--]]
--- ----------------------------------------------------------------------------
--> Location
--- ----------------------------------------------------------------------------

local create_Location = function(f)
	if not f.Location then
	local O = f:GetParent()
	f.Location = CreateFrame("Frame", nil, f)
	f.Location: SetSize(340,80)
	f.Location: SetPoint("BOTTOM", O, "CENTER", 0, 240)
	f.Location: EnableMouse(false)
	f.Location: Hide()
	
	f.Location.Bg = f.Location: CreateTexture(nil, "BACKGROUND")
	--f.Location.Bg: SetAllPoints(f.Location)
	f.Location.Bg: SetHeight(80)
	f.Location.Bg: SetTexture(F.Media.."Bar")
	f.Location.Bg: SetVertexColor(0.09,0.09,0.09)
	f.Location.Bg: SetAlpha(0.4)
	
	--f.Location.Line = L.create_Texture(f.Location, "BORDER", "Bar", 280,2, 0,1,0,1, C.Color.White,0.9, "CENTER",f.Location,"CENTER",0,-6)
	
	f.Location.Text = L.create_Fontstring(f.Location, C.Font.Name, 26, nil)
	--f.Location.Text: SetPoint("BOTTOM", f.Location.Line, "CENTER", 0, 6)
	f.Location.Text: SetPoint("CENTER", f.Location, "CENTER", 0, 0)
	f.Location.Text: SetText("暴风城")
	f.Location.Text: SetShadowColor(0,0,0, 0.8)
	f.Location.Text: SetAlpha(0.9)
	
	f.Location.Bg: SetPoint("LEFT", f.Location.Text, "LEFT", -16,0)
	f.Location.Bg: SetPoint("RIGHT", f.Location.Text, "RIGHT", 16,0)
	
	f.Location.Line = L.create_Texture(f.Location, "BORDER", "Bar", 6,70, 0,1,0,1, C.Color.White,0.9, "RIGHT",f.Location.Text,"LEFT",-6,0)
	
	f.Location.exText = L.create_Fontstring(f.Location, C.Font.Name, 14, nil)
	--f.Location.exText: SetPoint("TOPRIGHT", f.Location.Line, "CENTER", -20, -7)
	f.Location.exText: SetPoint("BOTTOMLEFT", f.Location.Text, "TOPLEFT", 1, 6)
	f.Location.exText: SetText("暴风城")
	f.Location.exText: SetShadowColor(0,0,0, 0.8)
	f.Location.exText: SetAlpha(0.9)
	
	f.Location.X = L.create_Fontstring(f.Location, C.Font.Num, 13, nil)
	--f.Location.X: SetPoint("TOPLEFT", f.Location.Line, "CENTER", 18, -7)
	f.Location.X: SetPoint("TOPLEFT", f.Location.Text, "BOTTOMLEFT", 1, -6)
	f.Location.X: SetText("x:00.0")
	f.Location.X: SetShadowColor(0,0,0, 0.8)
	f.Location.X: SetAlpha(0.9)
	
	f.Location.Y = L.create_Fontstring(f.Location, C.Font.Num, 13, nil)
	--f.Location.Y: SetPoint("TOPLEFT", f.Location.Line, "CENTER", 64, -7)
	f.Location.Y: SetPoint("LEFT", f.Location.X, "LEFT", 40, 0)
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
--> Dungeon Difficulty
--- ----------------------------------------------------------------------------
local IS_GUILD_GROUP
local unpdate_InstanceDifficulty = function(f, p)
    local _, instanceType, difficulty, difficultyName, maxPlayers, playerDifficulty, isDynamicInstance, _, instanceGroupSize = GetInstanceInfo();
    local _, _, isHeroic, isChallengeMode, displayHeroic, displayMythic = GetDifficultyInfo(difficulty)
	--print(instanceType, difficulty, instanceGroupSize, maxPlayers)
	if difficulty and difficulty ~= 0 then
		if instanceType == "party" then
			--f.Tex: Hide()
			if (instanceGroupSize ~= maxPlayers) and (maxPlayers == 40) then
				p.Tex: SetAlpha(0.35)
				p.Tex: SetVertexColor(unpack(C.Color.White2))
				f.Num[2]: SetSize(Num_TopRight_16["B"][1], Num_TopRight_16["B"][2])
				f.Num[2]: SetTexCoord(Num_TopRight_16["B"][3],Num_TopRight_16["B"][4], Num_TopRight_16["B"][5],Num_TopRight_16["B"][6])
				f.Num[3]: SetSize(Num_TopRight_16["B"][1], Num_TopRight_16["B"][2])
				f.Num[3]: SetTexCoord(Num_TopRight_16["B"][3],Num_TopRight_16["B"][4], Num_TopRight_16["B"][5],Num_TopRight_16["B"][6])
			else
				p.Tex: SetAlpha(0)
				p.Tex: SetVertexColor(unpack(C.Color.White2))
				local s1 = floor(maxPlayers/10)
				local s2 = maxPlayers - s1*10
				if s1 == 0 then
					s1 = "B"
				end
				f.Num[2]: SetSize(Num_TopRight_16[s1][1], Num_TopRight_16[s1][2])
				f.Num[2]: SetTexCoord(Num_TopRight_16[s1][3],Num_TopRight_16[s1][4], Num_TopRight_16[s1][5],Num_TopRight_16[s1][6])
				f.Num[3]: SetSize(Num_TopRight_16[s2][1], Num_TopRight_16[s2][2])
				f.Num[3]: SetTexCoord(Num_TopRight_16[s2][3],Num_TopRight_16[s2][4], Num_TopRight_16[s2][5],Num_TopRight_16[s2][6])
			end
		elseif instanceType == "raid" and instanceGroupSize then
			p.Tex: SetAlpha(0)
			p.Tex: SetVertexColor(unpack(C.Color.White2))
			local s1 = floor(instanceGroupSize/10)
			local s2 = instanceGroupSize - s1*10
			if s1 == 0 then
				s1 = "B"
			end
			f.Num[2]: SetSize(Num_TopRight_16[s1][1], Num_TopRight_16[s1][2])
			f.Num[2]: SetTexCoord(Num_TopRight_16[s1][3],Num_TopRight_16[s1][4], Num_TopRight_16[s1][5],Num_TopRight_16[s1][6])
			f.Num[3]: SetSize(Num_TopRight_16[s2][1], Num_TopRight_16[s2][2])
			f.Num[3]: SetTexCoord(Num_TopRight_16[s2][3],Num_TopRight_16[s2][4], Num_TopRight_16[s2][5],Num_TopRight_16[s2][6])
		else
			p.Tex: SetAlpha(0.9)
			p.Tex: SetVertexColor(unpack(C.Color.White))
			f.Num[2]: SetSize(Num_TopRight_16["B"][1], Num_TopRight_16["B"][2])
			f.Num[2]: SetTexCoord(Num_TopRight_16["B"][3],Num_TopRight_16["B"][4], Num_TopRight_16["B"][5],Num_TopRight_16["B"][6])
			f.Num[3]: SetSize(Num_TopRight_16["B"][1], Num_TopRight_16["B"][2])
			f.Num[3]: SetTexCoord(Num_TopRight_16["B"][3],Num_TopRight_16["B"][4], Num_TopRight_16["B"][5],Num_TopRight_16["B"][6])
		end
	else
		--f.Tex: Hide()
		p.Tex: SetAlpha(0.35)
		p.Tex: SetVertexColor(unpack(C.Color.White2))
		f.Num[2]: SetSize(Num_TopRight_16["B"][1], Num_TopRight_16["B"][2])
		f.Num[2]: SetTexCoord(Num_TopRight_16["B"][3],Num_TopRight_16["B"][4], Num_TopRight_16["B"][5],Num_TopRight_16["B"][6])
		f.Num[3]: SetSize(Num_TopRight_16["B"][1], Num_TopRight_16["B"][2])
		f.Num[3]: SetTexCoord(Num_TopRight_16["B"][3],Num_TopRight_16["B"][4], Num_TopRight_16["B"][5],Num_TopRight_16["B"][6])
	end
	
	if isChallengeMode then
		--f.Num[1]: SetVertexColor(unpack(C.Color.Yellow))
		f.Num[1]: SetSize(Num_TopRight_16["C"][1], Num_TopRight_16["C"][2])
		f.Num[1]: SetTexCoord(Num_TopRight_16["C"][3],Num_TopRight_16["C"][4], Num_TopRight_16["C"][5],Num_TopRight_16["C"][6])
	elseif displayMythic then
		--f.Num[1]: SetVertexColor(unpack(C.Color.White))
		f.Num[1]: SetSize(Num_TopRight_16["M"][1], Num_TopRight_16["M"][2])
		f.Num[1]: SetTexCoord(Num_TopRight_16["M"][3],Num_TopRight_16["M"][4], Num_TopRight_16["M"][5],Num_TopRight_16["M"][6])
	elseif isHeroic or displayHeroic then
		--f.Num[1]: SetVertexColor(unpack(C.Color.White))
		f.Num[1]: SetSize(Num_TopRight_16["H"][1], Num_TopRight_16["H"][2])
		f.Num[1]: SetTexCoord(Num_TopRight_16["H"][3],Num_TopRight_16["H"][4], Num_TopRight_16["H"][5],Num_TopRight_16["H"][6])
	else
		f.Num[1]: SetSize(Num_TopRight_16["B"][1], Num_TopRight_16["B"][2])
		f.Num[1]: SetTexCoord(Num_TopRight_16["B"][3],Num_TopRight_16["B"][4], Num_TopRight_16["B"][5],Num_TopRight_16["B"][6])
	end
	f: SetWidth(f.Num[1]:GetWidth()+f.Num[2]:GetWidth()+f.Num[3]:GetWidth()-14)
end

local create_InstanceInfo = function(f)
	f.Instance = CreateFrame("Frame", nil, f)
	--f.Instance: SetSize(30,24)
	f.Instance: SetHeight(22)
	f.Instance: SetPoint("CENTER", f, "CENTER", 0,-1)
	--f.Instance: SetFrameLevel(f:GetFrameLevel()+1)
	--f.Instance.Tex = L.create_Texture(f, "OVERLAY", "MinimapIconLFD", 52,52, 0,1,0,1, C.Color.White,0.9, "CENTER", f, "CENTER", 0,0)
	
	f.Instance.Num = {}
	for i = 1,3 do
		f.Instance.Num[i] = f.Instance:CreateTexture(nil, "OVERLAY")
		f.Instance.Num[i]: SetTexture(F.Media.."NumTopRight16")
		f.Instance.Num[i]: SetSize(Num_TopRight_16[0][1], Num_TopRight_16[0][2])
		f.Instance.Num[i]: SetTexCoord(Num_TopRight_16[0][3],Num_TopRight_16[0][4], Num_TopRight_16[0][5],Num_TopRight_16[0][6])
		f.Instance.Num[i]: SetAlpha(1)
		f.Instance.Num[i]: SetVertexColor(unpack(C.Color.White))
		if i == 1 then
			f.Instance.Num[i]: SetPoint("LEFT", f.Instance, "LEFT", 0,0)
		elseif i ==2 then
			f.Instance.Num[i]: SetPoint("LEFT", f.Instance.Num[i-1], "RIGHT", -7, 10*4/53)
		else
			f.Instance.Num[i]: SetPoint("LEFT", f.Instance.Num[i-1], "RIGHT", -7, 7*4/53)
		end	
	end
	
	f.Instance: RegisterEvent("PLAYER_DIFFICULTY_CHANGED")
	f.Instance: RegisterEvent("INSTANCE_GROUP_SIZE_CHANGED")
	f.Instance: RegisterEvent("UPDATE_INSTANCE_INFO")
	f.Instance: RegisterEvent("GROUP_ROSTER_UPDATE")
	f.Instance: RegisterEvent("PLAYER_GUILD_UPDATE")
	f.Instance: RegisterEvent("PARTY_MEMBER_ENABLE")
	f.Instance: RegisterEvent("PARTY_MEMBER_DISABLE")
	f.Instance: RegisterEvent("GUILD_PARTY_STATE_UPDATED")
	
	f.Instance: RegisterEvent("PLAYER_ENTERING_WORLD")
	f.Instance: RegisterEvent("MINIMAP_ZONE_CHANGED")
	f.Instance: RegisterEvent("ZONE_CHANGED")
	--f.Instance: RegisterEvent("CHAT_MSG_CHANNEL_NOTICE")
	
	f.Instance: SetScript("OnEvent", function(self,event, ...)
		if ( event == "GUILD_PARTY_STATE_UPDATED" ) then
			local isGuildGroup = ...
			if ( isGuildGroup ~= IS_GUILD_GROUP ) then
				IS_GUILD_GROUP = isGuildGroup
				unpdate_InstanceDifficulty(self, f)
			end
		elseif ( event == "PLAYER_DIFFICULTY_CHANGED") then
			unpdate_InstanceDifficulty(self, f)
		elseif ( event == "UPDATE_INSTANCE_INFO" or event == "INSTANCE_GROUP_SIZE_CHANGED" ) then
			RequestGuildPartyState()
			unpdate_InstanceDifficulty(self, f)
		elseif ( event == "PLAYER_GUILD_UPDATE" ) then
			if ( IsInGuild() ) then
				RequestGuildPartyState()
			else
				IS_GUILD_GROUP = nil
			end
			unpdate_InstanceDifficulty(self, f)
		else
			RequestGuildPartyState()
			unpdate_InstanceDifficulty(self, f)
		end
	end)
end

--- ----------------------------------------------------------------------------
--> Indicator    
--- ----------------------------------------------------------------------------

local function update_MinimapMailGameTooltip()
    local sender1,sender2,sender3 = GetLatestThreeSenders();
    local toolText;
	if( sender1 or sender2 or sender3 ) then
		toolText = HAVE_MAIL_FROM;
	else
		toolText = HAVE_MAIL;
	end
	if( sender1 ) then
		toolText = toolText.."\n"..sender1;
	end
	if( sender2 ) then
		toolText = toolText.."\n"..sender2;
	end
	if( sender3 ) then
		toolText = toolText.."\n"..sender3;
	end
	GameTooltip:SetText(toolText);
end

local create_Indicator = function(f)
	f.Indicator = {}
	f.Indicator.Help = CreateFrame("Frame", nil, f)
	f.Indicator.Help: SetSize(145,33)
	f.Indicator.Help: SetPoint("TOP", f, "TOP", -31,-56)
	for i = 1,5 do
		f.Indicator[i] = f: CreateTexture(nil, "BACKGROUND")
		f.Indicator[i]: SetTexture(F.Media.."MinimapIcon"..i)
		f.Indicator[i]: SetSize(145,33)
		f.Indicator[i]: SetTexCoord(56/256, 201/256, 16/64,49/64)
		f.Indicator[i]: SetVertexColor(unpack(C.Color.White))
		f.Indicator[i]: SetAlpha(0.3)
		f.Indicator[i]: SetPoint("CENTER", f.Indicator.Help, "CENTER", 0,0)
	end
	
	--> 2 LFG
	f.Indicator.LFG = CreateFrame("Button", nil, f)
	f.Indicator.LFG: SetSize(32,22)
	f.Indicator.LFG: SetPoint("CENTER", f.Indicator.Help, "CENTER", -38, -4)
	f.Indicator.LFG: SetFrameLevel(f:GetFrameLevel()+10)
	f.Indicator.LFG.Tex = L.create_Texture(f.Indicator.LFG, "BORDER", "MinimapIconLFD", 52,52, 0,1,0,1, C.Color.White2,0.35, "CENTER", f.Indicator.LFG, "CENTER", 0,0)
	create_InstanceInfo(f.Indicator.LFG)
	
	--> 3 Mail
	f.Indicator.Mail = CreateFrame("Button", nil, f)
	f.Indicator.Mail: SetSize(32,22)
	f.Indicator.Mail: SetPoint("CENTER", f.Indicator.Help, "CENTER", -2,-1)
	f.Indicator.Mail: SetFrameLevel(f:GetFrameLevel()+10)
	f.Indicator.Mail.Tex = L.create_Texture(f, "BORDER", "MinimapIconEmail", 26,26, 0,1,0,1, C.Color.White2,0.35, "CENTER", f.Indicator.Mail, "CENTER", 0,0)
	
	f.Indicator.Mail: RegisterEvent("PLAYER_ENTERING_WORLD")
	f.Indicator.Mail: RegisterEvent("UPDATE_PENDING_MAIL")
	f.Indicator.Mail: SetScript("OnEvent", function(self,event)
		if ( HasNewMail() ) then
			self:Show()
			self.Tex: SetAlpha(0.9)
			self.Tex: SetVertexColor(unpack(C.Color.White))
			--f.Indicator[3]: SetAlpha(0.9)
			if( GameTooltip:IsOwned(self) ) then
				update_MinimapMailGameTooltip()
			end
		else
			self:Hide()
			self.Tex: SetAlpha(0.35)
			self.Tex: SetVertexColor(unpack(C.Color.White2))
			--self.Tex: SetAlpha(1)
			--self.Tex: SetVertexColor(unpack(C.Color.White))
			--f.Indicator[3]: SetAlpha(0.3)
		end
	end)
	f.Indicator.Mail: SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
		if(GameTooltip:IsOwned(self)) then
			update_MinimapMailGameTooltip()
		end
	end)
	f.Indicator.Mail: SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)
	
	--> 4 Icon Collect
	f.Indicator.iconCollect = CreateFrame("Button", "OwD_Icon_Collect", f)
	f.Indicator.iconCollect: SetSize(36,24)
	f.Indicator.iconCollect: SetPoint("CENTER", f.Indicator.Help, "CENTER", 36, 2)
	f.Indicator.iconCollect: SetFrameLevel(f:GetFrameLevel()+10)
	f.Indicator.iconCollect.Tex = L.create_Texture(f.Indicator.iconCollect, "BORDER", "MinimapIconCollect", 56,56, 0,1,0,1, C.Color.White2,0.4, "CENTER", f.Indicator.iconCollect, "CENTER", 0,0)
	
	f.Indicator.iconCollect: SetScript("OnMouseDown", function(self, button)
		if button == "LeftButton" then
			if f.Collect: IsVisible() then
				f.Collect: Hide()
			else
				pos_Collect(f)
				f.Collect: Show()
			end
		elseif button == "RightButton" then
			CollectButtons(f.Collect)
		end
	end)
	
	f.Indicator.iconCollect: SetScript("OnEnter", function(self)
		self.Tex: SetAlpha(0.9)
		self.Tex: SetVertexColor(unpack(C.Color.White))
	end)
	
	f.Indicator.iconCollect: SetScript("OnLeave", function(self)
		self.Tex: SetAlpha(0.4)
		self.Tex: SetVertexColor(unpack(C.Color.White2))
	end)
end

--- ----------------------------------------------------------------------------
--> Minimap     
--- ----------------------------------------------------------------------------
--[[
local update_Date = function(f)
	local weekday, month, day, year = CalendarGetDate()
	local dayColor = {}
	if weekday == 1 or weekday == 7 then
		dayColor = {255/255,  102/255,  132/255}
	else
		dayColor = {230/255, 232/255, 234/255}
	end
	
	local d1 = max(floor(day/10),0)
	local d2 = max(floor(day)-d1*10,0)
	--
	f.Clock.Num[6]: SetSize(Num_TopRight_20[d1][1], Num_TopRight_20[d1][2])
	f.Clock.Num[6]: SetTexCoord(Num_TopRight_20[d1][3],Num_TopRight_20[d1][4], Num_TopRight_20[d1][5],Num_TopRight_20[d1][6])
	f.Clock.Num[7]: SetSize(Num_TopRight_20[d2][1], Num_TopRight_20[d2][2])
	f.Clock.Num[7]: SetTexCoord(Num_TopRight_20[d2][3],Num_TopRight_20[d2][4], Num_TopRight_20[d2][5],Num_TopRight_20[d2][6])
	
	f.Clock.Num[6]: SetVertexColor(dayColor[1], dayColor[2], dayColor[3])
	f.Clock.Num[7]: SetVertexColor(dayColor[1], dayColor[2], dayColor[3])
end
--]]
L.OnEvent_Minimap = function(f, event)
	if event == "PLAYER_ENTERING_WORLD" then
		--update_Date(f)
		
	end
end

L.OnUpdate_Minimap_gap = function(f)
	if f then
		--date("%H:%M:%S")
		local hour, minute = GetGameTime()
		local dateInfo = date("*t")
		--hour, min, sec, wday(weekday), day, yday(yearday), mouth, year
		if hour ~= dateInfo.hour then
			hour, minute = dateInfo.hour, dateInfo.min
		end
		
		local h1 = max(floor(hour/10),0)
		local h2 = max(floor(hour)-h1*10,0)
		local m1 = max(floor(minute/10),0)
		local m2 = max(floor(minute)-m1*10,0)
		
		f.Clock.Num[1]: SetSize(Num_TopRight_20[h1][1], Num_TopRight_20[h1][2])
		f.Clock.Num[1]: SetTexCoord(Num_TopRight_20[h1][3],Num_TopRight_20[h1][4], Num_TopRight_20[h1][5],Num_TopRight_20[h1][6])
		f.Clock.Num[2]: SetSize(Num_TopRight_20[h2][1], Num_TopRight_20[h2][2])
		f.Clock.Num[2]: SetTexCoord(Num_TopRight_20[h2][3],Num_TopRight_20[h2][4], Num_TopRight_20[h2][5],Num_TopRight_20[h2][6])
		f.Clock.Num[4]: SetSize(Num_TopRight_20[m1][1], Num_TopRight_20[m1][2])
		f.Clock.Num[4]: SetTexCoord(Num_TopRight_20[m1][3],Num_TopRight_20[m1][4], Num_TopRight_20[m1][5],Num_TopRight_20[m1][6])
		f.Clock.Num[5]: SetSize(Num_TopRight_20[m2][1], Num_TopRight_20[m2][2])
		f.Clock.Num[5]: SetTexCoord(Num_TopRight_20[m2][3],Num_TopRight_20[m2][4], Num_TopRight_20[m2][5],Num_TopRight_20[m2][6])
		
		if hour == 0 and minute == 0 then
			--update_Date(f)
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
	f.mnMap = CreateFrame("Frame", "OwD_Minimap", UIParent)
	f.mnMap:SetSize(349,349)
	f.mnMap:SetScale(OwD_DB["OwD_MinimapScale"])
	f.mnMap:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -70,0)
	f.mnMap:SetFrameLevel((Minimap:GetFrameLevel())+2)
	f.mnMap:SetClampedToScreen(true)
		
	f.mnMap.Border = L.create_Texture(f.mnMap, "OVERLAY", "MinimapBorder", 311,42, 101/512,412/512,11/64,53/64, C.Color.White,0.7, "TOP", f.mnMap, "TOP", -23,-55)
	f.mnMap.Gloss = L.create_Texture(f.mnMap, "ARTWORK", "MinimapMaskGloss", 349,216, 82/512,431/512,19/256,235/256, C.Color.White,0.12, "CENTER", f.mnMap, "CENTER", 0,8)
	f.mnMap.BorderGloss = L.create_Texture(f.mnMap, "BACKGROUND", "MinimapBorderGloss", 355,222, 79/512,434/512,17/256,239/256, C.Color.White,0.16, "CENTER", f.mnMap, "CENTER", 0,8)
	
	Minimap:SetSize(347, 347)
	Minimap:SetScale(OwD_DB["OwD_MinimapScale"])
	Minimap:SetMaskTexture(F.Media.."MinimapMask")
	Minimap:SetHitRectInsets(0, 0, 50, 50)
	Minimap:SetFrameLevel(2)
	Minimap:ClearAllPoints()
	Minimap:SetPoint("CENTER", f.mnMap, "CENTER", 0,0)
	
	Minimap:SetPlayerTexture(F.Media.."MinimapArrow")
	
	MinimapCluster: ClearAllPoints()
	MinimapCluster: SetAllPoints(Minimap)
	MinimapCluster:	EnableMouse(false)
	
	--Minimap: IgnoreDepth(false)
	--Minimap: SetDepth(200)
	--Minimap:SetQuestBlobInsideTexture(F.Media.."Minimap_MaskExtra")
	--Minimap:SetQuestBlobOutsideTexture(F.Media.."Minimap_MaskExtra")
	--Minimap:SetQuestBlobOutsideSelectedTexture(F.Media.."Minimap_MaskExtra")
	Minimap:SetArchBlobRingScalar(0)
	--Minimap:SetQuestBlobRingTexture("")
	Minimap:SetQuestBlobRingScalar(0)
	
	--Minimap.QuestBlobFrame: SetAlpha(0.2)
	--[[
	for i, child in ipairs({Minimap:GetChildren()}) do
		local name = child:GetName()
		print(name)
	end
	--]]
	function GetMinimapShape() return "SQUARE" end
	
	-->>
	create_Indicator(f.mnMap)
	hide_Stuff()
	Mouse_Wheel()
	Icon_Collect(f.mnMap)
	create_Clock(f.mnMap)
	create_Location(f.mnMap)
	
	-->地下城按钮
	QueueStatusMinimapButton: SetParent(f.mnMap)
	QueueStatusMinimapButton: ClearAllPoints()
	QueueStatusMinimapButton.ClearAllPoints = function() end
	--QueueStatusMinimapButton: SetPoint("CENTER", f.mnMap.Indicator[2], "CENTER", -38, -4)
	QueueStatusMinimapButton: SetPoint("CENTER", f.mnMap.Indicator.LFG, "CENTER", 0, 0)
	QueueStatusMinimapButton: SetFrameStrata("HIGH")
	QueueStatusMinimapButton: SetFrameLevel(6)
	QueueStatusMinimapButton.SetPoint = function() end
	QueueStatusMinimapButtonBorder: Hide()
	
	QueueStatusMinimapButton: SetHighlightTexture("") 
	QueueStatusMinimapButtonIcon: SetSize(52,52)
	QueueStatusMinimapButtonIconTexture: SetTexture(F.Media.."OwDEye")
	
	
-->>Move Frames
	-->任务追踪
	ObjectiveTrackerFrame: ClearAllPoints()	
	ObjectiveTrackerFrame.ClearAllPoints = function() end
	ObjectiveTrackerFrame: SetPoint("TOPLEFT", UIParent, "TOPLEFT", 50,-20)
	ObjectiveTrackerFrame. SetPoint = function() end
	ObjectiveTrackerFrame: SetClampedToScreen(true)
	ObjectiveTrackerFrame: SetHeight(600)
	ObjectiveTrackerFrame: SetMovable(true)
	ObjectiveTrackerFrame: SetUserPlaced(true)
	
	f.mnMap.TrackerHelp = CreateFrame("Frame", nil, UIParent)
	f.mnMap.TrackerHelp: SetSize(ObjectiveTrackerFrame:GetWidth(),14)
	f.mnMap.TrackerHelp: SetPoint("BOTTOM", ObjectiveTrackerFrame, "TOP", 0,0)
	f.mnMap.TrackerHelp: SetClampedToScreen(true)
	--f.mnMap.TrackerHelp: SetMovable(true)
	f.mnMap.TrackerHelp: EnableMouse(true)
	--f.mnMap.TrackerHelp: SetUserPlaced(true)
	f.mnMap.TrackerHelp: RegisterForDrag("LeftButton")
	f.mnMap.TrackerHelp: SetScript("OnDragStart", function(self) ObjectiveTrackerFrame:StartMoving() end)
	f.mnMap.TrackerHelp: SetScript("OnDragStop", function(self) ObjectiveTrackerFrame:StopMovingOrSizing() end)
	f.mnMap.TrackerHelp: Hide()
	
	f.mnMap.TrackerHelp.Tex =  f.mnMap.TrackerHelp:CreateTexture(nil, "BACKGROUND")
	f.mnMap.TrackerHelp.Tex: SetTexture(F.Media.."Bar")
	f.mnMap.TrackerHelp.Tex: SetVertexColor(unpack(C.Color.Red))
	f.mnMap.TrackerHelp.Tex: SetAlpha(1)
	f.mnMap.TrackerHelp.Tex: SetAllPoints(f.mnMap.TrackerHelp)
	--f.mnMap.TrackerHelp.Tex: Hide()
	
	--f.mnMap.TrackerHelp: SetScript("OnEnter", function(self) f.mnMap.TrackerHelp.Tex:Show() end)
	--f.mnMap.TrackerHelp: SetScript("OnLeave", function(self) f.mnMap.TrackerHelp.Tex:Hide() end)
	
	
	
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
	GarrisonLandingPageMinimapButton: SetSize(38,38)
	--[[
	GarrisonLandingPageMinimapButton: SetParent(f.mnMap)
	GarrisonLandingPageMinimapButton: ClearAllPoints()
	GarrisonLandingPageMinimapButton.ClearAllPoints = function() end
	GarrisonLandingPageMinimapButton: SetPoint("BOTTOMLEFT", Minimap,"BOTTOMLEFT", 70,10)
	GarrisonLandingPageMinimapButton.SetPoint = function() end
	--]]
	-->Mail
	--[[
	MiniMapMailFrame: ClearAllPoints()
	--MiniMapMailFrame: SetPoint("TOPRIGHT", Minimap, -28, -30)
	MiniMapMailFrame: SetFrameStrata("HIGH")
	MiniMapMailIcon: SetTexture(F.Media.."Minimap\\Mail")
	MiniMapMailIcon: SetSize(32,32)
	MiniMapMailIcon: SetAlpha(0)
	MiniMapMailBorder: Hide()
	--]]
	
	
	
	Minimap:SetScript("OnEnter", function(self)
		--CollectButtons()
		--f.mnMap.Collect:Show()
		--Collect_Update(f.mnMap.Collect)
		f.mnMap.Location: Show()
	end)
	
	Minimap:SetScript("OnLeave", function(self)
		f.mnMap.Location: Hide()
	end)
	
	Minimap:SetScript("OnMouseUp", function(self, button)
		Minimap:StopMovingOrSizing()
		if (button == "LeftButton") then
			Minimap_OnClick(self)
		elseif (button == "RightButton") then
			--ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, self, (Minimap:GetWidth()*1),(Minimap:GetHeight()*1))
			ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, self, 0,80)
		elseif (button == "MiddleButton") then
			--ToggleCalendar()
		end
	end)
end

--[[

name, type, difficulty, difficultyName, maxPlayers, playerDifficulty, isDynamicInstance, mapID, instanceGroupSize = GetInstanceInfo()

Returns:

    name - Name of the instance or world area (string)

    type - Type of the instance (string)
        arena - A PvP Arena instance
        none - Normal world area (e.g. Northrend, Kalimdor, Deeprun Tram)
        party - An instance for 5-man groups
        pvp - A PvP battleground instance
        raid - An instance for raid groups
        scenario - A scenario instance

    difficulty - Difficulty setting of the instance (number)
        0 - None; not in an Instance.
        1 - 5-player Instance.
        2 - 5-player Heroic Instance.
        3 - 10-player Raid Instance.
        4 - 25-player Raid Instance.
        5 - 10-player Heroic Raid Instance.
        6 - 25-player Heroic Raid Instance.
        7 - 25-player Raid Finder Instance.
        8 - Challenge Mode Instance.
        9 - 40-player Raid Instance.
        10 - Not used.
        11 - Heroic Scenario Instance.
        12 - Scenario Instance.
        13 - Not used.
        14 - 10-30-player Normal Raid Instance.
        15 - 10-30-player Heroic Raid Instance.
        16 - 20-player Mythic Raid Instance .
        17 - 10-30-player Raid Finder Instance.
        18 - Unknown.
        19 - Unknown.
        20 - Unknown.

    difficultyName - String representing the difficulty of the instance. E.g. "10 Player" (string)

    maxPlayers - Maximum number of players allowed in the instance (number)

    playerDifficulty - Unknown (number)

    isDynamicInstance - True for raid instances that can support multiple maxPlayers values (10 and 25) - eg. ToC, DS, ICC, etc (boolean)

    mapID - (number)

    instanceGroupSize - maxPlayers for fixed size raids, holds the actual raid size for the new flexible raid (between (8?)10 and 25) (number)

	
	--
-- Dungeon Difficulty
--
                         
local IS_GUILD_GROUP;
 
function MiniMapInstanceDifficulty_OnEvent(self, event, ...)
    if ( event == "GUILD_PARTY_STATE_UPDATED" ) then
        local isGuildGroup = ...;
        if ( isGuildGroup ~= IS_GUILD_GROUP ) then
            IS_GUILD_GROUP = isGuildGroup;
            MiniMapInstanceDifficulty_Update();
        end
    elseif ( event == "PLAYER_DIFFICULTY_CHANGED") then
        MiniMapInstanceDifficulty_Update();
    elseif ( event == "UPDATE_INSTANCE_INFO" or event == "INSTANCE_GROUP_SIZE_CHANGED" ) then
        RequestGuildPartyState();
        MiniMapInstanceDifficulty_Update();
    elseif ( event == "PLAYER_GUILD_UPDATE" ) then
        local tabard = GuildInstanceDifficulty;
        SetSmallGuildTabardTextures("player", tabard.emblem, tabard.background, tabard.border);
        if ( IsInGuild() ) then
            RequestGuildPartyState();
        else
            IS_GUILD_GROUP = nil;
            MiniMapInstanceDifficulty_Update();
        end
    else
        RequestGuildPartyState();
    end
end
 
function MiniMapInstanceDifficulty_Update()
    local _, instanceType, difficulty, _, maxPlayers, playerDifficulty, isDynamicInstance, _, instanceGroupSize = GetInstanceInfo();
    local _, _, isHeroic, isChallengeMode = GetDifficultyInfo(difficulty);
 
    if ( IS_GUILD_GROUP ) then
        if ( instanceGroupSize == 0 ) then
            GuildInstanceDifficultyText:SetText("");
            GuildInstanceDifficultyDarkBackground:SetAlpha(0);
            GuildInstanceDifficulty.emblem:SetPoint("TOPLEFT", 12, -16);
        else
            GuildInstanceDifficultyText:SetText(instanceGroupSize);
            GuildInstanceDifficultyDarkBackground:SetAlpha(0.7);
            GuildInstanceDifficulty.emblem:SetPoint("TOPLEFT", 12, -10);
        end
        GuildInstanceDifficultyText:ClearAllPoints();
        if ( isHeroic or isChallengeMode ) then
            local symbolTexture;
            if ( isChallengeMode ) then
                symbolTexture = GuildInstanceDifficultyChallengeModeTexture;
                GuildInstanceDifficultyHeroicTexture:Hide();
            else
                symbolTexture = GuildInstanceDifficultyHeroicTexture;
                GuildInstanceDifficultyChallengeModeTexture:Hide();
            end
            -- the 1 looks a little off when text is centered
            if ( instanceGroupSize < 10 ) then
                symbolTexture:SetPoint("BOTTOMLEFT", 11, 7);
                GuildInstanceDifficultyText:SetPoint("BOTTOMLEFT", 23, 8);
            elseif ( instanceGroupSize > 19 ) then
                symbolTexture:SetPoint("BOTTOMLEFT", 8, 7);
                GuildInstanceDifficultyText:SetPoint("BOTTOMLEFT", 20, 8);
            else
                symbolTexture:SetPoint("BOTTOMLEFT", 8, 7);
                GuildInstanceDifficultyText:SetPoint("BOTTOMLEFT", 19, 8);
            end
            symbolTexture:Show();
        else
            GuildInstanceDifficultyHeroicTexture:Hide();
            GuildInstanceDifficultyChallengeModeTexture:Hide();
            GuildInstanceDifficultyText:SetPoint("BOTTOM", 2, 8);
        end
        MiniMapInstanceDifficulty:Hide();
        SetSmallGuildTabardTextures("player", GuildInstanceDifficulty.emblem, GuildInstanceDifficulty.background, GuildInstanceDifficulty.border);
        GuildInstanceDifficulty:Show();
        MiniMapChallengeMode:Hide();
    elseif ( isChallengeMode ) then
        MiniMapChallengeMode:Show();
        MiniMapInstanceDifficulty:Hide();
        GuildInstanceDifficulty:Hide();
    elseif ( instanceType == "raid" or isHeroic ) then
        MiniMapInstanceDifficultyText:SetText(instanceGroupSize);
        -- the 1 looks a little off when text is centered
        local xOffset = 0;
        if ( instanceGroupSize >= 10 and instanceGroupSize <= 19 ) then
            xOffset = -1;
        end
        if ( isHeroic ) then
            MiniMapInstanceDifficultyTexture:SetTexCoord(0, 0.25, 0.0703125, 0.4140625);
            MiniMapInstanceDifficultyText:SetPoint("CENTER", xOffset, -9);
        else
            MiniMapInstanceDifficultyTexture:SetTexCoord(0, 0.25, 0.5703125, 0.9140625);
            MiniMapInstanceDifficultyText:SetPoint("CENTER", xOffset, 5);
        end
        MiniMapInstanceDifficulty:Show();
        GuildInstanceDifficulty:Hide();
        MiniMapChallengeMode:Hide();
    else
        MiniMapInstanceDifficulty:Hide();
        GuildInstanceDifficulty:Hide();
        MiniMapChallengeMode:Hide();
    end
end
 
function GuildInstanceDifficulty_OnEnter(self)
    local guildName = GetGuildInfo("player");
    local _, instanceType, _, _, maxPlayers = GetInstanceInfo();
    local _, numGuildPresent, numGuildRequired, xpMultiplier = InGuildParty();
    -- hack alert
    if ( instanceType == "arena" ) then
        maxPlayers = numGuildRequired;
    end
    GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT", 8, 8);
    GameTooltip:SetText(GUILD_GROUP, 1, 1, 1);
    if ( xpMultiplier < 1 ) then
        GameTooltip:AddLine(string.format(GUILD_ACHIEVEMENTS_ELIGIBLE_MINXP, numGuildRequired, maxPlayers, guildName, xpMultiplier * 100), nil, nil, nil, 1);
    elseif ( xpMultiplier > 1 ) then
        GameTooltip:AddLine(string.format(GUILD_ACHIEVEMENTS_ELIGIBLE_MAXXP, guildName, xpMultiplier * 100), nil, nil, nil, 1);
    else
        if ( instanceType == "party" and maxPlayers == 5 ) then
            numGuildRequired = 4;
        end
        GameTooltip:AddLine(string.format(GUILD_ACHIEVEMENTS_ELIGIBLE, numGuildRequired, maxPlayers, guildName), nil, nil, nil, 1);
    end
    GameTooltip:Show();
end
	
	
--]]