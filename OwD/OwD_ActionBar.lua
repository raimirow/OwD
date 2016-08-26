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



--< Number >----------------------------------------------------

local Num_Right16 = {
	[0] =	{12,14,   0/256, 12/256, 1/16,15/16},
	[1] =	{12,14,  12/256, 24/256, 1/16,15/16},
	[2] =	{12,14,  24/256, 36/256, 1/16,15/16},
	[3] =	{12,14,  36/256, 48/256, 1/16,15/16},
	[4] =	{12,14,  48/256, 60/256, 1/16,15/16},
	[5] =	{12,14,  60/256, 72/256, 1/16,15/16},
	[6] =	{12,14,  72/256, 84/256, 1/16,15/16},
	[7] =	{12,14,  84/256, 96/256, 1/16,15/16},
	[8] =	{12,14,  96/256,108/256, 1/16,15/16},
	[9] =	{12,14, 108/256,120/256, 1/16,15/16},
	[":"] =	{ 6,14, 120/256,126/256, 1/16,15/16},
	["K"] =	{ 8,14, 132/256,140/256, 1/16,15/16},
	["M"] =	{10,14, 144/256,154/256, 1/16,15/16},
	["G"] =	{ 8,14, 156/256,164/256, 1/16,15/16},
	["%"] =	{ 9,14, 168/256,177/256, 1/16,15/16},
	["B"] =	{ 1,14, 255/256,256/256, 1/16,15/16},
}

----------------------------------------------------------------



----------------------------------------------------------------
--> Thanks for rActionBar, rButtonTemplate and Dominos.
----------------------------------------------------------------



--< Hide Bizzard >----------------------------------------------

local color_Ring = function(f, color)
	f.LR.Ring: SetVertexColor(unpack(color))
	f.RR.Ring: SetVertexColor(unpack(color))
end

local update_Ring = function(f, d)
	if f.LR then
		if not d then d = 1 end
		d = min(max(d, 0), 1)
		if d < 0.5 then
			f.LR.Ring:SetRotation(math.rad(f.LR.Base+0))
			f.RR.Ring:SetRotation(math.rad(f.RR.Base-180*d*2))
		else
			f.LR.Ring:SetRotation(math.rad(f.LR.Base-180*(d*2-1)))
			f.RR.Ring:SetRotation(math.rad(f.RR.Base+180))
		end
	end
end

local format_Num = function(num)
	if num > 86400 then
		return floor(num/86400+0.5).."d"
	elseif num > 3600 then
		return floor(num/3600+0.5).."h"
	elseif num > 60 then
		return floor(num/60+0.5).."m"
	else
		return floor(num+0.5)
	end
end

local hiddenFrame = CreateFrame("Frame")
hiddenFrame:Hide()

local scripts = {
	"OnShow", "OnHide", "OnEvent", "OnEnter", "OnLeave", "OnUpdate", "OnValueChanged", "OnClick", "OnMouseDown", "OnMouseUp",
}

local framesToHide = {
	MainMenuBar,
	OverrideActionBar,
	PossessBarFrame,
}

local framesToDisable = {
	MainMenuBar,
	ActionBarDownButton, ActionBarUpButton, MainMenuBarVehicleLeaveButton, ExhaustionTick,
	ReputationWatchBar, ArtifactWatchBar, HonorWatchBar, MainMenuExpBar, MainMenuBarMaxLevelBar,
	OverrideActionBar,
	OverrideActionBarExpBar, OverrideActionBarHealthBar, OverrideActionBarPowerBar, OverrideActionBarPitchFrame,
	PossessBarFrame,
}

local function DisableAllScripts(frame)
	for i, script in next, scripts do
		if frame:HasScript(script) then
			frame:SetScript(script,nil)
		end
	end
end

