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
--> Unit
--- ----------------------------------------------------------------------------
--SecureUnitButtonTemplate

local init_Unit = function(f,unit)
	f: RegisterForClicks("AnyDown")
	
	f: SetAttribute("unit", unit)
	f: SetAttribute("*type1", "target")
	f: SetAttribute("ctrl-type1", "focus")
	f: SetAttribute("*type2", "togglemenu")
	f: SetAttribute("toggleForVehicle", true)
	RegisterUnitWatch(f)
end

L.create_Unit = function(f)
	f.PlayerButton = CreateFrame("Button", "OwD.PlayerButton", UIParent, "SecureUnitButtonTemplate")
	f.PlayerButton: SetSize(98,113)
	init_Unit(f.PlayerButton, f.Player.unit)
	f.PlayerButton:SetScale(OwD_DB["OwD_Scale"])
	
	f.PetButton = CreateFrame("Button", "OwD.PetButton", UIParent, "SecureUnitButtonTemplate")
	f.PetButton: SetSize(126, 32)
	f.PetButton: SetPoint("BOTTOMLEFT", f.PlayerButton, "BOTTOMLEFT", 410,58)
	init_Unit(f.PetButton, f.Pet.unit)
	f.PetButton:SetScale(OwD_DB["OwD_Scale"])
	
	f.TargetButton = CreateFrame("Button", "OwD.TargetButton", UIParent, "SecureUnitButtonTemplate")
	f.TargetButton: SetSize(390,30)
	init_Unit(f.TargetButton, f.Target.unit)
	f.TargetButton: SetScale(OwD_DB["OwD_Scale"])
	
	f.ToTButton = CreateFrame("Button", "OwD.ToTButton", UIParent, "SecureUnitButtonTemplate")
	f.ToTButton: SetSize(120,20)
	f.ToTButton: SetPoint("TOPLEFT", f.TargetButton, "BOTTOMRIGHT", 30, 0)
	init_Unit(f.ToTButton, f.ToT.unit)
	f.ToTButton: SetScale(OwD_DB["OwD_Scale"])
	
	f.FocusButton = CreateFrame("Button", "OwD.FocusButton", UIParent, "SecureUnitButtonTemplate")
	f.FocusButton: SetSize(140,24)
	init_Unit(f.FocusButton, f.Focus.unit)
	f.FocusButton: SetScale(OwD_DB["OwD_Scale"])
	
	f.ToFButton = CreateFrame("Button", "OwD.ToFButton", UIParent, "SecureUnitButtonTemplate")
	f.ToFButton: SetSize(140,24)
	f.ToFButton: SetPoint("BOTTOMRIGHT", f.FocusButton, "TOP", 0, 100)
	init_Unit(f.ToFButton, f.ToF.unit)
	f.ToFButton: SetScale(OwD_DB["OwD_Scale"])
end

--- ----------------------------------------------------------------------------
--> Hide Blizzard
--- ----------------------------------------------------------------------------
--> from oUF
local hiddenParent = CreateFrame("Frame")
hiddenParent:Hide()

local HandleFrame = function(baseName)
	local frame
	if(type(baseName) == 'string') then
		frame = _G[baseName]
	else
		frame = baseName
	end

	if(frame) then
		frame:UnregisterAllEvents()
		frame:Hide()

		-- Keep frame hidden without causing taint
		frame:SetParent(hiddenParent)

		local health = frame.healthbar
		if(health) then
			health:UnregisterAllEvents()
		end

		local power = frame.manabar
		if(power) then
			power:UnregisterAllEvents()
		end

		local spell = frame.spellbar
		if(spell) then
			spell:UnregisterAllEvents()
		end

		local altpowerbar = frame.powerBarAlt
		if(altpowerbar) then
			altpowerbar:UnregisterAllEvents()
		end
	end
end

L.Disable_Blizzard = function()
	if OwD_DB.Hide_Blizzard then
		HandleFrame(PlayerFrame)
		-- For the damn vehicle support:
		PlayerFrame:RegisterEvent('PLAYER_ENTERING_WORLD')
		PlayerFrame:RegisterEvent('UNIT_ENTERING_VEHICLE')
		PlayerFrame:RegisterEvent('UNIT_ENTERED_VEHICLE')
		PlayerFrame:RegisterEvent('UNIT_EXITING_VEHICLE')
		PlayerFrame:RegisterEvent('UNIT_EXITED_VEHICLE')
		PlayerFrame:SetUserPlaced(true)
		PlayerFrame:SetDontSavePosition(true)
		
		HandleFrame(PetFrame)
		
		HandleFrame(TargetFrame)
		HandleFrame(ComboFrame)
		--HandleFrame(TargetFrameToT)
		
		HandleFrame(FocusFrame)
		--HandleFrame(TargetofFocusFrame)
	end
end

--- ----------------------------------------------------------------------------
--> Config
--- ----------------------------------------------------------------------------

--> Move Frames
local floor_Position = function()
	OwD_DB.Pos.Player.x = floor(OwD_DB.Pos.Player.x + 0.5)
	OwD_DB.Pos.Player.y = floor(OwD_DB.Pos.Player.y + 0.5)
	
	OwD_DB.Pos.Target.y = floor(OwD_DB.Pos.Target.y + 0.5)
	
	OwD_DB.Pos.Focus.x = floor(OwD_DB.Pos.Focus.x + 0.5)
	OwD_DB.Pos.Focus.y = floor(OwD_DB.Pos.Focus.y + 0.5)
	
	OwD_DB.Pos.FCS.y = floor(OwD_DB.Pos.FCS.y + 0.5)
	
	OwD_DB.Pos.Bar.y = floor(OwD_DB.Pos.Bar.y + 0.5)
	
	OwD_DB.Pos.Minimap.x = floor(OwD_DB.Pos.Minimap.x + 0.5)
	OwD_DB.Pos.Minimap.y = floor(OwD_DB.Pos.Minimap.y + 0.5)
	
	OwD_DB.Pos.AuraWatch.x = floor(OwD_DB.Pos.AuraWatch.x + 0.5)
	OwD_DB.Pos.AuraWatch.y = floor(OwD_DB.Pos.AuraWatch.y + 0.5)
	
	OwD_DB.Pos.BuffFrame.x = floor(OwD_DB.Pos.BuffFrame.x + 0.5)
	OwD_DB.Pos.BuffFrame.y = floor(OwD_DB.Pos.BuffFrame.y + 0.5)
