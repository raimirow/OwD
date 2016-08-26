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
--> Element      
--- ----------------------------------------------------------------------------
local TARGET_CENTER_WIDTH = 300
local FOCUS_CENTER_WIDTH = 160
local Ring = {
	[1] = {64, 51, 59},
	[2] = {256, 242, 250},
}

local Num = {	
	[1] =	{5,14,  63/256, 68/256,  1/16,15/16},
	[2] =	{7,14,  70/256, 77/256,  1/16,15/16},
	[3] =	{7,14,  80/256, 87/256,  1/16,15/16},
	[4] =	{7,14,  89/256, 96/256,  1/16,15/16},
	[5] =	{7,14,  98/256,105/256,  1/16,15/16},
	[6] =	{7,14, 107/256,114/256,  1/16,15/16},
	[7] =	{7,14, 116/256,123/256,  1/16,15/16},
	[8] =	{7,14, 125/256,132/256,  1/16,15/16},
	[9] =	{7,14, 134/256,141/256,  1/16,15/16},
	[0] =	{7,14, 143/256,150/256,  1/16,15/16},
	["."] =	{3,14, 153/256,156/256,  1/16,15/16},
	["s"] =	{5,14, 157/256,162/256,  1/16,15/16},
	["K"] =	{6,14, 166/256,172/256,  1/16,15/16},
	["M"] =	{7,14, 174/256,181/256,  1/16,15/16},
	["G"] =	{6,14, 183/256,189/256,  1/16,15/16},
	["%"] =	{6,14, 192/256,198/256,  1/16,15/16},
}

local Num_Center_20 = {
	[0] =	{21,30,   0/512, 21/512, 2/32,1},
	[1] =	{21,30,  21/512, 42/512, 2/32,1},
	[2] =	{21,30,  42/512, 63/512, 2/32,1},
	[3] =	{21,30,  63/512, 84/512, 2/32,1},
	[4] =	{21,30,  84/512,105/512, 2/32,1},
	[5] =	{21,30, 105/512,126/512, 2/32,1},
	[6] =	{21,30, 126/512,147/512, 2/32,1},
	[7] =	{21,30, 147/512,168/512, 2/32,1},
	[8] =	{21,30, 168/512,189/512, 2/32,1},
	[9] =	{21,30, 189/512,210/512, 2/32,1},
	["."] =	{18,30, 213/512,231/512, 2/32,1},
	["/"] =	{21,30, 231/512,252/512, 2/32,1},
	["k"] =	{21,30, 252/512,273/512, 2/32,1},
	["m"] =	{21,30, 273/512,294/512, 2/32,1},
	["g"] =	{21,30, 294/512,314/512, 2/32,1},
	["%"] =	{21,30, 314/512,335/512, 2/32,1},
	["s"] =	{19,30, 337/512,356/512, 2/32,1},
	["B"] =	{11,30, 501/512,512/512, 2/32,1},
}

local castColor = {}
castColor["Cast"] = C.Color.Blue
castColor["Stop"] = C.Color.Green
castColor["Shield"] = C.Color.Yellow
castColor["Fail"] = C.Color.Red

local update_Color = function(f, color)
	if f.unit == "player" or f.unit == "vehicle" or f.unit == "target" or f.unit == "focus" then
		if f.t0 then f.t0:SetVertexColor(color[1],color[2],color[3]) end
		if f.t1 then f.t1:SetVertexColor(color[1],color[2],color[3]) end
		if f.t2 then f.t2:SetVertexColor(color[1],color[2],color[3]) end
		if f[1] then f[1]:SetVertexColor(color[1],color[2],color[3]) end
		if f[2] then f[2]:SetVertexColor(color[1],color[2],color[3]) end
		if f[3] then f[3]:SetVertexColor(color[1],color[2],color[3]) end
	end
end

