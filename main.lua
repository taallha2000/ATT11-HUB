if game.Players.LocalPlayer.Name ~= "ATT11559" then game.Players.LocalPlayer:Kick("مغلق") return end
 -- [[ ATT11 HUB - FULLY OBFUSCATED & SECURE ]]
local _0x1a = game
local _0x2b = _0x1a:GetService("Players")
local _0x3c = _0x1a:GetService("RunService")
local _0x4d = _0x1a:GetService("UserInputService")
local _0x5e = _0x1a:GetService("TweenService")
local _0x6f = _0x1a:GetService("HttpService")
local _0x70 = _0x2b.LocalPlayer

local _0x81 = (function()
    local t = {65,84,84,49,49,72,117,98,95,83,101,116,116,105,110,103,115,46,106,115,111,110}
    local s = ""
    for _, v in ipairs(t) do s = s .. string.char(v) end
    return s
end)()

local _0x92 = {
    AntiBatSpeed = 60,
    AimbotV2Speed = 58,
    BatCounter = false,
    MedusaCounter = false,
    AntiBatWindowVisible = true,
    AntiBatToggled = false,
    AimbotWindowVisible = true,
    AimbotToggled = false,
    AimbotV2 = false,
    AimbotV2WindowVisible = true,
    OpenButtonLocked = false,
    OpenButtonPos = {xScale = 0, xOffset = 150, yScale = 0, yOffset = 12},
}

local function _0xA3()
    pcall(function()
        if readfile and isfile and isfile(_0x81) then
            local _res = _0x6f:JSONDecode(readfile(_0x81))
            if type(_res) == "table" then
                for k, v in pairs(_res) do _0x92[k] = v end
            end
        end
    end)
end

local function _0xB4()
    pcall(function()
        if writefile then
            writefile(_0x81, _0x6f:JSONEncode(_0x92))
        end
    end)
end

_0xA3()

local _0xC5 = { hittingCooldown = false, batHitsCount = 0, medusaHitsCount = 0 }
local _h, _hrp = nil, nil

for _, name in pairs({"AxonAutoBatDesyncGUI", "EnvyAutoBatDesyncGUI", "MwvaneNewaBatDesyncGUI", "PhazeAutoBatDesyncGUI", "ATT11Hub_SettingsGui"}) do
    local _old = _0x1a:GetService("CoreGui"):FindFirstChild(name)
    if _old then _old:Destroy() end
    local _oldPG = _0x70.PlayerGui:FindFirstChild(name)
    if _oldPG then _oldPG:Destroy() end
end

local _gui = Instance.new("ScreenGui")
_gui.Name = "ATT11Hub_SettingsGui"
_gui.ResetOnSpawn = false
_gui.DisplayOrder = 10
_gui.IgnoreGuiInset = true
_gui.Parent = _0x70:WaitForChild("PlayerGui")

local _openBtn = Instance.new("TextButton", _gui)
_openBtn.Name = "OpenButton"
_openBtn.BackgroundColor3 = Color3.fromRGB(0, 30, 80)
_openBtn.Position = UDim2.new(_0x92.OpenButtonPos.xScale, _0x92.OpenButtonPos.xOffset, _0x92.OpenButtonPos.yScale, _0x92.OpenButtonPos.yOffset)
_openBtn.Size = UDim2.new(0, 110, 0, 28)
_openBtn.Font = Enum.Font.GothamBlack
_openBtn.Text = "ATT11 HUB"
_openBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
_openBtn.TextSize = 10
_openBtn.Visible = false
Instance.new("UICorner", _openBtn).CornerRadius = UDim.new(0, 5)
local _openStr = Instance.new("UIStroke", _openBtn)
_openStr.Color = Color3.fromRGB(255, 200, 0)
_openStr.Thickness = 1

do
    local _drag, _dInput, _dStart, _bStart = false, nil, nil, nil
    _openBtn.InputBegan:Connect(function(inp)
        if _0x92.OpenButtonLocked then return end
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            _drag = true; _dStart = inp.Position; _bStart = _openBtn.Position
            inp.Changed:Connect(function()
                if inp.UserInputState == Enum.UserInputState.End then _drag = false end
            end)
        end
    end)
    _openBtn.InputChanged:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then _dInput = inp end
    end)
    _0x4d.InputChanged:Connect(function(inp)
        if inp == _dInput and _drag and not _0x92.OpenButtonLocked then
            local dx = inp.Position.X - _dStart.X
            local dy = inp.Position.Y - _dStart.Y
            _openBtn.Position = UDim2.new(_bStart.X.Scale, _bStart.X.Offset + dx, _bStart.Y.Scale, _bStart.Y.Offset + dy)
            _0x92.OpenButtonPos = {
                xScale = _openBtn.Position.X.Scale,
                xOffset = _openBtn.Position.X.Offset,
                yScale = _openBtn.Position.Y.Scale,
                yOffset = _openBtn.Position.Y.Offset
            }
            _0xB4()
        end
    end)
end

