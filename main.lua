local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local LP = Players.LocalPlayer

local FileName = "ATT11Hub_Settings.json"

-- // STATE & CONFIG
local Config = {
    AntiBatSpeed = 60,
    BatCounter = false,
    MedusaCounter = false,
    AntiBatWindowVisible = true,
    AntiBatToggled = false,
    AimbotWindowVisible = true,
    AimbotToggled = false,
    Option8 = false,
    Option9 = false,
}

local function LoadConfig()
    pcall(function()
        if readfile and isfile and isfile(FileName) then
            local result = HttpService:JSONDecode(readfile(FileName))
            if type(result) == "table" then
                for k, v in pairs(result) do Config[k] = v end
            end
        end
    end)
end

local function SaveConfig()
    pcall(function()
        if writefile then
            writefile(FileName, HttpService:JSONEncode(Config))
        end
    end)
end

LoadConfig()

local AntiBatState = {
    hittingCooldown = false,
    guiVisible = true,
}

local h, hrp = nil, nil

-- // CLEANUP OLD GUI
for _, name in pairs({"AxonAutoBatDesyncGUI", "EnvyAutoBatDesyncGUI", "MwvaneNewaBatDesyncGUI", "PhazeAutoBatDesyncGUI", "ATT11Hub_SettingsGui"}) do
    local old = game:GetService("CoreGui"):FindFirstChild(name)
    if old then old:Destroy() end
    local oldPlayerGui = LP.PlayerGui:FindFirstChild(name)
    if oldPlayerGui then oldPlayerGui:Destroy() end
end

-- // GUI SETUP
local gui = Instance.new("ScreenGui")
gui.Name = "ATT11Hub_SettingsGui"
gui.ResetOnSpawn = false
gui.DisplayOrder = 10
gui.IgnoreGuiInset = true
gui.Parent = LP:WaitForChild("PlayerGui")

local OpenButton = Instance.new("TextButton", gui)
OpenButton.Name = "OpenButton"
OpenButton.BackgroundColor3 = Color3.fromRGB(0, 30, 80)
OpenButton.Position = UDim2.new(0, 10, 0.5, -14)
OpenButton.Size = UDim2.new(0, 110, 0, 28)
OpenButton.Font = Enum.Font.GothamBlack
OpenButton.Text = "ATT11 HUB"
OpenButton.TextColor3 = Color3.fromRGB(255, 215, 0)
OpenButton.TextSize = 10
OpenButton.Visible = false
Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(0, 5)
local openStroke = Instance.new("UIStroke", OpenButton)
openStroke.Color = Color3.fromRGB(255, 200, 0)
openStroke.Thickness = 1

-- ==================== [ القائمة الرئيسية ] ====================
local main = Instance.new("Frame", gui)
main.Name = "Main"
main.Size = UDim2.new(0, 300, 0, 250)
main.Position = UDim2.new(0.5, -150, 0.5, -125)
main.BackgroundColor3 = Color3.fromRGB(0, 30, 80)
main.BorderSizePixel = 0
main.Active = true
main.ClipsDescendants = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
local mainStroke = Instance.new("UIStroke", main)
mainStroke.Color = Color3.fromRGB(0, 100, 200)
mainStroke.Thickness = 1

do
    local dragging, dragInput, dragStart, mainStart = false, nil, nil, nil
    main.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = inp.Position; mainStart = main.Position
            inp.Changed:Connect(function()
                if inp.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    main.InputChanged:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then dragInput = inp end
    end)
    UIS.InputChanged:Connect(function(inp)
        if inp == dragInput and dragging then
            local dx = inp.Position.X - dragStart.X
            local dy = inp.Position.Y - dragStart.Y
            main.Position = UDim2.new(mainStart.X.Scale, mainStart.X.Offset + dx, mainStart.Y.Scale, mainStart.Y.Offset + dy)
        end
    end)
end

local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 36)
header.BackgroundColor3 = Color3.fromRGB(0, 20, 60)
header.BorderSizePixel = 0
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 10)