local update_Time = function(f, v)
		local v1,v2,v3
		if v then 
			v = min(v,99)
			v1 = max(floor(v/10), 0)
			v2 = max(floor(v)-v1*10, 0)
			v3 = floor(abs(v*10-floor(v)*10))
			
			if v1 == 0 then
				f.Time[5]:SetAlpha(0)
			else
				f.Time[5]:SetAlpha(0.9)
			end
			if f.style == "player" then
				f.Time[5]: SetSize(Num[v1][1], Num[v1][2])
				f.Time[5]: SetTexCoord(Num[v1][3],Num[v1][4], Num[v1][5],Num[v1][6])
				f.Time[4]: SetSize(Num[v2][1], Num[v2][2])
				f.Time[4]: SetTexCoord(Num[v2][3],Num[v2][4], Num[v2][5],Num[v2][6])
				f.Time[2]: SetSize(Num[v3][1], Num[v3][2])
				f.Time[2]: SetTexCoord(Num[v3][3],Num[v3][4], Num[v3][5],Num[v3][6])
			elseif f.style == "target" then
				f.Time[5]: SetSize(Num_Center_20[v1][1], Num_Center_20[v1][2])
				f.Time[5]: SetTexCoord(Num_Center_20[v1][3],Num_Center_20[v1][4], Num_Center_20[v1][5],Num_Center_20[v1][6])
				f.Time[4]: SetSize(Num_Center_20[v2][1], Num_Center_20[v2][2])
				f.Time[4]: SetTexCoord(Num_Center_20[v2][3],Num_Center_20[v2][4], Num_Center_20[v2][5],Num_Center_20[v2][6])
				f.Time[2]: SetSize(Num_Center_20[v3][1], Num_Center_20[v3][2])
				f.Time[2]: SetTexCoord(Num_Center_20[v3][3],Num_Center_20[v3][4], Num_Center_20[v3][5],Num_Center_20[v3][6])
			elseif f.style == "focus" then
				f.Time[5]: SetSize(Num_Center_20[v1][1], Num_Center_20[v1][2])
				f.Time[5]: SetTexCoord(Num_Center_20[v1][3],Num_Center_20[v1][4], Num_Center_20[v1][5],Num_Center_20[v1][6])
				f.Time[4]: SetSize(Num_Center_20[v2][1], Num_Center_20[v2][2])
				f.Time[4]: SetTexCoord(Num_Center_20[v2][3],Num_Center_20[v2][4], Num_Center_20[v2][5],Num_Center_20[v2][6])
				f.Time[2]: SetSize(Num_Center_20[v3][1], Num_Center_20[v3][2])
				f.Time[2]: SetTexCoord(Num_Center_20[v3][3],Num_Center_20[v3][4], Num_Center_20[v3][5],Num_Center_20[v3][6])
			end
		end
	end

local updateSafeZone = function(self,width)
	local sz = self.SafeZone
	local _, _, _, ms = GetNetStats()
	
	if(ms ~= 0) then
		local safeZonePercent = (width / self.max) * (ms / 1e5)
		if(safeZonePercent > 1) then safeZonePercent = 1 end
		sz:SetWidth(width * safeZonePercent + F.Debug)
		sz:Show()
	else
		sz:Hide()
	end
end

local CastingBar_FinishSpell = function(self, barSpark, barFlash)
	update_Color(self, castColor["Stop"])
	self.flash = 1;
	self.fadeOut = 1;
	self.casting = nil;
	self.channeling = nil;
end

local CastingBar_OnLoad = function(self, unit, showTradeSkills)
	self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED");
	self:RegisterEvent("UNIT_SPELLCAST_DELAYED");
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START");
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE");
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP");
	self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTIBLE");
	self:RegisterEvent("UNIT_SPELLCAST_NOT_INTERRUPTIBLE");
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterUnitEvent("UNIT_SPELLCAST_START", unit);
	self:RegisterUnitEvent("UNIT_SPELLCAST_STOP", unit);
	self:RegisterUnitEvent("UNIT_SPELLCAST_FAILED", unit);
	--self:RegisterEvent("UNIT_SPELLCAST_START");
	--self:RegisterEvent("UNIT_SPELLCAST_STOP");
	--self:RegisterEvent("UNIT_SPELLCAST_FAILED");
	
	self.unit = unit
	self.showTradeSkills = showTradeSkills
	self.casting = nil
	self.channeling = nil
	self.holdTime = 0
	self.showCastbar = true
	self.Per = 0
end

local function Update_Icon_Texture(self, texture)
	if (self.Icon and texture) then
		--print(texture)
		if texture ~= "INTERFACE\ICONS\thumbsdown" then	
			SetPortraitToTexture(self.Icon, texture)
		end
	end
end

