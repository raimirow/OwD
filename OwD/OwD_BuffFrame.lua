local C, F, L = unpack(select(2, ...))

--< APIs >------------------------------------------------------

local min = math.min
local max = math.max
local format = string.format
local floor = math.floor
local sqrt = math.sqrt
local sin = math.sin
local asin = math.asin
local cos = math.cos
local acos = math.acos
local atan = math.atan
local rad = math.rad
local modf = math.modf
local GetTime = GetTime

----------------------------------------------------------------



--<  >----------------------------------------------------------

local Ring_Artwork = function(f, size)
	f.C = CreateFrame("Frame", nil, f)
	f.C: SetSize(size, size)
	f: SetScrollChild(f.C)
	
	f.Ring = f.C:CreateTexture(nil, "BACKGROUND", nil, -2)
	f.Ring: SetTexture(F.Media.."Ring_64_4")
	f.Ring: SetSize(sqrt(2)*size, sqrt(2)*size)
    f.Ring: SetPoint("CENTER")
    f.Ring: SetVertexColor(unpack(L.Color.Buff))
	f.Ring: SetAlpha(0.9)
	f.Ring: SetBlendMode("BLEND")
	f.Ring: SetRotation(math.rad(f.Base+180))
end

local Create_Ring = function(f, size)
	if f.LR then return end
	f: SetFrameLevel(4)
	f.LR = CreateFrame("ScrollFrame", nil, f)
	f.LR: SetFrameLevel(2)
	f.LR: SetSize((size+8)/2, size+8)
	f.LR: SetPoint("LEFT", f, "LEFT", -4,0)
	f.LR.Base = -180
	Ring_Artwork(f.LR, size+8)
	
	f.RR = CreateFrame("ScrollFrame", nil, f)
	f.RR: SetFrameLevel(2)
	f.RR: SetSize((size+8)/2, size+8)
	f.RR: SetPoint("RIGHT", f, "RIGHT", 4,0)
	f.RR: SetHorizontalScroll((size+8)/2)
	f.RR.Base = 0
	Ring_Artwork(f.RR, size+8)
	
	local Bg1 = f:CreateTexture(nil, "BACKGROUND", nil, -1)
	Bg1: SetTexture(F.Media.."Ring_Bg")
	Bg1: SetSize(size, size)
	Bg1: SetPoint("CENTER", f ,"CENTER", 0,0)
	Bg1: SetVertexColor(unpack(L.Color.Back))
	
	local Bg2 = f.LR:CreateTexture(nil, "BACKGROUND", nil, -3)
	Bg2: SetTexture(F.Media.."Ring_Bg")
	Bg2: SetSize(size+8, size+8)
	Bg2: SetPoint("CENTER", f ,"CENTER", 0,0)
	Bg2: SetVertexColor(unpack(L.Color.Back))
	Bg2: SetBlendMode("BLEND")
end

local hook_Ring = function()
	local hook_AuraButton_Update = function(buttonName, index, filter)
		local unit = PlayerFrame.unit;
		local name, rank, texture, count, debuffType, d, expirationTime, _, _, _, spellId, _, _, _, _, timeMod = UnitAura(unit, index, filter);
		local buffName = buttonName..index;
		local buff = _G[buffName];
		
		if buff then
			if not buff.LR then
				Create_Ring(buff, OwD_DB.BuffFrame.Size)
			end
			buff.LR.Ring: SetVertexColor(unpack(L.Color.Buff))
			buff.RR.Ring: SetVertexColor(unpack(L.Color.Buff))
			buff.LR.Ring:SetRotation(math.rad(buff.LR.Base+180))
			buff.RR.Ring:SetRotation(math.rad(buff.RR.Base+180))
			
			if name then
				buff.d = d
				local helpful = (filter == "HELPFUL")
				if ( not helpful ) then
					local color;
					if ( debuffType ) then
						color = DebuffTypeColor[debuffType]
					else
						color = DebuffTypeColor["none"]
					end
					buff.LR.Ring: SetVertexColor(color.r, color.g, color.b)
					buff.RR.Ring: SetVertexColor(color.r, color.g, color.b)
					_G[buffName.."Border"]: SetAlpha(0)
				end
			end
		end
	end
	
	local hook_AuraButton_UpdateDuration = function(self, timeLeft)
		self.percent = 1
		if (self.d and self.d > 0 and self.expirationTime) then
			--percent = (self.expirationTime - GetTime())/self.d
			self.percent = (timeLeft)/self.d
		else
			self.percent = 1
		end
		if self.LR then
			if self.percent < 0.5 then
				self.LR.Ring:SetRotation(math.rad(self.LR.Base+180*(self.percent*2)))
				self.RR.Ring:SetRotation(math.rad(self.RR.Base+0))
			else
				self.LR.Ring:SetRotation(math.rad(self.LR.Base+180))
				self.RR.Ring:SetRotation(math.rad(self.RR.Base+180*(self.percent*2-1)))
			end
		end
	end
	
	local hook_TemporaryEnchantFrame_Update = function(...)
		local RETURNS_PER_ITEM = 4;
		local numVals = select("#", ...);
		local numItems = numVals / RETURNS_PER_ITEM;
		local enchantIndex = 0;
		for itemIndex = numItems, 1, -1 do	--Loop through the items from the back.
			local hasEnchant, enchantExpiration, enchantCharges = select(RETURNS_PER_ITEM * (itemIndex - 1) + 1, ...);
			if ( hasEnchant ) then
				enchantIndex = enchantIndex + 1;
				local enchantButton = _G["TempEnchant"..enchantIndex];
				if not enchantButton.LR then
					Create_Ring(enchantButton, OwD_DB.BuffFrame.Size)
				end
				
				enchantButton.percent = 1
				if ( enchantExpiration ) then
					enchantButton.percent = max(min(enchantExpiration/6e5, 1), 0)
				end
				if enchantButton.LR then
					if enchantButton.percent < 0.5 then
						enchantButton.LR.Ring:SetRotation(math.rad(enchantButton.LR.Base+180*(enchantButton.percent*2)))
						enchantButton.RR.Ring:SetRotation(math.rad(enchantButton.RR.Base+0))
					else
						enchantButton.LR.Ring:SetRotation(math.rad(enchantButton.LR.Base+180))
						enchantButton.RR.Ring:SetRotation(math.rad(enchantButton.RR.Base+180*(enchantButton.percent*2-1)))
					end
					enchantButton.LR.Ring: SetVertexColor(L.Color.DebuffType.Enchant.r, L.Color.DebuffType.Enchant.g, L.Color.DebuffType.Enchant.b)
					enchantButton.RR.Ring: SetVertexColor(L.Color.DebuffType.Enchant.r, L.Color.DebuffType.Enchant.g, L.Color.DebuffType.Enchant.b)
				end
			end
		end
	end
	
	hooksecurefunc("AuraButton_Update",  hook_AuraButton_Update)
	hooksecurefunc("AuraButton_UpdateDuration",  hook_AuraButton_UpdateDuration)
	hooksecurefunc("TemporaryEnchantFrame_Update",  hook_TemporaryEnchantFrame_Update)
