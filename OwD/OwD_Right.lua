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
--> Right Frame Element      
--- ----------------------------------------------------------------------------
	
local AuraFilter = {}

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

local Num_Right_28 = {
	[0] =	{27,39,   0/512, 27/512,  12/64,51/64},
	[1] =	{27,39,  27/512, 54/512,  12/64,51/64},
	[2] =	{27,39,  54/512, 81/512,  12/64,51/64},
	[3] =	{27,39,  81/512,108/512,  12/64,51/64},
	[4] =	{27,39, 108/512,135/512,  12/64,51/64},
	[5] =	{27,39, 135/512,162/512,  12/64,51/64},
	[6] =	{27,39, 162/512,189/512,  12/64,51/64},
	[7] =	{27,39, 189/512,216/512,  12/64,51/64},
	[8] =	{27,39, 216/512,243/512,  12/64,51/64},
	[9] =	{27,39, 243/512,270/512,  12/64,51/64},
	["."] =	{27,39, 270/255,297/255,  12/64,51/64},
	["s"] =	{27,39, 297/512,324/512,  12/64,51/64},
}

local Icon_Coord = {
	[24] =	{78,56,    1/2048,   79/2048, 4/64, 60/64},
	[23] =	{78,56,	  81/2048,  159/2048, 4/64, 60/64},
	[22] =	{78,56,	 161/2048,  239/2048, 4/64, 60/64},
	[21] =	{78,56,	 241/2048,  319/2048, 4/64, 60/64},
	[20] =	{78,56,	 321/2048,  399/2048, 4/64, 60/64},
	[19] =	{78,56,	 401/2048,  479/2048, 4/64, 60/64},
	[18] =	{78,56,	 481/2048,  559/2048, 4/64, 60/64},
	[17] =	{78,56,	 561/2048,  639/2048, 4/64, 60/64},
	[16] =	{78,56,	 641/2048,  719/2048, 4/64, 60/64},
	[15] =	{78,56,	 721/2048,  799/2048, 4/64, 60/64},
	[14] =	{78,56,	 801/2048,  879/2048, 4/64, 60/64},
	[13] =	{78,56,	 881/2048,  959/2048, 4/64, 60/64},
	[12] =	{78,56,	 961/2048, 1039/2048, 4/64, 60/64},
	[11] =	{78,56,	1041/2048, 1119/2048, 4/64, 60/64},
	[10] =	{78,56,	1121/2048, 1199/2048, 4/64, 60/64},
	[9]  =	{78,56,	1201/2048, 1279/2048, 4/64, 60/64},
	[8]  =	{78,56,	1281/2048, 1359/2048, 4/64, 60/64},
	[7]  =	{78,56,	1361/2048, 1439/2048, 4/64, 60/64},
	[6]  =	{78,56,	1441/2048, 1519/2048, 4/64, 60/64},
	[5]  =	{78,56,	1521/2048, 1599/2048, 4/64, 60/64},
	[4]  =	{78,56,	1601/2048, 1679/2048, 4/64, 60/64},
	[3]  =	{78,56,	1681/2048, 1759/2048, 4/64, 60/64},
	[2]  =	{78,56,	1761/2048, 1839/2048, 4/64, 60/64},
	[1]  =	{78,56,	1841/2048, 1919/2048, 4/64, 60/64},
	[0]  =	{78,56,	1921/2048, 2099/2048, 4/64, 60/64},
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

local resize_AuraIcon = function(f, i, d)
	local c = max(min(floor(d*24), 24), 0)
	f.Icon[i].Bar:SetTexCoord(Icon_Coord[c][3],Icon_Coord[c][4], Icon_Coord[c][5],Icon_Coord[c][6])
end

local resize_SpellIcon = function(f, i, d)
	local c = max(min(floor((1-d)*24), 24), 0)
	f.Icon[i].Bar:SetTexCoord(Icon_Coord[c][3],Icon_Coord[c][4], Icon_Coord[c][5],Icon_Coord[c][6])
end

L.init_AuraWatch = function(f)
	if OwD_DB.AuraWatch.WTF then
		AuraFilter = OwD_DB.AuraFilter
	else
		AuraFilter = C.AuraFilter
	end
	for i = 1,5 do
		f.Icon[i].AuraID = nil
		f.Icon[i].Unit = nil
		f.Icon[i].AuraCount = 0
		f.Icon[i].Color = C.Color.White
		f.Icon[i].Expires = 0
		f.Icon[i].Duration = 0
		f.Icon[i].AuraRemain = 0
		
		f.Icon[i].SpellID = nil
		f.Icon[i].SpellCount = 0
		f.Icon[i].Start = 0
		f.Icon[i].CD = 0
		f.Icon[i].SpellRemain = 0
		
		resize_AuraIcon(f, i, 1)
		f.Icon[i].Bar: SetAlpha(Alp1)
	end
	local a = 1
	local classFileName = select(2, UnitClass("player"))
	local specID = GetSpecialization() or 0
	if classFileName and specID then
		for k, v in ipairs (AuraFilter[classFileName][specID][1]) do
			if v.Show == "show" then
				if (v.Spell and v.Spell ~= "" and v.Spell ~= " ") and (v.Aura and v.Aura ~= "") then
					local name, rank, icon, castingTime, minRange, maxRange, spellID = GetSpellInfo(v.Spell)
					--if not a then a = 1 end
					if GetSpellInfo(name) and a <= 5 then
						f.Icon[a].SpellID = name
						f.Icon[a].AuraID = v.Aura
						f.Icon[a].Unit = v.Unit
						f.Icon[a].Tex: SetTexture(F.Media.."Icons\\"..v.Icon)
						a = a + 1
					end	
				elseif v.Spell and v.Spell ~= "" and v.Spell ~= " " then
					local name, rank, icon, castingTime, minRange, maxRange, spellID = GetSpellInfo(v.Spell)
					if GetSpellInfo(name) and a <= 5 then
						f.Icon[a].SpellID = name
						f.Icon[a].Tex: SetTexture(F.Media.."Icons\\"..v.Icon)
						a = a + 1
					end
				elseif v.Aura and v.Aura ~= "" then
					if a <= 5 then
						f.Icon[a].AuraID = v.Aura
						f.Icon[a].Unit = v.Unit
						f.Icon[a].Tex: SetTexture(F.Media.."Icons\\"..v.Icon)
						a = a + 1
					end
				end
			end
		end
	end
	
	f.Icon[5]: ClearAllPoints()
	if (f.Icon[5].AuraID and f.Icon[5].AuraID ~= "") or (f.Icon[5].SpellID and f.Icon[5].SpellID ~= "") then
		f.Icon[5]: SetAlpha(1)
		f.Icon[5]: SetPoint("TOPRIGHT", f.Icon.Help, "TOPRIGHT", 0,0)
	else
		f.Icon[5]: SetAlpha(0)
		f.Icon[5]: SetPoint("TOPRIGHT", f.Icon.Help, "TOPRIGHT", 63,-4)
	end
	
	for i = 1,4 do
		if (f.Icon[i].AuraID and f.Icon[i].AuraID ~= "") or (f.Icon[i].SpellID and f.Icon[i].SpellID ~= "") then
			f.Icon[i]: SetAlpha(1)
			f.Icon[i]: ClearAllPoints()
			f.Icon[i]: SetPoint("TOPRIGHT", f.Icon[i+1], "TOPRIGHT", -63,4)
		else
			f.Icon[i]: SetAlpha(0)
			f.Icon[i]: ClearAllPoints()
			f.Icon[i]: SetPoint("TOPRIGHT", f.Icon[i+1], "TOPRIGHT", 0,0)
		end
	end
end

local event_Aura = function(f)
	local name, rank, icon, count, dispelType, duration, expires, caster, isStealable, shouldConsolidate, spellID
	--[[
	for i = 1, #f.Icon do
		if f.Icon[i].AuraID and f.Icon[i].AuraID ~= "" and f.Icon[i].Unit then
			f.Icon[i].AuraCount = 0
			f.Icon[i].Expires = 0
			f.Icon[i].Duration = 0
			f.Icon[i].AuraRemain = 0
			name, rank, icon, count, dispelType, duration, expires, caster, isStealable, shouldConsolidate, spellID = UnitDebuff(f.Icon[i].Unit, f.Icon[i].AuraID, nil, "PLAYER")
			if name then
				f.Icon[i].AuraCount = count
				f.Icon[i].Expires = expires
				f.Icon[i].Duration = duration
				f.Icon[i].AuraRemain = max(expires - GetTime(), 0)
			end
			name, rank, icon, count, dispelType, duration, expires, caster, isStealable, shouldConsolidate, spellID = UnitBuff(f.Icon[i].Unit, f.Icon[i].AuraID, nil, "PLAYER")
			if name then
				f.Icon[i].AuraCount = count
				f.Icon[i].Expires = expires
				f.Icon[i].Duration = duration
				f.Icon[i].AuraRemain = max(expires - GetTime(), 0)
			end
			name = nil
		end
	end
	--]]
	for i =1, #f.Icon do
		if f.Icon[i].AuraID and f.Icon[i].AuraID ~= "" and f.Icon[i].Unit then
			f.Icon[i].AuraCount = 0
			f.Icon[i].Expires = 0
			f.Icon[i].Duration = 0
			f.Icon[i].AuraRemain = 0
		end
	end
	
	local index =1
	local n
	while (index == 1) or n do
		n = false
		name, rank, icon, count, dispelType, duration, expires, caster, isStealable, shouldConsolidate, spellID = UnitBuff("player", index)
		if name then n = true end
		for i =1, #f.Icon do
			if f.Icon[i].AuraID and f.Icon[i].AuraID ~= "" and f.Icon[i].Unit then
				if f.Icon[i].Unit == "player" and (f.Icon[i].AuraID == name or f.Icon[i].AuraID == tostring(spellID)) then
					f.Icon[i].AuraCount = count
					f.Icon[i].Expires = expires
					f.Icon[i].Duration = duration
					f.Icon[i].AuraRemain = max(expires - GetTime(), 0)
				end
			end
		end
		
		name, rank, icon, count, dispelType, duration, expires, caster, isStealable, shouldConsolidate, spellID = UnitDebuff("player", index)
		if name then n = true end
		for i =1, #f.Icon do
			if f.Icon[i].AuraID and f.Icon[i].AuraID ~= "" and f.Icon[i].Unit then
				if f.Icon[i].Unit == "player" and (f.Icon[i].AuraID == name or f.Icon[i].AuraID == tostring(spellID)) then
					f.Icon[i].AuraCount = count
					f.Icon[i].Expires = expires
					f.Icon[i].Duration = duration
					f.Icon[i].AuraRemain = max(expires - GetTime(), 0)
				end
			end
		end
		
		name, rank, icon, count, dispelType, duration, expires, caster, isStealable, shouldConsolidate, spellID = UnitBuff("target", index, "PLAYER")
		if name then n = true end
		for i =1, #f.Icon do
			if f.Icon[i].AuraID and f.Icon[i].AuraID ~= "" and f.Icon[i].Unit then
				if f.Icon[i].Unit == "target" and (f.Icon[i].AuraID == name or f.Icon[i].AuraID == tostring(spellID)) then
					f.Icon[i].AuraCount = count
					f.Icon[i].Expires = expires
					f.Icon[i].Duration = duration
					f.Icon[i].AuraRemain = max(expires - GetTime(), 0)
				end
			end
		end
		
		name, rank, icon, count, dispelType, duration, expires, caster, isStealable, shouldConsolidate, spellID = UnitDebuff("target", index, "PLAYER")
		if name then n = true end
		for i =1, #f.Icon do
			if f.Icon[i].AuraID and f.Icon[i].AuraID ~= "" and f.Icon[i].Unit then
				if f.Icon[i].Unit == "target" and (f.Icon[i].AuraID == name or f.Icon[i].AuraID == tostring(spellID)) then
					f.Icon[i].AuraCount = count
					f.Icon[i].Expires = expires
					f.Icon[i].Duration = duration
					f.Icon[i].AuraRemain = max(expires - GetTime(), 0)
				end
			end
		end
		index = index + 1
	end
end

local event_Spell = function(f)
	for i = 1, #f.Icon do
		if f.Icon[i].SpellID then --IsPlayerSpell(f.Icon[i].SpellID) 
			local start, duration, enabled = GetSpellCooldown(f.Icon[i].SpellID)
			local charges, maxCharges, chargeStart, chargeDuration = GetSpellCharges(f.Icon[i].SpellID)
			if maxCharges and maxCharges <= 1 then charges = 0 end
			f.Icon[i].SpellCount = charges
			f.Icon[i].Start = start or 0
			f.Icon[i].CD = duration or 0
			--f.Icon[i].SpellRemain = 1
		end
	end
end

local update_Num = function(f,i,d,s)
	if i <= 5 then
		d = min(d, 99)
		local d1 = floor(d/10)
		local d2 = floor(d-floor(d/10)*10)
		
		f.Icon[i].Num[1]: SetSize(Num_Right_28[d1][1],Num_Right_28[d1][2])
		f.Icon[i].Num[1]: SetTexCoord(Num_Right_28[d1][3],Num_Right_28[d1][4],Num_Right_28[d1][5],Num_Right_28[d1][6])
		f.Icon[i].Num[2]: SetSize(Num_Right_28[d2][1],Num_Right_28[d2][2])
		f.Icon[i].Num[2]: SetTexCoord(Num_Right_28[d2][3],Num_Right_28[d2][4],Num_Right_28[d2][5],Num_Right_28[d2][6])
		
		if s then
			f.Icon[i].Num[3]: Show()
		else
			f.Icon[i].Num[3]: Hide()
		end
	end
end

local canSpell = function(f)
	if f.SpellID then 
		local name = GetSpellInfo(f.SpellID)
		local isUsable, notEnoughMana = IsUsableSpell(name)
			--isUsable - 1 if the spell is castable; otherwise nil (1nil) 
			--notEnoughMana - 1 if the player lacks the resources (e.g. mana, energy, runes) to cast the spell; otherwise nil (1nil) 
		local inRange
		if (UnitExists("target") and name) then
			inRange = IsSpellInRange(name, "target")
			--inRange - 1 if the player is near enough to cast the spell on the unit; 0 if not in range; nil if the unit is not a valid target for the spell (1nil) 
		else
			inRange = 1
		end
		if (((not inRange) or (inRange and inRange == 1)) and (isUsable)) or (not UnitAffectingCombat("player")) then
			f.Forbid: Hide()
			f.Bar: Hide()
			f.Border: Hide()
			f.Bar: SetAlpha(Alp1)
			f.Back: SetAlpha(0.9)
			f.Back: SetVertexColor(unpack(C.Color.White))
		else
			f.Forbid: Show()
			f.Bar: Show()
			f.Border: Show()
			f.Bar: SetAlpha(Alp2)
			f.Back: SetAlpha(0.2)
			f.Back: SetVertexColor(unpack(C.Color.White2))
		end
	else
		f.Bar: Hide()
		f.Border: Hide()
		f.Bar: SetAlpha(Alp1)
		f.Back: SetAlpha(0.9)
		f.Back: SetVertexColor(unpack(C.Color.White))
	end
end

local Icon_Ready = function(f, ready)
	if ready then
		f.Num: Hide()
		--f.Bar: Hide()
		f.Tex: SetAlpha(0.9)
		f.Tex: SetVertexColor(unpack(C.Color.Black))
		--f.Back: SetAlpha(0.9)
		--f.Back: SetVertexColor(unpack(C.Color.White))
		canSpell(f)
	else
		f.Num: Show()
		f.Bar: Show()
		f.Border: Show()
		f.Tex: SetAlpha(0.9)
		f.Tex: SetVertexColor(unpack(C.Color.Black))
		f.Back: SetAlpha(0.2)
		f.Back: SetVertexColor(unpack(C.Color.White2))
		f.Forbid: Hide()
	end
end

local OnUpdate_Aura = function(f)
	f:SetScript("OnUpdate", function(self, elapsed)
		for i =1,#f.Icon do
			if (f.Icon[i].AuraID and f.Icon[i].AuraID ~= "") and (f.Icon[i].SpellID and f.Icon[i].SpellID ~= "") then
				f.Icon[i].AuraRemain = max(f.Icon[i].AuraRemain - elapsed, 0)
				f.Icon[i].SpellRemain = f.Icon[i].CD - (GetTime()-f.Icon[i].Start)
				f.Icon[i].Bar: SetVertexColor(unpack(C.Color.White))
				f.Icon[i].Border: SetVertexColor(unpack(C.Color.White))
				if f.Icon[i].AuraRemain > 0 then
					if f.Icon[i].AuraRemain >= f.Icon[i].Duration*0.3 then
						f.Icon[i].Bar: SetVertexColor(unpack(C.Color.Orange))
						f.Icon[i].Border: SetVertexColor(unpack(C.Color.Orange))
					else
						f.Icon[i].Bar: SetVertexColor(unpack(C.Color.Red))
						f.Icon[i].Border: SetVertexColor(unpack(C.Color.Red))
					end
					f.Icon[i].Bar: SetAlpha(Alp1)
					resize_AuraIcon(f, i, f.Icon[i].AuraRemain/(f.Icon[i].Duration+F.Debug))
					Icon_Ready(f.Icon[i], false)
					if f.Icon[i].AuraCount and f.Icon[i].AuraCount >= 1 then
						update_Num(f, i, f.Icon[i].AuraCount, false)
					else
						update_Num(f, i, f.Icon[i].AuraRemain, true)
					end
				elseif f.Icon[i].CD <= 2 then
					resize_SpellIcon(f, i, 0)
					f.Icon[i].Bar: SetAlpha(Alp1)
					f.Icon[i].SpellRemain = 0
					if UnitAffectingCombat("player") and f.Icon[i].SpellCount and (f.Icon[i].SpellCount >=1) then
						Icon_Ready(f.Icon[i], false)
						update_Num(f, i, f.Icon[i].SpellCount, false)
					else
						Icon_Ready(f.Icon[i], true)
					end
				elseif f.Icon[i].SpellRemain > 0 then
					f.Icon[i].Bar: SetAlpha(Alp2)
					resize_SpellIcon(f, i, f.Icon[i].SpellRemain/(f.Icon[i].CD+F.Debug))
					Icon_Ready(f.Icon[i], false)
					if f.Icon[i].SpellCount and f.Icon[i].SpellCount >= 1 then
						update_Num(f, i, f.Icon[i].SpellCount, false)
					else
						update_Num(f, i, f.Icon[i].SpellRemain, true)
					end
				else
					--resize_SpellIcon(f, i, 0)
					Icon_Ready(f.Icon[i], true)
				end
			elseif f.Icon[i].SpellID and f.Icon[i].SpellID ~= "" then
				f.Icon[i].SpellRemain = f.Icon[i].CD - (GetTime()-f.Icon[i].Start)
				f.Icon[i].Bar: SetVertexColor(unpack(C.Color.White))
				f.Icon[i].Border: SetVertexColor(unpack(C.Color.White))
				if f.Icon[i].CD <= 2 then
					f.Icon[i].Bar: SetAlpha(Alp1)
					resize_SpellIcon(f, i, 0)
					f.Icon[i].SpellRemain = 0
					if UnitAffectingCombat("player") and f.Icon[i].SpellCount and (f.Icon[i].SpellCount >=1) then
						Icon_Ready(f.Icon[i], false)
						update_Num(f, i, f.Icon[i].SpellCount, false)
					else
						Icon_Ready(f.Icon[i], true)
					end
				elseif f.Icon[i].SpellRemain > 0 then
					f.Icon[i].Bar: SetAlpha(Alp2)
					resize_SpellIcon(f, i, f.Icon[i].SpellRemain/(f.Icon[i].CD+F.Debug))
					Icon_Ready(f.Icon[i], false)
					if f.Icon[i].SpellCount and f.Icon[i].SpellCount >= 1 then
						update_Num(f, i, f.Icon[i].SpellCount, false)
					else
						update_Num(f, i, f.Icon[i].SpellRemain, true)
					end
				else
					--resize_SpellIcon(f, i, 0)
					Icon_Ready(f.Icon[i], true)
				end
			elseif f.Icon[i].AuraID  and f.Icon[i].AuraID ~= "" then
				f.Icon[i].AuraRemain = max(f.Icon[i].AuraRemain - elapsed, 0)
				f.Icon[i].Bar: SetVertexColor(unpack(C.Color.White))
				f.Icon[i].Border: SetVertexColor(unpack(C.Color.White))
				if f.Icon[i].AuraRemain > 0 then
					if f.Icon[i].AuraRemain >= f.Icon[i].Duration*0.3 then
						f.Icon[i].Bar: SetVertexColor(unpack(C.Color.Orange))
						f.Icon[i].Border: SetVertexColor(unpack(C.Color.Orange))
					else
						f.Icon[i].Bar: SetVertexColor(unpack(C.Color.Red))
						f.Icon[i].Border: SetVertexColor(unpack(C.Color.Red))
					end
					f.Icon[i].Bar: SetAlpha(Alp1)
					resize_AuraIcon(f, i, f.Icon[i].AuraRemain/(f.Icon[i].Duration+F.Debug))
					Icon_Ready(f.Icon[i], false)
					if f.Icon[i].AuraCount and f.Icon[i].AuraCount >= 1 then
						update_Num(f, i, f.Icon[i].AuraCount, false)
					else
						update_Num(f, i, f.Icon[i].AuraRemain, true)
					end
				else
					--resize_SpellIcon(f, i, 0)
					Icon_Ready(f.Icon[i], true)
				end
			end
		end
	end)
end

local OnEvent_Aura = function(f)
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
		if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_TARGET_CHANGED" or event == "PLAYER_SPECIALIZATION_CHANGED" or event == "GROUP_ROSTER_UPDATE" or event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "PLAYER_TALENT_UPDATE" or event == "CHARACTER_POINTS_CHANGED" then
			L.init_AuraWatch(f)
			event_Aura(f)
			event_Spell(f)
		elseif event == "UNIT_AURA" then
			event_Aura(f)
		elseif event == "SPELL_UPDATE_COOLDOWN" or event =="PLAYER_REGEN_DISABLED" or event =="PLAYER_REGEN_ENABLED" then
			event_Spell(f)
		end
	end)