local CastingBar_OnEvent = function(self, event, ...)
	--self:SetScript("OnEvent", function(self, event, ...)
		local arg1 = ...
		local unit = self.unit
		if ( event == "PLAYER_ENTERING_WORLD" ) then
			local nameChannel  = UnitChannelInfo(unit);
			local nameSpell  = UnitCastingInfo(unit);
			if ( nameChannel ) then
				event = "UNIT_SPELLCAST_CHANNEL_START";
				arg1 = unit
			elseif ( nameSpell ) then
				event = "UNIT_SPELLCAST_START";
				arg1 = unit
			else
				CastingBar_FinishSpell(self);
			end
		end
	
		if ( arg1 ~= unit ) then
			return
		end
	
		if ( event == "UNIT_SPELLCAST_START" ) then
			local name, Subtext, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible = UnitCastingInfo(unit)
			if ( not name or (not self.showTradeSkills and isTradeSkill)) then
				self:Hide()
				--U.Cast = false -->For Loop
				return
			end
			
			if notInterruptible then
				update_Color(self, castColor["Shield"])
			else
				update_Color(self, castColor["Cast"])
			end
			
			if (notInterruptible and self.Shield) then
				self.Shield:SetVertexColor(unpack(castColor["Shield"]))
			elseif (self.Shield) then
				self.Shield:SetVertexColor(unpack(castColor["Cast"]))
			end
			
			self.value = (GetTime() - (startTime / 1000))
			self.maxValue = (endTime - startTime) / 1000
			self.Per = floor((self.value/self.maxValue)*1e2)/1e2
			
			Update_Icon_Texture(self, texture)
			if (self.Text) then self.Text:SetText(F.Hex(C.Color.Black)..text) end
			
			self:SetAlpha(1);
			self.holdTime = 0;
			self.casting = 1;
			self.castID = castID;
			self.duration = GetTime() - startTime
			self.delay = 0
			self.channeling = nil
			self.fadeOut = nil
			
			--[[
			if (self.SafeZone) then
				self.SafeZone:ClearAllPoints()
				self.SafeZone:SetPoint'RIGHT'
				self.SafeZone:SetPoint'TOP'
				self.SafeZone:SetPoint'BOTTOM'
				updateSafeZone(self)
			end
			--]]
			
			if ( self.showCastbar ) then
				self:Show()
			end
		
		elseif ( event == "UNIT_SPELLCAST_STOP" or event == "UNIT_SPELLCAST_CHANNEL_STOP") then
			if ( not self:IsVisible() ) then
				self:Hide()
			end
			if ( (self.casting and event == "UNIT_SPELLCAST_STOP" and select(4, ...) == self.castID) or (self.channeling and event == "UNIT_SPELLCAST_CHANNEL_STOP") ) then
				--self.Per = 1
				update_Color(self, castColor["Stop"])
				
				if ( event == "UNIT_SPELLCAST_STOP" ) then
					self.casting = nil
				else
					self.channeling = nil
				end
				self.flash = 1;
				self.fadeOut = 1;
				self.holdTime = 0;
			end
		
		elseif ( event == "UNIT_SPELLCAST_FAILED" or event == "UNIT_SPELLCAST_INTERRUPTED" ) then
			if ( self:IsShown() and (self.casting and select(4, ...) == self.castID) and not self.fadeOut ) then
				self.Per = 1
				
				update_Color(self, castColor["Fail"])
				
				if ( event == "UNIT_SPELLCAST_FAILED" ) then
					if (self.Text) then self.Text:SetText(F.Hex(C.Color.Black).."Failed") end
				else
					if (self.Text) then self.Text:SetText(F.Hex(C.Color.Black).."Interrupted") end
				end
				self.casting = nil
				self.channeling = nil
				self.fadeOut = 1
				self.holdTime = GetTime() + CASTING_BAR_HOLD_TIME;
			end
			
		elseif ( event == "UNIT_SPELLCAST_DELAYED" ) then
			if ( self:IsShown() ) then
				local name, Subtext, text, texture, startTime, endTime, isTradeSkill = UnitCastingInfo(unit);
				if ( not name or (not self.showTradeSkills and isTradeSkill)) then
					-- if there is no name, there is no bar
					self:Hide();
					--U.Cast = false
					return
				end
				local duration = GetTime() - (startTime / 1000)
				if(duration < 0) then duration = 0 end
				
				if not self.delay then self.delay = 0 end
				self.delay = self.delay + self.value - duration
				self.value = duration
				self.maxValue = (endTime - startTime) / 1000
				self.Per = floor((self.value/self.maxValue)*1e2)/1e2
				if ( not self.casting ) then
					self.casting = 1
					self.channeling = nil
					self.flash = 0
					self.fadeOut = 0
				end
			end
	
		elseif ( event == "UNIT_SPELLCAST_CHANNEL_START" ) then
			local name, Subtext, text, texture, startTime, endTime, isTradeSkill, notInterruptible = UnitChannelInfo(unit);
			
			if ( not name or (not self.showTradeSkills and isTradeSkill)) then
				-- if there is no name, there is no bar
				self:Hide()
				--U.Cast = false
				return
			end
			
			self.value = ((endTime / 1000) - GetTime());
			self.maxValue = (endTime - startTime) / 1000;
			self.Per = floor((self.value/self.maxValue)*1e2)/1e2
			
			--if (self.Icon) then self.Icon:SetTexture(texture) end
			Update_Icon_Texture(self, texture)
			if (self.Text) then self.Text:SetText(F.Hex(C.Color.Black)..text) end
			
			self:SetAlpha(1)
			self.holdTime = 0
			self.casting = nil
			self.castID = nil
			self.channeling = 1
			self.fadeOut = nil
			
			if notInterruptible then
				update_Color(self, castColor["Shield"])
			else
				update_Color(self, castColor["Cast"])
			end
			
			if (notInterruptible and self.Shield) then
				self.Shield:SetVertexColor(unpack(castColor["Shield"]))
			elseif (self.Shield) then
				self.Shield:SetVertexColor(unpack(castColor["Cast"]))
			end
			
			if ( self.showCastbar ) then
				self:Show();
				--U.Cast = true
			end
			
		elseif ( event == "UNIT_SPELLCAST_CHANNEL_UPDATE" ) then
			if ( self:IsShown() ) then
				local name, nameSubtext, text, texture, startTime, endTime, isTradeSkill = UnitChannelInfo(unit);
				if ( not name or (not self.showTradeSkills and isTradeSkill)) then
					-- if there is no name, there is no bar
					self:Hide();
					--U.Cast = false;
					return;
				end
				
				local duration = (endTime / 1000) - GetTime()
				
				if not self.delay then self.delay = 0 end
				self.delay = self.delay + self.value - duration;
				self.value = duration;
				self.maxValue = (endTime - startTime) / 1000;
				self.Per = floor((self.value/self.maxValue)*1e2)/1e2;
			end
			
		elseif event == "UNIT_SPELLCAST_INTERRUPTIBLE" then
			update_Color(self, castColor["Cast"])
			--if (self.Shield) then self.Shield:SetVertexColor(unpack(T.Colors.Castbar["Casting"])) end
		elseif event == "UNIT_SPELLCAST_NOT_INTERRUPTIBLE" then
			update_Color(self, castColor["Shield"])
			--if (self.Shield) then self.Shield:SetVertexColor(unpack(T.Colors.Castbar["Interruptible"])) end
		end
	--end)
