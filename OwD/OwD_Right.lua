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
	if i <= 4 then
		f.Icon[i].Bar:SetSize(69,52*d+F.Debug)
		f.Icon[i].Bar:SetTexCoord(30/128,99/128, (38+52*abs(1-d)+F.Debug)/128, 90/128)
	else
		f.Icon[i].Bar:SetSize(40,30*d+F.Debug)
		f.Icon[i].Bar:SetTexCoord(12/64,52/64, (17+30*abs(1-d)+F.Debug)/64, 47/64)
	end
end

local resize_SpellIcon = function(f, i, d)
	if i <= 4 then
		f.Icon[i].Bar:SetSize(69,52*abs(1-d)+F.Debug)
		f.Icon[i].Bar:SetTexCoord(30/128,99/128, (38+52*abs(d)+F.Debug)/128, 90/128)
	else
		f.Icon[i].Bar:SetSize(40,30*abs(1-d)+F.Debug)
		f.Icon[i].Bar:SetTexCoord(12/64,52/64, (17+30*abs(d)+F.Debug)/64, 47/64)
	end
end

L.init_AuraWatch = function(f)
	if OwD_DB.WTF_AuraWatch then
		AuraFilter = OwD_DB.AuraFilter
	else
		AuraFilter = L.AuraFilter
	end
	for i = 1,6 do
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
	local a,b = 1,5
	local classFileName = select(2, UnitClass("player"))
	local specID = GetSpecialization()
	if classFileName and specID then
		--> 1
		for k, v in ipairs (AuraFilter[classFileName][specID][1]) do
			if v.Spell and v.Aura then
				local name, rank, icon, castingTime, minRange, maxRange, spellID = GetSpellInfo(v.Spell)
				--if not a then a = 1 end
				if GetSpellInfo(name) and a <= 4 then
					f.Icon[a].SpellID = name
					f.Icon[a].AuraID = GetSpellInfo(v.Aura)
					f.Icon[a].Unit = v.Unit
					f.Icon[a].Tex: SetTexture(F.Media.."Icons\\"..v.Icon)
					a = a + 1
				end	
			elseif v.Spell then
				local name, rank, icon, castingTime, minRange, maxRange, spellID = GetSpellInfo(v.Spell)
				if GetSpellInfo(name) and a <= 4 then
					f.Icon[a].SpellID = name
					f.Icon[a].Tex: SetTexture(F.Media.."Icons\\"..v.Icon)
					a = a + 1
				end
			elseif v.Aura then
				if a <= 4 then
					f.Icon[a].AuraID = GetSpellInfo(v.Aura)
					f.Icon[a].Unit = v.Unit
					f.Icon[a].Tex: SetTexture(F.Media.."Icons\\"..v.Icon)
					a = a + 1
				end
			end
		end
		--> 2
		for k, v in ipairs (AuraFilter[classFileName][specID][2]) do
			if v.Spell and v.Aura then
				local name, rank, icon, castingTime, minRange, maxRange, spellID = GetSpellInfo(v.Spell)
				if not b then b = 5 end
				if GetSpellInfo(name) and b <= 6 then
					f.Icon[b].SpellID = name
					f.Icon[b].AuraID = GetSpellInfo(v.Aura)
					f.Icon[b].Unit = v.Unit
					f.Icon[b].Tex: SetTexture(F.Media.."Icons\\"..v.Icon)
					b = b + 1
				end
				
			elseif v.Spell then
				local name, rank, icon, castingTime, minRange, maxRange, spellID = GetSpellInfo(v.Spell)
				if GetSpellInfo(name) and b <= 6 then
					f.Icon[b].SpellID = v.Spell
					f.Icon[b].Tex: SetTexture(F.Media.."Icons\\"..v.Icon)
					b = b + 1
				end
			elseif v.Aura then
				if b <= 6 then
					f.Icon[b].AuraID = GetSpellInfo(v.Aura)
					f.Icon[b].Unit = v.Unit
					f.Icon[b].Tex: SetTexture(F.Media.."Icons\\"..v.Icon)
					b = b + 1
				end
			end
		end
	end
	
	if f.Icon[6].AuraID or f.Icon[6].SpellID then
		f.Icon[6]: SetAlpha(1)
		f.Icon[6]: ClearAllPoints()
		f.Icon[6]: SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -40,22)
	else
		f.Icon[6]: SetAlpha(0)
		f.Icon[6]: ClearAllPoints()
		f.Icon[6]: SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -40+38,22-3)
	end
	
	for i = 1,5 do
		if f.Icon[i].AuraID or f.Icon[i].SpellID then
			f.Icon[i]: SetAlpha(1)
			f.Icon[i]: ClearAllPoints()
			if i < 4 then
				f.Icon[i]: SetPoint("TOPRIGHT", f.Icon[i+1], "TOPRIGHT", -60,4)
			elseif i == 4 then
				f.Icon[i]: SetPoint("TOPRIGHT", f.Icon[i+1], "TOPRIGHT", -42,5)
			else
				f.Icon[i]: SetPoint("TOPRIGHT", f.Icon[i+1], "TOPRIGHT", -38,3)
			end
		else
			f.Icon[i]: SetAlpha(0)
			f.Icon[i]: ClearAllPoints()
			if i == 4 then
				f.Icon[i]: SetPoint("TOPRIGHT", f.Icon[i+1], "TOPRIGHT", 18,1)
			else
				f.Icon[i]: SetPoint("TOPRIGHT", f.Icon[i+1], "TOPRIGHT", 0,0)
			end
		end
	end