end

local pos_Frame = function(f)
	f.Player: ClearAllPoints()
	f.Player: SetPoint("BOTTOMLEFT", f, "CENTER", OwD_DB.Pos.Player.x, OwD_DB.Pos.Player.y)
	f.PlayerButton: ClearAllPoints()
	f.PlayerButton: SetPoint("BOTTOMLEFT", f, "CENTER", OwD_DB.Pos.Player.x, OwD_DB.Pos.Player.y)
	
	f.Target: Show()
	f.Target: ClearAllPoints()
	f.Target: SetPoint("TOP", UIParent, "TOP", 0, OwD_DB.Pos.Target.y)
	f.TargetButton: ClearAllPoints()
	f.TargetButton: SetPoint("TOP", UIParent, "TOP", 0, OwD_DB.Pos.Target.y)
	f.Target: Hide()
	
	f.Focus: Show()
	f.Focus: ClearAllPoints()
	f.Focus: SetPoint("CENTER", f, "CENTER", OwD_DB.Pos.Focus.x, OwD_DB.Pos.Focus.y)
	f.FocusButton: ClearAllPoints()
	f.FocusButton: SetPoint("CENTER", f, "CENTER", OwD_DB.Pos.Focus.x, OwD_DB.Pos.Focus.y)
	f.Focus: Hide()
	
	f.Right: ClearAllPoints()
	f.Right: SetPoint("BOTTOMRIGHT", f, "CENTER", -OwD_DB.Pos.Player.x, OwD_DB.Pos.Player.y)
	
	
	f.Right.Icon.Help: ClearAllPoints()
	f.Right.Icon.Help: SetPoint("TOPRIGHT", f.Right, "TOPRIGHT", OwD_DB.Pos.AuraWatch.x, -4/63 * OwD_DB.Pos.AuraWatch.x)
	
	f.FCS: ClearAllPoints()
	f.FCS: SetPoint("CENTER", f, "CENTER", 0, OwD_DB.Pos.FCS.y)
	
	f.ActionBar: ClearAllPoints()
	f.ActionBar: SetPoint("CENTER", f, "CENTER", 0, OwD_DB.Pos.Bar.y)
	
	f.mnMap: ClearAllPoints()
	f.mnMap: SetPoint("CENTER", UIParent, "TOPRIGHT", OwD_DB.Pos.Minimap.x,OwD_DB.Pos.Minimap.y)
	
	f.AuraFrame: ClearAllPoints()
	f.AuraFrame: SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", OwD_DB.Pos.BuffFrame.x, OwD_DB.Pos.BuffFrame.y)
end

local pos_Gun = function(f)
	local G = 0
	if OwD_DB.Pos.AuraWatch.x > -122 then
		G = 0
	elseif OwD_DB.Pos.AuraWatch.x > -132 then
		G = 1
	elseif OwD_DB.Pos.AuraWatch.x > -142 then
		G = 2
	elseif OwD_DB.Pos.AuraWatch.x > -162 then
		G = 3	
	elseif OwD_DB.Pos.AuraWatch.x > -182 then
		G = 4
	elseif OwD_DB.Pos.AuraWatch.x > -202 then
		G = 5
	elseif OwD_DB.Pos.AuraWatch.x > -232 then
		G = 6
	else
		G = 7
	end
	if G > 0 then
		f.Right.Gun: Show()
		f.Right.Gun: SetTexture(F.Media.."Gun\\"..L.Gun[G][1])
		f.Right.Gun: SetSize(L.Gun[G][2],L.Gun[G][3])
		f.Right.Gun: SetTexCoord(L.Gun[G][4],L.Gun[G][5], L.Gun[G][6],L.Gun[G][7])
		f.Right.Gun: SetPoint("RIGHT", f.Right, "RIGHT", -40,(40+20)*4/63)
	else
		f.Right.Gun: Hide()
	end
end

L.init_Config = function(f)
	--> 2
	floor_Position()
	pos_Frame(f)
	pos_Gun(f)
	
	--> 4 
	if OwD_DB.Hide_Blizzard then
		L.Disable_Blizzard()
	end
			
	--> 5
	
	if (not UnitAffectingCombat("player")) then
		
	end
end

local init_Move = function(f)
	f: SetSize(20,20)
	f.v = L.create_Texture(f, "ARTWORK", "Joystick", 32,32, 0,1,0,1, C.Color.Red,1, "CENTER",f,"CENTER",0,0)
	
	f: SetClampedToScreen(true)
	f: SetMovable(true)
	f: EnableMouse(true)
	f: SetUserPlaced(false)
	f: RegisterForDrag("LeftButton","RightButton")
	f: SetScript("OnDragStart", function(self) self:StartMoving() end)
	f: SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
end

