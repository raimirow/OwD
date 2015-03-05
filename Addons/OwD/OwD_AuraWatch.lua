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

local Alp1 = 0.9
local Alp2 = 0.4

--- ----------------------------------------------------------------------------
--> Aura Filter		
--- ----------------------------------------------------------------------------
--> {"ID", "TYPE", "COLOR", "ICON", "NAME", "ID_EXTRA"}
--> TYPE: P = Player, T = Target, S = Spell. 
--> localizedClass, englishClass, classIndex = UnitClass("unit")
--> classIndex: 
--> None = 0, Warrior = 1, Paladin = 2, Hunter = 3, Rogue = 4, Priest = 5, 
--> DeathKnight = 6, Shaman = 7, Mage = 8, Warlock = 9, Monk = 10, Druid = 11,
--- ----------------------------------------------------------------------------
local AuraFilter = {}
	
AuraFilter["WARRIOR"] = {
	[1] = { --武器
		[1] = {"772", "T", C.Color.Red, "Ability_Druid_Disembowel", "撕裂"},
		[2] = {"167105", "S|T", C.Color.Blue2, "OW_PhotoShield", "巨人打击", "167105"},
		[3] = {"52437", "P", C.Color.Yellow2, "OW_SonicArrow", "猝死"}, 
		[4] = {"12294", "S", C.Color.Yellow2, "OW_Recall", "致死打击"},
		[5] = {"1719", "S|P", C.Color.Yellow2, "OW_Blink", "鲁莽", "1719"},
		[6] = {"6552", "S", C.Color.Yellow2, "OW_FireStrike", "拳击"},
	},
	[2] = { --狂怒
		[1] = {"23881", "S", C.Color.Red, "OW_ConcussiveBlast", "嗜血"},
		[5] = {"1719", "S|P", C.Color.Yellow2, "OW_Blink", "鲁莽", "1719"},
		[6] = {"6552", "S", C.Color.Yellow2, "OW_FireStrike", "拳击"},
	},
	[3] = { --防护
		[1] = {"23922", "S", C.Color.Red, "OW_SonicArrow", "盾牌猛击"},
		[2] = {"2565", "S", C.Color.Blue2, "OW_ShieldProjector", "盾牌格挡"},
		[3] = {"12975", "S|P", C.Color.Yellow2, "OW_Blink", "破釜沉舟", "12975"},
		[5] = {"6552", "S", C.Color.Yellow2, "OW_FireStrike", "拳击"},
	},
}

AuraFilter["PALADIN"] = {
	[1] = { --神圣
		
	},
	[2] = { --惩戒
		
	},
	[3] = { --防护
		
	},
}

AuraFilter["HUNTER"] = {
	[1] = {},
	[2] = {},
	[3] = {},
}

AuraFilter["ROGUE"] = {
	[1] = {},
	[2] = {},
	[3] = {},
}

AuraFilter["PRIEST"] = {
	[1] = {},
	[2] = {},
	[3] = {},
}

AuraFilter["DEATHKNIGHT"] = {
	[1] = {},
	[2] = {},
	[3] = {},
}

AuraFilter["SHAMAN"] = {
	[1] = {},
	[2] = {},
	[3] = {},
}

AuraFilter["MAGE"] = {
	[1] = { -->奥术
		[1] = {
			[1] = {"114923", "T", C.Color.Red, "OW_Blink", "虚空风暴"},
			[2] = {"157980", "S", C.Color.Yellow2, "OW_ConcussiveBlast", "超级新星"},
		},
		[2] = {"36032", "P", C.Color.Yellow2, "OW_SonicArrow", "奥术充能"},
		[3] = {"79683", "P", C.Color.Blue2, "OW_ScatterArrow", "奥术飞弹！"},
		[4] = {"12042", "S|P", C.Color.Blue2, "OW_GuardianAngel", "奥术强化"},
		[5] = {"2139", "S", C.Color.Yellow2, "OW_FireStrike", "法术反制"},
		[6] = {
			[1] = {"152087", "S", C.Color.Blue2, "OW_PhotoShield", "幻灵晶体"},
			[2] = {"153561", "S", C.Color.Blue2, "OW_PhotoShield", "流星"},
		},
	},
	[2] = { -->火焰
		[1] = {
			[1] = {"44457", "T", C.Color.Red, "OW_Blink", "活动炸弹"},
			[2] = {"157981", "S", C.Color.Yellow2, "OW_ConcussiveBlast", "冲击波"},
		},
		[2] = {"12654", "T", C.Color.Red, "OW_JumpJet", "点燃"},
		[3] = {"48107", "P", C.Color.Blue2, "OW_Charge", "热力迸发"},
		[4] = {"11366", "T", C.Color.Red, "OW_SonicArrow", "炎爆术"},
		[5] = {"2139", "S", C.Color.Yellow2, "OW_FireStrike", "法术反制"},
		[6] = {
			[1] = {"152087", "S", C.Color.Blue2, "OW_PhotoShield", "幻灵晶体"},
			[2] = {"153561", "S", C.Color.Blue2, "OW_PhotoShield", "流星"},
		},
	},
	[3] = { -->冰霜
		[1] = {
			[1] = {"112948", "T", C.Color.Red, "OW_Blink", "寒冰炸弹"},
			[2] = {"113092", "S", C.Color.Yellow2, "OW_ConcussiveBlast", "寒冰新星"},
		},
		[2] = {"44544", "P", C.Color.Blue2, "OW_JumpJet", "寒冰指"},
		[3] = {"57761", "P", C.Color.Blue2, "OW_Charge", "冰冷智慧"},
		[5] = {"2139", "S", C.Color.Yellow2, "OW_FireStrike", "法术反制"},
		[6] = {
			[1] = {"152087", "S", C.Color.Blue2, "OW_PhotoShield", "幻灵晶体"},
			[2] = {"153595", "S", C.Color.Blue2, "OW_PhotoShield", "彗星风暴"},
		},
	},
}