local headerIcon = Instance.new("Frame", header)
headerIcon.Size = UDim2.new(0, 24, 0, 24)
headerIcon.Position = UDim2.new(0, 8, 0.5, -12)
headerIcon.BackgroundColor3 = Color3.fromRGB(0, 40, 100)
headerIcon.BorderSizePixel = 0
Instance.new("UICorner", headerIcon).CornerRadius = UDim.new(0, 5)
local iconStroke = Instance.new("UIStroke", headerIcon)
iconStroke.Color = Color3.fromRGB(255, 200, 0)
iconStroke.Thickness = 1

local iconLbl = Instance.new("TextLabel", headerIcon)
iconLbl.Size = UDim2.new(1, 0, 1, 0)
iconLbl.BackgroundTransparency = 1
iconLbl.Text = "🥷"
iconLbl.TextSize = 12

local titleLbl = Instance.new("TextLabel", header)
titleLbl.Size = UDim2.new(1, -50, 1, 0)
titleLbl.Position = UDim2.new(0, 38, 0, 0)
titleLbl.BackgroundTransparency = 1
titleLbl.Text = "ATT11 HUB"
titleLbl.TextColor3 = Color3.fromRGB(255, 215, 0)
titleLbl.Font = Enum.Font.GothamBlack
titleLbl.TextSize = 11
titleLbl.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 22, 0, 22)
closeBtn.Position = UDim2.new(1, -28, 0.5, -11)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBlack
closeBtn.TextSize = 10
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 5)

closeBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    OpenButton.Visible = true
end)

OpenButton.MouseButton1Click:Connect(function()
    main.Visible = true
    OpenButton.Visible = false
end)

local scrollFrame = Instance.new("ScrollingFrame", main)
scrollFrame.Name = "ScrollFrame"
scrollFrame.Size = UDim2.new(1, 0, 1, -36)
scrollFrame.Position = UDim2.new(0, 0, 0, 36)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 300)
scrollFrame.ScrollBarThickness = 3
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 100, 200)

-- الخيار الأول: السرعة
local antiBatRowMain = Instance.new("Frame", scrollFrame)
antiBatRowMain.Name = "AntiBatRow"
antiBatRowMain.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
antiBatRowMain.Position = UDim2.new(0.04, 0, 0, 8)
antiBatRowMain.Size = UDim2.new(0.92, 0, 0, 32)
Instance.new("UICorner", antiBatRowMain).CornerRadius = UDim.new(0, 5)

local antiBatLabel = Instance.new("TextLabel", antiBatRowMain)
antiBatLabel.Size = UDim2.new(0.7, 0, 1, 0)
antiBatLabel.Position = UDim2.new(0, 8, 0, 0)
antiBatLabel.BackgroundTransparency = 1
antiBatLabel.Font = Enum.Font.GothamBold
antiBatLabel.Text = "ANTI BAT/SPEED :"
antiBatLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
antiBatLabel.TextSize = 10
antiBatLabel.TextXAlignment = Enum.TextXAlignment.Left

local antiBatBox = Instance.new("TextBox", antiBatRowMain)
antiBatBox.Size = UDim2.new(0, 42, 0, 22)
antiBatBox.Position = UDim2.new(1, -48, 0.5, -11)
antiBatBox.BackgroundColor3 = Color3.fromRGB(0, 50, 130)
antiBatBox.Font = Enum.Font.GothamBold
antiBatBox.Text = tostring(Config.AntiBatSpeed)
antiBatBox.TextColor3 = Color3.fromRGB(255, 215, 0)
antiBatBox.TextSize = 11
antiBatBox.ClearTextOnFocus = false
Instance.new("UICorner", antiBatBox).CornerRadius = UDim.new(0, 5)
local antiBoxStroke = Instance.new("UIStroke", antiBatBox)
antiBoxStroke.Color = Color3.fromRGB(255, 200, 0)
antiBoxStroke.Thickness = 1

antiBatBox.FocusLost:Connect(function()
    local num = tonumber(antiBatBox.Text)
    if num then Config.AntiBatSpeed = num else antiBatBox.Text = tostring(Config.AntiBatSpeed) end
    SaveConfig()
end)