L.HideMainMenuBar = function()
	for i, frame in next, framesToHide do
		frame:SetParent(hiddenFrame)
	end
	for i, frame in next, framesToDisable do
		frame:UnregisterAllEvents()
		DisableAllScripts(frame)
	end
	
	hook_ActionButton_ShowGrid = function(button)
		if ( button.NormalTexture ) then
			button.NormalTexture:SetVertexColor(1.0, 1.0, 1.0, 1.0);
		end
	end
	hooksecurefunc("ActionButton_ShowGrid", hook_ActionButton_ShowGrid)
	
	hook_ActionButton_UpdateCooldown = function(self)
		if self.LR then
			local locStart, locDuration;
			local start, duration, enable, charges, maxCharges, chargeStart, chargeDuration;
			if ( self.spellID ) then
				locStart, locDuration = GetSpellLossOfControlCooldown(self.spellID);
				start, duration, enable = GetSpellCooldown(self.spellID);
				charges, maxCharges, chargeStart, chargeDuration = GetSpellCharges(self.spellID);
			else
				locStart, locDuration = GetActionLossOfControlCooldown(self.action);
				start, duration, enable = GetActionCooldown(self.action);
				charges, maxCharges, chargeStart, chargeDuration = GetActionCharges(self.action);
			end
			if ( (locStart + locDuration) > (start + duration) ) then
				self.s = GetTime() - locStart
				self.d = locDuration
				self.e = true
			else
				self.s = GetTime() - start
				self.d = duration
				self.e = enable
			end
			if self.d > 1.5 then
				color_Ring(self, C.Color.Red0)
				--self.CD: SetText(floor(self.d - self.s))
			else
				color_Ring(self, C.Color.White)
				--self.CD: SetText("")
			end
		end
	end
	hooksecurefunc("ActionButton_UpdateCooldown", hook_ActionButton_UpdateCooldown)
	
	local hook_StanceBar_UpdateState = function()
		local numForms = GetNumShapeshiftForms();
		local texture, name, isActive, isCastable;
		local button, icon, cooldown;
		local start, duration, enable;
		for i=1, NUM_STANCE_SLOTS do
			button = StanceBarFrame.StanceButtons[i];
			if ( i <= numForms ) then
				start, duration, enable = GetShapeshiftFormCooldown(i);
				--[[
				if ( isCastable ) then
					icon:SetVertexColor(1.0, 1.0, 1.0);
				else
					icon:SetVertexColor(0.4, 0.4, 0.4);
				end
				--]]
				button.s = GetTime() - start
				button.d = duration
				button.e = enable
				
				if button.d > 0 then
					color_Ring(button, C.Color.Red0)
					--button.CD: SetText(floor(button.d - button.s))
				else
					color_Ring(button, C.Color.White)
					--button.CD: SetText("")
				end
			end
		end
	end
	hooksecurefunc("StanceBar_UpdateState", hook_StanceBar_UpdateState)
end

----------------------------------------------------------------



--< Action Buttons >--------------------------------------------

local Ring_Artwork = function(f, size)
	f.C = CreateFrame("Frame", nil, f)
	f.C: SetSize(size, size)
	f: SetScrollChild(f.C)
	
	f.Ring = f.C:CreateTexture(nil, "BACKGROUND", nil, -2)
	f.Ring: SetTexture(F.Media.."Ring_64_4")
	f.Ring: SetSize(sqrt(2)*size, sqrt(2)*size)
    f.Ring: SetPoint("CENTER")
    f.Ring: SetVertexColor(unpack(L.Color.Buff))
	f.Ring: SetAlpha(0.8)
	f.Ring: SetBlendMode("BLEND")
	f.Ring: SetRotation(math.rad(f.Base+180))
end

local Create_Ring = function(f, size)
	if f.LR then return end
	
	f.s = 0
	f.d = 0
	f.e = true
	
	local name = f:GetName("Interface\\Minimap\\UI-Minimap-Background")
	_G[name.."Icon"]: SetTexture()
	_G[name.."Icon"]: SetMask(nil)
	_G[name.."Icon"]: SetTexCoord(0,1,0,1)
	_G[name.."Icon"]: SetMask("Interface\\Minimap\\UI-Minimap-Background")
	
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

local Tex = {
	["Normal"] = F.Media.."Button_Normal",
	["Border"] = F.Media.."Button_Border",
	["Checked"] = F.Media.."Button_Checked",
	["Pushed"] = F.Media.."Button_Pushed",
	["HighLight"] = F.Media.."Button_HighLight",
}

local ButtonSetPoint = function(f)
	f: ClearAllPoints()
	f: SetPoint("TOPLEFT", 0,0)
	f: SetPoint("BOTTOMRIGHT", 0,0)
end