L.move_IsDragging = function(f)
	if (not f.Config:IsVisible()) then
		f.MoveFrame: SetScript("OnUpdate", nil)
		f.MoveFrame: Hide()
		return
	end
	
	if f.MoveFrame.Player then
		if f.MoveFrame.Player:IsDragging() then
			local x0,y0 = f.Player:GetCenter()
			local x1,y1 = f.MoveFrame.Player:GetCenter()
			local step = floor(1/(GetFramerate())*1e3)/1e3
			if x0 ~= x1 then
				OwD_DB.Pos.Player.x = OwD_DB.Pos.Player.x + (x1-x0)*step/2
			end
			if y0 ~= y1 then
				OwD_DB.Pos.Player.y = OwD_DB.Pos.Player.y + (y1-y0)*step/2
			end
			if OwD_DB.Pos.Player.x > -400 then OwD_DB.Pos.Player.x = -400 end
			if OwD_DB.Pos.Player.y > -200 then OwD_DB.Pos.Player.y = -200 end
			if x0 ~= x1 or y0 ~= y1 then
				f.Player: SetPoint("BOTTOMLEFT", f, "CENTER", OwD_DB.Pos.Player.x, OwD_DB.Pos.Player.y)
				f.PlayerButton: SetPoint("BOTTOMLEFT", f, "CENTER", OwD_DB.Pos.Player.x, OwD_DB.Pos.Player.y)
				f.Right: SetPoint("BOTTOMRIGHT", f, "CENTER", -OwD_DB.Pos.Player.x, OwD_DB.Pos.Player.y)
			end
		else
			f.MoveFrame.Player: ClearAllPoints()
			f.MoveFrame.Player: SetPoint("CENTER", f.Player, "CENTER", 0,0)
		end
	end
	
	if f.MoveFrame.AuraWatch then
		if f.MoveFrame.AuraWatch:IsDragging() then
			local x0,y0 = f.Right.Icon.Help:GetCenter()
			local x1,y1 = f.MoveFrame.AuraWatch:GetCenter()
			local step = floor(1/(GetFramerate())*1e3)/1e3
			if x0 ~= x1 then
				OwD_DB.Pos.AuraWatch.x = OwD_DB.Pos.AuraWatch.x + (x1-x0)*step/4
			end
			--[[
			if y0 ~= y1 then
				OwD_DB.Pos.AuraWatch.y = OwD_DB.Pos.AuraWatch.y + (y1-y0)*step/2
			end
			--]]
			if OwD_DB.Pos.AuraWatch.x > -10 then OwD_DB.Pos.AuraWatch.x = -10 end
			OwD_DB.Pos.AuraWatch.y = -4/63 * OwD_DB.Pos.AuraWatch.x
			
			if x0 ~= x1 or y0 ~= y1 then
				f.Right.Icon.Help: SetPoint("TOPRIGHT", f.Right, "TOPRIGHT", OwD_DB.Pos.AuraWatch.x, -4/63 * OwD_DB.Pos.AuraWatch.x)
				pos_Gun(f)
			end
		else
			f.MoveFrame.AuraWatch: ClearAllPoints()
			f.MoveFrame.AuraWatch: SetPoint("CENTER", f.Right.Icon.Help, "CENTER", 0,0)
		end
	end
	
	if f.MoveFrame.Target then
		if f.MoveFrame.Target:IsDragging() then
			local x0,y0 = f.Target:GetCenter()
			local x1,y1 = f.MoveFrame.Target:GetCenter()
			local step = floor(1/(GetFramerate())*1e3)/1e3
			if y0 ~= y1 then 
				OwD_DB.Pos.Target.y = OwD_DB.Pos.Target.y + (y1-y0)*step/2
			end
			if OwD_DB.Pos.Target.y > 0 then OwD_DB.Pos.Target.y = 0 end
			if y0 ~= y1 then
				f.Target: SetPoint("TOP", UIParent, "TOP", 0, OwD_DB.Pos.Target.y)
				f.TargetButton: SetPoint("TOP", UIParent, "TOP", 0, OwD_DB.Pos.Target.y)
			end
		else
			f.MoveFrame.Target: ClearAllPoints()
			f.MoveFrame.Target: SetPoint("TOP", UIParent, "TOP", 0, OwD_DB.Pos.Target.y)
		end
	end
	
	if f.MoveFrame.Focus then
		if f.MoveFrame.Focus:IsDragging() then
			local x0,y0 = f.Focus:GetCenter()
			local x1,y1 = f.MoveFrame.Focus:GetCenter()
			local step = floor(1/(GetFramerate())*1e3)/1e3
			if x0 ~= x1 then
				OwD_DB.Pos.Focus.x = OwD_DB.Pos.Focus.x + (x1-x0)*step/2
			end
			if y0 ~= y1 then
				OwD_DB.Pos.Focus.y = OwD_DB.Pos.Focus.y + (y1-y0)*step/2
			end
			if OwD_DB.Pos.Focus.x > 0 then OwD_DB.Pos.Focus.x = 0 end
			if x0 ~= x1 or y0 ~= y1 then
				f.Focus: SetPoint("CENTER", f, "CENTER", OwD_DB.Pos.Focus.x, OwD_DB.Pos.Focus.y)
				f.FocusButton: SetPoint("CENTER", f, "CENTER", OwD_DB.Pos.Focus.x, OwD_DB.Pos.Focus.y)
			end
		else
			f.MoveFrame.Focus: ClearAllPoints()
			f.MoveFrame.Focus: SetPoint("CENTER", f, "CENTER", OwD_DB.Pos.Focus.x, OwD_DB.Pos.Focus.y)
		end
	end
	
	if f.MoveFrame.FCS then
		if f.MoveFrame.FCS:IsDragging() then
			local x0,y0 = f.FCS:GetCenter()
			local x1,y1 = f.MoveFrame.FCS:GetCenter()
			local step = floor(1/(GetFramerate())*1e3)/1e3
			if y0 ~= y1 then 
				OwD_DB.Pos.FCS.y = OwD_DB.Pos.FCS.y + (y1-y0)*step/2
			end
			if OwD_DB.Pos.FCS.y > 0 then OwD_DB.Pos.FCS.y = 0 end
			if y0 ~= y1 then
				f.FCS: SetPoint("CENTER", f, "CENTER", 0, OwD_DB.Pos.FCS.y)
			end
		else
			f.MoveFrame.FCS: ClearAllPoints()
			f.MoveFrame.FCS: SetPoint("CENTER", f, "CENTER", 0, OwD_DB.Pos.FCS.y)
		end
	end
	
	if f.MoveFrame.ActionBar then
		if f.MoveFrame.ActionBar:IsDragging() then
			local x0,y0 = f.ActionBar:GetCenter()
			local x1,y1 = f.MoveFrame.ActionBar:GetCenter()
			x1 = x1*OwD_DB["OwD_Scale"]
			y1 = y1*OwD_DB["OwD_Scale"]
			local step = floor(1/(GetFramerate())*1e3)/1e3
			if y0 ~= y1 then 
				OwD_DB.Pos.Bar.y = OwD_DB.Pos.Bar.y + (y1-y0)*step/2
			end
			if y0 ~= y1 then
				f.ActionBar: SetPoint("CENTER", f, "CENTER", 0, OwD_DB.Pos.Bar.y)
			end
		else
			f.MoveFrame.ActionBar: ClearAllPoints()
			f.MoveFrame.ActionBar: SetPoint("CENTER", f.ActionBar, "CENTER", 0,0)
		end
	end
	
	if f.MoveFrame.Minimap then
		if f.MoveFrame.Minimap:IsDragging() then
			local x0,y0 = f.mnMap:GetCenter()
			x0 = x0 * OwD_DB["OwD_MinimapScale"]
			y0 = y0 * OwD_DB["OwD_MinimapScale"]
			local x1,y1 = f.MoveFrame.Minimap:GetCenter()
			local step = floor(1/(GetFramerate())*1e3)/1e3
			if x0 ~= x1 then
				OwD_DB.Pos.Minimap.x = OwD_DB.Pos.Minimap.x + (x1-x0)*step/2
			end
			if y0 ~= y1 then
				OwD_DB.Pos.Minimap.y = OwD_DB.Pos.Minimap.y + (y1-y0)*step/2
			end
			--if OwD_DB.Pos.Minimap.x > -174 then OwD_DB.Pos.Minimap.x = -174 end
			--if OwD_DB.Pos.Minimap.y > -174 then OwD_DB.Pos.Minimap.y = -174 end
			if x0 ~= x1 or y0 ~= y1 then
				f.mnMap: SetPoint("CENTER", UIParent, "TOPRIGHT", OwD_DB.Pos.Minimap.x, OwD_DB.Pos.Minimap.y)
			end
		else
			f.MoveFrame.Minimap: ClearAllPoints()
			f.MoveFrame.Minimap: SetPoint("CENTER", f.mnMap, "CENTER", 0,0)
		end
	end
	
	if f.MoveFrame.AuraFrame then
		if f.MoveFrame.AuraFrame:IsDragging() then
		local x0,y0 = f.AuraFrame:GetCenter()
			local x1,y1 = f.MoveFrame.AuraFrame:GetCenter()
			x1 = x1*OwD_DB["OwD_Scale"]
			y1 = y1*OwD_DB["OwD_Scale"]
			local step = floor(1/(GetFramerate())*1e3)/1e3
			if x0 ~= x1 then
				OwD_DB.Pos.BuffFrame.x = OwD_DB.Pos.BuffFrame.x + (x1-x0)*step/2
			end
			if y0 ~= y1 then
				OwD_DB.Pos.BuffFrame.y = OwD_DB.Pos.BuffFrame.y + (y1-y0)*step/2
			end
			
			if x0 ~= x1 or y0 ~= y1 then
				f.AuraFrame: SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", OwD_DB.Pos.BuffFrame.x, OwD_DB.Pos.BuffFrame.y)
			end
		else
			f.MoveFrame.AuraFrame: ClearAllPoints()
			f.MoveFrame.AuraFrame: SetPoint("CENTER", f.AuraFrame, "CENTER", 0, 0)
		end
	end