-- دالة إنشاء صفوف التفعيل القياسية
local function CreateToggleRow(name, yPos, configKey, labelText)
    local row = Instance.new("Frame", scrollFrame)
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
    lbl.Text = labelText .. " :"
    lbl.TextColor3 = Color3.fromRGB(255, 215, 0)
    lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local pBg = Instance.new("Frame", row)
    pBg.Size = UDim2.new(0, 30, 0, 18)
    pBg.Position = UDim2.new(1, -34, 0.5, -9)
    pBg.BackgroundColor3 = Config[configKey] and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(0, 30, 80)
    pBg.BorderSizePixel = 0
    pBg.ZIndex = 8
    Instance.new("UICorner", pBg).CornerRadius = UDim.new(0, 9)
    local pStr = Instance.new("UIStroke", pBg)
    pStr.Color = Color3.fromRGB(255, 200, 0)
    pStr.Thickness = 1

    local dDot = Instance.new("Frame", pBg)
    dDot.Size = UDim2.new(0, 12, 0, 12)
    dDot.Position = Config[configKey] and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6)
    dDot.BackgroundColor3 = Config[configKey] and Color3.fromRGB(0, 30, 80) or Color3.fromRGB(0, 60, 150)
    dDot.BorderSizePixel = 0
    dDot.ZIndex = 9
    Instance.new("UICorner", dDot).CornerRadius = UDim.new(0, 4)

    local tBtn = Instance.new("TextButton", pBg)
    tBtn.Size = UDim2.new(1, 0, 1, 0)
    tBtn.BackgroundTransparency = 1
    tBtn.Text = ""
    tBtn.ZIndex = 10

    return row, pBg, pStr, dDot, tBtn
end

CreateToggleRow("BatCounterRow", 46, "BatCounter", "BAT COUNTER")
CreateToggleRow("MedusaCounterRow", 84, "MedusaCounter", "MEDUSA COUNTER")


-- ==================== [ النافذة العائمة الأولى: ANTI BAT - ATT11 HUB ] ====================
local floatingMain = Instance.new("Frame", gui)
floatingMain.Name = "FloatingAntiBat"
floatingMain.Size = UDim2.new(0, 130, 0, 75)
floatingMain.Position = UDim2.new(0, 15, 0.18, 0)
floatingMain.BackgroundColor3 = Color3.fromRGB(0, 30, 80)
floatingMain.BorderSizePixel = 0
floatingMain.Active = true
floatingMain.Visible = Config.AntiBatWindowVisible
Instance.new("UICorner", floatingMain).CornerRadius = UDim.new(0, 8)
local floatStroke = Instance.new("UIStroke", floatingMain)
floatStroke.Color = Color3.fromRGB(0, 100, 200)
floatStroke.Thickness = 1

do
    local dragging, dragInput, dragStart, mainStart = false, nil, nil, nil
    floatingMain.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = inp.Position; mainStart = floatingMain.Position
            inp.Changed:Connect(function()
                if inp.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    floatingMain.InputChanged:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then dragInput = inp end
    end)
    UIS.InputChanged:Connect(function(inp)
        if inp == dragInput and dragging then
            local dx = inp.Position.X - dragStart.X
            local dy = inp.Position.Y - dragStart.Y
            floatingMain.Position = UDim2.new(mainStart.X.Scale, mainStart.X.Offset + dx, mainStart.Y.Scale, mainStart.Y.Offset + dy)
        end
    end)
end

local floatHeader = Instance.new("Frame", floatingMain)
floatHeader.Size = UDim2.new(1, 0, 0, 24)
floatHeader.BackgroundColor3 = Color3.fromRGB(0, 20, 60)
floatHeader.BorderSizePixel = 0
Instance.new("UICorner", floatHeader).CornerRadius = UDim.new(0, 8)

local floatTitle = Instance.new("TextLabel", floatHeader)
floatTitle.Size = UDim2.new(1, -8, 1, 0)
floatTitle.Position = UDim2.new(0, 6, 0, 0)
floatTitle.BackgroundTransparency = 1
floatTitle.Text = "ANTI BAT - ATT11 HUB"
floatTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
floatTitle.Font = Enum.Font.GothamBlack
floatTitle.TextSize = 7
floatTitle.TextXAlignment = Enum.TextXAlignment.Left

local floatDivider = Instance.new("Frame", floatHeader)
floatDivider.Size = UDim2.new(1, 0, 0, 1)
floatDivider.Position = UDim2.new(0, 0, 1, -1)
floatDivider.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
floatDivider.BorderSizePixel = 0