local ButtonSetFont = function(f, font, size, outline)
	f: SetFont(font, size, outline)
	f: SetShadowColor(0,0,0,0)
	f: SetShadowOffset(1,-1)
end

local ResetTexture = function(f, file)
	if not f.tex then return end
	if file == f.tex then return end
	f: SetTexture(f.tex)
end

local ResetNormalTexture = function(f, file)
	if not f.ntex then return end
	if file == f.ntex then return end
	f: SetNormalTexture(f.ntex)
end

local backdrop = {
	bgFile = F.Media.."Bar",
	edgeFile = "",
	tile = true, tileSize = 16, edgeSize = 0,
	insets = {left = 0, right = 0, top = 0, bottom = 0}
}

local ButtonTemplate = function(f)
	local name = f:GetName()
	
	_G[name.."Icon"]: SetTexCoord(0.08,0.92, 0.08,0.92)
	if _G[name.."FloatingBG"] then
		_G[name.."FloatingBG"]: Hide()
	end
	
	if _G[name.."Shine"] then
		_G[name.."Shine"]: ClearAllPoints()
		_G[name.."Shine"]: SetPoint("TOPLEFT", -1,1)
		_G[name.."Shine"]: SetPoint("BOTTOMRIGHT", 1,-1)
	end
	
	if _G[name.."AutoCastable"] then
		_G[name.."AutoCastable"]: ClearAllPoints()
		_G[name.."AutoCastable"]: SetPoint("TOPLEFT", -2,2)
		_G[name.."AutoCastable"]: SetPoint("BOTTOMRIGHT", 2,-2)
	end
	
	if _G[name.."Cooldown"] then
		_G[name.."Cooldown"]: SetAlpha(0)
		f.CD = L.create_Fontstring(f, C.Font.Num, 16, "THINOUTLINE")
		f.CD: SetPoint("CENTER", 0,0)
		f.CD: SetShadowOffset(0,0)
		f.CD: SetText("")
	end
	
	ButtonSetFont(_G[name.."HotKey"], L.Font.Num, 14, "THINOUTLINE")
	_G[name.."HotKey"]: ClearAllPoints()
	_G[name.."HotKey"]: SetPoint("BOTTOM", 0, 0)
	_G[name.."HotKey"]: SetTextColor(1,1,1,1)
	_G[name.."HotKey"]: SetVertexColor(1,1,1,1)
	_G[name.."HotKey"]: SetAlpha(1)
	_G[name.."HotKey"]: SetJustifyH("CENTER")
	
	ButtonSetFont(_G[name.."Count"], L.Font.Num, 14, "THINOUTLINE")
	_G[name.."Count"]: ClearAllPoints()
	_G[name.."Count"]: SetPoint("TOPRIGHT", 0, 0)
	_G[name.."Count"]: SetTextColor(1,1,1,1)
	_G[name.."Count"]: SetAlpha(1)
	_G[name.."Count"]: SetJustifyH("RIGHT")
	_G[name.."Count"]: SetJustifyV("TOP")
	
	ButtonSetFont(_G[name.."Name"], L.Font.Txt, 14, "THINOUTLINE")
	_G[name.."Name"]: ClearAllPoints()
	_G[name.."Name"]: SetPoint("CENTER", 0, 0)
	_G[name.."Name"]: SetTextColor(1,1,1,1)
	_G[name.."Name"]: SetAlpha(1)
	_G[name.."Name"]: SetJustifyH("CENTER")
	
	_G[name.."Border"]: ClearAllPoints()
	_G[name.."Border"]: SetPoint("TOPLEFT", 0,0)
	_G[name.."Border"]: SetPoint("BOTTOMRIGHT", 0,0)
	_G[name.."Border"].tex = Tex.Border
	_G[name.."Border"]: SetTexture(Tex.Border)
	_G[name.."Border"]: SetAlpha(1)
	hooksecurefunc(_G[name.."Border"], "SetTexture", ResetTexture)
	
	
	f.ntex = Tex.Normal
	local NormalTexture = f:GetNormalTexture()
	ButtonSetPoint(NormalTexture)
	hooksecurefunc(_G[name], "SetNormalTexture", ResetNormalTexture)
	
	f: SetNormalTexture(Tex.Normal)
	f: SetPushedTexture(Tex.Pushed)
	f: SetCheckedTexture(Tex.Checked)
	f: SetHighlightTexture(Tex.HighLight)