end

L.Move_Frame = function(f)
	f.MoveFrame = CreateFrame("Frame", nil, f)
	f.MoveFrame: SetFrameStrata("HIGH")
	f.MoveFrame: SetFrameLevel(2)
	f.MoveFrame: SetSize(8,8)
	f.MoveFrame: SetPoint("CENTER", UIParent, "CENTER", 0,0)
	f.MoveFrame: Hide()
	
	f.MoveFrame.Player = CreateFrame("Frame", nil, f.MoveFrame)
	init_Move(f.MoveFrame.Player)
	
	f.MoveFrame.AuraWatch = CreateFrame("Frame", nil, f.MoveFrame)
	init_Move(f.MoveFrame.AuraWatch)
	
	f.MoveFrame.Target = CreateFrame("Frame", nil, f.MoveFrame)
	init_Move(f.MoveFrame.Target)
	
	f.MoveFrame.Focus = CreateFrame("Frame", nil, f.MoveFrame)
	init_Move(f.MoveFrame.Focus)
	
	f.MoveFrame.FCS = CreateFrame("Frame", nil, f.MoveFrame)
	init_Move(f.MoveFrame.FCS)
	
	f.MoveFrame.ActionBar = CreateFrame("Frame", nil, f.MoveFrame)
	init_Move(f.MoveFrame.ActionBar)
	
	f.MoveFrame.Minimap = CreateFrame("Frame", nil, f.MoveFrame)
	init_Move(f.MoveFrame.Minimap)
	
	f.MoveFrame.AuraFrame = CreateFrame("Frame", nil, f.MoveFrame)
	init_Move(f.MoveFrame.AuraFrame)
	
	f.MoveFrame: SetScript("OnShow", function(self)
		f.MoveFrame.Player: SetPoint("BOTTOMLEFT", f, "CENTER", OwD_DB.Pos.Player.x, OwD_DB.Pos.Player.y)
		f.MoveFrame.AuraWatch: SetPoint("TOPRIGHT", f.Right, "TOPRIGHT", OwD_DB.Pos.AuraWatch.x, -4/63 * OwD_DB.Pos.AuraWatch.x)
		f.MoveFrame.Target: SetPoint("CENTER", UIParent, "CENTER", 0, OwD_DB.Pos.Target.y)
		f.MoveFrame.Focus: SetPoint("CENTER", f, "CENTER", OwD_DB.Pos.Focus.x, OwD_DB.Pos.Focus.y)
		f.MoveFrame.FCS: SetPoint("CENTER", f, "CENTER", 0, OwD_DB.Pos.FCS.y)
		f.MoveFrame.Minimap: SetPoint("CENTER", f.mnMap, "CENTER", 0, 0)
		f.MoveFrame.AuraFrame: SetPoint("CENTER", f.AuraFrame, "CENTER", 0, 0)
		
		f.MoveFrame: SetScript("OnUpdate", function(self,elapsed)
			L.move_IsDragging(f)
			f.Target: Show()
			f.Focus: Show()
			
			f.mnMap.TrackerHelp: Show()
		end)
	end)
	f.MoveFrame: SetScript("OnHide", function(self)
		if not UnitExists("target") then
			f.Target: Hide()
		end
		if not UnitExists("focus") then
			f.Focus: Hide()
		end
		f.MoveFrame: SetScript("OnUpdate", nil)
		
		f.mnMap.TrackerHelp: Hide()
	end)
end

