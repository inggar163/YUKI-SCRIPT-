-- Yuki Save Location
-- Khusus Mobile / HP
-- Tombol: Save & Back

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Variabel simpan posisi
local SavedPosition = nil

-- Buat UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "YukiSaveLocation"
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Kotak Utama
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 220, 0, 140)
MainFrame.Position = UDim2.new(0.02, 0, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Sudut membulat
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 8)
Corner.Parent = MainFrame

-- Judul
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.BorderSizePixel = 0
Title.Text = "Yuki Save Location"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = Title

-- Tombol Save
local SaveBtn = Instance.new("TextButton")
SaveBtn.Name = "SaveBtn"
SaveBtn.Size = UDim2.new(0.8, 0, 0, 40)
SaveBtn.Position = UDim2.new(0.1, 0, 0.4, 0)
SaveBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
SaveBtn.BorderSizePixel = 0
SaveBtn.Text = "SAVE LOCATION"
SaveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SaveBtn.Font = Enum.Font.Gotham
SaveBtn.TextSize = 14
SaveBtn.AutoButtonColor = false
SaveBtn.Parent = MainFrame

local SaveCorner = Instance.new("UICorner")
SaveCorner.CornerRadius = UDim.new(0, 6)
SaveCorner.Parent = SaveBtn

-- Tombol Back
local BackBtn = Instance.new("TextButton")
BackBtn.Name = "BackBtn"
BackBtn.Size = UDim2.new(0.8, 0, 0, 40)
BackBtn.Position = UDim2.new(0.1, 0, 0.75, 0)
BackBtn.BackgroundColor3 = Color3.fromRGB(180, 70, 70)
BackBtn.BorderSizePixel = 0
BackBtn.Text = "BACK TO LOCATION"
BackBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
BackBtn.Font = Enum.Font.Gotham
BackBtn.TextSize = 14
BackBtn.AutoButtonColor = false
BackBtn.Parent = MainFrame

local BackCorner = Instance.new("UICorner")
BackCorner.CornerRadius = UDim.new(0, 6)
BackCorner.Parent = BackBtn

-- Fungsi simpan lokasi
local function SaveLocation()
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local HRP = Character:FindFirstChild("HumanoidRootPart")
    if not HRP then return end

    SavedPosition = HRP.CFrame
    StarterGui:SetCore("SendNotification", {
        Title = "✅ Tersimpan",
        Text = "Lokasi berhasil disimpan!",
        Duration = 2
    })

    -- Efek klik
    TweenService:Create(SaveBtn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(90, 150, 200)}):Play()
    task.wait(0.1)
    TweenService:Create(SaveBtn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(70, 130, 180)}):Play()
end

-- Fungsi kembali ke lokasi
local function GoBack()
    if not SavedPosition then
        StarterGui:SetCore("SendNotification", {
            Title = "❌ Belum Tersimpan",
            Text = "Tekan SAVE dulu ya!",
            Duration = 2
        })
        return
    end

    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local HRP = Character:FindFirstChild("HumanoidRootPart")
    if HRP then
        HRP.CFrame = SavedPosition
        StarterGui:SetCore("SendNotification", {
            Title = "📍 Berpindah",
            Text = "Kembali ke lokasi tersimpan!",
            Duration = 2
        })
    end

    -- Efek klik
    TweenService:Create(BackBtn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(200, 90, 90)}):Play()
    task.wait(0.1)
    TweenService:Create(BackBtn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(180, 70, 70)}):Play()
end

-- Hubungkan tombol
SaveBtn.MouseButton1Click:Connect(SaveLocation)
BackBtn.MouseButton1Click:Connect(GoBack)

-- Bisa digeser UI (biar enak di HP)
local Dragging, DragStart, StartPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = true
        DragStart = input.Position
        StartPos = MainFrame.Position
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if Dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local Delta = input.Position - DragStart
        MainFrame.Position = UDim2.new(
            StartPos.X.Scale,
            StartPos.X.Offset + Delta.X,
            StartPos.Y.Scale,
            StartPos.Y.Offset + Delta.Y
        )
    end
end)

MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = false
    end
end)
