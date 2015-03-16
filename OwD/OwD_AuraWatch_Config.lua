local C, F, L = unpack(select(2, ...))


--- ----------------------------------------------------------------------------
--> Function
--- ----------------------------------------------------------------------------

local create_Backdrop = function(f)
	f: SetBackdrop({
		bgFile = F.Media.."Bar", 
		tile = false, 
		tileSize = 0, 
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	})
	f: SetBackdropColor(C.Color.Black[1],C.Color.Black[2],C.Color.Black[3],0.75)
	f: SetBackdropBorderColor(C.Color.White[1],C.Color.White[2],C.Color.White[3],0)
	
	if f.shadow then return end
	f.shadow = CreateFrame("Frame", nil, f)
	f.shadow:SetFrameLevel(0)
	f.shadow:SetFrameStrata(f:GetFrameStrata())
	f.shadow:SetPoint("TOPLEFT", -2, 2)
	f.shadow:SetPoint("BOTTOMLEFT", -2, -2)
	f.shadow:SetPoint("TOPRIGHT", 2, 2)
	f.shadow:SetPoint("BOTTOMRIGHT", 2, -2)
	f.shadow:SetBackdrop({
		edgeFile = F.Media.."glowTex", 
		edgeSize = 2,
		insets = { left = 0, right = 0, top = 0, bottom = 0 }
	})
	
	f.shadow: SetBackdropColor( .05,.05,.05, 0)
	f.shadow: SetBackdropBorderColor(C.Color.White2[1],C.Color.White2[2],C.Color.White2[3],0.5)
end

--- ----------------------------------------------------------------------------
--> AuraWatch_Config Frame
--- ----------------------------------------------------------------------------
local create_List_Text = function(f, y)
	f.Spell = L.create_Fontstring(f, C.Font.Name, 12, nil)
	f.Spell: SetJustifyH("CENTER")
	f.Spell: SetWidth(100)
	f.Spell: SetPoint("LEFT", f, "LEFT", 40,y)
	f.Spell: SetText("Spell")
	
	f.Aura = L.create_Fontstring(f, C.Font.Name, 12, nil)
	f.Aura: SetJustifyH("CENTER")
	f.Aura: SetWidth(100)
	f.Aura: SetPoint("LEFT", f.Spell, "RIGHT", 10,0)
	f.Aura: SetText("Aura")

	f.Unit = L.create_Fontstring(f, C.Font.Name, 12, nil)
	f.Unit: SetJustifyH("CENTER")
	f.Unit: SetWidth(60)
	f.Unit: SetPoint("LEFT", f.Aura, "RIGHT", 10, 0)
	f.Unit: SetText("Unit")
end

local Spell_Card = function(f)
	
	create_Backdrop(f)
	
	f.HL = f:CreateTexture(nil, "BORDER")
	f.HL: SetTexture(F.Media.."Bar")
	f.HL: SetAllPoints(f)
	f.HL: SetVertexColor(unpack(C.Color.Blue2))
	f.HL: SetAlpha(0.5)
	f.HL: Hide()
	
	f.Indicator3 = L.create_Texture(f, "ARTWORK", "Bar", 10,24, 0,1,0,1, C.Color.White2,0.9, "RIGHT",f,"RIGHT",-4,0)
	f.Indicator2 = L.create_Texture(f, "ARTWORK", "Bar", 10,24, 0,1,0,1, C.Color.White2,0.9, "RIGHT",f.Indicator3,"LEFT",-4,0)
	f.Indicator1 = L.create_Texture(f, "ARTWORK", "Bar", 10,24, 0,1,0,1, C.Color.Blue,0.9, "RIGHT",f.Indicator2,"LEFT",-4,0)
	
	f.Icon = L.create_Texture(f, "ARTWORK", "Icons\\OW_SonicArrow", 24,24, 0,1,0,1, C.Color.White,0.9, "LEFT",f,"LEFT",6,0)
	
	create_List_Text(f, 0)
	
	f.Delete = CreateFrame("Frame", nil, f)
	f.Delete: SetSize(28,28)
	f.Delete: SetPoint("LEFT",f,"RIGHT",4,0)
	create_Backdrop(f.Delete)
	f.Delete.Tex = L.create_Texture(f.Delete, "ARTWORK", "Config_No", 18,18, 0,1,0,1, C.Color.White,0.9, "CENTER",f.Delete,"CENTER",0,0)
	
	f.Delete.HL = f.Delete:CreateTexture(nil, "BACKGROUND")
	f.Delete.HL: SetTexture(F.Media.."Bar")
	f.Delete.HL: SetAllPoints(f.Delete)
	f.Delete.HL: SetVertexColor(unpack(C.Color.Blue))
	f.Delete.HL: SetAlpha(0.5)
	f.Delete.HL: Hide()
