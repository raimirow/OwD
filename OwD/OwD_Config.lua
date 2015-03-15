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

L.OnEvent_Unit = function(f)
	
end

L.OnUpdate_Unit = function(f)
	
end

L.create_Unit = function(f)
	f.PlayerButton = CreateFrame("Button", "OwD.PlayerButton", UIParent, "SecureUnitButtonTemplate")
	f.PlayerButton: SetSize(98,113)
	--f.PlayerButton: SetPoint("BOTTOMLEFT", f, "CENTER", OwD_DB.Pos.Player.x, OwD_DB.Pos.Player.y)
	init_Unit(f.PlayerButton, f.Player.unit)
	
	f.PetButton = CreateFrame("Button", "OwD.PetButton", UIParent, "SecureUnitButtonTemplate")
	f.PetButton: SetSize(48,48)
	f.PetButton: SetPoint("BOTTOMLEFT", f.PlayerButton, "BOTTOMRIGHT", 240, 20)
	init_Unit(f.PetButton, f.Pet.unit)
	
	f.TargetButton = CreateFrame("Button", "OwD.TargetButton", UIParent, "SecureUnitButtonTemplate")
	f.TargetButton: SetSize(140,24)
	f.TargetButton: SetPoint("CENTER", f, "CENTER", 264+30, 1+220)
	init_Unit(f.TargetButton, f.Target.unit)
	
	f.ToTButton = CreateFrame("Button", "OwD.ToTButton", UIParent, "SecureUnitButtonTemplate")
	f.ToTButton: SetSize(140,24)
	f.ToTButton: SetPoint("LEFT", f, "CENTER", 50, 286)
	init_Unit(f.ToTButton, f.ToT.unit)
	
	f.FocusButton = CreateFrame("Button", "OwD.FocusButton", UIParent, "SecureUnitButtonTemplate")
	f.FocusButton: SetSize(140,24)
	f.FocusButton: SetPoint("CENTER", f, "CENTER", -290, 220+16)
	init_Unit(f.FocusButton, f.Focus.unit)
	
	f.ToFButton = CreateFrame("Button", "OwD.ToFButton", UIParent, "SecureUnitButtonTemplate")
	f.ToFButton: SetSize(140,24)
	f.ToFButton: SetPoint("CENTER", f, "CENTER", -290-40, 220-50+16)
	init_Unit(f.ToFButton, f.ToF.unit)
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
		
		--HandleFrame(PetFrame)
		
		HandleFrame(TargetFrame)
		HandleFrame(ComboFrame)
		HandleFrame(TargetFrameToT)
		
		HandleFrame(FocusFrame)
		HandleFrame(TargetofFocusFrame)
	end
end

--- ----------------------------------------------------------------------------
--> Config
--- ----------------------------------------------------------------------------

--> Move Frames
local floor_Position = function()
	OwD_DB.Pos.Player.x = floor(OwD_DB.Pos.Player.x + 0.5)
	OwD_DB.Pos.Player.y = floor(OwD_DB.Pos.Player.y + 0.5)
	
	OwD_DB.Pos.FCS.y = floor(OwD_DB.Pos.FCS.y + 0.5)
	
	OwD_DB.Pos.Minimap.x = floor(OwD_DB.Pos.Minimap.x + 0.5)
	OwD_DB.Pos.Minimap.y = floor(OwD_DB.Pos.Minimap.y + 0.5)
end

local pos_Frame = function(f)
	f.Player: ClearAllPoints()
	f.Player: SetPoint("BOTTOMLEFT", f, "CENTER", OwD_DB.Pos.Player.x, OwD_DB.Pos.Player.y)
	f.PlayerButton: ClearAllPoints()
	f.PlayerButton: SetPoint("BOTTOMLEFT", f, "CENTER", OwD_DB.Pos.Player.x, OwD_DB.Pos.Player.y)
	f.Right: ClearAllPoints()
	f.Right: SetPoint("BOTTOMRIGHT", f, "CENTER", -OwD_DB.Pos.Player.x, OwD_DB.Pos.Player.y)
	f.FCS: ClearAllPoints()
	f.FCS: SetPoint("CENTER", f, "CENTER", 0, OwD_DB.Pos.FCS.y)
	Minimap: ClearAllPoints()
	Minimap: SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", OwD_DB.Pos.Minimap.x,OwD_DB.Pos.Minimap.y)
end

