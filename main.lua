-- ATT11 HUB - Auto Jump Script
local Players = game:Service("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:Service("UserInputService")
local RunService = game:Service("RunService")

-- إنشاء واجهة المستخدم (GUI)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local ToggleButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")

ScreenGui.Parent = game:CoreGui
ScreenGui.Name = "ATT11_Hub"

-- تصميم القائمة الرئيسية (باللون الأسود الداكن والأزرق)
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- أسود
MainFrame.BorderColor3 = Color3.fromRGB(0, 120, 255) -- إطار أزرق
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -75) -- في منتصف الشاشة
MainFrame.Size = UDim2.new(0, 200, 0, 150)
MainFrame.Active = true
MainFrame.Draggable = true -- إمكانية سحب القائمة

-- العنوان (ATT11)
TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundColor3 = Color3.fromRGB(0, 120, 255) -- خلفية زرقاء للنص
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "ATT11 HUB"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 14

-- زر التفعيل (Toggle Button)
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = MainFrame
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.BorderColor3 = Color3.fromRGB(0, 120, 255)
ToggleButton.Position = UDim2.new(0.1, 0, 0.35, 0)
ToggleButton.Size = UDim2.new(0.8, 0, 0, 40)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "Auto Jump: OFF"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 12

-- زر الإغلاق
CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseButton.Position = UDim2.new(0.85, 0, 0, 3)
CloseButton.Size = UDim2.new(0, 24, 0, 24)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 12

-- برمجة واجهة التشغيل والقفز التلقائي (قوة قفز 43 وبدون سرعة زائدة)
local autoJumpEnabled = false

ToggleButton.MouseButton1Click:Connect(function()
    autoJumpEnabled = not autoJumpEnabled
    if autoJumpEnabled then
        ToggleButton.Text = "Auto Jump: ON"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255) -- يتحول للأزرق عند التفعيل
    else
        ToggleButton.Text = "Auto Jump: OFF"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- حلقة التكرار للقفز التلقائي الآمن (Anti-Lag)
RunService.RenderStepped:Connect(function()
    if autoJumpEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local humanoid = LocalPlayer.Character.Humanoid
        humanoid.JumpPower = 43 -- قوة القفز المخصصة
        if humanoid.FloorMaterial ~= Enum.Material.Air then
            humanoid.Jump = true
        end
    end
end)