end

----------------------------------------------------------------



--< Action Bars >-----------------------------------------------

local is_Over = function(f)
	if MouseIsOver(f) then
		f: SetAlpha(1)
	else
		f: SetAlpha(0.1)
	end
end

local Mouse_Over = function(f, p, hook)
	if hook then
		f:HookScript("OnEnter", function(self)
			is_Over(p)
		end)
		f:HookScript("OnLeave", function(self)
			is_Over(p)
		end)
	else
		f: SetAlpha(0.1)
		f: EnableMouse(true)

		f: SetScript("OnEnter", function(self)
			is_Over(p)
		end)
	
		f: SetScript("OnLeave", function(self)
			is_Over(p)
		end)
	end
end

local Create_Bar1 = function(f, name)
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local button = _G[name..i]
		if not button then
			break
		end
		f["Button"..i] = button
		f: SetFrameRef(name..i, f["Button"..i])
	end
	
	-- creates new table in secure environment and fills it with action button frames retrieving them by frame reference
	f: Execute([[
		buttons = table.new()
		for i = 1, 12 do
			table.insert(buttons, self:GetFrameRef("ActionButton"..i))
		end  
	]])
	
	-- State driver updates "page" attribute based on macro conditionals.  "_onstate-page" is called and newstate contains new actionbar page number.
	f: SetAttribute("_onstate-page", [[ 
		
		for i, button in ipairs (buttons) do
			button:SetAttribute("actionpage", tonumber(newstate))
		end 
	]])
	
	--print("_onstate-page","index",newstate)
end

local Create_Bar = function(f)
	for i = 1, f.num do
		local button = _G[f.name..i]
		if not button then
			break
		end
		f["Button"..i] = button
	end
	
	if f.blizzardBar then
		f.blizzardBar:SetParent(f)
		f.blizzardBar:EnableMouse(false)
	else
		f["Button"..i]:SetParent(f)
	end
	
	if f.visibility then
		RegisterStateDriver(f, "visibility", f.visibility)
	end
end

local Bar1_Frame = function(f)
	f.Bar1 = CreateFrame("Frame", "Quafe_ActionBar1", UIParent, "SecureHandlerStateTemplate")
	f.Bar1.name = "ActionButton"
	f.Bar1.num = NUM_ACTIONBAR_BUTTONS
	f.Bar1: SetSize(720, 38)
	f.Bar1: SetPoint("CENTER", f, "CENTER", 0, 0)
	
	Create_Bar1(f.Bar1, "ActionButton")
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		if f.Bar1["Button"..i] then
			f.Bar1["Button"..i]: SetParent(f.Bar1)
			if i < 7 then
				f.Bar1["Button"..i]: SetSize(38,38)
			else
				f.Bar1["Button"..i]: SetSize(38,38)
			end
			f.Bar1["Button"..i]: ClearAllPoints()
			
			if i <= NUM_ACTIONBAR_BUTTONS/2 then
				f.Bar1["Button"..i]: SetPoint("BOTTOMLEFT", f.Bar1, "BOTTOMLEFT", (38+14)*(i-1),3*(i-1))
			else
				f.Bar1["Button"..i]: SetPoint("BOTTOMRIGHT", f.Bar1, "BOTTOMRIGHT", -(38+14)*(NUM_ACTIONBAR_BUTTONS-i), 3*(NUM_ACTIONBAR_BUTTONS-i))
			end
			
			ButtonTemplate(f.Bar1["Button"..i])
			Create_Ring(f.Bar1["Button"..i], 38)
		end
	end
	
	RegisterStateDriver(f.Bar1, "page", "[overridebar]14;[mod:ctrl]6;[mod:shift]5;[shapeshift]13;[vehicleui]12;[possessbar]12;[bonusbar:5]11;[bonusbar:4]10;[bonusbar:3]9;[bonusbar:2]8;[bonusbar:1]7;[bar:5]5;[bar:4]4;[bar:3]3;[bar:2]2; 1")
	RegisterStateDriver(f.Bar1, "visibility", "[petbattle]hide; show")
end