local _main = Instance.new("Frame", _gui)
_main.Name = "Main"
_main.Size = UDim2.new(0, 300, 0, 250)
_main.Position = UDim2.new(0.5, -150, 0.5, -125)
_main.BackgroundColor3 = Color3.fromRGB(0, 30, 80)
_main.BorderSizePixel = 0
_main.Active = true
_main.ClipsDescendants = true
Instance.new("UICorner", _main).CornerRadius = UDim.new(0, 10)
local _mainStr = Instance.new("UIStroke", _main)
_mainStr.Color = Color3.fromRGB(0, 100, 200)
_mainStr.Thickness = 1

do
    local _drag, _dInput, _dStart, _mStart = false, nil, nil, nil
    _main.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            _drag = true; _dStart = inp.Position; _mStart = _main.Position
            inp.Changed:Connect(function()
                if inp.UserInputState == Enum.UserInputState.End then _drag = false end
            end)
        end
    end)
    _main.InputChanged:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then _dInput = inp end
    end)
    _0x4d.InputChanged:Connect(function(inp)
        if inp == _dInput and _drag then
            local dx = inp.Position.X - _dStart.X
            local dy = inp.Position.Y - _dStart.Y
            _main.Position = UDim2.new(_mStart.X.Scale, _mStart.X.Offset + dx, _mStart.Y.Scale, _mStart.Y.Offset + dy)
        end
    end)
end

local _header = Instance.new("Frame", _main)
_header.Size = UDim2.new(1, 0, 0, 36)
_header.BackgroundColor3 = Color3.fromRGB(0, 20, 60)
_header.BorderSizePixel = 0
Instance.new("UICorner", _header).CornerRadius = UDim.new(0, 10)

local _hIcon = Instance.new("Frame", _header)
_hIcon.Size = UDim2.new(0, 24, 0, 24)
_hIcon.Position = UDim2.new(0, 8, 0.5, -12)
_hIcon.BackgroundColor3 = Color3.fromRGB(0, 40, 100)
_hIcon.BorderSizePixel = 0
Instance.new("UICorner", _hIcon).CornerRadius = UDim.new(0, 5)
local _iStr = Instance.new("UIStroke", _hIcon)
_iStr.Color = Color3.fromRGB(255, 200, 0)
_iStr.Thickness = 1

local _iLbl = Instance.new("TextLabel", _hIcon)
_iLbl.Size = UDim2.new(1, 0, 1, 0)
_iLbl.BackgroundTransparency = 1
_iLbl.Text = "ًں¥·"
_iLbl.TextSize = 12

local _tLbl = Instance.new("TextLabel", _header)
_tLbl.Size = UDim2.new(1, -90, 1, 0)
_tLbl.Position = UDim2.new(0, 38, 0, 0)
_tLbl.BackgroundTransparency = 1
_tLbl.Text = "ATT11 HUB"
_tLbl.TextColor3 = Color3.fromRGB(255, 215, 0)
_tLbl.Font = Enum.Font.GothamBlack
_tLbl.TextSize = 11
_tLbl.TextXAlignment = Enum.TextXAlignment.Left
_tLbl.TextYAlignment = Enum.TextYAlignment.Center

local _cBtn = Instance.new("TextButton", _header)
_cBtn.Size = UDim2.new(0, 22, 0, 22)
_cBtn.Position = UDim2.new(1, -28, 0.5, -11)
_cBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
_cBtn.BorderSizePixel = 0
_cBtn.Text = "X"
_cBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
_cBtn.Font = Enum.Font.GothamBlack
_cBtn.TextSize = 10
Instance.new("UICorner", _cBtn).CornerRadius = UDim.new(0, 5)

local _lBtn = Instance.new("TextButton", _header)
_lBtn.Size = UDim2.new(0, 42, 0, 22)
_lBtn.Position = UDim2.new(1, -74, 0.5, -11)
_lBtn.BackgroundColor3 = _0x92.OpenButtonLocked and Color3.fromRGB(0, 160, 0) or Color3.fromRGB(0, 50, 130)
_lBtn.BorderSizePixel = 0
_lBtn.Text = "LOCK"
_lBtn.TextColor3 = _0x92.OpenButtonLocked and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 215, 0)
_lBtn.Font = Enum.Font.GothamBold
_lBtn.TextSize = 9
Instance.new("UICorner", _lBtn).CornerRadius = UDim.new(0, 5)
local _lStr = Instance.new("UIStroke", _lBtn)
_lStr.Color = Color3.fromRGB(255, 200, 0)
_lStr.Thickness = 1

local function _updLock(locked)
    _0x92.OpenButtonLocked = locked
    _lBtn.BackgroundColor3 = locked and Color3.fromRGB(0, 160, 0) or Color3.fromRGB(0, 50, 130)
    _lBtn.TextColor3 = locked and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 215, 0)
    _0xB4()
end

_lBtn.MouseButton1Click:Connect(function()
    _updLock(not _0x92.OpenButtonLocked)
end)

_cBtn.MouseButton1Click:Connect(function()
    _main.Visible = false
    _openBtn.Visible = true
end)

_openBtn.MouseButton1Click:Connect(function()
    _main.Visible = true
    _openBtn.Visible = false
end)