end

local event_Aura = function(f)
	local name, rank, icon, count, dispelType, duration, expires, caster, isStealable, shouldConsolidate, spellID
	for i = 1, #f.Icon do
		if f.Icon[i].AuraID and f.Icon[i].Unit then
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
	--[[
	local index =1
	local n
	while (index == 1) or n do
		n = false
		name, rank, icon, count, dispelType, duration, expires, caster, isStealable, shouldConsolidate, spellID= UnitAura("player", index, "HELPFUL|PLAYER")
		if name then n = true end
		if spellID then
			--print(name, spellID)
		end
		index = index + 1
	end
	--]]
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

local OnUpdate_Aura = function(f)
	f:SetScript("OnUpdate", function(self, elapsed)
		for i =1,#f.Icon do
			if f.Icon[i].AuraID or f.Icon[i].SpellID then
				f.Icon[i].AuraRemain = max(f.Icon[i].AuraRemain - elapsed, 0)
				f.Icon[i].SpellRemain = f.Icon[i].CD - (GetTime()-f.Icon[i].Start)
				f.Icon[i].Bar: SetVertexColor(unpack(C.Color.White))
				if f.Icon[i].AuraRemain > 0 then
					--f.Icon[i].Bar: SetVertexColor(f.Icon[i].Color[1],f.Icon[i].Color[2],f.Icon[i].Color[3])
					if f.Icon[i].AuraRemain >= f.Icon[i].Duration/3 then
						f.Icon[i].Bar: SetVertexColor(unpack(C.Color.Orange))
					else
						f.Icon[i].Bar: SetVertexColor(unpack(C.Color.Red))
					end
					f.Icon[i].Bar: SetAlpha(Alp1)
					resize_AuraIcon(f, i, f.Icon[i].AuraRemain/(f.Icon[i].Duration+F.Debug))
					f.Icon[i].Num: Show()
					f.Icon[i].Tex: Hide()
					if f.Icon[i].AuraCount and f.Icon[i].AuraCount >= 1 then
						update_Num(f, i, f.Icon[i].AuraCount, true)
					else
						update_Num(f, i, f.Icon[i].AuraRemain, true)
					end
				elseif f.Icon[i].CD <= 2 then
					resize_SpellIcon(f, i, 0)
					f.Icon[i].Bar: SetAlpha(Alp1)
					f.Icon[i].SpellRemain = 0
					if UnitAffectingCombat("player") and f.Icon[i].SpellCount and (f.Icon[i].SpellCount >=1) then
						f.Icon[i].Num: Show()
						f.Icon[i].Tex: Hide()
						update_Num(f, i, f.Icon[i].SpellCount, true)
					else
						f.Icon[i].Num: Hide()
						f.Icon[i].Tex: Show()
					end
				elseif f.Icon[i].SpellRemain > 0 then
					f.Icon[i].Bar: SetAlpha(Alp2)
					resize_SpellIcon(f, i, f.Icon[i].SpellRemain/(f.Icon[i].CD+F.Debug))
					f.Icon[i].Num: Show()
					f.Icon[i].Tex: Hide()
					if f.Icon[i].SpellCount and f.Icon[i].SpellCount >= 1 then
						update_Num(f, i, f.Icon[i].SpellCount, true)
					else
						update_Num(f, i, f.Icon[i].SpellRemain, true)
					end
				end
			elseif f.Icon[i].SpellID then
				f.Icon[i].SpellRemain = f.Icon[i].CD - (GetTime()-f.Icon[i].Start)
				f.Icon[i].Bar: SetVertexColor(unpack(C.Color.White))
				if f.Icon[i].CD <= 1.5 then
					resize_SpellIcon(f, i, 0)
					f.Icon[i].Remain2 = 0
					if UnitAffectingCombat("player") and (f.Icon[i].SpellCount >=1) then
						f.Icon[i].Num: Show()
						f.Icon[i].Tex: Hide()
						update_Num(f, i, f.Icon[i].SpellCount, true)
					else
						f.Icon[i].Num: Hide()
						f.Icon[i].Tex: Show()
					end
				elseif f.Icon[i].SpellRemain > 0 then
					f.Icon[i].Bar: SetAlpha(Alp2)
					resize_SpellIcon(f, i, f.Icon[i].SpellRemain/(f.Icon[i].CD+F.Debug))
					f.Icon[i].Num: Show()
					f.Icon[i].Tex: Hide()
					if f.Icon[i].SpellCount and f.Icon[i].SpellCount >= 1 then
						update_Num(f, i, f.Icon[i].SpellCount, true)
					else
						update_Num(f, i, f.Icon[i].SpellRemain, true)
					end
				end
			elseif f.Icon[i].AuraID then
				f.Icon[i].AuraRemain = max(f.Icon[i].AuraRemain - elapsed, 0)
				f.Icon[i].Bar: SetVertexColor(unpack(C.Color.White))
				if f.Icon[i].AuraRemain > 0 then
					f.Icon[i].Bar: SetVertexColor(f.Icon[i].Color[1],f.Icon[i].Color[2],f.Icon[i].Color[3])
					f.Icon[i].Bar: SetAlpha(Alp1)
					resize_AuraIcon(f, i, f.Icon[i].AuraRemain/(f.Icon[i].Duration+F.Debug))
					f.Icon[i].Num: Show()
					f.Icon[i].Tex: Hide()
					if f.Icon[i].AuraCount and f.Icon[i].AuraCount >= 1 then
						update_Num(f, i, f.Icon[i].AuraCount, true)
					else
						update_Num(f, i, f.Icon[i].AuraRemain, true)
					end
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

		if i <= 4 then
			f.Icon[i]: SetSize(69,52)
			create_Icon(f.Icon[i], "Icon_Big", 69,52, 30/128,99/128,38/128,90/128)
			
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
	f.Icon[6]: SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -40,22)
end

L.Right = function(f)
	f.Right = CreateFrame("Frame", nil, f)
	f.Right: SetSize(98, 113)
	
	f.Border = f:CreateTexture(nil, "ARTWORK")
	create_Texture(f.Border, "Icon_Border_Right", 29,58, 1/32,30/32,3/64,61/64, C.Color.White,0.9, "BOTTOMRIGHT",f.Right,"BOTTOMRIGHT",0,-9)
	
	init_Icon(f.Right)
	OnEvent_Aura(f.Right)
	OnUpdate_Aura(f.Right)
end