L.init_Config = function(f)
	--> 2
	floor_Position()
	pos_Frame(f)
	
	--> 4 
	if OwD_DB.Hide_Blizzard then
		L.Disable_Blizzard()
	end
			
	--> 5
	if OwD_DB.Hide_TopBottomBorder then
		f.Artwork.Border_Bottom1:Hide()
		f.Artwork.Border_Bottom2:Hide()
		f.Artwork.Border_Top1:Hide()
		f.Artwork.Border_Top2:Hide()
	else
		f.Artwork.Border_Bottom1:Show()
		f.Artwork.Border_Bottom2:Show()
		f.Artwork.Border_Top1:Show()
		f.Artwork.Border_Top2:Show()			
	end
	
	if (not UnitAffectingCombat("player")) then
		
	end
end

local init_Move = function(f)
	f: SetSize(20,20)
	f.v = L.create_Texture(f, "ARTWORK", "Bar", 20,20, 0,1,0,1, C.Color.Blue,1, "CENTER",f,"CENTER",0,0)
	
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
			local x0,y0 = f.Player:GetLeft(),f.Player:GetBottom()
			local x1,y1 = f.MoveFrame.Player:GetLeft(),f.MoveFrame.Player:GetBottom()
			local step = floor(1/(GetFramerate())*1e3)/1e3
			if x0 ~= x1 then
				OwD_DB.Pos.Player.x = OwD_DB.Pos.Player.x + (x1-x0)*step/1.5
			end
			if y0 ~= y1 then
				OwD_DB.Pos.Player.y = OwD_DB.Pos.Player.y + (y1-y0)*step/1.5
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
			f.MoveFrame.Player: SetPoint("BOTTOMLEFT", f, "CENTER", OwD_DB.Pos.Player.x, OwD_DB.Pos.Player.y)
		end
	end
	
	if f.MoveFrame.FCS then
		if f.MoveFrame.FCS:IsDragging() then
			local y0 = f.FCS:GetBottom()
			local y1 = f.MoveFrame.FCS:GetBottom()
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
end

L.Move_Frame = function(f)
	f.MoveFrame = CreateFrame("Frame", nil, f)
	f.MoveFrame: SetFrameStrata("HIGH")
	f.MoveFrame: SetFrameLevel(2)
	f.MoveFrame: SetSize(8,8)
	f.MoveFrame: SetPoint("CENTER", UIParent, "CENTER", 0,0)
	f.MoveFrame: Hide()
	
	f.MoveFrame.Player = CreateFrame("Frame", nil, f.MoveFrame)
	--f.MoveFrame.Player: SetPoint("BOTTOMLEFT", f, "CENTER", OwD_DB.Pos.Player.x, OwD_DB.Pos.Player.y)
	init_Move(f.MoveFrame.Player)
	
	f.MoveFrame.FCS = CreateFrame("Frame", nil, f.MoveFrame)
	--f.MoveFrame.FCS: SetPoint("CENTER", f, "CENTER", 0, OwD_DB.Pos.FCS.y)
	init_Move(f.MoveFrame.FCS)
	
	f.MoveFrame: SetScript("OnShow", function(self)
		f.MoveFrame.Player: SetPoint("BOTTOMLEFT", f, "CENTER", OwD_DB.Pos.Player.x, OwD_DB.Pos.Player.y)
		f.MoveFrame.FCS: SetPoint("CENTER", f, "CENTER", 0, OwD_DB.Pos.FCS.y)
		f.MoveFrame: SetScript("OnUpdate", function(self,elapsed)
			L.move_IsDragging(f)
		end)
	end)
	f.MoveFrame: SetScript("OnHide", function(self)
		f.MoveFrame: SetScript("OnUpdate", nil)
	end)
end

local OnShow_Config = function(f)
	f.Config.Text: SetText("OwD")
	f.Config.exText: SetText(L.Text["CONFIG_EXPLAIN"])
	for i = 1,4 do
		f.Config[i].Border: Hide()
	end
	--> 1
	if OwD_DB.WTF_AuraWatch then
		f.Config[1].Border:Show()
	else
		f.Config[1].Border:Hide()
	end
	
	--> 2
	f.MoveFrame:Hide()
	f.Config[2].Border:Hide()
	--> 4 
	if OwD_DB.Hide_Blizzard and (not UnitAffectingCombat("player")) then
		L.Disable_Blizzard()
		f.Config[4].Border:Hide()
	else
		f.Config[4].Border:Show()
	end
	--> 5
	if OwD_DB.Hide_TopBottomBorder then
		f.Config[5].Border:Hide()
		f.Artwork.Border_Bottom1:Hide()
		f.Artwork.Border_Bottom2:Hide()
		f.Artwork.Border_Top1:Hide()
		f.Artwork.Border_Top2:Hide()
	else
		f.Config[5].Border:Show()
		f.Artwork.Border_Bottom1:Show()
		f.Artwork.Border_Bottom2:Show()
		f.Artwork.Border_Top1:Show()
		f.Artwork.Border_Top2:Show()			
	end