end

local init_EidtBox = function(f)
	f: SetSize(100,24)
	f: SetAutoFocus(false)
	f: SetFont(C.Font.Name, 12, nil)
	f: SetJustifyH("CENTER")
	
	f: SetBackdrop({
		bgFile = F.Media.."Bar", 
		edgeFile = F.Media.."Bar", 
		tile = false, 
		tileSize = 1, 
		edgeSize = 1, 
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	})
	f: SetBackdropColor(C.Color.White2[1],C.Color.White2[2],C.Color.White2[3],0)
	f: SetBackdropBorderColor(C.Color.White2[1],C.Color.White2[2],C.Color.White2[3],0.75)
	
	f: SetScript("OnEscapePressed", function(self)
		self: ClearFocus() 
	end)
end

local iconselect = {
	{'AngelicDescent', 'ArmorPack', 'Barrage', 'Blink', 'BuildTurret', 'Charge'},
	{'CombatRoll', 'ConcussiveBlast', 'Deadeye', 'DeathBlossom', 'Dragonstrike', 'FireStrike'},
	{'Flashbang', 'GrapplingHook', 'GravitonSurge', 'GuardianAngel', 'Infrasight', 'JumpJet'},
	{'JumpPack', 'MoltenCore', 'OrbofDiscord', 'OrbofHarmony', 'ParticleBarrier', 'PhotonShield'},
	{'PrimalRage', 'ProjectedBarrier', 'PulseBomb', 'Recall', 'Reconfigure', 'RemoteMine'},
	{'Resurrect', 'ScatterArrow', 'SelfRepair', 'SentryTurret', 'ShadowStep', 'Shield'},
	{'ShieldProjector', 'SonicArrow', 'Teleporter', 'Transcendence', 'VenomMine', 'WraithForm'},
}

local create_IconSelect = function(f)
	--local i = f:GetParent()
	--local p = i:GetParent()
	local p = f:GetParent()
	f.IS = CreateFrame("Frame", nil, f)
	f.IS: SetSize(32*6+4, 32*7+4)
	--f.IS: SetPoint("TOPRIGHT",p,"TOPLEFT",-10,0)
	f.IS: SetPoint("BOTTOMRIGHT",p,"BOTTOMLEFT",-10,0)
	create_Backdrop(f.IS)
	
	for i = 1,6 do
		f.IS[i] = {}
		for j = 1,7 do
			f.IS[i][j] = CreateFrame("Frame", nil, f.IS)
			f.IS[i][j]: SetSize(28,28)
			if j == 1 then
				if i == 1 then
					f.IS[i][j]: SetPoint("TOPLEFT", f.IS, "TOPLEFT", 4,-4)
				else
					f.IS[i][j]: SetPoint("TOPLEFT", f.IS[i-1][j], "TOPRIGHT", 4,0)
				end
			else
				if i == 1 then
					f.IS[i][j]: SetPoint("TOPLEFT", f.IS[i][j-1], "BOTTOMLEFT", 0,-4)
				else
					f.IS[i][j]: SetPoint("TOPLEFT", f.IS[i-1][j], "TOPRIGHT", 4,0)
				end
			end
			f.IS[i][j].Tex = f.IS[i][j]:CreateTexture(nil, "ARTWORK")
			f.IS[i][j].Tex: SetTexture(F.Media.."Icons\\"..iconselect[j][i])
			f.IS[i][j].Tex: SetAllPoints(f.IS[i][j])
			f.IS[i][j].Tex: SetVertexColor(unpack(C.Color.White))
			f.IS[i][j].Tex: SetAlpha(0.9)
			
			f.IS[i][j]: SetScript("OnMouseDown", function(self,button)
				f.ID = iconselect[j][i]
				f.Tex: SetTexture(F.Media.."Icons\\"..iconselect[j][i])
				f.IS: Hide()
			end)
		end
	end
	f.IS: Hide()
