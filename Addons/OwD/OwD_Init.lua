local addon, engine = ...

engine[1] = {}	-->C, Config
engine[2] = {}	-->F, Function
engine[3] = {}	-->L, Lib

OwD = engine	-->Allow other addons to use Engine

----------------------------------------------------------------------
--This should be at the top of every file inside of the Langley AddOn:	
--local C, F, L = unpack(select(2, ...))

--This is how another addon imports the Langley  engine:	
--local C, F, L = unpack(Langley)
----------------------------------------------------------------------

local C, F, L = unpack(select(2, ...))



--- ----------------------------------------------------------------------
--> Configure
--- ----------------------------------------------------------------------

--- ----------------------------------------------------------------------------
--> Locale
--- ----------------------------------------------------------------------------

local locale = GetLocale()
L.Text = {}
if locale == "zhCN" then
	L.Text["CONFIG_EXPLAIN"] = "Overwatch Display"
	L.Text["CONFIG_MOVEFRAME"] = "移动框体"
	L.Text["CONFIG_MOVEFRAME_EXPLAIN"] = "左键点击移动框体(拖动蓝色方块来移动框体)\n右键点击还原默认位置"
	L.Text["CONFIG_EXIT"] = "退出"
	L.Text["CONFIG_EXITE_EXPLAIN"] = "退出设置界面"
	L.Text["CONFIG_HIDEBLIZZARD"] = "暴雪默认头像"
	L.Text["CONFIG_HIDEBLIZZARD_EXPLAIN"] = "显示/隐藏暴雪默认头像(显示需重载界面)"
	L.Text["CONFIG_HIDETOPBOTTOMBORDER"] = "上下边框"
	L.Text["CONFIG_HIDETOPBOTTOMBORDER_EXPLAIN"] = "显示/隐藏上下装饰边框"
	L.Text["CONFIG_HIDEMINIMAP"] = "小地图"
	L.Text["CONFIG_HIDEMINIMAP_EXPLAIN"] = "隐藏小地图\n(注意：隐藏小地图后打不开设置界面)"
else
	L.Text["CONFIG_EXPLAIN"] = "Overwatch Display"
	L.Text["CONFIG_MOVEFRAME"] = "Move Frames"
	L.Text["CONFIG_MOVEFRAME_EXPLAIN"] = "Drag the blue square to move frame"
	L.Text["CONFIG_EXIT"] = "Exit"
	L.Text["CONFIG_EXITE_EXPLAIN"] = "Exit the config frame"
	L.Text["CONFIG_HIDEBLIZZARD"] = "Blizzard UnitFrames"
	L.Text["CONFIG_HIDEBLIZZARD_EXPLAIN"] = "Show/Hide Blizzard unitframes (need to reload UI)"
	L.Text["CONFIG_HIDETOPBOTTOMBORDER"] = "装饰边框"
	L.Text["CONFIG_HIDETOPBOTTOMBORDER_EXPLAIN"] = "显示/隐藏上下装饰边框"
	L.Text["CONFIG_HIDEMINIMAP"] = "小地图"
	L.Text["CONFIG_HIDEMINIMAP_EXPLAIN"] = "隐藏小地图\n(注意：隐藏小地图后打不开设置界面)"
end

---- ----------------------------------
-->> SavedVariables
---- ----------------------------------

L.DB = {
	["Pos"] = {
		["Player"] = {["x"] = -620, ["y"] = -320,},
		["FCS"] = {["y"] = -250,},
		["Minimap"] = {["x"] = -70, ["y"] = -20,},
	},
	["Hide_Blizzard"] = true,
	["Hide_TopBottomBorder"] = false,
	["Hide_Minimap"] = false,
}

OwD_DB = L.DB
local OwD_Config = CreateFrame("Frame", nil, UIParent)
OwD_Config:RegisterEvent("ADDON_LOADED")
OwD_Config:SetScript("OnEvent", function(self, event, addon)
	if addon == "OwD" then
		for key, value in pairs(L.DB) do
			if OwD_DB[key] == nil then
				if type(value) == "table" then
					OwD_DB[key] = {}
					for k, v in pairs(value) do
						OwD_DB[key][k] = value[k]
					end
				else
					OwD_DB[key] = value
				end
			end
		end
		L.Minimap(OwD)
		L.init_Config(OwD)
	end
end)

--- ----------------------------------------------------------------------
--> Texture
--- ----------------------------------------------------------------------