local _sFrame = Instance.new("ScrollingFrame", _main)
_sFrame.Name = "ScrollFrame"
_sFrame.Size = UDim2.new(1, 0, 1, -36)
_sFrame.Position = UDim2.new(0, 0, 0, 36)
_sFrame.BackgroundTransparency = 1
_sFrame.BorderSizePixel = 0
_sFrame.CanvasSize = UDim2.new(0, 0, 0, 310)
_sFrame.ScrollBarThickness = 3
_sFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 100, 200)

local _abRowM = Instance.new("Frame", _sFrame)
_abRowM.Name = "AntiBatRow"
_abRowM.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
_abRowM.Position = UDim2.new(0.04, 0, 0, 8)
_abRowM.Size = UDim2.new(0.92, 0, 0, 32)
Instance.new("UICorner", _abRowM).CornerRadius = UDim.new(0, 5)

local _abLbl = Instance.new("TextLabel", _abRowM)
_abLbl.Size = UDim2.new(0.7, 0, 1, 0)
_abLbl.Position = UDim2.new(0, 8, 0, 0)
_abLbl.BackgroundTransparency = 1
_abLbl.Font = Enum.Font.GothamBold
_abLbl.Text = "ANTI BAT/SPEED :"
_abLbl.TextColor3 = Color3.fromRGB(255, 215, 0)
_abLbl.TextSize = 10
_abLbl.TextXAlignment = Enum.TextXAlignment.Left

local _abBox = Instance.new("TextBox", _abRowM)
_abBox.Size = UDim2.new(0, 42, 0, 22)
_abBox.Position = UDim2.new(1, -48, 0.5, -11)
_abBox.BackgroundColor3 = Color3.fromRGB(0, 50, 130)
_abBox.Font = Enum.Font.GothamBold
_abBox.Text = tostring(_0x92.AntiBatSpeed)
_abBox.TextColor3 = Color3.fromRGB(255, 215, 0)
_abBox.TextSize = 11
_abBox.ClearTextOnFocus = false
Instance.new("UICorner", _abBox).CornerRadius = UDim.new(0, 5)
local _abbStr = Instance.new("UIStroke", _abBox)
_abbStr.Color = Color3.fromRGB(255, 200, 0)
_abbStr.Thickness = 1

_abBox.FocusLost:Connect(function()
    local num = tonumber(_abBox.Text)
    if num then _0x92.AntiBatSpeed = num else _abBox.Text = tostring(_0x92.AntiBatSpeed) end
    _0xB4()
end)

local _av2Row = Instance.new("Frame", _sFrame)
_av2Row.Name = "AimbotV2SpeedRow"
_av2Row.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
_av2Row.Position = UDim2.new(0.04, 0, 0, 236)
_av2Row.Size = UDim2.new(0.92, 0, 0, 32)
Instance.new("UICorner", _av2Row).CornerRadius = UDim.new(0, 5)

local _av2Lbl = Instance.new("TextLabel", _av2Row)
_av2Lbl.Size = UDim2.new(0.7, 0, 1, 0)
_av2Lbl.Position = UDim2.new(0, 8, 0, 0)
_av2Lbl.BackgroundTransparency = 1
_av2Lbl.Font = Enum.Font.GothamBold
_av2Lbl.Text = "AIMBOT V2 SPEED :"
_av2Lbl.TextColor3 = Color3.fromRGB(255, 215, 0)
_av2Lbl.TextSize = 10
_av2Lbl.TextXAlignment = Enum.TextXAlignment.Left

local _av2Box = Instance.new("TextBox", _av2Row)
_av2Box.Size = UDim2.new(0, 42, 0, 22)
_av2Box.Position = UDim2.new(1, -48, 0.5, -11)
_av2Box.BackgroundColor3 = Color3.fromRGB(0, 50, 130)
_av2Box.Font = Enum.Font.GothamBold
_av2Box.Text = tostring(_0x92.AimbotV2Speed)
_av2Box.TextColor3 = Color3.fromRGB(255, 215, 0)
_av2Box.TextSize = 11
_av2Box.ClearTextOnFocus = false
Instance.new("UICorner", _av2Box).CornerRadius = UDim.new(0, 5)
local _av2Str = Instance.new("UIStroke", _av2Box)
_av2Str.Color = Color3.fromRGB(255, 200, 0)
_av2Str.Thickness = 1

_av2Box.FocusLost:Connect(function()
    local num = tonumber(_av2Box.Text)
    if num then _0x92.AimbotV2Speed = num else _av2Box.Text = tostring(_0x92.AimbotV2Speed) end
    _0xB4()
end)