local Bar4_Frame = function(f)
	f.Bar4 = CreateFrame("Frame", "Quafe_ActionBar4", UIParent, "SecureHandlerStateTemplate")
	f.Bar4.name = "MultiBarRightButton"
	f.Bar4.num = NUM_ACTIONBAR_BUTTONS
	f.Bar4.visibility = "[petbattle][overridebar][vehicleui][possessbar][shapeshift]hide; show"
	f.Bar4.blizzardBar = MultiBarRight
	f.Bar4: SetSize(42, 32*f.Bar4.num+10*(f.Bar4.num+1))
	f.Bar4: SetPoint("RIGHT", UIParent, "RIGHT", -6,0)
	
	Create_Bar(f.Bar4)
	for i = 1, f.Bar4.num do
		if f.Bar4["Button"..i] then
			f.Bar4["Button"..i]: SetSize(32,32)
			f.Bar4["Button"..i]: ClearAllPoints()
			if i == 1 then
				f.Bar4["Button"..i]: SetPoint("TOP", f.Bar4, "TOP", 0,-5)
			else
				f.Bar4["Button"..i]: SetPoint("TOP", f.Bar4["Button"..(i-1)], "BOTTOM", 0,-10)
			end
			
			ButtonTemplate(f.Bar4["Button"..i])
			Create_Ring(f.Bar4["Button"..i], 32)
			Mouse_Over(f.Bar4["Button"..i], f.Bar4, true)
		end
	end
	
	Mouse_Over(f.Bar4, f.Bar4, false)
end

local Bar5_Frame = function(f)
	f.Bar5 = CreateFrame("Frame", "Quafe_ActionBar5", UIParent, "SecureHandlerStateTemplate")
	f.Bar5.name = "MultiBarLeftButton"
	f.Bar5.num = NUM_ACTIONBAR_BUTTONS
	f.Bar5.visibility = "[petbattle][overridebar][vehicleui][possessbar][shapeshift]hide; show"
	f.Bar5.blizzardBar = MultiBarLeft
	f.Bar5: SetSize(42, 32*f.Bar5.num+10*(f.Bar5.num+1))
	f.Bar5: SetPoint("RIGHT", f.Bar4, "LEFT", -4,0)
	
	Create_Bar(f.Bar5)
	for i = 1, f.Bar5.num do
		if f.Bar5["Button"..i] then
			f.Bar5["Button"..i]: SetSize(32,32)
			f.Bar5["Button"..i]: ClearAllPoints()
			if i == 1 then
				f.Bar5["Button"..i]: SetPoint("TOP", f.Bar5, "TOP", 0,-5)
			else
				f.Bar5["Button"..i]: SetPoint("TOP", f.Bar5["Button"..(i-1)], "BOTTOM", 0,-10)
			end
		end
		
		ButtonTemplate(f.Bar5["Button"..i])
		Create_Ring(f.Bar5["Button"..i], 32)
		Mouse_Over(f.Bar5["Button"..i], f.Bar5, true)
	end
	
	Mouse_Over(f.Bar5, f.Bar5, false)
end

local PetBar_Frame = function(f)
	f.PetBar = CreateFrame("Frame", "Quafe_ActionPetBar", UIParent, "SecureHandlerStateTemplate")
	f.PetBar.name = "PetActionButton"
	f.PetBar.num = NUM_PET_ACTION_SLOTS
	f.PetBar.visibility = "[petbattle][overridebar][vehicleui][possessbar][shapeshift]hide; [pet]show; hide"
	f.PetBar.blizzardBar = PetActionBarFrame
	f.PetBar: SetSize((20+2)*f.PetBar.num,20)
	--f.PetBar: SetPoint("LEFT", UIParent, "CENTER", 50, -320)
	f.PetBar: SetPoint("CENTER", f, "CENTER",  160,80)
	
	Create_Bar(f.PetBar)
	for i = 1, f.PetBar.num do
		if f.PetBar["Button"..i] then
			f.PetBar["Button"..i]: SetSize(28,28)
			f.PetBar["Button"..i]: ClearAllPoints()
			f.PetBar["Button"..i]: SetPoint("LEFT", f.PetBar, "LEFT", (28+8)*(i-1), -2*(i-1))
			
			ButtonTemplate(f.PetBar["Button"..i])
			Create_Ring(f.PetBar["Button"..i], 28)
			_G["PetActionButton"..i.."HotKey"]: SetFont(L.Font.Num, 10, "THINOUTLINE")
		end
	end
	
	SlidingActionBarTexture0:SetTexture(nil)
	SlidingActionBarTexture1:SetTexture(nil)