C.Tex = {
	["self"] =				"Interface\\Addons\\"..addon.."\\Media\\",
	["bar"] =				"Interface\\Addons\\"..addon.."\\Media\\Bar",
	["bg"] =				"Interface\\Addons\\"..addon.."\\Media\\Backdrop",
	["glow"] =				"Interface\\Addons\\"..addon.."\\Media\\glowTex",
	
	["Icon_1"] = 			"Interface\\Addons\\"..addon.."\\Media\\Icon_1",
	["Icon_2"] = 			"Interface\\Addons\\"..addon.."\\Media\\Icon_2",
	
	["Button_Hilight"] =	"Interface\\Addons\\"..addon.."\\Media\\ButtonHilight",
	
	["Chi"] =				"Interface\\Addons\\"..addon.."\\Media\\Point\\Chi",
	["Combo"] =				"Interface\\Addons\\"..addon.."\\Media\\Point\\Combo",
	
	["Minimap"] =			"Interface\\Addons\\"..addon.."\\Media\\Minimap\\",
}

C.Color = {
	["White"] =			{243/255, 244/255, 246/255},
	--["White2"] =		{119/255, 132/255, 144/255},
	["White2"] =		{154/255, 156/255, 162/255},
	["Gray"] =			{ 87/255,  96/255, 105/255},
	["Tapped"] =		{ 87/255,  96/255, 105/255},
	
	["Blue"] =			{ 51/255, 214/255, 255/255},
	["Blue2"] =			{ 31/255, 174/255, 255/255},
	
	["Green"] =			{192/255, 252/255, 226/255},
	["Green2"] =		{ 36/255, 227/255, 108/255},
	["Red"] =			{255/255,  29/255,  65/255},
	["Red0"] =			{255/255,  77/255, 105/255},
	["Yellow"] =		{253/255, 218/255,   4/255},
	["Yellow2"] =		{219/255, 140/255,  15/255},
	["Yellow3"] =		{205/255, 201/255,  125/255},
	--["Black"] =			{ 35/255,  15/255,  43/255},
	["Black"] =			{0.09, 0.09, 0.09},
	["Black2"] =			{ 52/255, 48/255, 78/255},
	
	["Class"] = {
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
	},
	["Power"] = {},
	{0/255, 246/255, 14/255},
}

for power, color in next, PowerBarColor do
	if (type(power) == "string") then
		C.Color.Power[power] = {color.r, color.g, color.b}
	end
end
C.Color.Power[0] = C.Color.Power["MANA"]
C.Color.Power[1] = C.Color.Power["RAGE"]
C.Color.Power[2] = C.Color.Power["FOCUS"]
C.Color.Power[3] = C.Color.Power["ENERGY"]
C.Color.Power[4] = C.Color.Power["CHI"]
C.Color.Power[5] = C.Color.Power["RUNES"]
C.Color.Power[6] = C.Color.Power["RUNIC_POWER"]
C.Color.Power[7] = C.Color.Power["SOUL_SHARDS"]
C.Color.Power[8] = C.Color.Power["ECLIPSE"]
C.Color.Power[9] = C.Color.Power["HOLY_POWER"]

C.Font = {
	["Name"] = 			"Interface\\Addons\\"..addon.."\\Media\\Fonts\\Hiragino Sans GB W6.ttf",
	["Num"] =			"Interface\\Addons\\"..addon.."\\Media\\Fonts\\Hiragino Sans GB W6.ttf",
	["Num2"] =			"Interface\\Addons\\"..addon.."\\Media\\Fonts\\BigNoodleTitling.ttf",
}

--- ----------------------------------------------------------------------
--> Slash
--- ----------------------------------------------------------------------

-->> Reload UI
SLASH_RELOADUI1 = "/rl"
SlashCmdList.RELOADUI = ReloadUI

-->> Calendar
SlashCmdList["CALENDAR"] = function()
	ToggleCalendar()
end
SLASH_CALENDAR1 = "/cl"
SLASH_CALENDAR2 = "/calendar"

--- ----------------------------------------------------------------------
--> Function
--- ----------------------------------------------------------------------

-->>Lua APIs
local min = math.min
local max = math.max
local format = string.format
local floor = math.floor
local sqrt = math.sqrt
local sin = math.sin
local cos = math.cos
local rad = math.rad

F.Media = "Interface\\Addons\\"..addon.."\\Media\\"