local function _createToggle(name, yPos, key, text)
    local row = Instance.new("Frame", _sFrame)
    row.Name = name
    row.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    row.Position = UDim2.new(0.04, 0, 0, yPos)
    row.Size = UDim2.new(0.92, 0, 0, 32)
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 5)

    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(0.7, 0, 1, 0)
    lbl.Position = UDim2.new(0, 8, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.Text = text .. " :"
    lbl.TextColor3 = Color3.fromRGB(255, 215, 0)
    lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local pBg = Instance.new("Frame", row)
    pBg.Size = UDim2.new(0, 30, 0, 18)
    pBg.Position = UDim2.new(1, -34, 0.5, -9)
    pBg.BackgroundColor3 = _0x92[key] and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(0, 30, 80)
    pBg.BorderSizePixel = 0
    pBg.ZIndex = 8
    Instance.new("UICorner", pBg).CornerRadius = UDim.new(0, 9)
    local pStr = Instance.new("UIStroke", pBg)
    pStr.Color = Color3.fromRGB(255, 200, 0)
    pStr.Thickness = 1

    local dDot = Instance.new("Frame", pBg)
    dDot.Size = UDim2.new(0, 12, 0, 12)
    dDot.Position = _0x92[key] and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6)
    dDot.BackgroundColor3 = _0x92[key] and Color3.fromRGB(0, 30, 80) or Color3.fromRGB(0, 60, 150)
    dDot.BorderSizePixel = 0
    dDot.ZIndex = 9
    Instance.new("UICorner", dDot).CornerRadius = UDim.new(0, 4)

    local tBtn = Instance.new("TextButton", pBg)
    tBtn.Size = UDim2.new(1, 0, 1, 0)
    tBtn.BackgroundTransparency = 1
    tBtn.Text = ""
    tBtn.ZIndex = 10

    return row, pBg, pStr, dDot, tBtn, lbl
end

local _, batPill, _, batDot, batTBtn = _createToggle("BatCounterRow", 46, "BatCounter", "BAT COUNTER")
batTBtn.MouseButton1Click:Connect(function()
    _0x92.BatCounter = not _0x92.BatCounter
    _0x5e:Create(batPill, TweenInfo.new(0.18), {BackgroundColor3 = _0x92.BatCounter and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(0, 30, 80)}):Play()
    _0x5e:Create(batDot, TweenInfo.new(0.18, Enum.EasingStyle.Back), {
        Position = _0x92.BatCounter and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6),
        BackgroundColor3 = _0x92.BatCounter and Color3.fromRGB(0, 30, 80) or Color3.fromRGB(0, 60, 150)
    }):Play()
    _0xB4()
end)

local _, medPill, _, medDot, medTBtn = _createToggle("MedusaCounterRow", 84, "MedusaCounter", "MEDUSA COUNTER")
medTBtn.MouseButton1Click:Connect(function()
    _0x92.MedusaCounter = not _0x92.MedusaCounter
    _0x5e:Create(medPill, TweenInfo.new(0.18), {BackgroundColor3 = _0x92.MedusaCounter and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(0, 30, 80)}):Play()
    _0x5e:Create(medDot, TweenInfo.new(0.18, Enum.EasingStyle.Back), {
        Position = _0x92.MedusaCounter and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6),
        BackgroundColor3 = _0x92.MedusaCounter and Color3.fromRGB(0, 30, 80) or Color3.fromRGB(0, 60, 150)
    }):Play()
    _0xB4()
end)

local fMain = Instance.new("Frame", _gui)
fMain.Name = "FloatingAntiBat"
fMain.Size = UDim2.new(0, 130, 0, 75)
fMain.Position = UDim2.new(0, 15, 0.18, 0)
fMain.BackgroundColor3 = Color3.fromRGB(0, 30, 80)
fMain.BorderSizePixel = 0
fMain.Active = true
fMain.Visible = _0x92.AntiBatWindowVisible
Instance.new("UICorner", fMain).CornerRadius = UDim.new(0, 8)
local fStr = Instance.new("UIStroke", fMain)
fStr.Color = Color3.fromRGB(0, 100, 200)
fStr.Thickness = 1

do
    local _drag, _dInput, _dStart, _mStart = false, nil, nil, nil
    fMain.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            _drag = true; _dStart = inp.Position; _mStart = fMain.Position
            inp.Changed:Connect(function()
                if inp.UserInputState == Enum.UserInputState.End then _drag = false end
            end)
        end
    end)
    fMain.InputChanged:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then _dInput = inp end
    end)
    _0x4d.InputChanged:Connect(function(inp)
        if inp == _dInput and _drag then
            local dx = inp.Position.X - _dStart.X
            local dy = inp.Position.Y - _dStart.Y
            fMain.Position = UDim2.new(_mStart.X.Scale, _mStart.X.Offset + dx, _mStart.Y.Scale, _mStart.Y.Offset + dy)
        end
    end)
end

local fHead = Instance.new("Frame", fMain)
fHead.Size = UDim2.new(1, 0, 0, 24)
fHead.BackgroundColor3 = Color3.fromRGB(0, 20, 60)
fHead.BorderSizePixel = 0
Instance.new("UICorner", fHead).CornerRadius = UDim.new(0, 8)

local fTitle = Instance.new("TextLabel", fHead)
fTitle.Size = UDim2.new(1, -8, 1, 0)
fTitle.Position = UDim2.new(0, 6, 0, 0)
fTitle.BackgroundTransparency = 1
fTitle.Text = "ANTI BAT - ATT11 HUB"
fTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
fTitle.Font = Enum.Font.GothamBlack
fTitle.TextSize = 7
fTitle.TextXAlignment = Enum.TextXAlignment.Left

local fDiv = Instance.new("Frame", fHead)
fDiv.Size = UDim2.new(1, 0, 0, 1)
fDiv.Position = UDim2.new(0, 0, 1, -1)
fDiv.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
fDiv.BorderSizePixel = 0