end

local CastingBar_OnUpdate = function(self, elapsed)
	if ( self.casting ) then
		self.value = self.value + elapsed
		if ( self.value >= self.maxValue ) then
			self.Per = 1
			CastingBar_FinishSpell(self, barSpark, barFlash);
			return
		end
		--update_Color(self, castColor["Cast"])
		self.Per = floor((self.value/self.maxValue)*1e2)/1e2
		if (self.Time) then
			update_Time(self, self.maxValue - self.value)
		end
		
	elseif ( self.channeling ) then
		self.value = self.value - elapsed;
		if ( self.value <= 0 ) then
			self.Per = 0
			CastingBar_FinishSpell(self, barSpark, barFlash);
			return
		end
		--update_Color(self, castColor["Cast"])
		self.Per = floor((self.value/self.maxValue)*1e2)/1e2
		
		if (self.Time) and (self.value and  self.value > 0) then
			update_Time(self, self.value)
		end
		
	elseif ( GetTime() < self.holdTime ) then
		return
	elseif ( self.fadeOut ) then
		--update_Color(self, castColor["Stop"])
		local alpha = self:GetAlpha() - CASTING_BAR_ALPHA_STEP * 1;
		if ( alpha > 0 ) then
			self:SetAlpha(1*alpha);
		else
			self.fadeOut = nil;
			self:Hide();
			--U.Cast = false
		end
	end
end

local CastingBar_OnShow = function(f)
	CastingBar_OnLoad(f.Castbar, f.unit, true)
	CastingBar_OnEvent(f.Castbar, "PLAYER_ENTERING_WORLD")
	if ( f.Castbar.casting ) then
		local _, _, _, _, startTime = UnitCastingInfo(f.Castbar.unit);
		if ( startTime ) then
			f.Castbar.value = (GetTime() - (startTime / 1000));
		end
	else
		local _, _, _, _, _, endTime = UnitChannelInfo(f.Castbar.unit);
		if ( endTime ) then
			f.Castbar.value = ((endTime / 1000) - GetTime());
		end
	end
end

---- ----------------------------------
-->> Style
---- ----------------------------------