local floatContent = Instance.new("Frame", floatingMain)
floatContent.Size = UDim2.new(1, -12, 1, -30)
floatContent.Position = UDim2.new(0, 6, 0, 27)
floatContent.BackgroundTransparency = 1

local innerFloatingBtn = Instance.new("TextButton", floatContent)
innerFloatingBtn.Size = UDim2.new(1, 0, 1, 0)
innerFloatingBtn.BackgroundColor3 = Config.AntiBatToggled and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(0, 50, 130)
innerFloatingBtn.BorderSizePixel = 0
innerFloatingBtn.Text = "ANTI BAT"
innerFloatingBtn.TextColor3 = Config.AntiBatToggled and Color3.fromRGB(0, 30, 80) or Color3.fromRGB(255, 215, 0)
innerFloatingBtn.Font = Enum.Font.GothamBold
innerFloatingBtn.TextSize = 9
Instance.new("UICorner", innerFloatingBtn).CornerRadius = UDim.new(0, 5)
local innerStroke = Instance.new("UIStroke", innerFloatingBtn)
innerStroke.Color = Color3.fromRGB(0, 100, 200)
innerStroke.Thickness = 1

local function updateAntiBatFeature(on)
    Config.AntiBatToggled = on
    innerFloatingBtn.BackgroundColor3 = on and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(0, 50, 130)
    innerFloatingBtn.TextColor3 = on and Color3.fromRGB(0, 30, 80) or Color3.fromRGB(255, 215, 0)
    SaveConfig()
end

innerFloatingBtn.MouseButton1Click:Connect(function()
    updateAntiBatFeature(not Config.AntiBatToggled)
end)


-- ==================== [ النافذة العائمة الثانية: AIMBOT V1 - ATT11 HUB ] ====================
local aimbotFloatingMain = Instance.new("Frame", gui)
aimbotFloatingMain.Name = "FloatingAimbot"
aimbotFloatingMain.Size = UDim2.new(0, 130, 0, 75)
aimbotFloatingMain.Position = UDim2.new(0, 15, 0.31, 0)
aimbotFloatingMain.BackgroundColor3 = Color3.fromRGB(0, 30, 80)
aimbotFloatingMain.BorderSizePixel = 0
aimbotFloatingMain.Active = true
aimbotFloatingMain.Visible = Config.AimbotWindowVisible
Instance.new("UICorner", aimbotFloatingMain).CornerRadius = UDim.new(0, 8)
local aimbotFloatStroke = Instance.new("UIStroke", aimbotFloatingMain)
aimbotFloatStroke.Color = Color3.fromRGB(0, 100, 200)
aimbotFloatStroke.Thickness = 1

do
    local dragging, dragInput, dragStart, mainStart = false, nil, nil, nil
    aimbotFloatingMain.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = inp.Position; mainStart = aimbotFloatingMain.Position
            inp.Changed:Connect(function()
                if inp.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    aimbotFloatingMain.InputChanged:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then dragInput = inp end
    end)
    UIS.InputChanged:Connect(function(inp)
        if inp == dragInput and dragging then
            local dx = inp.Position.X - dragStart.X
            local dy = inp.Position.Y - dragStart.Y
            aimbotFloatingMain.Position = UDim2.new(mainStart.X.Scale, mainStart.X.Offset + dx, mainStart.Y.Scale, mainStart.Y.Offset + dy)
        end
    end)
end

local aimbotFloatHeader = Instance.new("Frame", aimbotFloatingMain)
aimbotFloatHeader.Size = UDim2.new(1, 0, 0, 24)
aimbotFloatHeader.BackgroundColor3 = Color3.fromRGB(0, 20, 60)
aimbotFloatHeader.BorderSizePixel = 0
Instance.new("UICorner", aimbotFloatHeader).CornerRadius = UDim.new(0, 8)

local aimbotFloatTitle = Instance.new("TextLabel", aimbotFloatHeader)
aimbotFloatTitle.Size = UDim2.new(1, -8, 1, 0)
aimbotFloatTitle.Position = UDim2.new(0, 6, 0, 0)
aimbotFloatTitle.BackgroundTransparency = 1
aimbotFloatTitle.Text = "AIMBOT V1 - ATT11 HUB"
aimbotFloatTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
aimbotFloatTitle.Font = Enum.Font.GothamBlack
aimbotFloatTitle.TextSize = 7
aimbotFloatTitle.TextXAlignment = Enum.TextXAlignment.Left