local fCont = Instance.new("Frame", fMain)
fCont.Size = UDim2.new(1, -12, 1, -30)
fCont.Position = UDim2.new(0, 6, 0, 27)
fCont.BackgroundTransparency = 1

local abBtn = Instance.new("TextButton", fCont)
abBtn.Size = UDim2.new(1, 0, 1, 0)
abBtn.BackgroundColor3 = _0x92.AntiBatToggled and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(0, 50, 130)
abBtn.BorderSizePixel = 0
abBtn.Text = "ANTI BAT"
abBtn.TextColor3 = _0x92.AntiBatToggled and Color3.fromRGB(0, 30, 80) or Color3.fromRGB(255, 215, 0)
abBtn.Font = Enum.Font.GothamBold
abBtn.TextSize = 9
Instance.new("UICorner", abBtn).CornerRadius = UDim.new(0, 5)
local abStr = Instance.new("UIStroke", abBtn)
abStr.Color = Color3.fromRGB(0, 100, 200)
abStr.Thickness = 1

local function setAntiBat(on)
    _0x92.AntiBatToggled = on
    abBtn.BackgroundColor3 = on and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(0, 50, 130)
    abBtn.TextColor3 = on and Color3.fromRGB(0, 30, 80) or Color3.fromRGB(255, 215, 0)
    _0xB4()
end

abBtn.MouseButton1Click:Connect(function()
    setAntiBat(not _0x92.AntiBatToggled)
end)

local afMain = Instance.new("Frame", _gui)
afMain.Name = "FloatingAimbot"
afMain.Size = UDim2.new(0, 130, 0, 75)
afMain.Position = UDim2.new(0, 15, 0.31, 0)
afMain.BackgroundColor3 = Color3.fromRGB(0, 30, 80)
afMain.BorderSizePixel = 0
afMain.Active = true
afMain.Visible = _0x92.AimbotWindowVisible
Instance.new("UICorner", afMain).CornerRadius = UDim.new(0, 8)
local afStr = Instance.new("UIStroke", afMain)
afStr.Color = Color3.fromRGB(0, 100, 200)
afStr.Thickness = 1

do
    local _drag, _dInput, _dStart, _mStart = false, nil, nil, nil
    afMain.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            _drag = true; _dStart = inp.Position; _mStart = afMain.Position
            inp.Changed:Connect(function()
                if inp.UserInputState == Enum.UserInputState.End then _drag = false end
            end)
        end
    end)
    afMain.InputChanged:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then _dInput = inp end
    end)
    _0x4d.InputChanged:Connect(function(inp)
        if inp == _dInput and _drag then
            local dx = inp.Position.X - _dStart.X
            local dy = inp.Position.Y - _dStart.Y
            afMain.Position = UDim2.new(_mStart.X.Scale, _mStart.X.Offset + dx, _mStart.Y.Scale, _mStart.Y.Offset + dy)
        end
    end)
end

local afHead = Instance.new("Frame", afMain)
afHead.Size = UDim2.new(1, 0, 0, 24)
afHead.BackgroundColor3 = Color3.fromRGB(0, 20, 60)
afHead.BorderSizePixel = 0
Instance.new("UICorner", afHead).CornerRadius = UDim.new(0, 8)

local afTitle = Instance.new("TextLabel", afHead)
afTitle.Size = UDim2.new(1, -8, 1, 0)
afTitle.Position = UDim2.new(0, 6, 0, 0)
afTitle.BackgroundTransparency = 1
afTitle.Text = "AIMBOT V1 - ATT11 HUB"
afTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
afTitle.Font = Enum.Font.GothamBlack
afTitle.TextSize = 7
afTitle.TextXAlignment = Enum.TextXAlignment.Left

local afDiv = Instance.new("Frame", afHead)
afDiv.Size = UDim2.new(1, 0, 0, 1)
afDiv.Position = UDim2.new(0, 0, 1, -1)
afDiv.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
afDiv.BorderSizePixel = 0

local afCont = Instance.new("Frame", afMain)
afCont.Size = UDim2.new(1, -12, 1, -30)
afCont.Position = UDim2.new(0, 6, 0, 27)
afCont.BackgroundTransparency = 1

local aimBtn = Instance.new("TextButton", afCont)
aimBtn.Size = UDim2.new(1, 0, 1, 0)
aimBtn.BackgroundColor3 = _0x92.AimbotToggled and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(0, 50, 130)
aimBtn.BorderSizePixel = 0
aimBtn.Text = "AIMBOT"
aimBtn.TextColor3 = _0x92.AimbotToggled and Color3.fromRGB(0, 30, 80) or Color3.fromRGB(255, 215, 0)
aimBtn.Font = Enum.Font.GothamBold
aimBtn.TextSize = 9
Instance.new("UICorner", aimBtn).CornerRadius = UDim.new(0, 5)
local aimStr = Instance.new("UIStroke", aimBtn)
aimStr.Color = Color3.fromRGB(0, 100, 200)
aimStr.Thickness = 1