end

local ExtraBar_Frame = function(f)
	f.ExtraBar = CreateFrame("Frame", "Quafe_ExtraBar", UIParent, "SecureHandlerStateTemplate")
	f.ExtraBar.name = "ExtraActionButton"
	f.ExtraBar.num = NUM_ACTIONBAR_BUTTONS
	f.ExtraBar.visibility = "[extrabar] show; hide"
	f.ExtraBar.blizzardBar = ExtraActionBarFrame
	f.ExtraBar:SetSize(36,36)
	f.ExtraBar:SetPoint("CENTER", UIParent, "CENTER", 0, -200)
	
	Create_Bar(f.ExtraBar)
	for i  = 1, f.ExtraBar.num do
		if f.ExtraBar["Button"..i] then
			f.ExtraBar["Button"..i]: SetSize(36,36)
			f.ExtraBar["Button"..i]: ClearAllPoints()
			if i == 1 then
				f.ExtraBar["Button"..i]: SetPoint("LEFT", f.ExtraBar, "LEFT", 0,0)
			else
				f.ExtraBar["Button"..i]: SetPoint("LEFT", f.ExtraBar["Button"..(i-1)], "RIGHT", 2,0)
			end
		end
	end
end

local VehicleExit_Frame = function(f)
	f.VehicleExit = CreateFrame("Frame", "Quafe_VehicleExit", UIParent, "SecureHandlerStateTemplate")
	f.VehicleExit.visibility = "[canexitvehicle] show; hide"
	f.VehicleExit: SetSize(32,32)
	f.VehicleExit: SetPoint("CENTER", UIParent, "CENTER", 0,100)
	
	--f.VehicleExit.Button1 = OverrideActionBarLeaveFrameLeaveButton
	f.VehicleExit.Button1 = MainMenuBarVehicleLeaveButton
	f.VehicleExit.Button1: SetParent(f.VehicleExit)
	f.VehicleExit.Button1: SetSize(32,32)
	f.VehicleExit.Button1: ClearAllPoints()
	f.VehicleExit.Button1: SetPoint("CENTER", f.VehicleExit, "CENTER", 0,0)
	
	f.VehicleExit.Button2 = OverrideActionBarLeaveFrameLeaveButton
	f.VehicleExit.Button2: SetParent(f.VehicleExit)
	f.VehicleExit.Button2: SetSize(32,32)
	f.VehicleExit.Button2: ClearAllPoints()
	f.VehicleExit.Button2: SetPoint("CENTER", f.VehicleExit, "CENTER", 0,0)
	
	RegisterStateDriver(f.VehicleExit, "visibility", f.VehicleExit.visibility)
	
	
	local hook_OverrideActionBar_OnLoad = function(self)
		--Add Leave Button Textures
		self["LeaveUp"] = self.LeaveButton:GetNormalTexture();
		self["LeaveDown"] = self.LeaveButton:GetPushedTexture();
		self["LeaveHighlight"] = self.LeaveButton:GetHighlightTexture();
	end
end

local PossessExit_Frame = function(f)
	f.PossessExit = CreateFrame("Frame", "Quafe_PossessExit", UIParent, "SecureHandlerStateTemplate")
	f.PossessExit.name = "PossessButton"
	f.PossessExit.num = NUM_POSSESS_SLOTS
	f.PossessExit.visibility = "[possessbar] show; hide"
	f.PossessExit.blizzardBar = PossessBarFrame
	f.PossessExit: SetSize(32*f.PossessExit.num + 20*(f.PossessExit.num - 1), 32)
	--f.PossessExit: SetPoint("CENTER", f, "CENTER", 0,0)
	f.PossessExit: SetPoint("RIGHT", f, "CENTER", 360, -400)
	
	Create_Bar(f.PossessExit)
	for i = 1, f.PossessExit.num do
		if f.PossessExit["Button"..i] then
			f.PossessExit["Button"..i]: SetSize(32,32)
			f.PossessExit["Button"..i]: ClearAllPoints()
			--f.PossessExit["Button"..i]: SetPoint("BOTTOMLEFT", f.PossessExit, "BOTTOMLEFT", (38+14)*(i-1),3*(i-1))
			f.PossessExit["Button"..i]: SetPoint("BOTTOMRIGHT", f.PossessExit, "BOTTOMRIGHT", -(38+14)*(f.PossessExit.num-i), 3*(f.PossessExit.num-i))
			ButtonTemplate(f.PossessExit["Button"..i])
			Create_Ring(f.PossessExit["Button"..i], 32)
		end
	end
	
	PossessBackground1:SetTexture(nil)
	PossessBackground2:SetTexture(nil)
