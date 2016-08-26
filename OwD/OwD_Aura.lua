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
--> 
--- ----------------------------------------------------------------------------

local create_Backdrop = function(f)
	local d = 4
	if f.Shadow then return end
	f.Shadow = CreateFrame("Frame", nil, f)
	f.Shadow:SetFrameLevel(0)
	f.Shadow:SetFrameStrata(f:GetFrameStrata())
	f.Shadow:SetPoint("TOPLEFT", -d, d)
	f.Shadow:SetPoint("BOTTOMLEFT", -d, -d)
	f.Shadow:SetPoint("TOPRIGHT", d, d)
	f.Shadow:SetPoint("BOTTOMRIGHT", d, -d)
	f.Shadow:SetBackdrop({
		edgeFile = F.Media.."glowTex", 
		edgeSize = d,
		insets = { left = 0, right = 0, top = 0, bottom = 0 }
	})
	
	f.Shadow: SetBackdropColor( .05,.05,.05, 0)
	f.Shadow: SetBackdropBorderColor(C.Color.White2[1],C.Color.White2[2],C.Color.White2[3],0.75)
end

local formatTime = function(s)
	local day, hour, minute = 86400, 3600, 60
	if s >= day then
		return format("%dd", floor(s/day + 0.5)), s % day
	elseif s >= hour then
		return format("%dh", floor(s/hour + 0.5)), s % hour
	elseif s >= minute then
		return format("%dm", floor(s/minute + 0.5)), s % minute
	elseif s >= minute / 12 then
		return floor(s + 0.5), (s * 100 - floor(s * 100))/100
	end
	return format("%.1f", s), (s * 100 - floor(s * 100))/100
end

local UpdateTooltip = function(self)
	GameTooltip:SetUnitAura(self:GetParent().unit, self:GetID(), self.filter)
end

local OnEnter = function(self)
	if(not self:IsVisible()) then return end

	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
	self:UpdateTooltip()
end

local OnLeave = function(self)
	GameTooltip:Hide()
end

local event_Aura = function(f, unit, index, filter)
	local name, rank, icon, count, dispelType, duration, expires, caster, isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff, value1, value2, value3 = UnitAura(unit, index , filter)
	if name then
		f.name = name
		f.tex = icon
		f.count = count
		f.type = dispelType
		f.duration = duration
		--f.expires = expires
		f.remain = max(expires - GetTime(), 0)
		f.caster = caster
		f.steal = isStealable
		f.spellID = spellID
		f.isBoss = isBossDebuff
		f.filter = filter
		f:SetID(index)
	else
		f.name = nil
		f.tex = nil
		f.count = nil
		f.type = nil
		f.duration = nil
		f.remain = 0
		f.caster = nil
		f.steal = nil
		f.spellID = nil
		f.isBoss = nil
	end
end