L.create_Castbar = function(f, point_to, u)
	f.Castbar = CreateFrame("Frame", nil, f)
	f.Castbar: SetAlpha(1)
	f.Castbar: EnableMouse(false)
	f.Castbar.unit = f.unit
	f.Castbar.style = u
	
	if u == "player" then
		f.Castbar.Direction = 1
		f.Castbar: SetSize(128, 128)
		f.Castbar: SetPoint("CENTER", point_to, "CENTER", 0,0)
		L.create_Ring(f.Castbar, Ring[1], "CastbarPlayerBar", "slicer0", "slicer1", C.Color.White, 0.9)
		f.Castbar[1] = L.create_Texture(f.Castbar, "ARTWORK", "CastbarPlayerBar", 64,64, 1,0,1,0, C.Color.White,0.9, "TOPRIGHT",f.Castbar,"CENTER",0,0)
		f.Castbar[2] = L.create_Texture(f.Castbar, "ARTWORK", "CastbarPlayerBar", 64,64, 1,0,0,1, C.Color.White,0.9, "BOTTOMRIGHT",f.Castbar,"CENTER",0,0)
		f.Castbar[3] = L.create_Texture(f.Castbar, "ARTWORK", "CastbarPlayerBar", 64,64, 0,1,0,1, C.Color.White,0.9, "BOTTOMLEFT",f.Castbar,"CENTER",0,0)
		
		f.Castbar.Bg = L.create_Texture(f.Castbar, "BACKGROUND", "CastbarPlayerBarBg", 128,128, 0,1,0,1, C.Color.White2,0.4, "CENTER",f.Castbar,"CENTER",0,0)
		f.Castbar.B0 = L.create_Texture(f.Castbar, "BORDER", "FCSCasterBorder", 128,128, 0,1,0,1, C.Color.White,0.9, "CENTER",f.Castbar,"CENTER",0,0)
		f.Castbar.B1 = L.create_Texture(f.Castbar, "BORDER", "CastbarPlayerBorder", 256,256, 0,1,0,1, C.Color.White,0.9, "CENTER",f.Castbar,"CENTER",0,0)
	
	elseif u == "target" then
		f.Castbar: SetSize(TARGET_CENTER_WIDTH+32, 32)
		f.Castbar: SetPoint("TOP", point_to, "BOTTOM", 0,-20)
		
		f.Castbar[1] = L.create_Texture(f.Castbar, "BORDER", "CastbarTargetBar1", 16,32, 0,0.5,0,1, C.Color.White,0.9, "LEFT",f.Castbar,"LEFT",0,0)
		f.Castbar[2] = L.create_Texture(f.Castbar, "BORDER", "CastbarTargetBar2", TARGET_CENTER_WIDTH,32, 0,1,0,1, C.Color.White,0.9, "LEFT",f.Castbar[1],"RIGHT",0,0)
		f.Castbar[3] = L.create_Texture(f.Castbar, "BORDER", "CastbarTargetBar1", 16,32, 0.5,1,0,1, C.Color.White,0.9, "LEFT",f.Castbar[2],"RIGHT",0,0)
		
		f.Castbar[1].Bg = L.create_Texture(f.Castbar, "BACKGROUND", "CastbarTargetBar1", 16,32, 0,0.5,0,1, C.Color.White,0.5, "LEFT",f.Castbar,"LEFT",0,0)
		f.Castbar[2].Bg = L.create_Texture(f.Castbar, "BACKGROUND", "CastbarTargetBar2", TARGET_CENTER_WIDTH,32, 0,1,0,1, C.Color.White,0.5, "LEFT",f.Castbar[1].Bg,"RIGHT",0,0)
		f.Castbar[3].Bg = L.create_Texture(f.Castbar, "BACKGROUND", "CastbarTargetBar1", 16,32, 0.5,1,0,1, C.Color.White,0.5, "LEFT",f.Castbar[2].Bg,"RIGHT",0,0)
		
	elseif u == "focus" then
		f.Castbar: SetSize(FOCUS_CENTER_WIDTH+32, 32)
		f.Castbar: SetPoint("TOP", point_to, "BOTTOM", 0,-20)
		
		f.Castbar[1] = L.create_Texture(f.Castbar, "BORDER", "CastbarTargetBar1", 16,32, 0,0.5,0,1, C.Color.White,0.9, "LEFT",f.Castbar,"LEFT",0,0)
		f.Castbar[2] = L.create_Texture(f.Castbar, "BORDER", "CastbarTargetBar2", FOCUS_CENTER_WIDTH,32, 0,1,0,1, C.Color.White,0.9, "LEFT",f.Castbar[1],"RIGHT",0,0)
		f.Castbar[3] = L.create_Texture(f.Castbar, "BORDER", "CastbarTargetBar1", 16,32, 0.5,1,0,1, C.Color.White,0.9, "LEFT",f.Castbar[2],"RIGHT",0,0)
		
		f.Castbar[1].Bg = L.create_Texture(f.Castbar, "BACKGROUND", "CastbarTargetBar1", 16,32, 0,0.5,0,1, C.Color.White,0.5, "LEFT",f.Castbar,"LEFT",0,0)
		f.Castbar[2].Bg = L.create_Texture(f.Castbar, "BACKGROUND", "CastbarTargetBar2", FOCUS_CENTER_WIDTH,32, 0,1,0,1, C.Color.White,0.5, "LEFT",f.Castbar[1].Bg,"RIGHT",0,0)
		f.Castbar[3].Bg = L.create_Texture(f.Castbar, "BACKGROUND", "CastbarTargetBar1", 16,32, 0.5,1,0,1, C.Color.White,0.5, "LEFT",f.Castbar[2].Bg,"RIGHT",0,0)
	end
	
