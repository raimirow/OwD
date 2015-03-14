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
	f.Indicator1 = L.create_Texture(f, "ARTWORK", "Bar", 10,24, 0,1,0,1, C.Color.White,0.9, "RIGHT",f.Indicator2,"LEFT",-4,0)
	
	f.Icon = L.create_Texture(f, "ARTWORK", "Icons\\OW_SonicArrow", 24,24, 0,1,0,1, C.Color.White,0.9, "LEFT",f,"LEFT",6,0)
	
	create_List_Text(f, 0)
	
	f.Delete = CreateFrame("Frame", nil, f)
	f.Delete: SetSize(28,28)
	f.Delete: SetPoint("LEFT",f,"RIGHT",4,0)
	create_Backdrop(f.Delete)
	
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
			if i <= n1 then
				f.Card[i].Icon: SetTexture(F.Media.."Icons\\"..OwD_DB.AuraFilter[classFileName][specID][1][i].Icon)
				f.Card[i].Spell: SetText(GetSpellInfo(OwD_DB.AuraFilter[classFileName][specID][1][i].Spell))
				f.Card[i].Aura: SetText(GetSpellInfo(OwD_DB.AuraFilter[classFileName][specID][1][i].Aura))
				f.Card[i].Unit: SetText(OwD_DB.AuraFilter[classFileName][specID][1][i].Unit)
				f.Card[i].Indicator = 1
				f.Card[i].Indicator1: SetVertexColor(unpack(C.Color.Blue))
				f.Card[i].Indicator2: SetVertexColor(unpack(C.Color.White2))
				f.Card[i].Indicator3: SetVertexColor(unpack(C.Color.White2))
			elseif i > n1 and i <= n1+n2 then
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
	local classFileName = select(2, UnitClass("player"))
	local specID = GetSpecialization()
	
	f.Explain = CreateFrame("Frame", nil, f)
	f.Explain: SetSize(f:GetWidth(),44)
	f.Explain: SetPoint("TOPLEFT", f, "BOTTOMLEFT", 0,-4)
	create_Backdrop(f.Explain)
	
	f.Explain.Line = L.create_Texture(f.Explain, "BORDER", "Bar", f:GetWidth()-4,3, 0,1,0,1, C.Color.White,0.9, "BOTTOM",f.Explain,"BOTTOM",0,2)
	
	f.insert = CreateFrame("Frame", nil, f)
	f.insert: SetFrameLevel(f:GetFrameLevel()+1)
	f.insert: SetSize(370,28)
	f.insert: SetPoint("TOPLEFT", f.Explain, "BOTTOMLEFT", 0,-4)
	create_Backdrop(f.insert)
	
	f.insert.Icon = L.create_Texture(f.insert, "ARTWORK", "Bar", 24,24, 0,1,0,1, C.Color.White,0.9, "BOTTOMLEFT",f.insert,"BOTTOMLEFT",6,2)
	
	f.insert.Spell = CreateFrame("EditBox", nil, f.insert)
	f.insert.Spell: SetPoint("LEFT", f.insert, "LEFT", 40,0)
	f.insert.Spell.ID = nil
	init_EidtBox(f.insert.Spell)
	
	f.insert.Aura = CreateFrame("EditBox", nil, f.insert)
	f.insert.Aura: SetPoint("LEFT", f.insert.Spell, "RIGHT", 10,0)
	f.insert.Aura.ID = nil
	init_EidtBox(f.insert.Aura)
	
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
	
	f.insert.Delete = CreateFrame("Frame", nil, f.insert)
	f.insert.Delete: SetSize(28,28)
	f.insert.Delete: SetPoint("LEFT",f.insert,"RIGHT",4,0)
	create_Backdrop(f.insert.Delete)
	
	f.insert.Delete.HL = f.insert.Delete:CreateTexture(nil, "BACKGROUND")
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
		if button == "LeftButton" then
			f.insert.Spell.ID = f.insert.Spell:GetText()
			f.insert.Aura.ID = f.insert.Aura:GetText()
			print(f.insert.Spell.ID, f.insert.Aura.ID)
		elseif button == "RightButton" then
			
		end
	end)
end

L.AuraWatch_Config = function(f)
	f.AW_Config = CreateFrame("Frame", nil, f)
	f.AW_Config: SetSize(402, 54)
	f.AW_Config: SetPoint("TOPLEFT", f, "CENTER", 160,80)
	--f.AW_Config: SetFrameStrata("HIGH")
	f.AW_Config: SetFrameLevel(20)
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
end