local unpdate_Aura = function(f)
	if not f.Aura then
		f.Aura = {}
	end
	local i = 1
	while (i < f.limit) do
		if not f.Aura[i] then
			f.Aura[i] = CreateFrame("Button", nil, f)
			f.Aura[i]: SetSize(f.size, f.size)
			f.Aura[i]: RegisterForClicks("RightButton")
			
			create_Backdrop(f.Aura[i])
			f.Aura[i].Shadow: SetBackdropBorderColor(C.Color.Black[1],C.Color.Black[2],C.Color.Black[3],0.9)
			
			f.Aura[i].UpdateTooltip = UpdateTooltip
			f.Aura[i]: SetScript("OnEnter", function(self)
				OnEnter(self)
			end)
			f.Aura[i]: SetScript("OnLeave", function(self)
				OnLeave(self)
			end)
			
			f.Aura[i].Icon = f.Aura[i]:CreateTexture(nil, "BORDER")
			f.Aura[i].Icon: SetSize(f.size, f.size)
			f.Aura[i].Icon: SetTexCoord(0.08, 0.92, 0.08, 0.92)
			f.Aura[i].Icon: SetPoint("CENTER", f.Aura[i], "CENTER", 0,0)
			
			f.Aura[i].CD = f.Aura[i]:CreateFontString(nil, "OVERLAY")
			f.Aura[i].CD: SetFont(C.Font.Num, f.font, "THINOUTLINE")--"THINOUTLINE,MONOCHROME"
			f.Aura[i].CD: SetShadowColor(0,0,0,0.9)
			f.Aura[i].CD: SetShadowOffset(0,0)
			f.Aura[i].CD: SetJustifyH("CENTER")
			f.Aura[i].CD: SetPoint("BOTTOM", f.Aura[i], "BOTTOM", 0,-2)
			f.Aura[i].CD: SetText(formatTime(54))
			
			f.Aura[i].Ct = f.Aura[i]:CreateFontString(nil, "OVERLAY")
			f.Aura[i].Ct: SetFont(C.Font.Num, f.font, "THINOUTLINE")
			f.Aura[i].Ct: SetShadowColor(0,0,0,0.9)
			f.Aura[i].Ct: SetShadowOffset(0,0)
			f.Aura[i].Ct: SetJustifyH("CENTER")
			f.Aura[i].Ct: SetPoint("TOPRIGHT", f.Aura[i], "TOPRIGHT", 1,2)
			
			f.Aura[i].Overlay = f.Aura[i]:CreateTexture(nil, "ARTWORK")
			
			f.Aura[i].Border = f.Aura[i]:CreateTexture(nil, "OVERLAY")
			
		end
		event_Aura(f.Aura[i], f.unit, i, f.filter)
		if f.Aura[i].name then
			f.Aura[i].Icon: SetTexture(f.Aura[i].tex)
			if f.Direction == "RIGHT" then
				if i == 1 then
					f.Aura[i]: SetPoint("BOTTOMLEFT",f,"BOTTOMLEFT",3,-3)
				elseif (i > f.PerLine) and (((i-1)/f.PerLine) == floor((i-1)/f.PerLine)) then
					f.Aura[i]: SetPoint("BOTTOMLEFT",f[i-f.PerLine],"TOPLEFT",0,6)
					f: SetHeight((f.size+6)*floor((i-1)/12))
				else
					f.Aura[i]: SetPoint("LEFT",f.Aura[i-1],"RIGHT",6,0)
				end
			elseif f.Direction == "LEFT" then
				if i == 1 then
					f.Aura[i]: SetPoint("BOTTOMRIGHT",f,"BOTTOMRIGHT",3,-3)
				elseif (i > f.PerLine) and (((i-1)/f.PerLine) == floor((i-1)/f.PerLine)) then
					f.Aura[i]: SetPoint("BOTTOMRIGHT",f[i-f.PerLine],"TOPRIGHT",0,6)
					f: SetHeight((f.size+6)*floor((i-1)/12))
				else
					f.Aura[i]: SetPoint("RIGHT",f.Aura[i-1],"LEFT",-6,0)
				end
			end
			
			if f.Aura[i].isBoss or f.Aura[i].caster == "player" then
				f.Aura[i].Icon: SetDesaturated(false)  
			else
				f.Aura[i].Icon: SetDesaturated(true)  
			end
			f.Aura[i]: Show()
			
		else
			f.Aura[i]: Hide()
		end
		i = i + 1
	end
end

local OnUpdate_Aura = function(f, elapsed)
	if f:IsVisible() then
		for i = 1, f.limit do
			if f.Aura[i] and f.Aura[i].name then
				f.Aura[i].remain = max(f.Aura[i].remain - elapsed, 0)
				if f.Aura[i].remain > 0 then
					f.Aura[i].CD: SetText(formatTime(f.Aura[i].remain))
				else
					f.Aura[i].CD: SetText()
				end
				if f.Aura[i].count and f.Aura[i].count > 0 then
					f.Aura[i].Ct: SetText(f.Aura[i].count)
				else
					f.Aura[i].Ct: SetText()
				end
			end
		end
	end
end