--> Shield
	--f.Castbar.Shield = f.Castbar:CreateTexture(nil, "BACKGROUND")
	--f.Castbar.Shield:SetTexture(F.Tex.." ")
	
--> Spell Icon
	f.Castbar.Icon = f.Castbar:CreateTexture(nil, "ARTWORK")
	f.Castbar.Icon: SetAlpha(1)
	
	--f.Castbar.Icon: SetTexCoord(0.1, 0.9, 0.1, 0.9)
	if u == "target" then
		f.Castbar.Icon: SetSize(24,24)
		f.Castbar.Icon: SetPoint("LEFT", f.Castbar, "LEFT", 4,0)
		
		f.Castbar.Icon.Gloss = L.create_Texture(f.Castbar, "OVERLAY", "CastbarTargetIcon", 26,26, 4/32,28/32,4/32,28/32, C.Color.Black,0.6, "CENTER", f.Castbar.Icon, "CENTER",0,0)
	elseif u == "focus" then
		f.Castbar.Icon: SetSize(24,24)
		f.Castbar.Icon: SetPoint("LEFT", f.Castbar, "LEFT", 4,0)
		
		f.Castbar.Icon.Gloss = L.create_Texture(f.Castbar, "OVERLAY", "CastbarTargetIcon", 26,26, 4/32,28/32,4/32,28/32, C.Color.Black,0.6, "CENTER", f.Castbar.Icon, "CENTER",0,0)
	end
	
--> Time
	f.Castbar.Time = CreateFrame("Frame", nil, f.Castbar)
	for i = 1,5,1 do
		f.Castbar.Time[i] = f.Castbar.Time:CreateTexture(nil, "ARTWORK")
		f.Castbar.Time[i]: SetAlpha(0.9)
		if u == "player" then
			f.Castbar.Time[i]: SetTexture(F.Media.."PlayerNum4")
			f.Castbar.Time[i]: SetVertexColor(unpack(C.Color.White))
			f.Castbar.Time[i]: SetSize(Num[0][1], Num[0][2])
			f.Castbar.Time[i]: SetTexCoord(Num[0][3],Num[0][4], Num[0][5],Num[0][6])
			if i == 1 then
				f.Castbar.Time[i]: SetPoint("BOTTOMRIGHT", f.Castbar, "LEFT", -6,-8)
				f.Castbar.Time[i]: SetSize(Num["s"][1], Num["s"][2])
				f.Castbar.Time[i]: SetTexCoord(Num["s"][3],Num["s"][4], Num["s"][5],Num["s"][6])
			else
				f.Castbar.Time[i]: SetPoint("BOTTOMRIGHT", f.Castbar.Time[i-1], "BOTTOMLEFT", 0,0)
				if i == 3 then
					f.Castbar.Time[i]: SetSize(Num["."][1], Num["."][2])
					f.Castbar.Time[i]: SetTexCoord(Num["."][3],Num["."][4], Num["."][5],Num["."][6])
				end
			end
		elseif u == "target" then
			f.Castbar.Time[i]: SetTexture(F.Media.."NumCenter20")
			f.Castbar.Time[i]: SetVertexColor(unpack(C.Color.Black))
			f.Castbar.Time[i]: SetSize(Num_Center_20[0][1], Num_Center_20[0][2])
			f.Castbar.Time[i]: SetTexCoord(Num_Center_20[0][3],Num_Center_20[0][4], Num_Center_20[0][5],Num_Center_20[0][6])
			if i == 1 then
				f.Castbar.Time[i]: SetPoint("RIGHT", f.Castbar, "RIGHT", -6,0)
				f.Castbar.Time[i]: SetSize(Num_Center_20["s"][1], Num_Center_20["s"][2])
				f.Castbar.Time[i]: SetTexCoord(Num_Center_20["s"][3],Num_Center_20["s"][4], Num_Center_20["s"][5],Num_Center_20["s"][6])
			else
				f.Castbar.Time[i]: SetPoint("BOTTOMRIGHT", f.Castbar.Time[i-1], "BOTTOMLEFT", 11,0)
				if i == 3 then
					f.Castbar.Time[i]: SetSize(Num_Center_20["."][1], Num_Center_20["."][2])
					f.Castbar.Time[i]: SetTexCoord(Num_Center_20["."][3],Num_Center_20["."][4], Num_Center_20["."][5],Num_Center_20["."][6])
				end
			end
		elseif u == "focus" then
			--[[
			f.Castbar.Time[i]: SetTexture(F.Media.."Num_Center_20")
			f.Castbar.Time[i]: SetVertexColor(unpack(C.Color.Black))
			f.Castbar.Time[i]: SetSize(Num_Center_20[0][1], Num_Center_20[0][2])
			f.Castbar.Time[i]: SetTexCoord(Num_Center_20[0][3],Num_Center_20[0][4], Num_Center_20[0][5],Num_Center_20[0][6])
			if i == 1 then
				f.Castbar.Time[i]: SetPoint("RIGHT", f.Castbar, "RIGHT", -6,0)
				f.Castbar.Time[i]: SetSize(Num_Center_20["s"][1], Num_Center_20["s"][2])
				f.Castbar.Time[i]: SetTexCoord(Num_Center_20["s"][3],Num_Center_20["s"][4], Num_Center_20["s"][5],Num_Center_20["s"][6])
			else
				f.Castbar.Time[i]: SetPoint("BOTTOMRIGHT", f.Castbar.Time[i-1], "BOTTOMLEFT", 11,0)
				if i == 3 then
					f.Castbar.Time[i]: SetSize(Num_Center_20["."][1], Num_Center_20["."][2])
					f.Castbar.Time[i]: SetTexCoord(Num_Center_20["."][3],Num_Center_20["."][4], Num_Center_20["."][5],Num_Center_20["."][6])
				end
			end
			--]]
		end
	end
	