local av2fMain = Instance.new("Frame", _gui)
av2fMain.Name = "FloatingAimbotV2"
av2fMain.Size = UDim2.new(0, 130, 0, 75)
av2fMain.Position = UDim2.new(0, 15, 0.44, 0)
av2fMain.BackgroundColor3 = Color3.fromRGB(0, 30, 80)
av2fMain.BorderSizePixel = 0
av2fMain.Active = true
av2fMain.Visible = _0x92.AimbotV2WindowVisible
Instance.new("UICorner", av2fMain).CornerRadius = UDim.new(0, 8)
local av2fStr = Instance.new("UIStroke", av2fMain)
av2fStr.Color = Color3.fromRGB(0, 100, 200)
av2fStr.Thickness = 1

do
    local _drag, _dInput, _dStart, _mStart = false, nil, nil, nil
    av2fMain.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            _drag = true; _dStart = inp.Position; _mStart = av2fMain.Position
            inp.Changed:Connect(function()
                if inp.UserInputState == Enum.UserInputState.End then _drag = false end
            end)
        end
    end)
    av2fMain.InputChanged:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then _dInput = inp end
    end)
    _0x4d.InputChanged:Connect(function(inp)
        if inp == _dInput and _drag then
            local dx = inp.Position.X - _dStart.X
            local dy = inp.Position.Y - _dStart.Y
            av2fMain.Position = UDim2.new(_mStart.X.Scale, _mStart.X.Offset + dx, _mStart.Y.Scale, _mStart.Y.Offset + dy)
        end
    end)
end

local av2fHead = Instance.new("Frame", av2fMain)
av2fHead.Size = UDim2.new(1, 0, 0, 24)
av2fHead.BackgroundColor3 = Color3.fromRGB(0, 20, 60)
av2fHead.BorderSizePixel = 0
Instance.new("UICorner", av2fHead).CornerRadius = UDim.new(0, 8)

local av2fTitle = Instance.new("TextLabel", av2fHead)
av2fTitle.Size = UDim2.new(1, -8, 1, 0)
av2fTitle.Position = UDim2.new(0, 6, 0, 0)
av2fTitle.BackgroundTransparency = 1
av2fTitle.Text = "AIMBOT V2 - ATT11 HUB"
av2fTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
av2fTitle.Font = Enum.Font.GothamBlack
av2fTitle.TextSize = 7
av2fTitle.TextXAlignment = Enum.TextXAlignment.Left

local av2fDiv = Instance.new("Frame", av2fHead)
av2fDiv.Size = UDim2.new(1, 0, 0, 1)
av2fDiv.Position = UDim2.new(0, 0, 1, -1)
av2fDiv.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
av2fDiv.BorderSizePixel = 0

local av2fCont = Instance.new("Frame", av2fMain)
av2fCont.Size = UDim2.new(1, -12, 1, -30)
av2fCont.Position = UDim2.new(0, 6, 0, 27)
av2fCont.BackgroundTransparency = 1

local aimv2Btn = Instance.new("TextButton", av2fCont)
aimv2Btn.Size = UDim2.new(1, 0, 1, 0)
aimv2Btn.BackgroundColor3 = _0x92.AimbotV2 and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(0, 50, 130)
aimv2Btn.BorderSizePixel = 0
aimv2Btn.Text = "AIMBOT V2"
aimv2Btn.TextColor3 = _0x92.AimbotV2 and Color3.fromRGB(0, 30, 80) or Color3.fromRGB(255, 215, 0)
aimv2Btn.Font = Enum.Font.GothamBold
aimv2Btn.TextSize = 9
Instance.new("UICorner", aimv2Btn).CornerRadius = UDim.new(0, 5)
local aimv2Str = Instance.new("UIStroke", aimv2Btn)
aimv2Str.Color = Color3.fromRGB(0, 100, 200)
aimv2Str.Thickness = 1

local _, winPill, winPStr, winDot, winTBtn = _createToggle("AntiBatWindowRow", 122, "AntiBatWindowVisible", "ANTI BAT")
winTBtn.MouseButton1Click:Connect(function()
    local vis = not _0x92.AntiBatWindowVisible
    _0x92.AntiBatWindowVisible = vis
    fMain.Visible = vis
    _0x5e:Create(winPill, TweenInfo.new(0.18), {BackgroundColor3 = vis and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(0, 30, 80)}):Play()
    _0x5e:Create(winPStr, TweenInfo.new(0.18), {Color = vis and Color3.fromRGB(255, 235, 59) or Color3.fromRGB(255, 200, 0)}):Play()
    _0x5e:Create(winDot, TweenInfo.new(0.18, Enum.EasingStyle.Back), {
        Position = vis and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6),
        BackgroundColor3 = vis and Color3.fromRGB(0, 30, 80) or Color3.fromRGB(0, 60, 150)
    }):Play()
    _0xB4()
end)