AuraFilter["WARLOCK"] = {
	[1] = { --痛苦
		[1] = {"146739", "T", C.Color.Yellow2, "OW_JumpJet", "腐蚀术"},
		[2] = {"980", "T", C.Color.Red, "OW_Blink", "痛楚"},
		[3] = {"30108", "T", C.Color.Yellow2, "OW_ConcussiveBlast", "痛苦无常"},
		[4] = {"48181", "T", C.Color.Yellow2, "OW_SonicArrow", "鬼影缠身"},
		[5] = {"113860", "S|P", C.Color.Blue2, "OW_GuardianAngel", "黑暗灵魂：哀难", "113860"},
	},
	[2] = { --恶魔学识
		
	},
	[3] = { --毁灭
		[1] = {"157736", "T", C.Color.Red, "OW_JumpJet", "献祭"},
		[2] = {"117828", "P", C.Color.Yellow2, "OW_SonicArrow", "爆燃"},
		[3] = {"17962", "S", C.Color.Yellow2, "OW_ConcussiveBlast", "燃烧"},
		[4] = {"113858", "S|P", C.Color.Blue2, "OW_GuardianAngel", "黑暗灵魂：易爆", "113858"},
		[5] = {"120451", "S", C.Color.Yellow2, "OW_OrbofHarmony", "克索诺斯之焰"},
	},
}

AuraFilter["MONK"] = {
	[1] = {	--酒仙
		
	},
	[2] = {	--织雾
		
	},
	[3] = {	--风行
		[1] = {"125195", "P", C.Color.Yellow2, "OW_Blink", "虎眼酒"},
		[2] = {"107428", "S", C.Color.Yellow2, "OW_JumpJet", "旭日东升踢"},
		[3] = {"117418", "S", C.Color.Yellow2, "OW_ScatterArrow", "怒雷破"},
		--[4] = {"107428", "S", C.Color.Yellow2, "Ability_Monk_RisingSunKick", "旭日东升踢"},
		[5] = {"125359", "P", C.Color.Blue2, "Ability_Monk_TigerPalm", "猛虎之力"},
		[6] = {"116705", "S", C.Color.Yellow2, "OW_FireStrike", "切喉手"},
	},
}

AuraFilter["DRUID"] = {
	[1] = {	--平衡
		[1] = {"164812", "T", C.Color.Blue2, "OW_OrbofDiscord", "月火术"},
		[2] = {"164815", "T", C.Color.Red, "OW_OrbofHarmony", "阳炎术"},
		[3] = {"112071", "S|P", C.Color.Yellow2, "OW_ConcussiveBlast", "超凡之盟", "112071"},
	},
	[2] = {	--野性
		[1] = {"155722", "T", C.Color.Red, "Ability_Druid_Disembowel", "斜掠"},
		[2] = {"1079", "T", C.Color.Red, "OW_Recall", "割裂"},
		[3] = {"5217", "S|P", C.Color.Blue2, "OW_Blink", "猛虎之怒", "5217"},
		[4] = {"106952", "S|P", C.Color.Blue2, "OW_ConcussiveBlast", "狂暴", "106951"},
		[5] = {"106839", "S", C.Color.Yellow2, "OW_FireStrike", "迎头痛击"},
		[6] = {"127538", "P", C.Color.Blue2, "OW_GuardianAngel", "野蛮咆哮"},
	},
	[3] = {	--守护
		[1] = {"77758", "T", C.Color.Red, "OW_ScatterArrow", "痛击"},
		[2] = {"6807", "S", C.Color.Yellow2, "OW_SonicArrow", "重殴"},
		[3] = {"33917", "S", C.Color.Yellow2, "OW_Recall", "裂伤"},
		[4] = {"106952", "S|P", C.Color.Blue2, "OW_ConcussiveBlast", "狂暴", "106951"},
		[5] = {"106839", "S", C.Color.Yellow2, "OW_FireStrike", "迎头痛击"},
	},
	[4] = {	--恢复
		
	},
}