--> Text
	if u == "target" then
		f.Castbar.Text = L.create_Fontstring(f.Castbar, C.Font.Name, 16, nil)--"OUTLINE MONOCHROME"  "THINOUTLINE MONOCHROME"
		f.Castbar.Text: SetShadowOffset(2,2)
		f.Castbar.Text: SetShadowColor(C.Color.White[1],C.Color.White[2],C.Color.White[3],0.2)
		f.Castbar.Text: SetPoint("CENTER", f.Castbar, "CENTER", 0,0)
		f.Castbar.Text: SetText(F.Hex(C.Color.Black).."Target 施法条")
	elseif u == "focus" then
		f.Castbar.Text = L.create_Fontstring(f.Castbar, C.Font.Name, 16, nil)--"OUTLINE MONOCHROME"  "THINOUTLINE MONOCHROME"
		f.Castbar.Text: SetShadowOffset(2,2)
		f.Castbar.Text: SetShadowColor(C.Color.White[1],C.Color.White[2],C.Color.White[3],0.2)
		f.Castbar.Text: SetPoint("CENTER", f.Castbar, "CENTER", 8,0)
		f.Castbar.Text: SetText(F.Hex(C.Color.Black).."Focus 施法条")
	end
--> SafeZone
	--f.Castbar.SafeZone
	
--> On Load
	CastingBar_OnLoad(f.Castbar, f.unit, true)
	f.Castbar:SetScript("OnLoad", function(self)
		CastingBar_OnLoad(f.Castbar, f.unit, true)
	end)
	
--> On Event
	f.Castbar:SetScript("OnEvent", function(self, event, ...)
		CastingBar_OnEvent(self, event, ...)
	end)
	