end

local Style_Button = function(f, i)
	f["Button"..i]: SetSize(f.size, f.size)
	f["Button"..i]:ClearAllPoints()
	if i == 1 then
		f["Button"..i]: SetPoint("TOPRIGHT", f, "TOPRIGHT", 0,0)
	else
		f["Button"..i]: SetPoint("TOPRIGHT", f["Button"..(i-1)], "TOPLEFT", -f.gap,0)
	end
	
	--_G[f.name..i.."Icon"]: SetMask("Interface\\Minimap\\UI-Minimap-Background")
	if _G[f.name..i.."Border"] then
		_G[f.name..i.."Border"]: SetAlpha(0)
	end
	_G[f.name..i.."Duration"]: SetFont(L.Font.Num, 12, "THINOUTLINE")
	_G[f.name..i.."Duration"]: ClearAllPoints()
	_G[f.name..i.."Duration"]: SetPoint("TOP", f["Button"..i], "BOTTOM", 0,-6)
end

local Create_Button = function(f)
	for i = 1, f.num do
		local button = _G[f.name..i]
		if not button then
			if (helpful) then
				button = CreateFrame("Button", f.name..i, BuffFrame, "BuffButtonTemplate")
			else
				button = CreateFrame("Button", f.name..i, BuffFrame, "DebuffButtonTemplate")
			end
		end
		local icon = _G[f.name..i.."Icon"]
		icon: SetMask("Interface\\Minimap\\UI-Minimap-Background")
		f["Button"..i] = button
		Style_Button(f, i)
	end
end

local Create_Buff = function(f)
	f.Enchant = CreateFrame("Frame", "OwD_TempEnchant", f)
	f.Enchant.name = "TempEnchant"
	f.Enchant.num = NUM_TEMP_ENCHANT_FRAMES
	f.Enchant.size = OwD_DB.BuffFrame.Size
	f.Enchant.gap = 12
	
	f.Enchant: SetSize(OwD_DB.BuffFrame.Size, OwD_DB.BuffFrame.Size)
	f.Enchant: SetPoint("TOPRIGHT", f, "TOPRIGHT", 0,0)

	f.Buff = CreateFrame("Frame", "OwD_BuffFrame", f)
	f.Buff.name = "BuffButton"
	f.Buff.num = BUFF_MAX_DISPLAY
	f.Buff.size = OwD_DB.BuffFrame.Size
	f.Buff.gap = 12
	
	f.Buff: SetSize(OwD_DB.BuffFrame.Size, OwD_DB.BuffFrame.Size)
	f.Buff: SetPoint("TOPRIGHT", f.Enchant, "TOPLEFT", 0,0)
	
	local UpdateAllBuffAnchors = function()
		Create_Button(f.Enchant)
		Create_Button(f.Buff)
		f.Enchant: SetWidth((OwD_DB.BuffFrame.Size+f.Enchant.gap)*BuffFrame.numEnchants+F.Debug)
	end
	hooksecurefunc("BuffFrame_UpdateAllBuffAnchors", UpdateAllBuffAnchors)
end

local Create_Debuff = function(f)
	f.Debuff = CreateFrame("Frame", "OwD_BuffFrame", f)
	f.Debuff.name = "DebuffButton"
	f.Debuff.num = DEBUFF_MAX_DISPLAY
	f.Debuff.size = OwD_DB.BuffFrame.Size
	f.Debuff.gap = 12
	
	f.Debuff: SetSize(OwD_DB.BuffFrame.Size+4, OwD_DB.BuffFrame.Size+4)
	f.Debuff: SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -70)
	
	local UpdateAllDebuffAnchors = function()
		Create_Button(f.Debuff)
	end
	hooksecurefunc("DebuffButton_UpdateAnchors", UpdateAllDebuffAnchors)
end

L.AuraFrame = function(f)
	f.AuraFrame = CreateFrame("Frame", nil, UIParent)
	f.AuraFrame: SetSize(OwD_DB.BuffFrame.Size+4, OwD_DB.BuffFrame.Size+4)
	f.AuraFrame: SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", OwD_DB.Pos.BuffFrame.x, OwD_DB.Pos.BuffFrame.y)
	if OwD_DB.BuffFrame.ON == true then
		Create_Buff(f.AuraFrame)
		Create_Debuff(f.AuraFrame)
		hook_Ring()
	end
end

----------------------------------------------------------------