local create_TargetAura = function(f)
	f.DeBuff = CreateFrame("Frame", nil, f)
	f.DeBuff.size = 28
	f.DeBuff.font = 12
	f.DeBuff.limit = 12
	f.DeBuff.unit = "target"
	f.DeBuff.filter = "HARMFUL"
	f.DeBuff.Direction = "RIGHT"
	f.DeBuff.PerLine = 12
	f.DeBuff: SetSize(f.DeBuff.size+6, f.DeBuff.size+6)
	f.DeBuff: SetPoint("BOTTOMLEFT", f, "TOPLEFT", -10,32)	
	
	f.Buff = CreateFrame("Frame", nil, f)
	f.Buff.size = 28
	f.Buff.font = 12
	f.Buff.limit = 12
	f.Buff.unit = "target"
	f.Buff.filter = "HELPFUL"
	f.Buff.Direction = "RIGHT"
	f.Buff.PerLine = 12
	f.Buff: SetSize(f.Buff.size+6, f.Buff.size+6)
	f.Buff: SetPoint("BOTTOMLEFT", f.DeBuff, "TOPLEFT", 0,2)
	--f.Buff: SetPoint("BOTTOMLEFT", f.DeBuff, "BOTTOMLEFT", 0,0)
end

local create_FocusAura = function(f)
	f.DeBuff = CreateFrame("Frame", nil, f)
	f.DeBuff.size = 20
	f.DeBuff.font = 10
	f.DeBuff.limit = 12
	f.DeBuff.unit = "focus"
	f.DeBuff.filter = "HARMFUL"
	f.DeBuff.Direction = "LEFT"
	f.DeBuff.PerLine = 12
	f.DeBuff: SetSize(f.DeBuff.size+6, f.DeBuff.size+6)
	f.DeBuff: SetPoint("BOTTOMRIGHT", f, "TOPRIGHT", 0,28)	
	
	f.Buff = CreateFrame("Frame", nil, f)
	f.Buff.size = 20
	f.Buff.font = 10
	f.Buff.limit = 12
	f.Buff.unit = "focus"
	f.Buff.filter = "HELPFUL"
	f.Buff.Direction = "LEFT"
	f.Buff.PerLine = 12
	f.Buff: SetSize(f.Buff.size+6, f.Buff.size+6)
	f.Buff: SetPoint("BOTTOMLEFT", f.DeBuff, "TOPLEFT", 0,4)
	--f.Buff: SetPoint("BOTTOMLEFT", f.DeBuff, "BOTTOMLEFT", 0,0)
end

L.OnUpdate_Aura = function(f, elapsed)
	OnUpdate_Aura(f.Target.DeBuff, elapsed)
	OnUpdate_Aura(f.Target.Buff, elapsed)
	OnUpdate_Aura(f.Focus.DeBuff, elapsed)
	OnUpdate_Aura(f.Focus.Buff, elapsed)
end

L.Aura = function(f)
	create_TargetAura(f.Target)
	create_FocusAura(f.Focus)
	
	f.Aura = CreateFrame("Frame", nil, f)
	f.Aura: RegisterEvent("PLAYER_ENTERING_WORLD")
	f.Aura: RegisterEvent("PLAYER_TARGET_CHANGED")
	f.Aura: RegisterEvent("PLAYER_FOCUS_CHANGED")
	f.Aura: RegisterEvent("UNIT_AURA")
	f.Aura: SetScript("OnEvent", function(self,event)
		unpdate_Aura(f.Target.DeBuff)
		unpdate_Aura(f.Target.Buff)
		unpdate_Aura(f.Focus.DeBuff)
		unpdate_Aura(f.Focus.Buff)
	end)
end





--[[
		if(unit == "target") then	
			if (unitCaster == "player" or unitCaster == "vehicle") then
				button.icon:SetDesaturated(false)                 
			elseif(not UnitPlayerControlled(unit)) then -- If Unit is Player Controlled don"t desaturate debuffs
				button:SetBackdropColor(0, 0, 0)
				button.overlay:SetVertexColor(0.3, 0.3, 0.3)      
				button.icon:SetDesaturated(true)  
			end
		end
		
		
		
		
--]]