--- ----------------------------------------------------------------------------
--> Right Frame Element      
--- ----------------------------------------------------------------------------

local Num1 = {	
	[1] =	{16,27,  17/256, 33/256,  11.5/64,38.5/64},
	[2] =	{19,27,  36/256, 55/256,  12.5/64,39.5/64},
	[3] =	{18,26,  59/256, 77/256,  15/64,41/64},
	[4] =	{18,25,  82/256,100/256,  17/64,42/64},
	[5] =	{19,26, 104/256,123/256,  18/64,44/64},
	[6] =	{19,26, 126/256,145/256,  19/64,45/64},
	[7] =	{19,26, 148/256,167/256,  21.5/64,47.5/64},
	[8] =	{19,26, 169/256,188/256,  22/64,48/64},
	[9] =	{19,27, 191/256,210/256,  23/64,50/64},
	[0] =	{19,27, 214/256,233/256,  25/64,52/64},
	["s"] =	{10,14, 236/256,246/256,  39/64,53/64},
}

local create_Texture = function(f, texture, x,y, x1,x2,y1,y2, color,a, p1,p2,p3,p4,p5)
	f: SetTexture(F.Media..texture)
	f: SetSize(x,y)
	f: SetTexCoord(x1,x2, y1,y2)
	f: SetVertexColor(color[1], color[2], color[3])
	f: SetAlpha(a)
	f: SetPoint(p1,p2,p3,p4,p5)
end

local event_Vehicle ={
	"PLAYER_ENTERING_WORLD",
	"UNIT_ENTERED_VEHICLE",
	"UNIT_EXITED_VEHICLE",
}

local event_Aura = {
	"PLAYER_ENTERING_WORLD",
	"UNIT_AURA",
}

local event_Specialization = {
	"PLAYER_ENTERING_WORLD",
	"PLAYER_SPECIALIZATION_CHANGED",
	"PLAYER_TALENT_UPDATE",
}

local get_Buff = function(f)
	local index =1
	local name, rank, icon, count, dispelType, duration, expires, caster, isStealable, shouldConsolidate, spellID = UnitBuff(f.unit, index) 
end

local resize_Icon1 = function(f, i, d)
	if i <= 4 then
		f.Icon[i].Bar:SetSize(69,52*d+F.Debug)
		f.Icon[i].Bar:SetTexCoord(30/128,99/128, (38+52*abs(1-d)+F.Debug)/128, 90/128)
	else
		f.Icon[i].Bar:SetSize(40,30*d+F.Debug)
		f.Icon[i].Bar:SetTexCoord(12/64,52/64, (17+30*abs(1-d)+F.Debug)/64, 47/64)
	end
end

local resize_Icon2 = function(f, i, d)
	if i <= 4 then
		f.Icon[i].Bar:SetSize(69,52*abs(1-d)+F.Debug)
		f.Icon[i].Bar:SetTexCoord(30/128,99/128, (38+52*abs(d)+F.Debug)/128, 90/128)
	else
		f.Icon[i].Bar:SetSize(40,30*abs(1-d)+F.Debug)
		f.Icon[i].Bar:SetTexCoord(12/64,52/64, (17+30*abs(d)+F.Debug)/64, 47/64)
	end
end