local aimbotFloatDivider = Instance.new("Frame", aimbotFloatHeader)
aimbotFloatDivider.Size = UDim2.new(1, 0, 0, 1)
aimbotFloatDivider.Position = UDim2.new(0, 0, 1, -1)
aimbotFloatDivider.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
aimbotFloatDivider.BorderSizePixel = 0

local aimbotFloatContent = Instance.new("Frame", aimbotFloatingMain)
aimbotFloatContent.Size = UDim2.new(1, -12, 1, -30)
aimbotFloatContent.Position = UDim2.new(0, 6, 0, 27)
aimbotFloatContent.BackgroundTransparency = 1

local aimbotInnerBtn = Instance.new("TextButton", aimbotFloatContent)
aimbotInnerBtn.Size = UDim2.new(1, 0, 1, 0)
aimbotInnerBtn.BackgroundColor3 = Config.AimbotToggled and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(0, 50, 130)
aimbotInnerBtn.BorderSizePixel = 0
aimbotInnerBtn.Text = "AIMBOT"
aimbotInnerBtn.TextColor3 = Config.AimbotToggled and Color3.fromRGB(0, 30, 80) or Color3.fromRGB(255, 215, 0)
aimbotInnerBtn.Font = Enum.Font.GothamBold
aimbotInnerBtn.TextSize = 9
Instance.new("UICorner", aimbotInnerBtn).CornerRadius = UDim.new(0, 5)
local aimbotInnerStroke = Instance.new("UIStroke", aimbotInnerBtn)
aimbotInnerStroke.Color = Color3.fromRGB(0, 100, 200)
aimbotInnerStroke.Thickness = 1


-- ==================== [ الخيار الرابع: إظهار/إخفاء نافذة Anti Bat ] ====================
local windowRow, windowPill, windowPStr, windowDot, windowTBtn = CreateToggleRow("AntiBatWindowRow", 122, "AntiBatWindowVisible", "ANTI BAT")

local function updateWindowVisibility(visible)
    Config.AntiBatWindowVisible = visible
    floatingMain.Visible = visible
    
    TweenService:Create(windowPill, TweenInfo.new(0.18), {BackgroundColor3 = visible and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(0, 30, 80)}):Play()
    TweenService:Create(windowPStr, TweenInfo.new(0.18), {Color = visible and Color3.fromRGB(255, 235, 59) or Color3.fromRGB(255, 200, 0)}):Play()
    TweenService:Create(windowDot, TweenInfo.new(0.18, Enum.EasingStyle.Back), {
        Position = visible and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6),
        BackgroundColor3 = visible and Color3.fromRGB(0, 30, 80) or Color3.fromRGB(0, 60, 150)
    }):Play()
    SaveConfig()
end

windowTBtn.MouseButton1Click:Connect(function()
    updateWindowVisibility(not Config.AntiBatWindowVisible)
end)


-- ==================== [ الخيار الخامس: إظهار/إخفاء نافذة AIMBOT ] ====================
local aimbotRow, aimbotPill, aimbotPStr, aimbotDot, aimbotTBtn = CreateToggleRow("AimbotWindowRow", 160, "AimbotWindowVisible", "AIMBOT")

local function updateAimbotWindowVisibility(visible)
    Config.AimbotWindowVisible = visible
    aimbotFloatingMain.Visible = visible
    
    TweenService:Create(aimbotPill, TweenInfo.new(0.18), {BackgroundColor3 = visible and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(0, 30, 80)}):Play()
    TweenService:Create(aimbotPStr, TweenInfo.new(0.18), {Color = visible and Color3.fromRGB(255, 235, 59) or Color3.fromRGB(255, 200, 0)}):Play()
    TweenService:Create(aimbotDot, TweenInfo.new(0.18, Enum.EasingStyle.Back), {
        Position = visible and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6),
        BackgroundColor3 = visible and Color3.fromRGB(0, 30, 80) or Color3.fromRGB(0, 60, 150)
    }):Play()
    SaveConfig()
end