end

--- ----------------------------------------------------------------------------
--> Right Frame
--- ----------------------------------------------------------------------------

local init_Icon = function(f)
	f.Icon = {}
	f.Icon.Help = CreateFrame("Frame", nil, f)
	f.Icon.Help: SetSize(78,56)
	f.Icon.Help: SetPoint("TOPRIGHT", f, "TOPRIGHT", -20, -10)
	f.Icon.Help: SetClampedToScreen(true)
	
	for i = 1,5 do 
		f.Icon[i] = CreateFrame("Frame", nil, f)
		f.Icon[i]: SetSize(78,56)
		
		f.Icon[i].Num = CreateFrame("Frame", nil, f.Icon[i])
		f.Icon[i].Num: Hide()
		f.Icon[i].Num[1] = f.Icon[i].Num:CreateTexture(nil, "OVERLAY")
		create_Texture(f.Icon[i].Num[1], "NumRight28", Num_Right_28[0][1],Num_Right_28[0][2], Num_Right_28[0][3],Num_Right_28[0][4],Num_Right_28[0][5],Num_Right_28[0][6], C.Color.White,1, "CENTER",f.Icon[i],"CENTER",-8,0)
		f.Icon[i].Num[2] = f.Icon[i].Num:CreateTexture(nil, "OVERLAY")
		create_Texture(f.Icon[i].Num[2], "NumRight28", Num_Right_28[0][1],Num_Right_28[0][2], Num_Right_28[0][3],Num_Right_28[0][4],Num_Right_28[0][5],Num_Right_28[0][6], C.Color.White,1, "BOTTOMLEFT",f.Icon[i].Num[1],"BOTTOMRIGHT",-14,-1)
		f.Icon[i].Num[3] = f.Icon[i].Num:CreateTexture(nil, "OVERLAY")
		create_Texture(f.Icon[i].Num[3], "NumRight28", Num_Right_28["s"][1],Num_Right_28["s"][2], Num_Right_28["s"][3],Num_Right_28["s"][4],Num_Right_28["s"][5],Num_Right_28["s"][6], C.Color.White,1, "BOTTOMLEFT",f.Icon[i].Num[2],"BOTTOMRIGHT",-20,0)
		
		f.Icon[i].Back = f.Icon[i]:CreateTexture(nil, "BACKGROUND")
		f.Icon[i].Back: SetTexture(F.Media.."RightIcon")
		f.Icon[i].Back: SetPoint("CENTER", f.Icon[i], "CENTER", 0,0)
		f.Icon[i].Back: SetVertexColor(unpack(C.Color.White))
		f.Icon[i].Back: SetSize(Icon_Coord[24][1],Icon_Coord[24][2])
		f.Icon[i].Back: SetTexCoord(Icon_Coord[24][3],Icon_Coord[24][4], Icon_Coord[24][5],Icon_Coord[24][6])
		f.Icon[i].Back: SetAlpha(0.9)
		
		f.Icon[i].Tex = f.Icon[i]:CreateTexture(nil, "ARTWORK")
		f.Icon[i].Tex: SetSize(40,40)
		f.Icon[i].Tex: SetVertexColor(unpack(C.Color.Black))
		f.Icon[i].Tex: SetAlpha(0.9)
		f.Icon[i].Tex: SetPoint("CENTER", f.Icon[i], "CENTER", 1,0)
			
		f.Icon[i].Bar = f.Icon[i]:CreateTexture(nil, "BORDER")
		f.Icon[i].Bar: SetTexture(F.Media.."RightIcon")
		f.Icon[i].Bar: SetPoint("CENTER", f.Icon[i], "CENTER", 0,0)
		f.Icon[i].Bar: SetVertexColor(unpack(C.Color.White))
		f.Icon[i].Bar: SetSize(Icon_Coord[24][1],Icon_Coord[24][2])
		f.Icon[i].Bar: SetTexCoord(Icon_Coord[24][3],Icon_Coord[24][4], Icon_Coord[24][5],Icon_Coord[24][6])
		f.Icon[i].Bar: SetAlpha(0.9)
	
		f.Icon[i].Border = f.Icon[i]:CreateTexture(nil, "OVERLAY")
		f.Icon[i].Border: SetTexture(F.Media.."RightIconBorder")
		f.Icon[i].Border: SetPoint("CENTER", f.Icon[i], "CENTER", 0,0)
		f.Icon[i].Border: SetVertexColor(unpack(C.Color.White))
		f.Icon[i].Border: SetSize(78,56)
		f.Icon[i].Border: SetTexCoord(25/128,103/128, 4/64,60/64)
		f.Icon[i].Border: SetAlpha(0.9)
		
		f.Icon[i].Forbid = L.create_Texture(f.Icon[i], "OVERLAY", "Right_IconForbid1", 42,42, 0,1,0,1, C.Color.Red,0.9, "CENTER", f.Icon[i], "CENTER", 6,-10)
		f.Icon[i].Forbid: Hide()
		
		f.Icon[i].AuraID = nil
		f.Icon[i].Unit = nil
		f.Icon[i].AuraCount = 0
		f.Icon[i].Color = C.Color.White
		f.Icon[i].Expires = 0
		f.Icon[i].Duration = 0
		f.Icon[i].AuraRemain = 0
		
		f.Icon[i].SpellID = nil
		f.Icon[i].SpellCount = 0
		f.Icon[i].Start = 0
		f.Icon[i].CD = 0
		f.Icon[i].SpellRemain = 0
	end
end

local create_Gun = function(f)
	f.Gun = f:CreateTexture(nil, "ARTWORK")
	--f.Gun: SetTexture(F.Media..texture)
	--f.Gun: SetSize(x,y)
	--f.Gun: SetTexCoord(x1,x2, y1,y2)
	f.Gun: SetVertexColor(unpack(C.Color.White))
	f.Gun: SetAlpha(0.9)
	--f.Gun: SetPoint(p1,p2,p3,p4,p5)
end

L.Right = function(f)
	f.Right = CreateFrame("Frame", nil, f)
	f.Right: SetSize(112, 72)
	f.Right: SetAlpha(0.95)
	f.Right.Border = L.create_Texture(f.Right, "ARTWORK", "RightBorderRight", 33,62, 16/64,49/64,1/64,63/64, C.Color.Blue,0.9, "TOPRIGHT",f.Right,"TOPRIGHT",0,0)
	
	init_Icon(f.Right)
	OnEvent_Aura(f.Right)
	OnUpdate_Aura(f.Right)
	create_Gun(f.Right)
end