local init_Aura = function(f)
	for i = 1,6 do
		f.Icon[i].ID = nil
		f.Icon[i].exID = nil
		f.Icon[i].Type = nil
		f.Icon[i].Count = nil
		f.Icon[i].Color = C.Color.White
		f.Icon[i].Expires = 0
		f.Icon[i].Remain1 = 0
		f.Icon[i].Remain2 = 0
		f.Icon[i].Duration = 0
		f.Icon[i].Start = 0
		f.Icon[i].CD = 0
		resize_Icon1(f, i, 1)
		f.Icon[i].Bar: SetAlpha(Alp1)
	end
	
	local classFileName = select(2, UnitClass("player"))
	local specID = GetSpecialization()
	if classFileName and specID then
		for k, v in pairs (AuraFilter[classFileName][specID]) do
			if type(v[1]) == "table" then
				f.Icon[k].ID = nil
				f.Icon[k].Type = nil
				f.Icon[k].Color = nil
				f.Icon[k].Tex: SetTexture("")
				f.Icon[k].exID = nil
				for key, value in pairs (v) do
					local name, rank, icon, castingTime, minRange, maxRange, spellID = GetSpellInfo(v[key][1])
					--local isKnow = IsSpellKnown(v[key][1]
					if GetSpellInfo(name) and (not f.Icon[k].ID)then
						f.Icon[k].ID = v[key][1]
						f.Icon[k].Type = v[key][2]
						f.Icon[k].Color = v[key][3]
						f.Icon[k].Tex: SetTexture(F.Media.."Icons\\"..v[key][4])
						f.Icon[k].exID = v[key][6] or nil
					end
				end
			else
				f.Icon[k].ID = v[1]
				f.Icon[k].Type = v[2]
				f.Icon[k].Color = v[3]
				f.Icon[k].Tex: SetTexture(F.Media.."Icons\\"..v[4])
				f.Icon[k].exID = v[6] or nil
			end
		end
	end
	
	if f.Icon[6].ID then
		f.Icon[6]: Show()
		f.Icon[5]: ClearAllPoints()
		f.Icon[5]: SetPoint("TOPLEFT", f, "TOPLEFT", -86,5)
	else
		f.Icon[6]: Hide()
		f.Icon[5]: ClearAllPoints()
		f.Icon[5]: SetPoint("TOPLEFT", f, "TOPLEFT", -56,3)
	end
	
	if f.Icon[4].ID then
		f.Icon[2]: Show()
		f.Icon[3]: Show()
		f.Icon[4]: Show()
		f.Icon[1]: ClearAllPoints()
		f.Icon[1]: SetPoint("TOPLEFT", f.Icon[5], "TOPLEFT", -250,17)
	elseif f.Icon[3].ID then
		f.Icon[2]: Show()
		f.Icon[3]: Show()
		f.Icon[4]: Hide()
		f.Icon[1]: ClearAllPoints()
		f.Icon[1]: SetPoint("TOPLEFT", f.Icon[5], "TOPLEFT", -190,13)
	elseif f.Icon[2].ID then
		f.Icon[2]: Show()
		f.Icon[3]: Hide()
		f.Icon[4]: Hide()
		f.Icon[1]: ClearAllPoints()
		f.Icon[1]: SetPoint("TOPLEFT", f.Icon[5], "TOPLEFT", -130,9)
	else
		f.Icon[2]: Hide()
		f.Icon[3]: Hide()
		f.Icon[4]: Hide()
		f.Icon[1]: ClearAllPoints()
		f.Icon[1]: SetPoint("TOPLEFT", f.Icon[5], "TOPLEFT", -70,5)
	end
end

local update_Player = function(f)
	local index =1
	local n
	local name, rank, icon, count, dispelType, duration, expires, caster, isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff, value1, value2, value3
	while (index == 1) or n do
		n = false
		name, rank, icon, count, dispelType, duration, expires, caster, isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff, value1, value2, value3 = UnitAura("player", index, "HARMFUL")
		if name then n = true end
		--[[
		if spellID then
			print(name, spellID)
		end
		-]]
		for i =1,#f.Icon do
			if f.Icon[i].Type == "P" and spellID  and tostring(spellID) == f.Icon[i].ID then
				f.Icon[i].Count = count
				f.Icon[i].Expires = expires
				f.Icon[i].Duration = duration
				f.Icon[i].Remain1 = max(expires - GetTime(), 0)
			elseif f.Icon[i].Type == "S|P" and spellID  and tostring(spellID) == f.Icon[i].exID then
				f.Icon[i].Count = count
				f.Icon[i].Expires = expires
				f.Icon[i].Duration = duration
				f.Icon[i].Remain1 = max(expires - GetTime(), 0)
			end
		end
		
		name, rank, icon, count, dispelType, duration, expires, caster, isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff, value1, value2, value3 = UnitAura("player", index, "HELPFUL|PLAYER")
		if name then n = true end
		--[[
		if spellID then
			print(name, spellID)
		end
		--]]
		for i =1,#f.Icon do
			if f.Icon[i].Type == "P" and spellID  and tostring(spellID) == f.Icon[i].ID then
				f.Icon[i].Count = count
				f.Icon[i].Expires = expires
				f.Icon[i].Duration = duration
				f.Icon[i].Remain1 = max(expires - GetTime(), 0)
			elseif f.Icon[i].Type == "S|P" and spellID  and tostring(spellID) == f.Icon[i].exID then
				f.Icon[i].Count = count
				f.Icon[i].Expires = expires
				f.Icon[i].Duration = duration
				f.Icon[i].Remain1 = max(expires - GetTime(), 0)
			end
		end
		index = index + 1
	end
end

local update_Target = function(f)
	if not UnitExists("target") then
		for i =1,#f.Icon do
			if (f.Icon[i].Type == "T") then
				f.Icon[i].Count = nil
				f.Icon[i].Expires = 0
				f.Icon[i].Duration = 0
				f.Icon[i].Remain1 = 0
				f.Icon[i].Num: Hide()
				f.Icon[i].Tex: Show()
				f.Icon[i].Bar: SetVertexColor(unpack(C.Color.White))
				resize_Icon1(f, i, 1)
			elseif (f.Icon[i].Type == "S|T") then
				f.Icon[i].Count = nil
				f.Icon[i].Expires = 0
				f.Icon[i].Duration = 0
				f.Icon[i].Remain1 = 0
				f.Icon[i].Num: Hide()
				f.Icon[i].Tex: Show()
				f.Icon[i].Bar: SetVertexColor(unpack(C.Color.White))
				resize_Icon1(f, i, 1)
			end
		end
	else
		local index = 1
		local n
		local name, rank, icon, count, dispelType, duration, expires, caster, isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff, value1, value2, value3
		while  (index == 1) or n do
			n = false
			name, rank, icon, count, dispelType, duration, expires, caster, isStealable, shouldConsolidate, spellID = UnitAura("target", index, "PLAYER|HARMFUL")
			if name then n = true end
			--[[
			if spellID then
			print(name, spellID)
			end
			--]]
			for i =1,#f.Icon do
				if (f.Icon[i].Type == "T") and spellID  and tostring(spellID) == f.Icon[i].ID then
					f.Icon[i].Count = count
					f.Icon[i].Expires = expires
					f.Icon[i].Duration = duration
					f.Icon[i].Remain1 = max(expires - GetTime(), 0)
				elseif f.Icon[i].Type == "S|T" and spellID  and tostring(spellID) == f.Icon[i].exID then
					f.Icon[i].Count = count
					f.Icon[i].Expires = expires
					f.Icon[i].Duration = duration
					f.Icon[i].Remain1 = max(expires - GetTime(), 0)
				end
			end

			name, rank, icon, count, dispelType, duration, expires, caster, isStealable, shouldConsolidate, spellID = UnitAura("target", index, "PLAYER|HELPFUL")
			if name then n = true end
			--[[
			if spellID then
				print(name, spellID)
			end
			--]]
			for i =1,#f.Icon do
				if (f.Icon[i].Type == "T") and spellID  and tostring(spellID) == f.Icon[i].ID then
					f.Icon[i].Count = count
					f.Icon[i].Expires = expires
					f.Icon[i].Duration = duration
					f.Icon[i].Remain1 = max(expires - GetTime(), 0)
				elseif f.Icon[i].Type == "S|T" and spellID  and tostring(spellID) == f.Icon[i].exID then
					f.Icon[i].Count = count
					f.Icon[i].Expires = expires
					f.Icon[i].Duration = duration
					f.Icon[i].Remain1 = max(expires - GetTime(), 0)
				end
			end
			index = index + 1
		end
	end
end

local update_Spell = function(f)
	for i =1,#f.Icon do
		if f.Icon[i].Type == "S" and IsPlayerSpell(f.Icon[i].ID) then
			local start, duration, enabled = GetSpellCooldown(f.Icon[i].ID)
			--local charges, maxCharges, chargeStart, chargeDuration = GetSpellCharges(f[i].ID)
			f.Icon[i].CD = duration
			f.Icon[i].Start = start
			f.Icon[i].Remain2 = 1
		elseif f.Icon[i].Type == "S|P" and IsPlayerSpell(f.Icon[i].ID) then
			local start, duration, enabled = GetSpellCooldown(f.Icon[i].ID)
			f.Icon[i].CD = duration
			f.Icon[i].Start = start
			f.Icon[i].Remain2 = 1
		elseif f.Icon[i].Type == "S|T" and IsPlayerSpell(f.Icon[i].ID) then
			local start, duration, enabled = GetSpellCooldown(f.Icon[i].ID)
			f.Icon[i].CD = duration
			f.Icon[i].Start = start
			f.Icon[i].Remain2 = 1
		end
	end
end

local update_Num = function(f,i,d,s)
	if i <= 4 then
		d = min(d, 99)
		local d1 = floor(d/10)
		local d2 = floor(d-floor(d/10)*10)
		
		f.Icon[i].Num[1]: SetSize(Num1[d1][1],Num1[d1][2])
		f.Icon[i].Num[1]: SetTexCoord(Num1[d1][3],Num1[d1][4],Num1[d1][5],Num1[d1][6])
		f.Icon[i].Num[2]: SetSize(Num1[d2][1],Num1[d2][2])
		f.Icon[i].Num[2]: SetTexCoord(Num1[d2][3],Num1[d2][4],Num1[d2][5],Num1[d2][6])
		
		if s then
			f.Icon[i].Num[3]: Show()
		else
			f.Icon[i].Num[3]: Hide()
		end
	end
end

local onUpdate_Aura = function(f)
	f:SetScript("OnUpdate", function(self, elapsed)
		if not (f.Icon[1].Remain1 > 0 or f.Icon[2].Remain1 > 0 or f.Icon[3].Remain1 > 0 or f.Icon[4].Remain1 > 0 or f.Icon[5].Remain1 > 0 or f.Icon[6].Remain1 > 0 or f.Icon[1].Remain2 > 0 or f.Icon[2].Remain2 > 0 or f.Icon[3].Remain2 > 0 or f.Icon[4].Remain2 > 0 or f.Icon[5].Remain2 > 0 or f.Icon[6].Remain2 > 0) then 
			f:SetScript("OnUpdate", nil)
			return 
		end
		for i =1,#f.Icon do
			if not f.Icon[i].ID then
				resize_Icon2(f, i, 0)
				f.Icon[i].Bar: SetAlpha(Alp2)
			end
			--if (f.Icon[i].Remain1 > 0) or (f.Icon[i].Remain2 > 0) then
				if f.Icon[i].Type == "P" or f.Icon[i].Type == "T" then
					f.Icon[i].Remain1 = max(f.Icon[i].Remain1 - elapsed, 0)
					if f.Icon[i].Remain1 > 0 then
						--print(f.Icon[i].Remain1)
						f.Icon[i].Bar: SetVertexColor(f.Icon[i].Color[1],f.Icon[i].Color[2],f.Icon[i].Color[3])
						f.Icon[i].Num: Show()
						f.Icon[i].Tex: Hide()
						if f.Icon[i].Count and f.Icon[i].Count > 0 then
							update_Num(f, i, f.Icon[i].Count, false)
						else
							update_Num(f, i, f.Icon[i].Remain1, true)
						end
						resize_Icon1(f, i, f.Icon[i].Remain1/(f.Icon[i].Duration+F.Debug))
						f.Icon[i].Bar: SetAlpha(Alp1)
					else
						f.Icon[i].Num: Hide()
						f.Icon[i].Tex: Show()
						f.Icon[i].Bar: SetVertexColor(unpack(C.Color.White))
						resize_Icon1(f, i, 1)
						f.Icon[i].Bar: SetAlpha(Alp1)
					end
					--f.Icon[i].Bar: SetAlpha(Alp1)
					
				elseif f.Icon[i].Type == "S" then
					if f.Icon[i].CD <= 1 and UnitAffectingCombat("player") then
						f.Icon[i].Bar: SetVertexColor(f.Icon[i].Color[1],f.Icon[i].Color[2],f.Icon[i].Color[3])
						resize_Icon2(f, i, 0)
						f.Icon[i].Remain2 = 0
						f.Icon[i].Num: Hide()
						f.Icon[i].Tex: Show()
					else
						f.Icon[i].Remain2 = f.Icon[i].CD - (GetTime()-f.Icon[i].Start)
						if f.Icon[i].Remain2 > 0 then
							f.Icon[i].Bar: SetAlpha(Alp2)
							f.Icon[i].Bar: SetVertexColor(unpack(C.Color.White))
							resize_Icon2(f, i, f.Icon[i].Remain2/(f.Icon[i].CD+F.Debug))
							f.Icon[i].Num: Show()
							f.Icon[i].Tex: Hide()
							update_Num(f, i, f.Icon[i].Remain2, true)
						else
							if UnitAffectingCombat("player") then
								f.Icon[i].Bar: SetVertexColor(f.Icon[i].Color[1],f.Icon[i].Color[2],f.Icon[i].Color[3])
							else
								f.Icon[i].Bar: SetVertexColor(unpack(C.Color.White))
							end
							f.Icon[i].Bar: SetAlpha(Alp1)
							
							resize_Icon2(f, i, 0)
							f.Icon[i].Num: Hide()
							f.Icon[i].Tex: Show()
						end
					end
				elseif f.Icon[i].Type == "S|P" then
					f.Icon[i].Remain1 = max(f.Icon[i].Remain1 - elapsed, 0)
					if f.Icon[i].Remain1 > 0 then
						f.Icon[i].Bar: SetVertexColor(f.Icon[i].Color[1],f.Icon[i].Color[2],f.Icon[i].Color[3])
						f.Icon[i].Bar: SetAlpha(Alp1)
						resize_Icon1(f, i, f.Icon[i].Remain1/(f.Icon[i].Duration+F.Debug))
						f.Icon[i].Num: Show()
						f.Icon[i].Tex: Hide()
						update_Num(f, i, f.Icon[i].Remain1, true)
					elseif f.Icon[i].CD <= 1 then
						---if UnitAffectingCombat("player") then
							--f.Icon[i].Bar: SetVertexColor(f.Icon[i].Color[1],f.Icon[i].Color[2],f.Icon[i].Color[3])
						--else
							f.Icon[i].Bar: SetVertexColor(unpack(C.Color.White))
						--end
						resize_Icon2(f, i, 0)
						f.Icon[i].Remain2 = 0
						f.Icon[i].Num: Hide()
						f.Icon[i].Tex: Show()
					else
						f.Icon[i].Remain2 = f.Icon[i].CD - (GetTime()-f.Icon[i].Start)
						if f.Icon[i].Remain2 > 0 then
							f.Icon[i].Bar: SetVertexColor(unpack(C.Color.White))
							f.Icon[i].Bar: SetAlpha(0.4)
							resize_Icon2(f, i, f.Icon[i].Remain2/(f.Icon[i].CD+F.Debug))
							f.Icon[i].Num: Show()
							f.Icon[i].Tex: Hide()
							update_Num(f, i, f.Icon[i].Remain2, true)
						else
							if UnitAffectingCombat("player") then
								f.Icon[i].Bar: SetVertexColor(f.Icon[i].Color[1],f.Icon[i].Color[2],f.Icon[i].Color[3])
							else
								f.Icon[i].Bar: SetVertexColor(unpack(C.Color.White))
							end
							f.Icon[i].Bar: SetAlpha(Alp1)
							resize_Icon2(f, i, 0)
							f.Icon[i].Num: Hide()
							f.Icon[i].Tex: Show()
						end
					end
				elseif f.Icon[i].Type == "S|T" then
					f.Icon[i].Remain1 = max(f.Icon[i].Remain1 - elapsed, 0)
					if f.Icon[i].CD <= 1 then
						--if UnitAffectingCombat("player") then
							--f.Icon[i].Bar: SetVertexColor(f.Icon[i].Color[1],f.Icon[i].Color[2],f.Icon[i].Color[3])
						--else
							f.Icon[i].Bar: SetVertexColor(unpack(C.Color.White))
						--end
						resize_Icon2(f, i, 0)
						f.Icon[i].Remain2 = 0
						f.Icon[i].Num: Hide()
						f.Icon[i].Tex: Show()
					else
						f.Icon[i].Remain2 = f.Icon[i].CD - (GetTime()-f.Icon[i].Start)
						if f.Icon[i].Remain1 > 0 then
							f.Icon[i].Bar: SetVertexColor(f.Icon[i].Color[1],f.Icon[i].Color[2],f.Icon[i].Color[3])
							f.Icon[i].Bar: SetAlpha(Alp1)
							resize_Icon1(f, i, f.Icon[i].Remain1/(f.Icon[i].Duration+F.Debug))
							f.Icon[i].Num: Show()
							f.Icon[i].Tex: Hide()
							update_Num(f, i, f.Icon[i].Remain1, true)
						elseif f.Icon[i].Remain2 > 0 then
							f.Icon[i].Bar: SetVertexColor(unpack(C.Color.White))
							f.Icon[i].Bar: SetAlpha(Alp2)
							resize_Icon2(f, i, f.Icon[i].Remain2/(f.Icon[i].CD+F.Debug))
							f.Icon[i].Num: Show()
							f.Icon[i].Tex: Hide()
							update_Num(f, i, f.Icon[i].Remain2, true)
						else
							if UnitAffectingCombat("player") then
								f.Icon[i].Bar: SetVertexColor(f.Icon[i].Color[1],f.Icon[i].Color[2],f.Icon[i].Color[3])
							else
								f.Icon[i].Bar: SetVertexColor(unpack(C.Color.White))
							end
							f.Icon[i].Bar: SetAlpha(Alp1)
							resize_Icon2(f, i, 0)
							f.Icon[i].Num: Hide()
							f.Icon[i].Tex: Show()
						end
					end
				end
			--else
				--[[
				f.Icon[i].Num: Hide()
				f.Icon[i].Tex: Show()
				--f.Icon[i].Bar: SetVertexColor(unpack(C.Color.White))
				resize_Icon1(f, i, 1)
				--f.Icon[i].Bar: SetAlpha(Alp1)
				--]]
			--end
		end
	end)
end

local onEvent_Aura = function(f)
	f:RegisterUnitEvent("UNIT_AURA", "player", "target", "vehicle")
	f:RegisterEvent("GROUP_ROSTER_UPDATE")
	f:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
	f:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	f:RegisterEvent("PLAYER_TALENT_UPDATE")
	f:RegisterEvent("CHARACTER_POINTS_CHANGED")
	f:RegisterEvent("SPELL_UPDATE_COOLDOWN")
	f:RegisterEvent("PLAYER_REGEN_DISABLED")
	f:RegisterEvent("PLAYER_REGEN_ENABLED")
	f:RegisterEvent("PLAYER_TARGET_CHANGED")
	f:RegisterEvent("PLAYER_ENTERING_WORLD")
	
	f:SetScript("OnEvent", function(self,event)
		if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_TARGET_CHANGED" or event == "PLAYER_SPECIALIZATION_CHANGED" or event == "GROUP_ROSTER_UPDATE" or event == "UNIT_AURA" or event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "PLAYER_TALENT_UPDATE"  or event == "CHARACTER_POINTS_CHANGED" then
			init_Aura(f)
			update_Player(f)
			update_Target(f)
			update_Spell(f)
			onUpdate_Aura(f)
		elseif event == "SPELL_UPDATE_COOLDOWN" or event =="PLAYER_REGEN_DISABLED" or event =="PLAYER_REGEN_ENABLED" then
			update_Spell(f)
			onUpdate_Aura(f)
		end
	end)
end

--- ----------------------------------------------------------------------------
--> Right Frame
--- ----------------------------------------------------------------------------

local create_Icon = function(f, texture, x,y, x1,x2, y1,y2)
	f.Bar = f:CreateTexture(nil, "ARTWORK")
	f.Bar: SetTexture(F.Media..texture)
	f.Bar: SetPoint("BOTTOM", f, "BOTTOM", 0,0)
	f.Bar: SetVertexColor(unpack(C.Color.White))
	f.Bar: SetSize(x,y)
	f.Bar: SetTexCoord(x1,x2, y1,y2)
	f.Bar: SetAlpha(Alp1)
	
	f.BarGloss = f:CreateTexture(nil, "BORDER")
	f.BarGloss: SetTexture(F.Media..texture.."_Gloss")
	f.BarGloss: SetPoint("BOTTOM", f, "BOTTOM", 0,0)
	f.BarGloss: SetVertexColor(unpack(C.Color.White))
	f.BarGloss: SetSize(x,y)
	f.BarGloss: SetTexCoord(x1,x2, y1,y2)
	f.BarGloss: SetAlpha(0.4)
	
	f.BarBg = f:CreateTexture(nil, "BACKGROUND")
	f.BarBg:SetTexture(F.Media..texture.."_Gloss")
	f.BarBg:SetPoint("BOTTOM", f, "BOTTOM", 3,3)
	f.BarBg:SetVertexColor(unpack(C.Color.White))
	f.BarBg:SetSize(x,y)
	f.BarBg:SetTexCoord(x1,x2, y1,y2)
	f.BarBg:SetAlpha(0.4)
end

local init_Icon = function(f)
	f.Icon = CreateFrame("Frame", nil, f)
	
	for i = 1,6 do 
		f.Icon[i] = CreateFrame("Frame", nil, f)
		f.Icon[i].Num = CreateFrame("Frame", nil, f.Icon[i])
		f.Icon[i].Num: Hide()
		
		f.Icon[i].Tex = f.Icon[i]:CreateTexture(nil, "OVERLAY")
		--f.Icon[i].Tex: SetTexture(F.Media..texture)
		
		--[[
		f.Icon[i].ID = nil
		f.Icon[i].exID = nil
		f.Icon[i].Type = nil
		f.Icon[i].Color = C.Color.White
		f.Icon[i].Count = nil
		f.Icon[i].Expires = 0
		f.Icon[i].Remain1 = 0
		f.Icon[i].Remain2 = 0
		f.Icon[i].Duration = 0
		f.Icon[i].Start = 0
		f.Icon[i].CD = 0
		--]]
		if i <= 4 then
			f.Icon[i]: SetSize(69,52)
			create_Icon(f.Icon[i], "Icon_Big", 69,52, 30/128,99/128,38/128,90/128)
			if i == 1 then
				--f.Icon[i]: SetPoint("TOPLEFT", f, "TOPLEFT", 0,0)
			else
				f.Icon[i]: SetPoint("TOPLEFT", f.Icon[i-1], "TOPLEFT", 60,-4)
			end
			
			f.Icon[i].Num[1] = f.Icon[i].Num:CreateTexture(nil, "OVERLAY")
			create_Texture(f.Icon[i].Num[1], "Right_Num1", Num1[0][1],Num1[0][2], Num1[0][3],Num1[0][4],Num1[0][5],Num1[0][6], C.Color.White,1, "BOTTOM",f.Icon[i],"BOTTOM",-6,14)
			
			f.Icon[i].Num[2] = f.Icon[i].Num:CreateTexture(nil, "OVERLAY")
			create_Texture(f.Icon[i].Num[2], "Right_Num1", Num1[0][1],Num1[0][2], Num1[0][3],Num1[0][4],Num1[0][5],Num1[0][6], C.Color.White,1, "BOTTOMLEFT",f.Icon[i].Num[1],"BOTTOMRIGHT",-8,-1)
			
			f.Icon[i].Num[3] = f.Icon[i].Num:CreateTexture(nil, "OVERLAY")
			create_Texture(f.Icon[i].Num[3], "Right_Num1", Num1["s"][1],Num1["s"][2], Num1["s"][3],Num1["s"][4],Num1["s"][5],Num1["s"][6], C.Color.White,1, "BOTTOMLEFT",f.Icon[i],"BOTTOM",9,13)
			
			f.Icon[i].Tex: SetSize(32,32)
		else
			f.Icon[i]: SetSize(40,30)
			create_Icon(f.Icon[i], "Icon_Small", 40,30, 12/64,52/64,17/64,47/64)
			
			f.Icon[i].Tex: SetSize(20,20)
		end
		
		f.Icon[i].Tex: SetVertexColor(0.09,0.09,0.09)
		f.Icon[i].Tex: SetAlpha(0.9)
		f.Icon[i].Tex: SetPoint("CENTER", f.Icon[i], "CENTER", 0,0)
	end
	f.Icon[6]: SetPoint("TOPLEFT", f.Icon[5], "TOPLEFT", 38,-3)	
end

L.Right = function(f)
	f.Right = CreateFrame("Frame", nil, f)
	f.Right: SetSize(29,44)
	--f.Right: SetPoint("BOTTOMRIGHT", f, "CENTER", 580, -320)
	f.Right: SetPoint("BOTTOMRIGHT", f, "CENTER", -OwD_DB.Pos.Player.x, OwD_DB.Pos.Player.y)
	
	f.Border = f:CreateTexture(nil, "ARTWORK")
	create_Texture(f.Border, "Icon_Border_Right", 29,58, 1/32,30/32,3/64,61/64, C.Color.White,0.9, "TOPRIGHT",f.Right,"TOPRIGHT",0,0)
	
	init_Icon(f.Right)
	onEvent_Aura(f.Right)
end