end

local StanceBar_Frame = function(f)
	f.StanceBar = CreateFrame("Frame", "OwD_StanceBar", UIParent, "SecureHandlerStateTemplate")
	f.StanceBar.name = "StanceButton"
	f.StanceBar.num = NUM_STANCE_SLOTS
	f.StanceBar.visibility = "[petbattle][overridebar][vehicleui]hide; show"
	f.StanceBar.blizzardBar = StanceBarFrame
	f.StanceBar: SetSize(32*f.StanceBar.num + 20*(f.StanceBar.num-1), 32)
	f.StanceBar: SetPoint("BOTTOMLEFT", f, "CENTER", -384, 40)
	
	Create_Bar(f.StanceBar)
	for i = 1, f.StanceBar.num do
		if f.StanceBar["Button"..i] then
			f.StanceBar["Button"..i]: SetSize(32,32)
			f.StanceBar["Button"..i]: ClearAllPoints()
			f.StanceBar["Button"..i]: SetPoint("BOTTOMLEFT", f.StanceBar, "BOTTOMLEFT", (38+14)*(i-1),3*(i-1))
			
			ButtonTemplate(f.StanceBar["Button"..i])
			Create_Ring(f.StanceBar["Button"..i], 32)
		end
	end
	StanceBarLeft:SetTexture(nil)
	StanceBarMiddle:SetTexture(nil)
	StanceBarRight:SetTexture(nil)
end

local MicroMenu_Frame = function(f)
	f.MicroMenu = CreateFrame("Frame", "Quafe_MicroMenu", UIParent, "SecureHandlerStateTemplate")
	f.MicroMenu.name = "StoreMicroButton"
	f.MicroMenu.num = MICRO_BUTTONS
	f.MicroMenu.visibility = "show"
	f.MicroMenu: SetSize(320,52)
	f.MicroMenu: SetPoint("TOP", UIParent, "TOP", 0,0)
	
	local MicroButton = {
		"CharacterMicroButton",
		"SpellbookMicroButton",
		"TalentMicroButton",
		"AchievementMicroButton",
		"QuestLogMicroButton",
		"GuildMicroButton",
		"LFDMicroButton",
		"CollectionsMicroButton",
		"EJMicroButton",
		"StoreMicroButton",
		"MainMenuMicroButton",
	}
	
	for i = 1, #MicroButton, 1 do
		local button = _G[MicroButton[i]]
		if button then
			f.MicroMenu["Button"..i] = button
			f.MicroMenu["Button"..i]: SetParent(f.MicroMenu)
		end
		f.MicroMenu["Button"..i]: ClearAllPoints()
		if i == 1 then
			f.MicroMenu["Button"..i]: SetPoint("TOPLEFT", f.MicroMenu, "TOPLEFT", 0, 16)
		else
			if f.MicroMenu["Button"..(i-1)] then
				f.MicroMenu["Button"..i]: SetPoint("LEFT", f.MicroMenu["Button"..(i-1)], "RIGHT", 2,0)
			else
				f.MicroMenu["Button"..i]: SetPoint("LEFT", f.MicroMenu["Button"..(i-2)], "RIGHT", 2,0)
			end
		end
		Mouse_Over(f.MicroMenu["Button"..i], f.MicroMenu, true)
	end
	RegisterStateDriver(f.MicroMenu, "visibility", f.MicroMenu.visibility)
	
	Mouse_Over(f.MicroMenu, f.MicroMenu, false)
end


local pos_ActionBar = function(f, Q, x0, y0)
	local r = 140
	local r2 = 190
	local d = 20
	local sd = 270 - d*5.5
	local sd2 = 270 - d*1.75
	local x1,y1
	for i = 1, 12 do 
		y1 = sin(rad(sd+(i-1)*d))*r + y0
		x1 = cos(rad(sd+(i-1)*d))*r + x0
		
		f.Bar1["Button"..i]: SetPoint("CENTER", Q, "CENTER", x1, y1)
	end