local OnShow_Config = function(f)
	f.Config.Text: SetText(L.Text["OwD"])
	f.Config.Button[6].Text: SetText(L.Text["CONFIG_EXPLAIN"])
	for i = 1,5 do
		f.Config.Button[i].B2:SetVertexColor(unpack(C.Color.White2))
	end
	--> 1
	if OwD_DB.AuraWatch.WTF then
		f.Config.Button[1].B2:SetVertexColor(unpack(C.Color.Blue))
	else
		f.Config.Button[1].B2:SetVertexColor(unpack(C.Color.White2))
	end
	
	--> 2
	f.MoveFrame:Hide()
	f.Config.Button[2].B2:SetVertexColor(unpack(C.Color.White2))
	--> 4 
	if OwD_DB.Hide_Blizzard and (not UnitAffectingCombat("player")) then
		L.Disable_Blizzard()
		f.Config.Button[4].B2:SetVertexColor(unpack(C.Color.White2))
	else
		f.Config.Button[4].B2:SetVertexColor(unpack(C.Color.Blue))
	end
	--> 5
	if OwD_DB.ActionBar.ON then
		f.Config.Button[5].B2:SetVertexColor(unpack(C.Color.Blue))
	else
		f.Config.Button[5].B2:SetVertexColor(unpack(C.Color.White2))
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
local max_addons = 40

local OnEnter_Indicator = function(f)
	collectgarbage()
	local total = 0
	for i = 1, GetNumAddOns() do 
		total = total + GetAddOnMemoryUsage(i)
	end
	
	GameTooltip:SetOwner(f, "ANCHOR_BOTTOMRIGHT", 0,0)
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
	f.Indication = CreateFrame("Frame", nil, UIParent)
	f.Indication: SetSize(32, 32)
	f.Indication: SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0,0)
	f.Indication: SetFrameLevel(f:GetFrameLevel()+3)
	f.Indication: EnableMouse(true)
	
	f.Indication.In = L.create_Texture(f.Indication, "BORDER", "ConfigTopLeft", 32,32, 0/32,32/32,0/32,32/32, C.Color.White,0.7, "TOPLEFT", f.Indication, "TOPLEFT", 0,0)
	
	f.Indication: SetScript("OnEnter", function(self)
		f.Indication.In: SetAlpha(0.9)
		OnEnter_Indicator(self)
	end)
	f.Indication: SetScript("OnLeave", function(self)
		f.Indication.In: SetAlpha(0.7)
		GameTooltip:Hide()
	end)
	--local p = f:GetParent()
	f.Indication: SetScript("OnMouseDown", function(self, button)
		GameTooltip:Hide()
		if (button == "LeftButton") or (button == "RightButton") then
			if f:IsVisible() or UnitAffectingCombat("player") then
				f:Hide()
			else
				f:Show()
			end
		end
	end)
	end
end

L.OnUpdate_Config_gap = function(f)
	-->Lag and FPS
	local framerate = floor(GetFramerate())
	local down, up, lagHome, lagWorld = GetNetStats()
	local late = max(lagHome, lagWorld)
	if framerate < 24 or late > 150 then
		f.Indication.In: SetVertexColor(unpack(C.Color.Red))
	elseif framerate < 40 or late > 70 then
		f.Indication.In: SetVertexColor(unpack(C.Color.Yellow))
	else
		f.Indication.In: SetVertexColor(unpack(C.Color.Green2))
	end
end

--- ----------------------------------------------------------------------------
--> Extra Button
--- ----------------------------------------------------------------------------