local _, aimPill, aimPStr, aimDot, aimTBtn = _createToggle("AimbotWindowRow", 160, "AimbotWindowVisible", "AIMBOT")
aimTBtn.MouseButton1Click:Connect(function()
    local vis = not _0x92.AimbotWindowVisible
    _0x92.AimbotWindowVisible = vis
    afMain.Visible = vis
    _0x5e:Create(aimPill, TweenInfo.new(0.18), {BackgroundColor3 = vis and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(0, 30, 80)}):Play()
    _0x5e:Create(aimPStr, TweenInfo.new(0.18), {Color = vis and Color3.fromRGB(255, 235, 59) or Color3.fromRGB(255, 200, 0)}):Play()
    _0x5e:Create(aimDot, TweenInfo.new(0.18, Enum.EasingStyle.Back), {
        Position = vis and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6),
        BackgroundColor3 = vis and Color3.fromRGB(0, 30, 80) or Color3.fromRGB(0, 60, 150)
    }):Play()
    _0xB4()
end)

local _, v2Pill, v2PStr, v2Dot, v2TBtn = _createToggle("AimbotV2WindowRow", 198, "AimbotV2WindowVisible", "AIMBOT V2")
v2TBtn.MouseButton1Click:Connect(function()
    local vis = not _0x92.AimbotV2WindowVisible
    _0x92.AimbotV2WindowVisible = vis
    av2fMain.Visible = vis
    _0x5e:Create(v2Pill, TweenInfo.new(0.18), {BackgroundColor3 = vis and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(0, 30, 80)}):Play()
    _0x5e:Create(v2PStr, TweenInfo.new(0.18), {Color = vis and Color3.fromRGB(255, 235, 59) or Color3.fromRGB(255, 200, 0)}):Play()
    _0x5e:Create(v2Dot, TweenInfo.new(0.18, Enum.EasingStyle.Back), {
        Position = vis and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6),
        BackgroundColor3 = vis and Color3.fromRGB(0, 30, 80) or Color3.fromRGB(0, 60, 150)
    }):Play()
    _0xB4()
end)

local _BAT_LIST = { "Bat", "Slap", "Iron Slap", "Gold Slap", "Diamond Slap", "Emerald Slap", "Ruby Slap", "Dark Matter Slap", "Flame Slap", "Nuclear Slap", "Galaxy Slap", "Glitched Slap" }
local _HIT_DIST = 8
local _SWING_CD = 0.35
local _aimConn = nil
local _prevAR = nil

local function getBat()
    local char = _0x70.Character; if not char then return nil end
    for _, name in ipairs(_BAT_LIST) do
        local t = char:FindFirstChild(name)
        if t and t:IsA("Tool") then return t end
    end
    local bp = _0x70:FindFirstChildOfClass("Backpack")
    if bp then
        for _, name in ipairs(_BAT_LIST) do
            local t = bp:FindFirstChild(name)
            if t and t:IsA("Tool") then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then pcall(function() hum:EquipTool(t) end) end
                return t
            end
        end
    end
    return nil
end

local function trySwing()
    if _0xC5.hittingCooldown then return end
    _0xC5.hittingCooldown = true
    pcall(function()
        local char = _0x70.Character
        if char then
            local bat = getBat()
            if bat then
                if bat.Parent ~= char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then pcall(function() hum:EquipTool(bat) end) end
                end
                pcall(function() bat:Activate() end)
                if _0x92.BatCounter then
                    _0xC5.batHitsCount = _0xC5.batHitsCount + 1
                end
            end
        end
    end)
    task.delay(_SWING_CD, function() _0xC5.hittingCooldown = false end)
end

local function getClosest()
    local char = _0x70.Character; if not char then return nil, math.huge end
    local rootPart = char:FindFirstChild("HumanoidRootPart"); if not rootPart then return nil, math.huge end
    local closest, dist = nil, math.huge
    for _, p in ipairs(_0x2b:GetPlayers()) do
        if p ~= _0x70 and p.Character then
            local tr = p.Character:FindFirstChild("HumanoidRootPart")
            local ph = p.Character:FindFirstChildOfClass("Humanoid")
            if tr and ph and ph.Health > 0 then
                local d = (rootPart.Position - tr.Position).Magnitude
                if d < dist then dist = d; closest = p end
            end
        end
    end
    return closest, dist
end