end

local update_CD = function(f)
	local t = f.d - f.s
	if t < 0 then f.d = 0 end
	if f.d > 1.5 then
		if f.CD then
			f.CD: SetText(format_Num(t))
		end
	else
		if f.CD then
			f.CD: SetText("")
		end
	end
end

L.ActionBar = function(f, Q)
	f.ActionBar = CreateFrame("Frame", nil, UIParent)
	f.ActionBar: SetSize(32,32)
	f.ActionBar: SetPoint("CENTER", UIParent, "CENTER", 0, -400)
	
	if OwD_DB.ActionBar.ON then
		
		L.HideMainMenuBar()
		
		Bar1_Frame(f.ActionBar)
		Bar4_Frame(f.ActionBar)
		Bar5_Frame(f.ActionBar)
		PetBar_Frame(f.ActionBar)
		ExtraBar_Frame(f.ActionBar)
		VehicleExit_Frame(f.ActionBar)
		PossessExit_Frame(f.ActionBar)
		StanceBar_Frame(f.ActionBar)
		MicroMenu_Frame(f.ActionBar)
		local last1 = 0
		local last2 = 0
		f.ActionBar: SetScript("OnUpdate", function(self, elapsed)
			if self.Bar1 then
				for i = 1, self.Bar1.num do
					if self.Bar1["Button"..i].d > 0 then
						update_Ring(self.Bar1["Button"..i], self.Bar1["Button"..i].s/self.Bar1["Button"..i].d)
						self.Bar1["Button"..i].s = self.Bar1["Button"..i].s + elapsed
						--color_Ring(self.Bar1["Button"..i], C.Color.Red0)
					else
						update_Ring(self.Bar1["Button"..i], 1)
						--color_Ring(self.Bar1["Button"..i], C.Color.White)
					end
				end
			end
			
			last1 = last1 + elapsed
			if last1 >= 0.1 then
				last1 = 0
				
				if self.Bar1 then
					for i = 1, self.Bar1.num do
						update_CD(self.Bar1["Button"..i])
					end
				end
				
				if self.Bar4 then
					for i = 1, self.Bar4.num do
						if self.Bar4["Button"..i].d > 1.5 then
							update_Ring(self.Bar4["Button"..i], self.Bar4["Button"..i].s/self.Bar4["Button"..i].d)
							self.Bar4["Button"..i].s = self.Bar4["Button"..i].s + elapsed
						else
							update_Ring(self.Bar4["Button"..i], 1)
						end
						update_CD(self.Bar4["Button"..i])
					end
				end
				
				if self.Bar5 then
					for i = 1, self.Bar5.num do
						if self.Bar5["Button"..i].d > 1.5 then
							update_Ring(self.Bar5["Button"..i], self.Bar5["Button"..i].s/self.Bar5["Button"..i].d)
							self.Bar5["Button"..i].s = self.Bar5["Button"..i].s + elapsed
						else
							update_Ring(self.Bar5["Button"..i], 1)
						end
						update_CD(self.Bar5["Button"..i])
					end
				end
				
				if self.PetBar then
					for i = 1, self.PetBar.num do
						if self.PetBar["Button"..i].d > 1.5 then
							update_Ring(self.PetBar["Button"..i], self.PetBar["Button"..i].s/self.PetBar["Button"..i].d)
							self.PetBar["Button"..i].s = self.PetBar["Button"..i].s + elapsed
						else
							update_Ring(self.PetBar["Button"..i], 1)
						end
						update_CD(self.PetBar["Button"..i])
					end
				end
				
				if self.StanceBar then
					for i = 1, self.StanceBar.num do
						if self.StanceBar["Button"..i].d > 1.5 then
							update_Ring(self.StanceBar["Button"..i], self.StanceBar["Button"..i].s/self.StanceBar["Button"..i].d)
							self.StanceBar["Button"..i].s = self.StanceBar["Button"..i].s + elapsed
						else
							update_Ring(self.StanceBar["Button"..i], 1)
						end
						update_CD(self.StanceBar["Button"..i])
					end
				end
			end
		end)
		
	end
end

----------------------------------------------------------------

