local C, F, L = unpack(select(2, ...))

L.init_Smooth = function(self)
	self.Per = 0
	self.Cur = 0
	self.Max = 100
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

L.TradeSkillFrame = function()
	local TSF = CreateFrame("Frame", nil ,UIParent)
	TSF: RegisterEvent("ADDON_LOADED", "Blizzard_TradeSkillUI")
	TSF: SetScript("OnEvent", function(self,event,name)
		if name == "Blizzard_TradeSkillUI" then
			TRADE_SKILLS_DISPLAYED = 20
			local DetailHeight = TRADE_SKILLS_DISPLAYED * 16
			--- Create Skill Buttons ---
			for i = 9, TRADE_SKILLS_DISPLAYED do
				local skillButton = CreateFrame('Button', 'TradeSkillSkill' .. i, TradeSkillFrame, 'TradeSkillSkillButtonTemplate')
				skillButton:SetPoint('TOPLEFT', _G['TradeSkillSkill' .. (i - 1)], 'BOTTOMLEFT')
			end
			
			TradeSkillFrame: SetHeight(DetailHeight + 114 + TradeSkillDetailScrollFrame:GetHeight() + 30)
			
			TradeSkillListScrollFrame: SetHeight(DetailHeight)
			
			TradeSkillDetailScrollFrame: ClearAllPoints()
			TradeSkillDetailScrollFrame: SetPoint("TOPLEFT", TradeSkillListScrollFrame, "BOTTOMLEFT", 0, -20)
		end
	end)
	--[[
	if not IsAddOnLoaded("Blizzard_TradeSkillUI") then
		LoadAddOn("Blizzard_TradeSkillUI")
	end
	--]]
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

--- ----------------------------------------------------------------------------
--> Artwork     
--- ----------------------------------------------------------------------------

L.change_Font = function()
	DAMAGE_TEXT_FONT = C.Font.Name
end

L.Artwork = function(f)
	f.Artwork = CreateFrame("Frame", nil, f)
	
	f.Artwork.Border_Bottom1 = L.create_Texture(f.Artwork, "BORDER", "Artwork_BottomBorder", 169,26, 44/256,213/256,3/32,29/32, C.Color.White, 1, "BOTTOM", UIParent, "BOTTOM", -400,40)
	f.Artwork.Border_Bottom2 = L.create_Texture(f.Artwork, "BORDER", "Artwork_BottomBorder", 169,26, 213/256,44/256,3/32,29/32, C.Color.White, 1, "BOTTOM", UIParent, "BOTTOM", 400,40)
	
	f.Artwork.Border_Top1 = L.create_Texture(f.Artwork, "BORDER", "Artwork_TopBorder", 169,19, 44/256,213/256,7/32,26/32, C.Color.White, 1, "TOP", UIParent, "TOP", -400,-40)
	f.Artwork.Border_Top2 = L.create_Texture(f.Artwork, "BORDER", "Artwork_TopBorder", 169,19, 213/256,44/256,7/32,26/32, C.Color.White, 1, "TOP", UIParent, "TOP", 400,-40)
	
	f.Artwork.B1 = L.create_Texture(f.Artwork, "BORDER", "Target_B1", 1024,512, 0,1,0,1, C.Color.White,0.9, "CENTER",f,"CENTER",0,0)
end

L.OnUpdate_Artwork_gap = function(f)
	if (f.Target:IsVisible()) or (f.GCD:GetAlpha() ~= 0) or (f.Focus.Castbar:IsVisible())then
		f.Artwork.B1: Show()
	else
		f.Artwork.B1: Hide()
	end
end

L.Feedback = function(f)
	f.Feedback = CreateFrame("Frame", nil, f)
	f.Feedback.x = 0
	f.Feedback.x_offset = 0
	f.Feedback.y = 0
	f.Feedback.y_offset = 0
	f.Feedback.dir = -1
	
	f.Feedback: RegisterEvent("UNIT_HEALTH_FREQUENT")
	f.Feedback: RegisterEvent("UNIT_COMBAT")
	f.Feedback: SetScript("OnEvent", function(self,event,arg1,arg2,arg3,arg4,arg5) --("unitID", "action", "descriptor", damage, damageType)
		if event == "UNIT_COMBAT" then
			if arg1 == "player" then
				if arg2 == "WOUND" then
					if arg4 ~= 0 then
						local maxHealth = UnitHealthMax("player")
						local d = floor(abs(arg4/maxHealth)*100)/100
						if d > 0.001 then
							f.Feedback.x_offset = max(f.Feedback.x_offset, d*34)
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
	end)
end