aimbotTBtn.MouseButton1Click:Connect(function()
    updateAimbotWindowVisibility(not Config.AimbotWindowVisible)
end)


-- الأزرار المتبقية في الأسفل (8, 9)
local function CreateBlankButton(name, yPos, configKey)
    local Btn = Instance.new("TextButton", scrollFrame)
    Btn.Name = name
    Btn.BackgroundColor3 = Config[configKey] and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(35, 35, 35)
    Btn.Position = UDim2.new(0.04, 0, 0, yPos)
    Btn.Size = UDim2.new(0.92, 0, 0, 32)
    Btn.Font = Enum.Font.GothamBold
    Btn.Text = ""
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextSize = 11
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 5)

    Btn.MouseButton1Click:Connect(function()
        Config[configKey] = not Config[configKey]
        Btn.BackgroundColor3 = Config[configKey] and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(35, 35, 35)
        SaveConfig()
    end)
end

CreateBlankButton("Btn8", 198, "Option8")
CreateBlankButton("Btn9", 236, "Option9")


-- ==================== [ منطق الـ Bat Aimbot المتقدم المدمج ] ====================
local BAT_SLAP_LIST = { "Bat", "Slap", "Iron Slap", "Gold Slap", "Diamond Slap", "Emerald Slap", "Ruby Slap", "Dark Matter Slap", "Flame Slap", "Nuclear Slap", "Galaxy Slap", "Glitched Slap" }
local HIT_DIST = 8
local SWING_CD = 0.35
local hittingCooldown = false
local aimbotConn = nil
local prevAutoRotate = nil

local function getBat()
    local char = LP.Character; if not char then return nil end
    for _, name in ipairs(BAT_SLAP_LIST) do
        local t = char:FindFirstChild(name)
        if t and t:IsA("Tool") then return t end
    end
    local bp = LP:FindFirstChildOfClass("Backpack")
    if bp then
        for _, name in ipairs(BAT_SLAP_LIST) do
            local t = bp:FindFirstChild(name)
            if t and t:IsA("Tool") then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then pcall(function() hum:EquipTool(t) end) end
                return t
            end
        end
    end
    for _, ch in ipairs(char:GetChildren()) do
        if ch:IsA("Tool") and (ch.Name:lower():find("bat") or ch.Name:lower():find("slap")) then return ch end
    end
    if bp then
        for _, ch in ipairs(bp:GetChildren()) do
            if ch:IsA("Tool") and (ch.Name:lower():find("bat") or ch.Name:lower():find("slap")) then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then pcall(function() hum:EquipTool(ch) end) end
                return ch
            end
        end
    end
    return nil
end

local function trySwing()
    if hittingCooldown then return end
    hittingCooldown = true
    pcall(function()
        local char = LP.Character
        if char then
            local bat = getBat()
            if bat then
                if bat.Parent ~= char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then pcall(function() hum:EquipTool(bat) end) end
                end
                pcall(function() bat:Activate() end)
            end
        end
    end)
    task.delay(SWING_CD, function() hittingCooldown = false end)
end

local function getClosestPlayer()
    local char = LP.Character; if not char then return nil, math.huge end
    local rootPart = char:FindFirstChild("HumanoidRootPart"); if not rootPart then return nil, math.huge end
    local closest, dist = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
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
    if aimbotConn then return end
    local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        if prevAutoRotate == nil then prevAutoRotate = hum.AutoRotate end
        hum.AutoRotate = false
    end
    aimbotConn = RunService.RenderStepped:Connect(function()
        if not Config.AimbotToggled then return end
        local char = LP.Character; if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart"); if not root then return end
        local hum = char:FindFirstChildOfClass("Humanoid"); if not hum then return end
        if not char:FindFirstChildOfClass("Tool") then
            local bat = getBat()
            if bat then pcall(function() hum:EquipTool(bat) end) end
        end
        local targetPlr, targetDist = getClosestPlayer()
        if not targetPlr or not targetPlr.Character then return end
        local target = targetPlr.Character:FindFirstChild("HumanoidRootPart")
        if not target then return end
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
        local desiredVel = Vector3.new(flatDir.X * 58, yVel, flatDir.Z * 58)
        root.AssemblyLinearVelocity = root.AssemblyLinearVelocity:Lerp(desiredVel, 0.8)
        local speed3 = targetVel.Magnitude
        local predictTime = math.clamp(speed3 / 150, 0.05, 0.2)
        local predictedPos = targetPos + targetVel * predictTime
        local toPredict = predictedPos - myPos
        if toPredict.Magnitude > 0.1 then
            local goalCF = CFrame.lookAt(myPos, predictedPos)
            local diffCF = root.CFrame:Inverse() * goalCF
            local rx, ry, rz = diffCF:ToEulerAnglesXYZ()
            rx = math.clamp(rx, -2.5, 2.5); ry = math.clamp(ry, -2.5, 2.5); rz = math.clamp(rz, -2.5, 2.5)
            root.AssemblyAngularVelocity = root.CFrame:VectorToWorldSpace(Vector3.new(rx * 42, ry * 42, rz * 42))
        end
        if targetDist <= HIT_DIST then trySwing() end
    end)