F.Debug = 0.000001

F.rEvent = function(f, event)
	for i = 1,#event do
		f:RegisterEvent(event[i])
	end
end

F.ShortValue = function(value)
	if value >= 1e6 then
		return ("%.2fm"):format(value / 1e6):gsub("%.?0+([km])$", "%1")
	elseif value >= 1e3 or value <= -1e3 then
		return ("%.1fk"):format(value / 1e3):gsub("%.?+([km])$", "%1")
	else
		return value
	end
end

F.CheckEvent = function(f,event,unit1,unit2)
	local registered = f:IsEventRegistered(event)
	if not registered then
		if unit2 then
			f:RegisterUnitEvent(event, unit1, unit2)
		elseif unit1 then
			f:RegisterUnitEvent(event, unit1)
		else
			f:RegisterEvent(event)
		end
	end
end

F.Hex = function(rgb)
	local r,g,b = rgb[1],rgb[2],rgb[3]
	return format("|cff%02x%02x%02x",r*255,g*255,b*255)
end

F.Gradient = function(perc,a,b)
	perc = perc > 1 and 1 or perc < 0 and 0 or perc -- Stay between 0-1
	local r1,g1,b1,r2,g2,b2 = a[1],a[2],a[3],b[1],b[2],b[3]
	local r = r1+(r2-r1)*perc
	local g = g1+(g2-g1)*perc
	local b = b1+(b2-b1)*perc
	return r,g,b
end

-->>获取帧数
F.FrameRate = function()
	if GetFramerate() >= 60 then
		return 60 
	else 
		return GetFramerate()
	end
end

-->>同步闪烁
F.Alpha = 0
local Transfer = 0
local flash = CreateFrame("Frame", nil, UIParent)
flash:SetScript("OnUpdate",function(self)
	local step = floor(1/(GetFramerate() * 0.4)*1e3)/1e3
	if Transfer == 0 then
		F.Alpha = F.Alpha + step
	elseif Transfer == 1 then
		F.Alpha = F.Alpha - step
	else
		F.Alpha = 0
		Transfer = 0
	end
	if F.Alpha <= 0 then
		F.Alpha = 0
		Transfer = 0
	elseif F.Alpha >= 1 then
		F.Alpha = 1
		Transfer = 1
	end
end)

F.FadeIn = function(f, t, a1, a2)
	if f:GetAlpha() == a1 then
		UIFrameFadeIn(f, t, a1, a2)
	end
end

F.FadeOut = function(f, t, a1, a2)
	if f:GetAlpha() == a1 then
		UIFrameFadeOut(f, t, a1, a2)
	end
end

--- ----------------------------------------------------------------------
--> Ring
--- ----------------------------------------------------------------------

local function CalculateCorner(angle)
	local radian = rad(angle);
	return 0.5 + cos(radian) / sqrt(2), 0.5 + sin(radian) / sqrt(2);
end
--
F.RotateTexture = function(texture, angle)
	local LRx, LRy = CalculateCorner(angle + 45);
	local LLx, LLy = CalculateCorner(angle + 135);
	local ULx, ULy = CalculateCorner(angle + 225);
	local URx, URy = CalculateCorner(angle - 45);

	texture: SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy);
	--print(rad(angle),ULx,ULy)