--> On Update
	local angle_player = 296
	local angle_target = 60
	f.Castbar:SetScript("OnUpdate", function(self, elapsed)
		CastingBar_OnUpdate(self, elapsed)
		if (self:IsVisible()) and (self.maxValue) then
			if u == "player" then
				if self.Per*angle_player < 90 then
					self.Interval = 3
					F.Ring_Update(f.Castbar, (angle_player*self.Per + F.Debug))
					if f.Castbar[1] then f.Castbar[1]: Hide() end
					if f.Castbar[2] then f.Castbar[2]: Hide() end
					if f.Castbar[3] then f.Castbar[3]: Hide() end
				elseif self.Per*angle_player >= 90 and self.Per*angle_player < 180 then
					self.Interval = 2
					F.Ring_Update(f.Castbar, (angle_player*self.Per - 90 + F.Debug))
					if f.Castbar[1] then f.Castbar[1]: Show() end
					if f.Castbar[2] then f.Castbar[2]: Hide() end
					if f.Castbar[3] then f.Castbar[3]: Hide() end
				elseif self.Per*angle_player >= 180 and self.Per*angle_player < 270 then
					self.Interval = 1
					F.Ring_Update(f.Castbar, (angle_player*self.Per - 180 + F.Debug))
					if f.Castbar[1] then f.Castbar[1]: Show() end
					if f.Castbar[2] then f.Castbar[2]: Show() end
					if f.Castbar[3] then f.Castbar[3]: Hide() end
				elseif self.Per*angle_player >= 270 then
					self.Interval = 4
					F.Ring_Update(f.Castbar, (angle_player*self.Per - 270 + F.Debug))
					if f.Castbar[1] then f.Castbar[1]: Show() end
					if f.Castbar[2] then f.Castbar[2]: Show() end
					if f.Castbar[3] then f.Castbar[3]: Show() end
				end
			elseif u == "target" then
				local d,d1,d2,d3 =0, 16/(32+TARGET_CENTER_WIDTH), TARGET_CENTER_WIDTH/(32+TARGET_CENTER_WIDTH), 16/(32+TARGET_CENTER_WIDTH)
				if self.Per > (d1+d2) then
					d = (self.Per - d1 - d2)/d3
					f.Castbar[1]: SetSize(16,32)
					f.Castbar[1]: SetTexCoord(0,0.5,0,1)
					f.Castbar[2]: SetSize(TARGET_CENTER_WIDTH,32)
					f.Castbar[3]: SetSize(16*d,32)
					f.Castbar[3]: SetTexCoord(0.5,0.5*d+0.5+F.Debug,0,1)
				elseif self.Per > d1 then
					d = (self.Per - d1)/d2
					f.Castbar[1]: SetSize(16,32)
					f.Castbar[1]: SetTexCoord(0,0.5,0,1)
					f.Castbar[2]: SetSize(TARGET_CENTER_WIDTH*d,32)
					f.Castbar[3]: SetSize(F.Debug,32)
					f.Castbar[3]: SetTexCoord(0.5,0.5+F.Debug,0,1)
				else
					d = self.Per/d1
					f.Castbar[1]: SetSize(16*d,32)
					f.Castbar[1]: SetTexCoord(0,0.5*d,0,1)
					f.Castbar[2]: SetSize(F.Debug,32)
					f.Castbar[3]: SetSize(F.Debug,32)
					f.Castbar[3]: SetTexCoord(0.5,0.5+F.Debug,0,1)
				end		
			elseif u == "focus" then
				local d,d1,d2,d3 =0, 16/(32+FOCUS_CENTER_WIDTH), FOCUS_CENTER_WIDTH/(32+FOCUS_CENTER_WIDTH), 16/(32+FOCUS_CENTER_WIDTH)
				if self.Per > (d1+d2) then
					d = (self.Per - d1 - d2)/d3
					f.Castbar[1]: SetSize(16,32)
					f.Castbar[1]: SetTexCoord(0,0.5,0,1)
					f.Castbar[2]: SetSize(FOCUS_CENTER_WIDTH,32)
					f.Castbar[3]: SetSize(16*d,32)
					f.Castbar[3]: SetTexCoord(0.5,0.5*d+0.5+F.Debug,0,1)
				elseif self.Per > d1 then
					d = (self.Per - d1)/d2
					f.Castbar[1]: SetSize(16,32)
					f.Castbar[1]: SetTexCoord(0,0.5,0,1)
					f.Castbar[2]: SetSize(FOCUS_CENTER_WIDTH*d,32)
					f.Castbar[3]: SetSize(F.Debug,32)
					f.Castbar[3]: SetTexCoord(0.5,0.5+F.Debug,0,1)
				else
					d = self.Per/d1
					f.Castbar[1]: SetSize(16*d,32)
					f.Castbar[1]: SetTexCoord(0,0.5*d,0,1)
					f.Castbar[2]: SetSize(F.Debug,32)
					f.Castbar[3]: SetSize(F.Debug,32)
					f.Castbar[3]: SetTexCoord(0.5,0.5+F.Debug,0,1)
				end		
			end
		end
	end)
	f.Castbar:SetScript("OnShow", function(self)
		CastingBar_OnShow(f)
	end)
end

local CastingBar_UpdateIsShown = function(f)
	--CastingBar_OnLoad(f.Castbar, f.unit, true)
	CastingBar_OnEvent(f.Castbar, "PLAYER_ENTERING_WORLD")
	if (( f.Castbar.casting or f.Castbar.channeling ) and f.Castbar.showCastbar ) then
		--U.Cast = true
		f.Castbar:Show();
	else
		f.Castbar:Hide();
		--U.Cast = false
	end
end

L.OnShow_Castbar = function(f, event)
	if event == "PLAYER_ENTERING_WORLD" then
		CastingBar_UpdateIsShown(f.Target)
		CastingBar_UpdateIsShown(f.Focus)
	elseif event == "PLAYER_TARGET_CHANGED" then
		CastingBar_UpdateIsShown(f.Target)
	elseif event == "PLAYER_FOCUS_CHANGED" then
		CastingBar_UpdateIsShown(f.Focus)
	end
end

local HideCastbar = CreateFrame("Frame")
HideCastbar:RegisterEvent('PLAYER_TALENT_UPDATE')
HideCastbar:RegisterEvent('PLAYER_ENTERING_WORLD')
HideCastbar:RegisterEvent('ADDON_LOADED')
HideCastbar:SetScript('OnEvent', function(self, event, arg1, ...)
	if event == 'PLAYER_ENTERING_WORLD' or event=='PLAYER_TALENT_UPDATE' then
		CastingBarFrame.showCastbar = false 
		CastingBarFrame:UnregisterAllEvents()
		CastingBarFrame:SetScript("OnUpdate", function() end)
	end
end)