end

L.update_Card = function(f)
	local classFileName = select(2, UnitClass("player"))
	local specID = GetSpecialization()
	local n0, n1, n2, n3 = 0, 0, 0, 0
	n1 = #OwD_DB.AuraFilter[classFileName][specID][1]
	n2 = #OwD_DB.AuraFilter[classFileName][specID][2]
	if #f.Card >= n1 + n2 + 1 then
		for i = n1 + n2 + 1, #f.Card do
			f.Card[i]:Hide()
			f.Card[i] = nil
			table.remove(f.Card,i)
		end
	end
	if n1 + n2 >= 1 then
		for i = 1, n1+n2 do
			if i <= n1 and (OwD_DB.AuraFilter[classFileName][specID][1][i].Icon) then
				f.Card[i].Icon: SetTexture(F.Media.."Icons\\"..OwD_DB.AuraFilter[classFileName][specID][1][i].Icon)
				f.Card[i].Spell: SetText(GetSpellInfo(OwD_DB.AuraFilter[classFileName][specID][1][i].Spell))
				f.Card[i].Aura: SetText(GetSpellInfo(OwD_DB.AuraFilter[classFileName][specID][1][i].Aura))
				f.Card[i].Unit: SetText(OwD_DB.AuraFilter[classFileName][specID][1][i].Unit)
				f.Card[i].Indicator = 1
				f.Card[i].Indicator1: SetVertexColor(unpack(C.Color.Blue))
				f.Card[i].Indicator2: SetVertexColor(unpack(C.Color.White2))
				f.Card[i].Indicator3: SetVertexColor(unpack(C.Color.White2))
			elseif i > n1 and i <= n1+n2 and (OwD_DB.AuraFilter[classFileName][specID][2][i-n1].Icon) then
				f.Card[i].Icon: SetTexture(F.Media.."Icons\\"..OwD_DB.AuraFilter[classFileName][specID][2][i-n1].Icon)
				f.Card[i].Spell: SetText(GetSpellInfo(OwD_DB.AuraFilter[classFileName][specID][2][i-n1].Spell))
				f.Card[i].Aura: SetText(GetSpellInfo(OwD_DB.AuraFilter[classFileName][specID][2][i-n1].Aura))
				f.Card[i].Unit: SetText(OwD_DB.AuraFilter[classFileName][specID][2][i-n1].Unit)
				f.Card[i].Indicator = 2
				f.Card[i].Indicator1: SetVertexColor(unpack(C.Color.White2))
				f.Card[i].Indicator2: SetVertexColor(unpack(C.Color.Blue))
				f.Card[i].Indicator3: SetVertexColor(unpack(C.Color.White2))
			end
			
			if i == 1 then
				f.Card[i]: SetPoint("TOPLEFT", f, "BOTTOMLEFT", 0,-4)
			else
				f.Card[i]: SetPoint("TOPLEFT", f.Card[i-1], "BOTTOMLEFT", 0,-4)
			end
			f.Card[i]: SetScript("OnMouseDown", function(self,button)
				if button == "LeftButton" then
					if f.Card[i-1] and f.Card[i-1].Indicator == f.Card[i].Indicator then 
						local a = {}
						local b = {}
						local c = 0
						if f.Card[i].Indicator == 2 then
							c = n1
						end
						a = OwD_DB.AuraFilter[classFileName][specID][f.Card[i].Indicator][i-c-1]
						OwD_DB.AuraFilter[classFileName][specID][f.Card[i].Indicator][i-c-1] = OwD_DB.AuraFilter[classFileName][specID][f.Card[i].Indicator][i-c]
						OwD_DB.AuraFilter[classFileName][specID][f.Card[i].Indicator][i-c] = a
						L.update_Card(f)
					end
				elseif button == "RightButton" then
					if f.Card[i+1] and f.Card[i+1].Indicator == f.Card[i].Indicator then 
						local a = {}
						local b = {}
						local c = 0
						if f.Card[i].Indicator == 2 then
							c = n1
						end
						a = OwD_DB.AuraFilter[classFileName][specID][f.Card[i].Indicator][i-c+1]
						OwD_DB.AuraFilter[classFileName][specID][f.Card[i].Indicator][i-c+1] = OwD_DB.AuraFilter[classFileName][specID][f.Card[i].Indicator][i-c]
						OwD_DB.AuraFilter[classFileName][specID][f.Card[i].Indicator][i-c] = a
						L.update_Card(f)
					end
				end
			end)
			f.Card[i].Delete: SetScript("OnMouseDown", function(self,button)
				if i <= n1 then
					table.remove(OwD_DB.AuraFilter[classFileName][specID][f.Card[i].Indicator],i)
				else
					table.remove(OwD_DB.AuraFilter[classFileName][specID][f.Card[i].Indicator],i-n1)
				end
				L.update_Card(f)
			end)
		end
	end
	if n1 + n2 >= 1 then
		f.Explain: ClearAllPoints()
		f.Explain: SetPoint("TOPLEFT", f.Card[n1+n2], "BOTTOMLEFT", 0,-4)
	else
		f.Explain: ClearAllPoints()
		f.Explain: SetPoint("TOPLEFT", f, "BOTTOMLEFT", 0,-4)
	end
	
	-->
	if n1 + n2 > 20 then
		f.insert: Hide()
	else
		f.insert: Show()
	end
	
	-->
	local p = f:GetParent()
	L.init_AuraWatch(p.Right)