end
--[[
F.RotateTexture = function(self, degrees)
	local angle = math.rad(degrees)
	local cos, sin = math.cos(angle), math.sin(angle)
	self:SetTexCoord((sin - cos), -(cos + sin), -cos, -sin, sin, -cos, 0, 0)
end
--]]
-->>
F.Ring_Update = function(f, angle)
    local segmentsize = f.segmentsize
    local outer_radius = f.outer_radius
    local difference = segmentsize-outer_radius
    local inner_radius = f.inner_radius
    local ring_factor = outer_radius/inner_radius
    local ring_width = outer_radius-inner_radius

    local Arad = math.rad(angle)

    local Nx = 0
    local Ny = 0
    local Mx = segmentsize
    local My = segmentsize
    
    local Ix,Iy,Ox,Oy
    local IxCoord, IyCoord, OxCoord, OyCoord, NxCoord, NyCoord, MxCoord, MyCoord
    local sq1_c1_x, sq1_c1_y, sq1_c2_x, sq1_c2_y, sq1_c3_x, sq1_c3_y, sq1_c4_x, sq1_c4_y
    local sq2_c1_x, sq2_c1_y, sq2_c2_x, sq2_c2_y, sq2_c3_x, sq2_c3_y, sq2_c4_x, sq2_c4_y

    
    if f.Direction == 0 then
		Ix = inner_radius * math.cos(Arad)
		Iy = (outer_radius - (inner_radius * math.sin(Arad))) + difference
		Ox = outer_radius * math.cos(Arad)
		Oy = (outer_radius - (outer_radius * math.sin(Arad))) + difference
		IxCoord = Ix / segmentsize 
		IyCoord = Iy / segmentsize
		OxCoord = Ox / segmentsize
		OyCoord = Oy / segmentsize   
		NxCoord = Nx / segmentsize
		NyCoord = Ny / segmentsize
		MxCoord = Mx / segmentsize
		MyCoord = My / segmentsize
   	   
		sq1_c1_x = IxCoord
		sq1_c1_y = IyCoord
		sq1_c2_x = IxCoord
		sq1_c2_y = MyCoord
		sq1_c3_x = MxCoord
		sq1_c3_y = IyCoord
		sq1_c4_x = MxCoord
		sq1_c4_y = MyCoord
		      
		sq2_c1_x = OxCoord
		sq2_c1_y = OyCoord
		sq2_c2_x = OxCoord
		sq2_c2_y = IyCoord
		sq2_c3_x = MxCoord
		sq2_c3_y = OyCoord
		sq2_c4_x = MxCoord
		sq2_c4_y = IyCoord
		
		if f.Interval == 1 then
			f.t0:ClearAllPoints()
			f.t1:ClearAllPoints()
			f.t2:ClearAllPoints()
			f.t0:SetPoint("TOPLEFT", f, "TOP", Ix,-Iy)
			f.t0:SetWidth(segmentsize-Ix)
			f.t0:SetHeight(segmentsize-Iy)
			f.t1:SetPoint("TOPLEFT", f, "TOP", Ox,-Oy)
			f.t1:SetWidth(segmentsize-Ox)
			f.t1:SetHeight(Iy-Oy)
			f.t2:SetPoint("TOPLEFT", f, "TOP", Ix,-Oy)
			f.t2:SetWidth(Ox-Ix)
			f.t2:SetHeight(Iy-Oy)
			if (f.t4) then
				f.t3:ClearAllPoints()
				f.t4:ClearAllPoints()
				f.t3:SetPoint("TOPLEFT", f, "TOP", Ix,-Iy)
				f.t3:SetWidth(segmentsize-Ix)
				f.t3:SetHeight(segmentsize-Iy)
				f.t4:SetPoint("TOPLEFT", f, "TOP", Ox,-Oy)
				f.t4:SetWidth(segmentsize-Ox)
				f.t4:SetHeight(Iy-Oy)
			end
		elseif f.Interval == 2 then
			f.t0:ClearAllPoints()
			f.t1:ClearAllPoints()
			f.t2:ClearAllPoints()
			f.t0:SetPoint("BOTTOMLEFT", f, "LEFT", Iy,Ix)
			f.t0:SetWidth(segmentsize-Iy)
			f.t0:SetHeight(segmentsize-Ix)
			f.t1:SetPoint("BOTTOMLEFT", f, "LEFT",Oy,Ox)
			f.t1:SetWidth(Iy-Oy)
			f.t1:SetHeight(segmentsize-Ox)
			f.t2:SetPoint("BOTTOMLEFT", f, "LEFT",Oy,Ix)
			f.t2:SetWidth(Iy-Oy)
			f.t2:SetHeight(Ox-Ix)
			f.t2:SetTexCoord(1,0, 0,0, 1,1, 0,1)
			if (f.t4) then
				f.t3:ClearAllPoints()
				f.t4:ClearAllPoints()
				f.t3:SetPoint("BOTTOMLEFT", f, "LEFT", Iy,Ix)
				f.t3:SetWidth(segmentsize-Iy)
				f.t3:SetHeight(segmentsize-Ix)
				f.t4:SetPoint("BOTTOMLEFT", f, "LEFT",Oy,Ox)
				f.t4:SetWidth(Iy-Oy)
				f.t4:SetHeight(segmentsize-Ox)
			end
		elseif f.Interval == 3 then
			f.t0:ClearAllPoints()
			f.t1:ClearAllPoints()
			f.t2:ClearAllPoints()
			f.t0:SetPoint("BOTTOMRIGHT", f, "BOTTOM", -Ix,Iy)
			f.t0:SetWidth(segmentsize-Ix)
			f.t0:SetHeight(segmentsize-Iy)
			f.t1:SetPoint("BOTTOMRIGHT", f, "BOTTOM", -Ox,Oy)
			f.t1:SetWidth(segmentsize-Ox)
			f.t1:SetHeight(Iy-Oy)
			f.t2:SetPoint("BOTTOMRIGHT", f, "BOTTOM", -Ix,Oy)
			f.t2:SetWidth(Ox-Ix)
			f.t2:SetHeight(Iy-Oy)
			f.t2:SetTexCoord(1,1, 1,0, 0,1, 0,0)
			if (f.t4) then
				f.t3:ClearAllPoints()
				f.t4:ClearAllPoints()
				f.t3:SetPoint("BOTTOMRIGHT", f, "BOTTOM", -Ix,Iy)
				f.t3:SetWidth(segmentsize-Ix)
				f.t3:SetHeight(segmentsize-Iy)
				f.t4:SetPoint("BOTTOMRIGHT", f, "BOTTOM", -Ox,Oy)
				f.t4:SetWidth(segmentsize-Ox)
				f.t4:SetHeight(Iy-Oy)
			end
		elseif f.Interval == 4 then
			f.t0:ClearAllPoints()
			f.t1:ClearAllPoints()
			f.t2:ClearAllPoints()
			f.t0:SetPoint("TOPRIGHT", f, "RIGHT", -Iy,-Ix)
			f.t0:SetWidth(segmentsize-Iy)
			f.t0:SetHeight(segmentsize-Ix)
			f.t1:SetPoint("TOPRIGHT", f, "RIGHT", -Oy,-Ox)
			f.t1:SetWidth(Iy-Oy)
			f.t1:SetHeight(segmentsize-Ox)
			f.t2:SetPoint("TOPRIGHT", f, "RIGHT", -Oy,-Ix)
			f.t2:SetWidth(Iy-Oy)
			f.t2:SetHeight(Ox-Ix)
			f.t2:SetTexCoord(0,1, 1,1, 0,0, 1,0)
			if (f.t4) then
				f.t3:ClearAllPoints()
				f.t4:ClearAllPoints()
				f.t3:SetPoint("TOPRIGHT", f, "RIGHT", -Iy,-Ix)
				f.t3:SetWidth(segmentsize-Iy)
				f.t3:SetHeight(segmentsize-Ix)
				f.t4:SetPoint("TOPRIGHT", f, "RIGHT", -Oy,-Ox)
				f.t4:SetWidth(Iy-Oy)
				f.t4:SetHeight(segmentsize-Ox)
			end
		end
		
	elseif f.Direction == 1 then
		Ix = inner_radius * math.sin(Arad)
		Iy = (outer_radius - (inner_radius * math.cos(Arad))) + difference
		Ox = outer_radius * math.sin(Arad)
		Oy = (outer_radius - (outer_radius * math.cos(Arad))) + difference
		IxCoord = Ix / segmentsize 
		IyCoord = Iy / segmentsize
		OxCoord = Ox / segmentsize
		OyCoord = Oy / segmentsize   
		NxCoord = Nx / segmentsize
		NyCoord = Ny / segmentsize
		MxCoord = Nx / segmentsize
		MyCoord = Ny / segmentsize
		
		sq1_c1_x = NxCoord
		sq1_c1_y = NyCoord
		sq1_c2_x = NxCoord
		sq1_c2_y = IyCoord
		sq1_c3_x = IxCoord
		sq1_c3_y = NyCoord
		sq1_c4_x = IxCoord
		sq1_c4_y = IyCoord
		
		sq2_c1_x = IxCoord
		sq2_c1_y = NyCoord
		sq2_c2_x = IxCoord
		sq2_c2_y = OyCoord
		sq2_c3_x = OxCoord
		sq2_c3_y = NyCoord
		sq2_c4_x = OxCoord
		sq2_c4_y = OyCoord
		
		if f.Interval == 1 then
			f.t0:ClearAllPoints()
			f.t1:ClearAllPoints()
			f.t2:ClearAllPoints()
			f.t0:SetPoint("TOPLEFT", f, "TOP", Nx,-Ny)
			f.t0:SetWidth(Ix)
			f.t0:SetHeight(Iy)
			f.t1:SetPoint("TOPLEFT", f, "TOP", Ix,-Ny)
			f.t1:SetWidth(Ox-Ix)
			f.t1:SetHeight(Oy)
			f.t2:SetPoint("TOPLEFT", f, "TOP", Ix,-Oy)
			f.t2:SetWidth(Ox-Ix)
			f.t2:SetHeight(Iy-Oy)
			f.t2:SetTexCoord(0,0, 0,1, 1,0, 1,1)
			if (f.t4) then
				f.t3:ClearAllPoints()
				f.t4:ClearAllPoints()
				f.t3:SetPoint("TOPLEFT", f, "TOP", Nx,-Ny)
				f.t3:SetWidth(Ix)
				f.t3:SetHeight(Iy)
				f.t4:SetPoint("TOPLEFT", f, "TOP", Ix,-Ny)
				f.t4:SetWidth(Ox-Ix)
				f.t4:SetHeight(Oy)
			end
		elseif f.Interval == 2 then
			f.t0:ClearAllPoints()
			f.t1:ClearAllPoints()
			f.t2:ClearAllPoints()
			f.t0:SetPoint("BOTTOMLEFT", f, "LEFT", Nx,Ny)
			f.t0:SetWidth(Iy)
			f.t0:SetHeight(Ix)
			f.t1:SetPoint("BOTTOMLEFT", f, "LEFT", Ny,Ix)
			f.t1:SetWidth(Oy)
			f.t1:SetHeight(Ox-Ix)
			f.t2:SetPoint("BOTTOMLEFT", f, "LEFT", Oy,Ix)
			f.t2:SetWidth(Iy-Oy)
			f.t2:SetHeight(Ox-Ix)
			f.t2:SetTexCoord(1,0, 0,0, 1,1, 0,1)
			if (f.t4) then
				f.t3:ClearAllPoints()
				f.t4:ClearAllPoints()
				f.t3:SetPoint("BOTTOMLEFT", f, "LEFT", Nx,Ny)
				f.t3:SetWidth(Iy)
				f.t3:SetHeight(Ix)
				f.t4:SetPoint("BOTTOMLEFT", f, "LEFT", Ny,Ix)
				f.t4:SetWidth(Oy)
				f.t4:SetHeight(Ox-Ix)
			end
		elseif f.Interval == 3 then
			f.t0:ClearAllPoints()
			f.t1:ClearAllPoints()
			f.t2:ClearAllPoints()
			f.t0:SetPoint("BOTTOMRIGHT", f, "BOTTOM", Nx,Ny)
			f.t0:SetWidth(Ix)
			f.t0:SetHeight(Iy)
			f.t1:SetPoint("BOTTOMRIGHT", f, "BOTTOM", -Ix,Ny)
			f.t1:SetWidth(Ox-Ix)
			f.t1:SetHeight(Oy)
			f.t2:SetPoint("BOTTOMRIGHT", f, "BOTTOM", -Ix,Oy)
			f.t2:SetWidth(Ox-Ix)
			f.t2:SetHeight(Iy-Oy)
			f.t2:SetTexCoord(1,1, 1,0, 0,1, 0,0)
			if (f.t4) then
				f.t3:ClearAllPoints()
				f.t4:ClearAllPoints()
				f.t3:SetPoint("BOTTOMRIGHT", f, "BOTTOM", Nx,Ny)
				f.t3:SetWidth(Ix)
				f.t3:SetHeight(Iy)
				f.t4:SetPoint("BOTTOMRIGHT", f, "BOTTOM", -Ix,Ny)
				f.t4:SetWidth(Ox-Ix)
				f.t4:SetHeight(Oy)
			end
		elseif f.Interval == 4 then
			f.t0:ClearAllPoints()
			f.t1:ClearAllPoints()
			f.t2:ClearAllPoints()
			f.t0:SetPoint("TOPRIGHT", f, "RIGHT", Nx,Ny)
			f.t0:SetWidth(Iy)
			f.t0:SetHeight(Ix)
			f.t1:SetPoint("TOPRIGHT", f, "RIGHT", Ny,-Ix)
			f.t1:SetWidth(Oy)
			f.t1:SetHeight(Ox-Ix)
			f.t2:SetPoint("TOPRIGHT", f, "RIGHT", -Oy,-Ix)
			f.t2:SetWidth(Iy-Oy)
			f.t2:SetHeight(Ox-Ix)
			f.t2:SetTexCoord(0,1, 1,1, 0,0, 1,0)
			if (f.t4) then
				f.t3:ClearAllPoints()
				f.t4:ClearAllPoints()
				f.t3:SetPoint("TOPRIGHT", f, "RIGHT", Nx,Ny)
				f.t3:SetWidth(Iy)
				f.t3:SetHeight(Ix)
				f.t4:SetPoint("TOPRIGHT", f, "RIGHT", Ny,-Ix)
				f.t4:SetWidth(Oy)
				f.t4:SetHeight(Ox-Ix)
			end
		end
	end

	if f.Interval == 1 then
		f.t0:SetTexCoord(sq1_c1_x,sq1_c1_y, sq1_c2_x,sq1_c2_y, sq1_c3_x,sq1_c3_y, sq1_c4_x, sq1_c4_y)
		f.t1:SetTexCoord(sq2_c1_x,sq2_c1_y, sq2_c2_x,sq2_c2_y, sq2_c3_x,sq2_c3_y, sq2_c4_x, sq2_c4_y)
		if (f.t4) then
			f.t3:SetTexCoord(sq1_c1_x,sq1_c1_y, sq1_c2_x,sq1_c2_y, sq1_c3_x,sq1_c3_y, sq1_c4_x, sq1_c4_y)
			f.t4:SetTexCoord(sq2_c1_x,sq2_c1_y, sq2_c2_x,sq2_c2_y, sq2_c3_x,sq2_c3_y, sq2_c4_x, sq2_c4_y)
		end
	elseif f.Interval == 2 then
		f.t0:SetTexCoord(sq1_c3_x,sq1_c3_y, sq1_c1_x,sq1_c1_y, sq1_c4_x, sq1_c4_y, sq1_c2_x,sq1_c2_y)
		f.t1:SetTexCoord(sq2_c3_x,sq2_c3_y, sq2_c1_x,sq2_c1_y, sq2_c4_x, sq2_c4_y, sq2_c2_x,sq2_c2_y)
		if (f.t4) then
			f.t3:SetTexCoord(sq1_c3_x,sq1_c3_y, sq1_c1_x,sq1_c1_y, sq1_c4_x, sq1_c4_y, sq1_c2_x,sq1_c2_y)
			f.t4:SetTexCoord(sq2_c3_x,sq2_c3_y, sq2_c1_x,sq2_c1_y, sq2_c4_x, sq2_c4_y, sq2_c2_x,sq2_c2_y)
		end
	elseif f.Interval == 3 then
		f.t0:SetTexCoord(sq1_c4_x, sq1_c4_y, sq1_c3_x,sq1_c3_y, sq1_c2_x,sq1_c2_y, sq1_c1_x,sq1_c1_y)
		f.t1:SetTexCoord(sq2_c4_x, sq2_c4_y, sq2_c3_x,sq2_c3_y, sq2_c2_x,sq2_c2_y, sq2_c1_x,sq2_c1_y)
		if (f.t4) then
			f.t3:SetTexCoord(sq1_c4_x, sq1_c4_y, sq1_c3_x,sq1_c3_y, sq1_c2_x,sq1_c2_y, sq1_c1_x,sq1_c1_y)
			f.t4:SetTexCoord(sq2_c4_x, sq2_c4_y, sq2_c3_x,sq2_c3_y, sq2_c2_x,sq2_c2_y, sq2_c1_x,sq2_c1_y)
		end
	elseif f.Interval ==4 then
		f.t0:SetTexCoord(sq1_c2_x,sq1_c2_y, sq1_c4_x, sq1_c4_y, sq1_c1_x,sq1_c1_y, sq1_c3_x,sq1_c3_y)
		f.t1:SetTexCoord(sq2_c2_x,sq2_c2_y, sq2_c4_x, sq2_c4_y, sq2_c1_x,sq2_c1_y, sq2_c3_x,sq2_c3_y)
		if (f.t4) then
			f.t3:SetTexCoord(sq1_c2_x,sq1_c2_y, sq1_c4_x, sq1_c4_y, sq1_c1_x,sq1_c1_y, sq1_c3_x,sq1_c3_y)
			f.t4:SetTexCoord(sq2_c2_x,sq2_c2_y, sq2_c4_x, sq2_c4_y, sq2_c1_x,sq2_c1_y, sq2_c3_x,sq2_c3_y)
		end
	end
end