end

--> Config Frame
L.Config_Frame = function(f)
	f.Config = CreateFrame("Frame", nil, f)
	--f.Config: SetFrameStrata("HIGH")
	f.Config: SetFrameLevel(20)
	f.Config: SetSize(54,54)
	f.Config: SetPoint("CENTER", f, "CENTER", 0,0)
	f.Config: Hide()
	
	f.Config.Bg = L.create_Texture(f.Config, "BORDER", "Config\\Circle_Fill", 64,64, 0,1,0,1, C.Color.Black, 0.75, "CENTER",f.Config,"CENTER",0,0)
	f.Config.Gs = L.create_Texture(f.Config, "BACKGROUND", "Config\\Circle_Gloss", 64,64, 0,1,0,1, C.Color.White, 0.4, "CENTER",f.Config,"CENTER",0,0)
	f.Config.Border = L.create_Texture(f.Config, "ARTWORK", "Config\\Circle", 64,64, 0,1,0,1, C.Color.Blue, 0.9, "CENTER",f.Config,"CENTER",0,0)
	f.Config.Text = L.create_Fontstring(f.Config, C.Font.Name, 12, nil)
	f.Config.Text: SetPoint("CENTER",f.Config,"CENTER",0,0)
	f.Config.Text: SetText("OwD")
	
	f.Config.exText = L.create_Fontstring(f.Config, C.Font.Name, 12, nil)
	f.Config.exText: SetWidth(220)
	f.Config.exText: SetPoint("TOPRIGHT",f.Config,"BOTTOMLEFT",0,-12)
	f.Config.exText: SetText(L.Text["CONFIG_EXPLAIN"])
	
	for i = 1,6 do 
		f.Config[i] = CreateFrame("Button", nil, f.Config)
		if i <= 4 then
			f.Config[i]: SetSize(60,60)
			f.Config[i].Bg = L.create_Texture(f.Config[i], "BORDER", "Config\\Hex_Fill", 128,128, 0,1,0,1, C.Color.Black, 0.75, "CENTER",f.Config[i],"CENTER",0,0)
			f.Config[i].Gs = L.create_Texture(f.Config[i], "BACKGROUND", "Config\\Hex_Gloss", 128,128, 0,1,0,1, C.Color.White, 0.4, "CENTER",f.Config[i],"CENTER",0,0)
			f.Config[i].Border = L.create_Texture(f.Config[i], "ARTWORK", "Config\\Hex", 128,128, 0,1,0,1, C.Color.Blue, 0.9, "CENTER",f.Config[i],"CENTER",0,0)
			f.Config[i].Border: Hide()
			f.Config[i].Text = L.create_Fontstring(f.Config[i], C.Font.Name, 12, nil)
			f.Config[i].Text: SetPoint("CENTER",f.Config[i],"CENTER",0,0)
			f.Config[i].Text: SetWidth(64)
		else
			f.Config[i]: SetSize(36,36)
			f.Config[i].Bg = L.create_Texture(f.Config[i], "BORDER", "Config\\Small_Fill", 64,64, 0,1,0,1, C.Color.Black, 0.75, "CENTER",f.Config[i],"CENTER",0,0)
			f.Config[i].Gs = L.create_Texture(f.Config[i], "BACKGROUND", "Config\\Small_Gloss", 64,64, 0,1,0,1, C.Color.White, 0.4, "CENTER",f.Config[i],"CENTER",0,0)
			f.Config[i].Border = L.create_Texture(f.Config[i], "ARTWORK", "Config\\Small", 64,64, 0,1,0,1, C.Color.Blue, 0.9, "CENTER",f.Config[i],"CENTER",0,0)
			f.Config[i].Border: Hide()
			f.Config[i].Text = L.create_Fontstring(f.Config[i], C.Font.Name, 10, nil)
			f.Config[i].Text: SetPoint("CENTER",f.Config[i],"CENTER",0,0)
			f.Config[i].Text: SetWidth(36)
		end
	end
	f.Config[1]: SetPoint("TOPLEFT", f.Config, "RIGHT", 16,-12)
	f.Config[2]: SetPoint("BOTTOMLEFT", f.Config, "RIGHT", 16,12)
	f.Config[3]: SetPoint("BOTTOM", f.Config, "TOP", 0,26)
	f.Config[4]: SetPoint("BOTTOMRIGHT", f.Config, "LEFT", -16,12)
	f.Config[5]: SetPoint("BOTTOMRIGHT", f.Config, "LEFT", -36,91)
	f.Config[6]: SetPoint("BOTTOMRIGHT", f.Config, "LEFT", -81,66)
	
	f.Config: SetScript("OnShow", function(self)
		OnShow_Config(f)
	end)
	
	f.Config: SetScript("OnEnter", function(self) f.Config.Text: SetText(L.Text["CONFIG_EXIT"]) end)
	f.Config: SetScript("OnLeave", function(self) f.Config.Text: SetText("OwD") end)
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
	
	f.Config[1].Text: SetText(L.Text["CONFIG_AuraWatch"])
	f.Config[1]: SetScript("OnEnter", function(self) f.Config.exText: SetText(L.Text["CONFIG_AuraWatch_EXPLAIN"]) end)
	f.Config[1]: SetScript("OnLeave", function(self) f.Config.exText: SetText(L.Text["CONFIG_EXPLAIN"]) end)
	f.Config[1]: SetScript("OnMouseDown", function(self, button)
		if button == "LeftButton" then
			if f.AW_Config:IsVisible() then
				f.AW_Config:Hide()
			else
				f.AW_Config:Show()
			end
		elseif button == "RightButton" then
			if OwD_DB.WTF_AuraWatch then
				OwD_DB.WTF_AuraWatch = false
				f.Config[1].Border:Hide()
				L.init_AuraWatch(f.Right)
			
			else
				OwD_DB.WTF_AuraWatch = true
				f.Config[1].Border:Show()
				L.init_AuraWatch(f.Right)
			end
		end
	end)
	
	f.Config[2].Text: SetText(L.Text["CONFIG_MOVEFRAME"])
	f.Config[2]: SetScript("OnEnter", function(self) f.Config.exText: SetText(L.Text["CONFIG_MOVEFRAME_EXPLAIN"]) end)
	f.Config[2]: SetScript("OnLeave", function(self) f.Config.exText: SetText(L.Text["CONFIG_EXPLAIN"]) end)
	f.Config[2]: SetScript("OnMouseDown", function(self, button)
		if button == "LeftButton" then
			if f.MoveFrame:IsShown() then
				f.MoveFrame:Hide()
				f.Config[2].Border:Hide()
			else
				f.MoveFrame:Show()
				f.Config[2].Border:Show()
			end
		elseif button == "RightButton" then
			for key, value in pairs(L.DB["Pos"]) do
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
		end
	end)
	
	f.Config[4].Text: SetText(L.Text["CONFIG_HIDEBLIZZARD"])
	f.Config[4]: SetScript("OnEnter", function(self) f.Config.exText: SetText(L.Text["CONFIG_HIDEBLIZZARD_EXPLAIN"]) end)
	f.Config[4]: SetScript("OnLeave", function(self) f.Config.exText: SetText(L.Text["CONFIG_EXPLAIN"]) end)
	f.Config[4]: SetScript("OnClick", function(self, button)
		if OwD_DB.Hide_Blizzard then
			OwD_DB.Hide_Blizzard = false
			f.Config[4].Border:Show()
			SlashCmdList.RELOADUI()
		else
			OwD_DB.Hide_Blizzard = true
			f.Config[4].Border:Hide()
			L.Disable_Blizzard()
		end
	end)
	
	f.Config[5].Text: SetText(L.Text["CONFIG_HIDETOPBOTTOMBORDER"])
	f.Config[5]: SetScript("OnEnter", function(self) f.Config.exText: SetText(L.Text["CONFIG_HIDETOPBOTTOMBORDER_EXPLAIN"]) end)
	f.Config[5]: SetScript("OnLeave", function(self) f.Config.exText: SetText(L.Text["CONFIG_EXPLAIN"]) end)
	f.Config[5]: SetScript("OnMouseDown", function(self, button)
		if OwD_DB.Hide_TopBottomBorder then
			OwD_DB.Hide_TopBottomBorder = false
			f.Config[5].Border:Show()
			f.Artwork.Border_Bottom1:Show()
			f.Artwork.Border_Bottom2:Show()
			f.Artwork.Border_Top1:Show()
			f.Artwork.Border_Top2:Show()
		else
			OwD_DB.Hide_TopBottomBorder = true
			f.Config[5].Border:Hide()
			f.Artwork.Border_Bottom1:Hide()
			f.Artwork.Border_Bottom2:Hide()
			f.Artwork.Border_Top1:Hide()
			f.Artwork.Border_Top2:Hide()
		end
	end)
end