local function create_ExtraButton3(f,p)
	f.ExButton = {}
	for i = 1,5 do
		f.ExButton[i] = CreateFrame("Button", nil, f)
		f.ExButton[i]: SetFrameLevel(f:GetFrameLevel()+1)
		f.ExButton[i]: SetSize(106,32)
		
		f.ExButton[i].B1 = L.create_Texture(f.ExButton[i], "BORDER", "ConfigExtra0",	256,32, 1,0,0,1, C.Color.Black, 0.75, "CENTER",f.ExButton[i],"CENTER",0,0)
		f.ExButton[i].B1_Gloss = L.create_Texture(f.ExButton[i], "BACKGROUND",	"ConfigExtra0Gloss",	256,32, 1,0,0,1, C.Color.White, 0.3, "CENTER",f.ExButton[i],"CENTER",0,0)
		
		f.ExButton[i].B2 = L.create_Texture(f.ExButton[i], "ARTWORK", "ConfigExtra1",	256,32, 1,0,0,1, C.Color.White2, 0.9, "CENTER",f.ExButton[i],"CENTER",0,0)
		
		f.ExButton[i].Text = L.create_Fontstring(f.ExButton[i], C.Font.Name, 12, nil)
		f.ExButton[i].Text: SetPoint("CENTER",f.ExButton[i],"CENTER",-8,0)
		f.ExButton[i].Text: SetWidth(90)
		
		f.ExButton[i]:Hide()
		if i == 1 then
			f.ExButton[i]:SetPoint("RIGHT", f, "TOPLEFT", -20, 1)
		else
			f.ExButton[i]:SetPoint("CENTER", f.ExButton[i-1], "CENTER", -18, -32)
		end
	end
	
	--> 1
	f.ExButton[1].Text: SetText(L.Text["CONFIG_OwD_RuneBar"])
	f.ExButton[1]: SetScript("OnShow", function(self)
		if OwD_DB["OwD_RuneBar"] == true then
			f.ExButton[1].B2:SetVertexColor(unpack(C.Color.Blue))
		else
			f.ExButton[1].B2:SetVertexColor(unpack(C.Color.White2))
		end
	end)
	f.ExButton[1]: SetScript("OnHide", function(self)
		self: Hide()
	end)
	f.ExButton[1]: SetScript("OnEnter", function(self)
		self.B1_Gloss: SetAlpha(0.9)
		--f.Config.Button[6].Text: SetText(L.Text["CONFIG_OwD_Frames_EXPLAIN"])
	end)
	f.ExButton[1]: SetScript("OnLeave", function(self)
		self.B1_Gloss: SetAlpha(0.3)
		--f.Config.Button[6].Text: SetText(L.Text["CONFIG_EXPLAIN"])
	end)
	f.ExButton[1]: SetScript("OnClick", function(self, button)
		if OwD_DB["OwD_RuneBar"] == true then
			OwD_DB["OwD_RuneBar"] = false
			--OwD.Alone:Hide()
			f.ExButton[1].B2:SetVertexColor(unpack(C.Color.White2))
		else
			OwD_DB["OwD_RuneBar"] = true
			f.ExButton[1].B2:SetVertexColor(unpack(C.Color.Blue))
		end
	end)
	
	--> 2
	f.ExButton[2].Text: SetText(L.Text["CONFIG_OwD_Minimap"])
	f.ExButton[2]: SetScript("OnShow", function(self)
		--f.ExButton[2].B2:SetVertexColor(unpack(C.Color.Blue))
		f.ExButton[2].B2:SetVertexColor(unpack(C.Color.White2))
	end)
	f.ExButton[2]: SetScript("OnHide", function(self)
		self: Hide()
	end)
	f.ExButton[2]: SetScript("OnEnter", function(self)
		self.B1_Gloss: SetAlpha(0.9)
		--f.Config.Button[6].Text: SetText(L.Text["CONFIG_OwD_Frames_EXPLAIN"])
	end)
	f.ExButton[2]: SetScript("OnLeave", function(self)
		self.B1_Gloss: SetAlpha(0.3)
		--f.Config.Button[6].Text: SetText(L.Text["CONFIG_EXPLAIN"])
	end)
	f.ExButton[2]: SetScript("OnMouseDown", function(self, button)
		if button == "LeftButton" then
			OwD_DB["OwD_MinimapScale"] = OwD_DB["OwD_MinimapScale"] + 0.1
			if OwD_DB["OwD_MinimapScale"] > 1 then
				OwD_DB["OwD_MinimapScale"] = 0.5
			end
		elseif button == "RightButton" then
			OwD_DB["OwD_MinimapScale"] = OwD_DB["OwD_MinimapScale"] - 0.1
			if OwD_DB["OwD_MinimapScale"] < 0.5 then
				OwD_DB["OwD_MinimapScale"] = 1
			end
		end
		OwD.mnMap: SetScale(OwD_DB["OwD_MinimapScale"])
		Minimap: SetScale(OwD_DB["OwD_MinimapScale"])
		print("Minimap Scale is "..F.Hex(C.Color.Yellow)..OwD_DB["OwD_MinimapScale"])
	end)
	
	--> 3
	f.ExButton[3].Text: SetText(L.Text["CONFIG_OwD_SCALE"])
	f.ExButton[3]: SetScript("OnShow", function(self)
		--f.ExButton[3].B2:SetVertexColor(unpack(C.Color.Blue))
		f.ExButton[3].B2:SetVertexColor(unpack(C.Color.White2))
	end)
	f.ExButton[3]: SetScript("OnHide", function(self)
		self: Hide()
	end)
	f.ExButton[3]: SetScript("OnEnter", function(self)
		self.B1_Gloss: SetAlpha(0.9)
		--f.Config.Button[6].Text: SetText(L.Text["CONFIG_OwD_Frames_EXPLAIN"])
	end)
	f.ExButton[3]: SetScript("OnLeave", function(self)
		self.B1_Gloss: SetAlpha(0.3)
		--f.Config.Button[6].Text: SetText(L.Text["CONFIG_EXPLAIN"])
	end)
	f.ExButton[3]: SetScript("OnMouseDown", function(self, button)
		if button == "LeftButton" then
			OwD_DB["OwD_Scale"] = OwD_DB["OwD_Scale"] + 0.1
			if OwD_DB["OwD_Scale"] > 1 then
				OwD_DB["OwD_Scale"] = 0.6
			end
		elseif button == "RightButton" then
			OwD_DB["OwD_Scale"] = OwD_DB["OwD_Scale"] - 0.1
			if OwD_DB["OwD_Scale"] < 0.6 then
				OwD_DB["OwD_Scale"] = 1
			end
		end
		OwD: SetScale(OwD_DB["OwD_Scale"])
		OwD.PlayerButton:SetScale(OwD_DB["OwD_Scale"])
		OwD.PetButton:SetScale(OwD_DB["OwD_Scale"])
		OwD.TargetButton: SetScale(OwD_DB["OwD_Scale"])
		OwD.ToTButton: SetScale(OwD_DB["OwD_Scale"])
		OwD.FocusButton: SetScale(OwD_DB["OwD_Scale"])
		OwD.ToFButton: SetScale(OwD_DB["OwD_Scale"])
		local s = UIParent:GetScale()
		OwD.Player.Portrait.P: SetModelScale(0.66/(OwD_DB["OwD_Scale"]*s)) 
		OwD.Player.Portrait.P: RefreshCamera()
		print("OwD Scale is "..F.Hex(C.Color.Yellow)..OwD_DB["OwD_Scale"])
	end)
	
	--> 4
	f.ExButton[4].Text: SetText(L.Text["CONFIG_OUTCOMBATFADE"])
	f.ExButton[4]: SetScript("OnShow", function(self)
		if OwD_DB["OutCombat_Fade"] == true then
			self.B2:SetVertexColor(unpack(C.Color.Blue))
		else
			self.B2:SetVertexColor(unpack(C.Color.White2))
		end
	end)
	f.ExButton[4]: SetScript("OnHide", function(self)
		self: Hide()
	end)
	f.ExButton[4]: SetScript("OnEnter", function(self)
		self.B1_Gloss: SetAlpha(0.9)
		--f.Config.Button[6].Text: SetText(L.Text["CONFIG_OwD_Frames_EXPLAIN"])
	end)
	f.ExButton[4]: SetScript("OnLeave", function(self)
		self.B1_Gloss: SetAlpha(0.3)
		--f.Config.Button[6].Text: SetText(L.Text["CONFIG_EXPLAIN"])
	end)
	f.ExButton[4]: SetScript("OnClick", function(self, button)
		if OwD_DB["OutCombat_Fade"] == true then
			OwD_DB["OutCombat_Fade"] = false
			L.update_OutCombat_Fade(p)
			self.B2:SetVertexColor(unpack(C.Color.White2))
		else
			OwD_DB["OutCombat_Fade"] = true
			L.update_OutCombat_Fade(p)
			self.B2:SetVertexColor(unpack(C.Color.Blue))
		end
	end)
	
	--> 5
	f.ExButton[5].Text: SetText(L.Text["CONFIG_BUFFFRAME"])
	f.ExButton[5]: SetScript("OnShow", function(self)
		if OwD_DB.BuffFrame.ON == true then
			self.B2:SetVertexColor(unpack(C.Color.Blue))
		else
			self.B2:SetVertexColor(unpack(C.Color.White2))
		end
	end)
	f.ExButton[5]: SetScript("OnHide", function(self)
		self: Hide()
	end)
	f.ExButton[5]: SetScript("OnEnter", function(self)
		self.B1_Gloss: SetAlpha(0.9)
		--f.Config.Button[6].Text: SetText(L.Text["CONFIG_OwD_Frames_EXPLAIN"])
	end)
	f.ExButton[5]: SetScript("OnLeave", function(self)
		self.B1_Gloss: SetAlpha(0.3)
		--f.Config.Button[6].Text: SetText(L.Text["CONFIG_EXPLAIN"])
	end)
	f.ExButton[5]: SetScript("OnClick", function(self, button)
		if OwD_DB.BuffFrame.ON == true then
			OwD_DB.BuffFrame.ON = false
			self.B2:SetVertexColor(unpack(C.Color.White2))
			SlashCmdList.RELOADUI()
		else
			OwD_DB.BuffFrame.ON = true
			self.B2:SetVertexColor(unpack(C.Color.Blue))
			SlashCmdList.RELOADUI()
		end
	end)