end

L.update_AW_Config = function(f)
	local classFileName = select(2, UnitClass("player"))
	local specID = GetSpecialization()
	local n1, n2, n3 = 0, 0, 0
	n1 = #OwD_DB.AuraFilter[classFileName][specID][1]
	n2 = #OwD_DB.AuraFilter[classFileName][specID][2]
	
	if n1 + n2 >= 1 then
		for i = 1, n1+n2 do
			if not f.Card[i] then
				f.Card[i] = CreateFrame("Frame", nil, f)
				f.Card[i]: SetSize(370,28)
				Spell_Card(f.Card[i])
				
				f.Card[i]: SetScript("OnEnter", function(self)
					self.HL: Show()
				end)
				f.Card[i]: SetScript("OnLeave", function(self)
					self.HL: Hide()
				end)
			
				f.Card[i].Delete: SetScript("OnEnter", function(self)
					self.HL: Show()
				end)
				f.Card[i].Delete: SetScript("OnLeave", function(self)
					self.HL: Hide()
				end)
			end
		end
	end
	L.update_Card(f)
end

local init_AW_Config = function(f)
	--local classFileName = select(2, UnitClass("player"))
	--local specID = GetSpecialization()
	
	f.Explain = CreateFrame("Frame", nil, f)
	f.Explain: SetSize(f:GetWidth(),44)
	f.Explain: SetPoint("TOPLEFT", f, "BOTTOMLEFT", 0,-4)
	create_Backdrop(f.Explain)
	f.Explain.Line = L.create_Texture(f.Explain, "BORDER", "Bar", f:GetWidth()-4,3, 0,1,0,1, C.Color.White,0.9, "BOTTOM",f.Explain,"BOTTOM",0,2)
	f.Explain.Text = L.create_Fontstring(f.Explain, C.Font.Name, 12, nil)
	f.Explain.Text: SetJustifyH("LEFT")
	f.Explain.Text: SetWidth(320)
	f.Explain.Text: SetPoint("TOPLEFT", f.Explain, "TOPLEFT", 4,-4)
	f.Explain.Text: SetText("左键点击上移，右键点击下移，点 X 号删除技能。\n下方输入新技能，点对号添加。")
	
	
	f.insert = CreateFrame("Frame", nil, f)
	f.insert: SetFrameLevel(f:GetFrameLevel()+1)
	f.insert: SetSize(370,28)
	f.insert: SetPoint("TOPLEFT", f.Explain, "BOTTOMLEFT", 0,-4)
	create_Backdrop(f.insert)
	
	-->
	f.insert.Icon = CreateFrame("Frame", nil, f.insert)
	f.insert.Icon: SetSize(24,24)
	f.insert.Icon: SetPoint("BOTTOMLEFT",f.insert,"BOTTOMLEFT",6,2)
	f.insert.Icon.ID = "Reconfigure"
	f.insert.Icon.Tex = L.create_Texture(f.insert, "ARTWORK", "Icons\\Reconfigure", 24,24, 0,1,0,1, C.Color.White,0.9, "BOTTOMLEFT",f.insert.Icon,"BOTTOMLEFT",0,0)
	create_IconSelect(f.insert.Icon)
	f.insert.Icon: SetScript("OnMouseDown", function(self,button)
		if self.IS:IsVisible() then
			self.IS:Hide()
		else
			self.IS:Show()
		end
	end)
	
	-->
	f.insert.Spell = CreateFrame("EditBox", nil, f.insert)
	f.insert.Spell: SetPoint("LEFT", f.insert, "LEFT", 40,0)
	f.insert.Spell.ID = nil
	init_EidtBox(f.insert.Spell)
	
	-->
	f.insert.Aura = CreateFrame("EditBox", nil, f.insert)
	f.insert.Aura: SetPoint("LEFT", f.insert.Spell, "RIGHT", 10,0)
	f.insert.Aura.ID = nil
	init_EidtBox(f.insert.Aura)
	
	-->
	f.insert.Unit = CreateFrame("Frame", nil, f.insert)
	f.insert.Unit: SetSize(60,24)
	f.insert.Unit: SetPoint("LEFT", f.insert.Aura, "RIGHT", 10,0)
	f.insert.Unit.ID = nil
	f.insert.Unit: SetBackdrop({
		bgFile = F.Media.."Bar", 
		edgeFile = F.Media.."Bar", 
		tile = false, 
		tileSize = 1, 
		edgeSize = 1, 
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	})
	f.insert.Unit: SetBackdropColor(C.Color.White2[1],C.Color.White2[2],C.Color.White2[3],0)
	f.insert.Unit: SetBackdropBorderColor(C.Color.White2[1],C.Color.White2[2],C.Color.White2[3],0.75)
	f.insert.Unit.Text = L.create_Fontstring(f.insert.Unit, C.Font.Name, 12, nil)
	f.insert.Unit.Text: SetJustifyH("CENTER")
	f.insert.Unit.Text: SetWidth(50)
	f.insert.Unit.Text: SetPoint("CENTER", f.insert.Unit, "CENTER", 0,0)
	f.insert.Unit.ID = "target"
	f.insert.Unit.Text: SetText(f.insert.Unit.ID)
	f.insert.Unit: SetScript("OnMouseDown", function(self,button)
		if f.insert.Unit.ID == "target" then
			f.insert.Unit.ID = "player"
		else
			f.insert.Unit.ID = "target"
		end
		self.Text: SetText(f.insert.Unit.ID)
	end)
	
	-->
	f.insert.Indicator = CreateFrame("Frame", nil, f.insert)
	f.insert.Indicator: SetSize(38,24)
	f.insert.Indicator: SetPoint("RIGHT", f.insert, "RIGHT", -4,0)
	f.insert.Indicator[1] = L.create_Texture(f.insert.Indicator, "ARTWORK", "Bar", 10,24, 0,1,0,1, C.Color.Blue,0.9, "LEFT",f.insert.Indicator,"LEFT",0,0)
	f.insert.Indicator[2] = L.create_Texture(f.insert.Indicator, "ARTWORK", "Bar", 10,24, 0,1,0,1, C.Color.White2,0.9, "LEFT",f.insert.Indicator[1],"RIGHT",4,0)
	f.insert.Indicator[3] = L.create_Texture(f.insert.Indicator, "ARTWORK", "Bar", 10,24, 0,1,0,1, C.Color.White2,0.9, "LEFT",f.insert.Indicator[2],"RIGHT",4,0)
	f.insert.Indicator.ID = 1
	f.insert.Indicator: SetScript("OnMouseDown", function(self,button)
		if f.insert.Indicator.ID == 1 then
			f.insert.Indicator.ID = 2
		elseif f.insert.Indicator.ID == 2 then
			f.insert.Indicator.ID = 1
		end
		for i = 1,3 do
			if i == f.insert.Indicator.ID then
				f.insert.Indicator[i]:SetVertexColor(unpack(C.Color.Blue))
			else
				f.insert.Indicator[i]:SetVertexColor(unpack(C.Color.White2))
			end
		end
	end)
	
	-->
	f.insert.Delete = CreateFrame("Frame", nil, f.insert)
	f.insert.Delete: SetSize(28,28)
	f.insert.Delete: SetPoint("LEFT",f.insert,"RIGHT",4,0)
	create_Backdrop(f.insert.Delete)
	
	f.insert.Delete.Tex = L.create_Texture(f.insert.Delete, "ARTWORK", "Config_Yes", 18,18, 0,1,0,1, C.Color.White,0.9, "CENTER",f.insert.Delete,"CENTER",0,0)
	
	f.insert.Delete.HL = f.insert.Delete:CreateTexture(nil, "BORDER")
	f.insert.Delete.HL: SetTexture(F.Media.."Bar")
	f.insert.Delete.HL: SetAllPoints(f.insert.Delete)
	f.insert.Delete.HL: SetVertexColor(unpack(C.Color.Blue))
	f.insert.Delete.HL: SetAlpha(0.5)
	f.insert.Delete.HL: Hide()
	
	f.insert.Delete: SetScript("OnEnter", function(self)
		self.HL: Show()
	end)
	f.insert.Delete: SetScript("OnLeave", function(self)
		self.HL: Hide()
	end)
	
	f.insert.Delete: SetScript("OnMouseDown", function(self,button)
		f.insert.Spell.ID = f.insert.Spell:GetText()
		f.insert.Aura.ID = f.insert.Aura:GetText()
		if f.insert.Icon.ID and f.insert.Indicator.ID then
			if f.insert.Spell.ID or (f.insert.Aura.ID and f.insert.Unit.ID) then
				local classFileName = select(2, UnitClass("player"))
				local specID = GetSpecialization()
				local n1, n2, n3 = 0, 0, 0
				n1 = #OwD_DB.AuraFilter[classFileName][specID][1]
				n2 = #OwD_DB.AuraFilter[classFileName][specID][2]
				if f.insert.Indicator.ID == 1 then
					OwD_DB.AuraFilter[classFileName][specID][1][n1+1] = {
					Spell = f.insert.Spell.ID,
					Aura = f.insert.Aura.ID, 
					Unit = f.insert.Unit.ID, 
					Icon = f.insert.Icon.ID,
					}
				elseif f.insert.Indicator.ID == 2 then
					OwD_DB.AuraFilter[classFileName][specID][2][n2+1] = {
						Spell = f.insert.Spell.ID,
						Aura = f.insert.Aura.ID, 
						Unit = f.insert.Unit.ID, 
						Icon = f.insert.Icon.ID,
					}
				end
				
				f.insert.Spell:SetText("")
				f.insert.Spell:ClearFocus()
				f.insert.Aura:SetText("")
				f.insert.Aura:ClearFocus()
				L.update_AW_Config(f)
			end
		end
	end)