local function startAimbot()
    if _aimConn then return end
    local hum = _0x70.Character and _0x70.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        if _prevAR == nil then _prevAR = hum.AutoRotate end
        hum.AutoRotate = false
    end
    _aimConn = _0x3c.RenderStepped:Connect(function()
        if not _0x92.AimbotToggled and not _0x92.AimbotV2 then return end
        local char = _0x70.Character; if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart"); if not root then return end
        local hum = char:FindFirstChildOfClass("Humanoid"); if not hum then return end
        if not char:FindFirstChildOfClass("Tool") then
            local bat = getBat()
            if bat then pcall(function() hum:EquipTool(bat) end) end
        end
        local targetPlr, targetDist = getClosest()
        if not targetPlr or not targetPlr.Character then return end
        local target = targetPlr.Character:FindFirstChild("HumanoidRootPart")
        if not target then return end

        if _0x92.AimbotV2 then
            pcall(function()
                if sethiddenproperty then
                    sethiddenproperty(root, "PhysicsRepRootPart", target)
                end
            end)
            local targetPos = target.Position + Vector3.new(0, 0.9, 0)
            if (root.Position - targetPos).Magnitude > 8 then
                pcall(function() root.CFrame = CFrame.new(targetPos) end)
            end
            pcall(function()
                local cam = workspace.CurrentCamera
                cam.CFrame = CFrame.new(cam.CFrame.Position, target.Position)
            end)
        end

        local targetVel = target.AssemblyLinearVelocity
        local myPos = root.Position
        local targetPos = target.Position
        local predictPos = targetPos + targetVel * 0.14 + target.CFrame.LookVector * 0.3
        local direction = predictPos - myPos
        local flatDir = Vector3.new(direction.X, 0, direction.Z)
        if flatDir.Magnitude > 0 then flatDir = flatDir.Unit else flatDir = Vector3.new(0,0,0) end
        local desiredHeight = targetPos.Y + 3.7
        local yVel = (desiredHeight - myPos.Y) * 19.5 + targetVel.Y * 0.8
        if hum.FloorMaterial ~= Enum.Material.Air then yVel = math.max(yVel, 13) end
        yVel = math.clamp(yVel, -70, 110)
        local currentSpeed = _0x92.AimbotV2Speed or 58
        local desiredVel = Vector3.new(flatDir.X * currentSpeed, yVel, flatDir.Z * currentSpeed)
        pcall(function() root.AssemblyLinearVelocity = root.AssemblyLinearVelocity:Lerp(desiredVel, 0.8) end)
        if targetDist <= _HIT_DIST then trySwing() end
    end)
end

local function stopAimbot()
    if _0x92.AimbotToggled or _0x92.AimbotV2 then return end
    if _aimConn then _aimConn:Disconnect(); _aimConn = nil end
    local char = _0x70.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.AutoRotate = (_prevAR == nil) and true or _prevAR
        hum.PlatformStand = false
        pcall(function() hum:ChangeState(Enum.HumanoidStateType.GettingUp) end)
    end
    if root then
        pcall(function()
            root.AssemblyLinearVelocity = Vector3.new(0, root.AssemblyLinearVelocity.Y * 0.3, 0)
            root.AssemblyAngularVelocity = Vector3.zero
        end)
    end
    _prevAR = nil
end

_0x70.CharacterAdded:Connect(function(char)
    _prevAR = nil
    task.wait(0.1)
    _h = char:WaitForChild("Humanoid", 5)
    _hrp = char:WaitForChild("HumanoidRootPart", 5)
    if _0x92.AimbotToggled or _0x92.AimbotV2 then startAimbot() end
end)

local function setAimbot(on)
    _0x92.AimbotToggled = on
    aimBtn.BackgroundColor3 = on and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(0, 50, 130)
    aimBtn.TextColor3 = on and Color3.fromRGB(0, 30, 80) or Color3.fromRGB(255, 215, 0)
    if on then startAimbot() else stopAimbot() end
    _0xB4()
end

aimBtn.MouseButton1Click:Connect(function()
    setAimbot(not _0x92.AimbotToggled)
end)

local function setAimbotV2(on)
    _0x92.AimbotV2 = on
    aimv2Btn.BackgroundColor3 = on and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(0, 50, 130)
    aimv2Btn.TextColor3 = on and Color3.fromRGB(0, 30, 80) or Color3.fromRGB(255, 215, 0)
    if on then startAimbot() else stopAimbot() end
    _0xB4()
end

aimv2Btn.MouseButton1Click:Connect(function()
    setAimbotV2(not _0x92.AimbotV2)
end)

if _0x92.AimbotToggled or _0x92.AimbotV2 then startAimbot() end

local function tryHitBat()
    if _0xC5.hittingCooldown then return end; _0xC5.hittingCooldown = true
    pcall(function()
        local bat = getBat()
        if bat then
            bat:Activate()
            local ev = bat:FindFirstChildWhichIsA("RemoteEvent")
            if ev then ev:FireServer() end
            if _0x92.BatCounter then _0xC5.batHitsCount = _0xC5.batHitsCount + 1 end
        end
    end)
    local hitDelay = math.clamp(1 / math.max(_0x92.AntiBatSpeed, 1), 0.01, 1)
    task.delay(hitDelay, function() _0xC5.hittingCooldown = false end)
end

_0x3c.Heartbeat:Connect(function()
    if _0x92.AntiBatToggled and _h and _hrp then
        local target, dist = getClosest()
        if target and target.Character then
            local tr = target.Character:FindFirstChild("HumanoidRootPart")
            if tr then
                pcall(function()
                    if sethiddenproperty then sethiddenproperty(_hrp, "PhysicsRepRootPart", tr) end
                end)
                local targetPos = tr.Position + Vector3.new(0, 0.9, 0)
                if (_hrp.Position - targetPos).Magnitude > 8 then
                    pcall(function() _hrp.CFrame = CFrame.new(targetPos) end)
                end
                pcall(function()
                    local cam = workspace.CurrentCamera
                    cam.CFrame = CFrame.new(cam.CFrame.Position, tr.Position)
                end)
                tryHitBat()
                if _0x92.MedusaCounter then _0xC5.medusaHitsCount = _0xC5.medusaHitsCount + 0.05 end
            end
        end
    end
end)

print("[ATT11 HUB] Secure Full Script Loaded Successfully!")