end

--- ----------------------------------------------------------------------------
--> Config Frame
--- ----------------------------------------------------------------------------

L.Config_Frame = function(f)
	f.Config = CreateFrame("Frame", nil, UIParent)
	--f.Config: SetFrameStrata("HIGH")
	f.Config: SetFrameLevel(20)
	f.Config: SetSize(70,70)
	f.Config: SetPoint("CENTER", f, "CENTER", 0,0)
	f.Config: Hide()
	
	create_Indication(f.Config)
	
	f.Config.B1 = L.create_Texture(f.Config, "BACKGROUND", "ConfigHex0Fill", 256,256, 0,1,0,1, C.Color.Black, 0.75, "CENTER",f.Config,"CENTER",0,0)
	f.Config.B2 = L.create_Texture(f.Config, "BORDER", "ConfigHex0", 256,256, 0,1,0,1, C.Color.White2, 0.9, "CENTER",f.Config,"CENTER",0,0)
	f.Config.Text = L.create_Fontstring(f.Config, C.Font.Name, 18, nil)
	f.Config.Text: SetPoint("CENTER",f.Config,"CENTER",0,0)
	f.Config.Text: SetText(L.Text["OwD"])
	
	f.Config.Button = {}
	for i = 1,6 do 
		f.Config.Button[i] = CreateFrame("Button", nil, f.Config)
		f.Config.Button[i]: SetSize(90,90)
		if i <= 5 then
			f.Config.Button[i].B1 = L.create_Texture(f.Config.Button[i], "BORDER",	"ConfigHex1",	256,256, 0,1,0,1, C.Color.Black, 0.75, "CENTER",f.Config.Button[i],"CENTER",0,0)
			f.Config.Button[i].B1_Gloss = L.create_Texture(f.Config.Button[i], "BACKGROUND",	"ConfigHex1Gloss",	256,256, 0,1,0,1, C.Color.White, 0.3, "CENTER",f.Config.Button[i],"CENTER",0,0)
			f.Config.Button[i].Text = L.create_Fontstring(f.Config.Button[i], C.Font.Name, 12, nil)
			f.Config.Button[i].Text: SetPoint("CENTER",f.Config.Button[i],"CENTER",0,0)
			f.Config.Button[i].Text: SetWidth(90)
		elseif i == 6 then
			f.Config.Button[i].Text = L.create_Fontstring(f.Config.Button[i], C.Font.Name, 11, "THINOUTLINE")
			f.Config.Button[i].Text: SetPoint("LEFT",f.Config.Button[i],"CENTER",-50,20)
			f.Config.Button[i].Text: SetWidth(160)
			f.Config.Button[i].Text: SetJustifyH("LEFT")
			f.Config.Button[i].Text: SetShadowColor(0,0,0,0)
			f.Config.Button[i].Text: SetText(L.Text["CONFIG_EXPLAIN"])
		else
			
		end
	end
	f.Config.Button[1]: SetPoint("CENTER", f.Config, "CENTER", 110,63)
	f.Config.Button[1].B2 = L.create_Texture(f.Config.Button[1], "ARTWORK", "ConfigHex2", 256,256, 0,1,0,1, C.Color.Blue, 0.9, "CENTER",f.Config.Button[1],"CENTER",0,0)
	f.Config.Button[2]: SetPoint("CENTER", f.Config, "CENTER", 0,126)
	f.Config.Button[2].B2 = L.create_Texture(f.Config.Button[2], "ARTWORK", "ConfigHex3", 256,256, 0,1,0,1, C.Color.Blue, 0.9, "CENTER",f.Config.Button[2],"CENTER",0,0)
	f.Config.Button[3]: SetPoint("CENTER", f.Config, "CENTER", -110,63)
	f.Config.Button[3].B2 = L.create_Texture(f.Config.Button[3], "ARTWORK", "ConfigHex2", 256,256, 1,0,0,1, C.Color.Blue, 0.9, "CENTER",f.Config.Button[3],"CENTER",0,0)
	f.Config.Button[4]: SetPoint("CENTER", f.Config, "CENTER", -110,-63)
	f.Config.Button[4].B2 = L.create_Texture(f.Config.Button[4], "ARTWORK", "ConfigHex2", 256,256, 1,0,1,0, C.Color.Blue, 0.9, "CENTER",f.Config.Button[4],"CENTER",0,0)
	f.Config.Button[5]: SetPoint("CENTER", f.Config, "CENTER", 0,-126)
	f.Config.Button[5].B2 = L.create_Texture(f.Config.Button[5], "ARTWORK", "ConfigHex3", 256,256, 0,1,1,0, C.Color.Blue, 0.9, "CENTER",f.Config.Button[5],"CENTER",0,0)
	f.Config.Button[6]: SetPoint("CENTER", f.Config, "CENTER", 110,-63)
	
	f.Config: SetScript("OnShow", function(self)
		OnShow_Config(f)
	end)
	
	f.Config: SetScript("OnEnter", function(self)
		f.Config.Text: SetText(L.Text["CONFIG_EXIT"])
		f.Config.B2: SetVertexColor(unpack(C.Color.Red))
	end)
	f.Config: SetScript("OnLeave", function(self)
		f.Config.Text: SetText(L.Text["OwD"])
		f.Config.B2: SetVertexColor(unpack(C.Color.White2))
	end)
	f.Config: SetScript("OnMouseDown", function(self, button)
		f.Config:Hide()
	end)
	
	f.Config:RegisterEvent("PLAYER_REGEN_DISABLED")
	f.Config:RegisterEvent("PLAYER_REGEN_ENABLED")
	f.Config:SetScript("OnEvent", function(self,event)
		if UnitAffectingCombat("player") then
			f.Config:Hide()
		end
	end)
	
	--> Button 1
	f.Config.Button[1].Text: SetText(L.Text["CONFIG_AuraWatch"])
	f.Config.Button[1]: SetScript("OnEnter", function(self)
		self.B1_Gloss: SetAlpha(0.9)
		f.Config.Button[6].Text: SetText(L.Text["CONFIG_AuraWatch_EXPLAIN"]) 
	end)
	f.Config.Button[1]: SetScript("OnLeave", function(self)
		self.B1_Gloss: SetAlpha(0.3)
		f.Config.Button[6].Text: SetText(L.Text["CONFIG_EXPLAIN"])
	end)
	f.Config.Button[1]: SetScript("OnMouseDown", function(self, button)
		if button == "LeftButton" then
			if f.AW_Config:IsVisible() then
				f.AW_Config:Hide()
			else
				f.AW_Config:Show()
			end
		elseif button == "RightButton" then
			if OwD_DB.AuraWatch.WTF then
				OwD_DB.AuraWatch.WTF = false
				f.Config.Button[1].B2:SetVertexColor(unpack(C.Color.White2))
				L.init_AuraWatch(f.Right)
			
			else
				OwD_DB.AuraWatch.WTF = true
				f.Config.Button[1].B2:SetVertexColor(unpack(C.Color.Blue))
				L.init_AuraWatch(f.Right)
			end
		end
	end)
	
	--> Button2
	f.Config.Button[2].Text: SetText(L.Text["CONFIG_MOVEFRAME"])
	f.Config.Button[2]: SetScript("OnEnter", function(self)
		self.B1_Gloss: SetAlpha(0.9)
		f.Config.Button[6].Text: SetText(L.Text["CONFIG_MOVEFRAME_EXPLAIN"])
	end)
	f.Config.Button[2]: SetScript("OnLeave", function(self)
		self.B1_Gloss: SetAlpha(0.3)
		f.Config.Button[6].Text: SetText(L.Text["CONFIG_EXPLAIN"])
	end)
	f.Config.Button[2]: SetScript("OnHide", function(self)
		f.MoveFrame:Hide()
	end)
	f.Config.Button[2]: SetScript("OnMouseDown", function(self, button)
		if button == "LeftButton" then
			if f.MoveFrame:IsShown() then
				f.MoveFrame:Hide()
				f.Config.Button[2].B2:SetVertexColor(unpack(C.Color.White2))
			else
				f.MoveFrame:Show()
				f.Config.Button[2].B2:SetVertexColor(unpack(C.Color.Blue))
			end
		elseif button == "RightButton" then
			for key, value in pairs(C.DB["Pos"]) do
				if type(value) == "table" then
					OwD_DB["Pos"][key] = {}
					for k, v in pairs(value) do
						OwD_DB["Pos"][key][k] = value[k]
					end
				else
					OwD_DB["Pos"][key] = value
				end
			end
			pos_Frame(f)
			pos_Gun(f)
		end
	end)
	
	--> Button 3
	create_ExtraButton3(f.Config.Button[3], f)
	f.Config.Button[3].Text: SetText(L.Text["CONFIG_OwD_Frames"])
	f.Config.Button[3]: SetScript("OnEnter", function(self)
		self.B1_Gloss: SetAlpha(0.9)
		f.Config.Button[6].Text: SetText(L.Text["CONFIG_OwD_Frames_EXPLAIN"])
	end)
	f.Config.Button[3]: SetScript("OnLeave", function(self)
		self.B1_Gloss: SetAlpha(0.3)
		f.Config.Button[6].Text: SetText(L.Text["CONFIG_EXPLAIN"])
	end)
	f.Config.Button[3]: SetScript("OnClick", function(self, button)
		if self.ExButton[1]: IsVisible() then
			for i = 1, #self.ExButton do
				self.ExButton[i]: Hide()
			end
		else
			for i = 1, #self.ExButton do
				self.ExButton[i]: Show()
			end
		end
	end)
	
	--> Button 4
	f.Config.Button[4].Text: SetText(L.Text["CONFIG_HIDEBLIZZARD"])
	f.Config.Button[4]: SetScript("OnEnter", function(self)
		self.B1_Gloss: SetAlpha(0.9)
		f.Config.Button[6].Text: SetText(L.Text["CONFIG_HIDEBLIZZARD_EXPLAIN"])
	end)
	f.Config.Button[4]: SetScript("OnLeave", function(self)
		self.B1_Gloss: SetAlpha(0.3)
		f.Config.Button[6].Text: SetText(L.Text["CONFIG_EXPLAIN"])
	end)
	f.Config.Button[4]: SetScript("OnClick", function(self, button)
		if OwD_DB.Hide_Blizzard then
			OwD_DB.Hide_Blizzard = false
			f.Config.Button[4].B2:SetVertexColor(unpack(C.Color.Blue))
			SlashCmdList.RELOADUI()
		else
			OwD_DB.Hide_Blizzard = true
			f.Config.Button[4].B2:SetVertexColor(unpack(C.Color.White2))
			L.Disable_Blizzard()
		end
	end)
	
	--> Button 5
	f.Config.Button[5].Text: SetText(L.Text["CONFIG_ACTIONBAR"])
	f.Config.Button[5]: SetScript("OnEnter", function(self)
		self.B1_Gloss: SetAlpha(0.9)
		f.Config.Button[6].Text: SetText(L.Text["CONFIG_ACTIONBAR"])
	end)
	f.Config.Button[5]: SetScript("OnLeave", function(self)
		self.B1_Gloss: SetAlpha(0.3)
		f.Config.Button[6].Text: SetText(L.Text["CONFIG_EXPLAIN"])
	end)
	f.Config.Button[5]: SetScript("OnClick", function(self, button)
		if OwD_DB.ActionBar.ON then
			OwD_DB.ActionBar.ON = false
			f.Config.Button[5].B2:SetVertexColor(unpack(C.Color.Blue))
			SlashCmdList.RELOADUI()
		else
			OwD_DB.ActionBar.ON = true
			f.Config.Button[5].B2:SetVertexColor(unpack(C.Color.White2))
			SlashCmdList.RELOADUI()
		end
	end)
end