end

L.AuraWatch_Config = function(f)
	f.AW_Config = CreateFrame("Frame", nil, f)
	f.AW_Config: SetSize(402, 54)
	f.AW_Config: SetPoint("TOPLEFT", f, "CENTER", 160,80)
	--f.AW_Config: SetFrameStrata("HIGH")
	f.AW_Config: SetFrameLevel(20)
	f.AW_Config: SetClampedToScreen(true) 
	f.AW_Config: Hide()
	
	create_Backdrop(f.AW_Config)
	f.AW_Config.Line = f.AW_Config:CreateTexture(nil, "BORDER")
	f.AW_Config.Line: SetTexture(F.Media.."Bar")
	f.AW_Config.Line: SetSize(f.AW_Config:GetWidth()-4,3)
	f.AW_Config.Line: SetPoint("BOTTOM", f.AW_Config, "BOTTOM", 0,20)
	f.AW_Config.Line: SetVertexColor(unpack(C.Color.White))
	f.AW_Config.Line: SetAlpha(0.9)
	
	f.AW_Config.Title = L.create_Fontstring(f.AW_Config, C.Font.Name, 16, nil)
	f.AW_Config.Title: SetJustifyH("LEFT")
	--f.AW_Config.Title: SetWidth(90)
	f.AW_Config.Title: SetPoint("TOPLEFT", f.AW_Config, "TOPLEFT", 8,-10)
	f.AW_Config.Title: SetText("AuraWatch")
	
	create_List_Text(f.AW_Config, -16)
	
	f.AW_Config.Card = {}
	init_AW_Config(f.AW_Config)
	
	f.AW_Config: SetScript("OnShow", function(self)
		L.update_AW_Config(f.AW_Config)
	end)
	
	f.AW_Config: SetMovable(true)
	f.AW_Config: EnableMouse(true)
	f.AW_Config: SetUserPlaced(false)
	f.AW_Config: RegisterForDrag("LeftButton")
	f.AW_Config: SetScript("OnDragStart", function(self) self:StartMoving() end)
	f.AW_Config: SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
	
	-->Close Button
	f.AW_Config.Close = CreateFrame("Frame", nil, f.AW_Config)
	f.AW_Config.Close: SetSize(28, 20)
	f.AW_Config.Close: SetPoint("TOPRIGHT", f.AW_Config, "TOPRIGHT", -2,-2)
	f.AW_Config.Close: SetBackdrop({
		bgFile = F.Media.."Bar", 
		tile = false, 
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	})
	f.AW_Config.Close: SetBackdropColor(C.Color.Red[1],C.Color.Red[2],C.Color.Red[3],0.75)
	f.AW_Config.Close: SetBackdropBorderColor(C.Color.White2[1],C.Color.White2[2],C.Color.White2[3],0)
	f.AW_Config.Close.Tex = L.create_Texture(f.AW_Config.Close, "ARTWORK", "Config_No", 18,18, 0,1,0,1, C.Color.White,0.9, "CENTER",f.AW_Config.Close,"CENTER",0,0)
	
	f.AW_Config.Close: SetScript("OnMouseDown", function(self,button)
		f.AW_Config:Hide()
	end)
	
	-->Reset Button
	f.AW_Config.Reset = CreateFrame("Frame", nil, f.AW_Config)
	f.AW_Config.Reset: SetSize(12, 20)
	f.AW_Config.Reset: SetPoint("TOPRIGHT", f.AW_Config.Close, "TOPLEFT", -10,0)
	
	f.AW_Config.Reset.Text = L.create_Fontstring(f.AW_Config.Reset, C.Font.Name, 14, nil)
	f.AW_Config.Reset.Text: SetJustifyH("CENTER")
	f.AW_Config.Reset.Text: SetPoint("CENTER", f.AW_Config.Reset, "CENTER", 0,0)
	f.AW_Config.Reset.Text: SetText("R")
	
	f.AW_Config.Reset: SetScript("OnMouseDown", function(self,button)
		if f.AW_Config.Reset.Warn:IsVisible() then
			f.AW_Config.Reset.Warn:Hide()
		else
			f.AW_Config.Reset.Warn:Show()
		end
	end)
	
	f.AW_Config.Reset.Warn = CreateFrame("Frame", nil, f.AW_Config.Reset)
	f.AW_Config.Reset.Warn: SetSize(220,28)
	f.AW_Config.Reset.Warn: SetPoint("BOTTOMRIGHT", f.AW_Config, "TOPRIGHT", 0,8)
	create_Backdrop(f.AW_Config.Reset.Warn)
	f.AW_Config.Reset.Warn: Hide()
	
	f.AW_Config.Reset.Warn.Text = L.create_Fontstring(f.AW_Config.Reset.Warn, C.Font.Name, 12, nil)
	f.AW_Config.Reset.Warn.Text: SetJustifyH("CENTER")
	f.AW_Config.Reset.Warn.Text: SetPoint("CENTER", f.AW_Config.Reset.Warn, "CENTER", 0,0)
	f.AW_Config.Reset.Warn.Text: SetText("用Lua替换存档")
	
	f.AW_Config.Reset.Warn.Yes = CreateFrame("Frame", nil, f.AW_Config.Reset.Warn)
	f.AW_Config.Reset.Warn.Yes: SetSize(28,24)
	f.AW_Config.Reset.Warn.Yes: SetPoint("LEFT", f.AW_Config.Reset.Warn, "LEFT", 2,0)
	f.AW_Config.Reset.Warn.Yes: SetBackdrop({
		bgFile = F.Media.."Bar", 
		tile = false, 
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	})
	f.AW_Config.Reset.Warn.Yes: SetBackdropColor(C.Color.Blue[1],C.Color.Blue[2],C.Color.Blue[3],0.75)
	f.AW_Config.Reset.Warn.Yes: SetBackdropBorderColor(C.Color.White2[1],C.Color.White2[2],C.Color.White2[3],0)
	f.AW_Config.Reset.Warn.Yes.Tex = L.create_Texture(f.AW_Config.Reset.Warn.Yes, "ARTWORK", "Config_Yes", 18,18, 0,1,0,1, C.Color.White,0.9, "CENTER",f.AW_Config.Reset.Warn.Yes,"CENTER",0,0)
	
	f.AW_Config.Reset.Warn.Yes: SetScript("OnMouseDown", function(self,button)
		OwD_DB.AuraFilter = nil
		OwD_DB["AuraFilter"] = {}
		for k1, v1 in pairs(L.AuraFilter) do
			if OwD_DB["AuraFilter"][k1] == nil then
				OwD_DB["AuraFilter"][k1] = {}
				if type(v1) == "table" then
					for k2, v2 in pairs(v1) do
						OwD_DB["AuraFilter"][k1][k2] = v1[k2]
					end
				else
					OwD_DB["AuraFilter"][k1] = v1
				end
			end
		end
		L.update_AW_Config(f.AW_Config)
		f.AW_Config.Reset.Warn:Hide()
	end)
	
	f.AW_Config.Reset.Warn.No = CreateFrame("Frame", nil, f.AW_Config.Reset.Warn)
	f.AW_Config.Reset.Warn.No: SetSize(28,24)
	f.AW_Config.Reset.Warn.No: SetPoint("RIGHT", f.AW_Config.Reset.Warn, "RIGHT", -2,0)
	f.AW_Config.Reset.Warn.No: SetBackdrop({
		bgFile = F.Media.."Bar", 
		tile = false, 
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	})
	f.AW_Config.Reset.Warn.No: SetBackdropColor(C.Color.Red[1],C.Color.Red[2],C.Color.Red[3],0.75)
	f.AW_Config.Reset.Warn.No: SetBackdropBorderColor(C.Color.White2[1],C.Color.White2[2],C.Color.White2[3],0)
	f.AW_Config.Reset.Warn.No.Tex = L.create_Texture(f.AW_Config.Reset.Warn.No, "ARTWORK", "Config_No", 18,18, 0,1,0,1, C.Color.White,0.9, "CENTER",f.AW_Config.Reset.Warn.No,"CENTER",0,0)
	
	f.AW_Config.Reset.Warn.No: SetScript("OnMouseDown", function(self,button)
		f.AW_Config.Reset.Warn:Hide()
	end)
end

