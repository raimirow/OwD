local C, F, L = unpack(select(2, ...))
L.M = {}

---- ----------------------------------
-->> Hunter
---- ----------------------------------

local raid_Buff = {
	[1] = 160206, --巨猿之力,0,属性,Stats
	[2] = 160199, --巨熊之韧,0,耐力,Stamina
	[3] =  19506, --强击光环,15,Attack Power
	[4] = 160203, --土狼之速,0,急速,Haste
	[5] = 160205, --神龙之智,0,法强,Spell Power
	[6] = 160200, --迅猛龙之恶,0,暴击,Critical Strike
	[7] = 160198, --猫之优雅,0, 精通550,Mastery
	[8] = 172968, --龙鹰之速,0 溅射5%,Multistrike
	[9] = 172967, --掠食者之力,0,全能,Versatility
}
--独来独往, BuffID 164273, SpellID 155228

local check_Buff = {
	[1] = {--野兽控制
		[1] = {1, raid_Buff[1]},
		[2] = {7, raid_Buff[7]},
		[3] = {8, raid_Buff[8]},
		[4] = {4, raid_Buff[4]},
		[5] = {6, raid_Buff[6]},
		[6] = {9, raid_Buff[9]},
		[7] = {2, raid_Buff[2]},
		[8] = {5, raid_Buff[5]},
	},
	[2] = {--射击
		[1] = {1, raid_Buff[1]},
		[2] = {6, raid_Buff[6]},
		[3] = {8, raid_Buff[8]},
		[4] = {7, raid_Buff[7]},
		[5] = {4, raid_Buff[4]},
		[6] = {9, raid_Buff[9]},
		[7] = {2, raid_Buff[2]},
		[8] = {5, raid_Buff[5]},
	},
	[3] = {--生存
		[1] = {1, raid_Buff[1]},
		[2] = {8, raid_Buff[8]},
		[3] = {9, raid_Buff[9]},
		[4] = {6, raid_Buff[6]},
		[5] = {7, raid_Buff[7]},
		[6] = {4, raid_Buff[4]},
		[7] = {2, raid_Buff[2]},
		[8] = {5, raid_Buff[5]},
	},
}
L.M.Hunter_Alone = function(f)
	f.Alone = CreateFrame("Frame", nil, f)
	if OwD_DB["OwD_HunterAlone"] then
		f.Alone: Show()
	else
		f.Alone: Hide()
	end
	local classFileName = select(2, UnitClass("player"))
	if classFileName == "HUNTER" then
		f.Alone.Button = CreateFrame("Button", "OwD_HunterAlone", f.Alone, "SecureActionButtonTemplate") --"ActionButtonTemplate, SecureActionButtonTemplate"
		f.Alone.Button: SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", 0,0)
		f.Alone.Button: SetSize(28,28)
		f.Alone.Button: SetAttribute("type", "spell")
		
		f.Alone.Icon1 = f.Alone.Button:CreateTexture(nil, "ARTWORK")
		f.Alone.Icon1: SetSize(28,28)
		f.Alone.Icon1: SetTexCoord(0.08,0.92, 0.08,0.92)
		--Alone.Icon1: SetVertexColor(color[1], color[2], color[3])
		f.Alone.Icon1: SetAlpha(0)
		f.Alone.Icon1: SetPoint("CENTER", f.Alone.Button, "CENTER", 0,0)
		
		f.Alone.Spell = {}
		f.Alone.SpellName = nil
		
		f.Alone.Button: SetScript("OnEnter", function(self)
			f.Alone.Icon1: SetAlpha(0.6)
		end)
		f.Alone.Button: SetScript("OnLeave", function(self)
			f.Alone.Icon1: SetAlpha(0)
		end)
		
		f.Alone: RegisterUnitEvent("UNIT_AURA", "player", "vehicle")
		f.Alone: RegisterEvent("PLAYER_ENTER_WORLD")
		f.Alone: RegisterEvent("GROUP_ROSTER_UPDATE")
		f.Alone: RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
		f.Alone: SetScript("OnEvent", function(self, event)
			if UnitAffectingCombat("player") then return end
			for i = 1, NUM_LE_RAID_BUFF_TYPES do
				local name, rank, texture, duration, expiration, spellId, slot = GetRaidBuffTrayAuraInfo(i)
				if name then
					f.Alone.Spell[i] = spellId
				else
					f.Alone.Spell[i] = nil
				end
			end
			if UnitBuff("player", GetSpellInfo(155228), nil, "player") then
				f.Alone.Button:Show()
				local specID = GetSpecialization()
				for i1 = 1, #check_Buff[specID] do
					if f.Alone.Spell[check_Buff[specID][i1][1]] then
						local name, rank, icon = GetSpellInfo(check_Buff[specID][i1][2])
						if UnitBuff("player", name, nil, "player") then
							f.Alone.Button: SetAttribute("spell", f.Alone.SpellName)
							f.Alone.Icon1: SetTexture(icon)
							f.Alone.Icon1: SetAlpha(0)
							return
						end
					end
				end
				for i2 = 1, #check_Buff[specID] do
					if not f.Alone.Spell[check_Buff[specID][i2][1]] then
						local name, rank, icon = GetSpellInfo(check_Buff[specID][i2][2])
						f.Alone.SpellName = name
						f.Alone.Button: SetAttribute("spell", f.Alone.SpellName)
						f.Alone.Icon1: SetTexture(icon)
						f.Alone.Icon1: SetAlpha(0.6)
						return
					end
				end
			else
				f.Alone.Button:Hide()
			end
		end)
	end
end

--[[
desc = GetSpellDescription(spellId)
--]]


---- ----------------------------------
-->> TradeSkill Frame
---- ----------------------------------
L.M.TradeSkillFrame = function()
	if not IsAddOnLoaded("Blizzard_TradeSkillUI") then
		LoadAddOn("Blizzard_TradeSkillUI")
	end
	local TSF = CreateFrame("Frame", nil ,UIParent)
	TSF: RegisterEvent("PLAYER_ENTERING_WORLD")
	TSF: RegisterEvent("ADDON_LOADED", "Blizzard_TradeSkillUI")
	TSF: SetScript("OnEvent", function(self,event,name)
		--(event == "ADDON_LOADED" and name == "Blizzard_TradeSkillUI")
		if (event == "PLAYER_ENTERING_WORLD" and IsAddOnLoaded("Blizzard_TradeSkillUI")) then
			TRADE_SKILLS_DISPLAYED = 20
			local DetailHeight = TRADE_SKILLS_DISPLAYED * 16
			--- Create Skill Buttons ---
			if TradeSkillSkill10 then return end
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
end

---- ----------------------------------
-->> Aura Caster By Who
---- ----------------------------------
L.M.AuraTooltip = function()
	hooksecurefunc(GameTooltip, "SetUnitAura", function(self,...)
		local id = select(11,UnitAura(...))
		local caster = select(8,UnitAura(...)) and UnitName(select(8,UnitAura(...)))
		self:AddLine(id and ' ')
		self:AddDoubleLine(id, caster)
		self:Show()
	end)
end

---- ----------------------------------
-->> Damage Font
---- ----------------------------------
L.M.DamageFont = function()
	DAMAGE_TEXT_FONT = C.Font.Name
end