end

local function stopAimbot()
    if aimbotConn then aimbotConn:Disconnect(); aimbotConn = nil end
    local char = LP.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.AutoRotate = (prevAutoRotate == nil) and true or prevAutoRotate
        hum.PlatformStand = false
        pcall(function() hum:ChangeState(Enum.HumanoidStateType.GettingUp) end)
    end
    if root then
        root.AssemblyLinearVelocity = Vector3.new(0, root.AssemblyLinearVelocity.Y * 0.3, 0)
        root.AssemblyAngularVelocity = Vector3.zero
    end
    prevAutoRotate = nil
end

LP.CharacterAdded:Connect(function(char)
    prevAutoRotate = nil
    task.wait(0.1)
    h = char:WaitForChild("Humanoid", 5)
    hrp = char:WaitForChild("HumanoidRootPart", 5)
    if Config.AimbotToggled then
        startAimbot()
    end
end)

if LP.Character then 
    task.spawn(function() 
        h = LP.Character:FindFirstChildOfClass("Humanoid")
        hrp = LP.Character:FindFirstChild("HumanoidRootPart")
    end) 
end

local function updateAimbotFeature(on)
    Config.AimbotToggled = on
    aimbotInnerBtn.BackgroundColor3 = on and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(0, 50, 130)
    aimbotInnerBtn.TextColor3 = on and Color3.fromRGB(0, 30, 80) or Color3.fromRGB(255, 215, 0)
    if on then
        startAimbot()
    else
        stopAimbot()
    end
    SaveConfig()
end

aimbotInnerBtn.MouseButton1Click:Connect(function()
    updateAimbotFeature(not Config.AimbotToggled)
end)

-- التشغيل التلقائي إذا كان مفعلاً مسبقاً في الإعدادات
if Config.AimbotToggled then
    startAimbot()
end


-- // منطق الـ Anti Bat الأصلي
local function tryHitBat()
    if AntiBatState.hittingCooldown then return end; AntiBatState.hittingCooldown = true
    pcall(function()
        local bat = getBat()
        if bat then
            bat:Activate()
            local ev = bat:FindFirstChildWhichIsA("RemoteEvent")
            if ev then ev:FireServer() end
        end
    end)
    local hitDelay = math.clamp(1 / math.max(Config.AntiBatSpeed, 1), 0.01, 1)
    task.delay(hitDelay, function() AntiBatState.hittingCooldown = false end)
end

RunService.Heartbeat:Connect(function()
    -- Anti Bat Logic
    if Config.AntiBatToggled and h and hrp then
        local target, dist = getClosestPlayer()
        if target and target.Character then
            local tr = target.Character:FindFirstChild("HumanoidRootPart")
            if tr then
                if sethiddenproperty then
                    sethiddenproperty(hrp, "PhysicsRepRootPart", tr)
                end
                local targetPos = tr.Position + Vector3.new(0, 0.9, 0)
                if (hrp.Position - targetPos).Magnitude > 8 then
                    hrp.CFrame = CFrame.new(targetPos)
                end
                local cam = workspace.CurrentCamera
                cam.CFrame = CFrame.new(cam.CFrame.Position, tr.Position)
                tryHitBat()
            end
        end
    end
end)

print("[ATT11 HUB] Loaded Successfully with Advanced Bat Aimbot Integrated!")
