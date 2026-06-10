-- Script Mancing Indo Yuki Hub
-- Fitur: Teleport, Auto Sell, Minimize, dll

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")

-- Daftar Pulau & Koordinat
local DaftarPulau = {
    {Nama = "PULAU BOOMERANG", X = -1950.98, Y = 6.57, Z = 898.18},
    {Nama = "PULAU SERIBU", X = 1371.79, Y = 4.14, Z = 3822.75},
    {Nama = "PULAU BATU KARANG", X = -921.89, Y = 6.31, Z = -3394.37},
    {Nama = "BAGAN TELUK LUAR", X = -1885.67, Y = 8.02, Z = -1312.16},
    {Nama = "BAGAN UJUNG", X = -2917.05, Y = 7.95, Z = 4309.71},
    {Nama = "BAGAN LUAR", X = -1897.95, Y = 7.95, Z = -1311.29},
    {Nama = "BAGAN TENGAH", X = 3324.17, Y = 7.95, Z = -4418.95},
    {Nama = "BAGAN DALAM", X = 978.55, Y = 7.95, Z = 1257.90}
}

-- GUI Utama
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MancingIndoYukiHub"
ScreenGui.Parent = PlayerGui

-- Frame Utama
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 160, 0, 170)
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local isMinimized = false
local TampilPulau = false
local AutoSellAktif = false
local AutoSellGui = nil
local HotkeyTerhubung = nil

-- JUDUL
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -10, 0, 30)
Title.Position = UDim2.new(0, 5, 0, 3)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.BorderSizePixel = 0
Title.Text = "MANCING INDO YUKI HUB"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 11
Title.Parent = MainFrame
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 6)

-- TOMBOL KONTROL
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 22, 0, 22)
MinimizeBtn.Position = UDim2.new(0, 8, 0, 38)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
MinimizeBtn.Text = "_"
MinimizeBtn.TextColor3 = Color3.new(1,1,1)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 12
MinimizeBtn.Parent = MainFrame
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 4)

local ShrinkBtn = Instance.new("TextButton")
ShrinkBtn.Size = UDim2.new(0, 22, 0, 22)
ShrinkBtn.Position = UDim2.new(0, 36, 0, 38)
ShrinkBtn.BackgroundColor3 = Color3.fromRGB(180, 160, 60)
ShrinkBtn.Text = "-"
ShrinkBtn.TextColor3 = Color3.new(1,1,1)
ShrinkBtn.Font = Enum.Font.GothamBold
ShrinkBtn.TextSize = 12
ShrinkBtn.Parent = MainFrame
Instance.new("UICorner", ShrinkBtn).CornerRadius = UDim.new(0, 4)

local EnlargeBtn = Instance.new("TextButton")
EnlargeBtn.Size = UDim2.new(0, 22, 0, 22)
EnlargeBtn.Position = UDim2.new(0, 64, 0, 38)
EnlargeBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 70)
EnlargeBtn.Text = "+"
EnlargeBtn.TextColor3 = Color3.new(1,1,1)
EnlargeBtn.Font = Enum.Font.GothamBold
EnlargeBtn.TextSize = 12
EnlargeBtn.Parent = MainFrame
Instance.new("UICorner", EnlargeBtn).CornerRadius = UDim.new(0, 4)

local DeleteBtn = Instance.new("TextButton")
DeleteBtn.Size = UDim2.new(0, 22, 0, 22)
DeleteBtn.Position = UDim2.new(0, 92, 0, 38)
DeleteBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
DeleteBtn.Text = "X"
DeleteBtn.TextColor3 = Color3.new(1,1,1)
DeleteBtn.Font = Enum.Font.GothamBold
DeleteBtn.TextSize = 12
DeleteBtn.Parent = MainFrame
Instance.new("UICorner", DeleteBtn).CornerRadius = UDim.new(0, 4)

-- TOMBOL TELEPORT
local TeleportBtn = Instance.new("TextButton")
TeleportBtn.Size = UDim2.new(0.9, 0, 0, 32)
TeleportBtn.Position = UDim2.new(0.05, 0, 0, 70)
TeleportBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
TeleportBtn.BorderSizePixel = 0
TeleportBtn.Text = "TELEPORT"
TeleportBtn.TextColor3 = Color3.new(1,1,1)
TeleportBtn.Font = Enum.Font.GothamBold
TeleportBtn.TextSize = 12
TeleportBtn.Parent = MainFrame
Instance.new("UICorner", TeleportBtn).CornerRadius = UDim.new(0, 6)

-- DAFTAR PULAU
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(0.9, 0, 0, 110)
ScrollingFrame.Position = UDim2.new(0.05, 0, 0, 110)
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.ScrollBarThickness = 5
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #DaftarPulau * 33)
ScrollingFrame.Visible = false
ScrollingFrame.Parent = MainFrame
Instance.new("UICorner", ScrollingFrame).CornerRadius = UDim.new(0, 6)

-- Buat tombol pulau
for i, Pulau in ipairs(DaftarPulau) do
    local Tombol = Instance.new("TextButton")
    Tombol.Size = UDim2.new(0.95, 0, 0, 30)
    Tombol.Position = UDim2.new(0.025, 0, 0, (i-1) * 33)
    Tombol.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Tombol.BorderSizePixel = 0
    Tombol.Text = Pulau.Nama
    Tombol.TextColor3 = Color3.new(1,1,1)
    Tombol.Font = Enum.Font.Gotham
    Tombol.TextSize = 10
    Tombol.TextWrapped = true
    Tombol.AutoButtonColor = false
    Tombol.Parent = ScrollingFrame
    Instance.new("UICorner", Tombol).CornerRadius = UDim.new(0, 4)

    Tombol.MouseButton1Click:Connect(function()
        HRP.CFrame = CFrame.new(Pulau.X, Pulau.Y, Pulau.Z)
        StarterGui:SetCore("SendNotification", {
            Title = "✅ Teleport Berhasil",
            Text = "Ke: "..Pulau.Nama,
            Duration = 1.5
        })
        TweenService:Create(Tombol, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(80,80,80)}):Play()
        task.wait(0.1)
        TweenService:Create(Tombol, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(60,60,60)}):Play()
    end)
end

-- TOMBOL AUTO SELL
local AutoSellBtn = Instance.new("TextButton")
AutoSellBtn.Size = UDim2.new(0.9, 0, 0, 32)
AutoSellBtn.Position = UDim2.new(0.05, 0, 0, 110)
AutoSellBtn.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
AutoSellBtn.BorderSizePixel = 0
AutoSellBtn.Text = "AUTO SELL"
AutoSellBtn.TextColor3 = Color3.new(1,1,1)
AutoSellBtn.Font = Enum.Font.GothamBold
AutoSellBtn.TextSize = 12
AutoSellBtn.Parent = MainFrame
Instance.new("UICorner", AutoSellBtn).CornerRadius = UDim.new(0, 6)

-- Fungsi Tampil/Sembunyi Daftar Pulau
TeleportBtn.MouseButton1Click:Connect(function()
    TampilPulau = not TampilPulau
    ScrollingFrame.Visible = TampilPulau
    
    if TampilPulau then
        MainFrame.Size = UDim2.new(0, 160, 0, 260)
        AutoSellBtn.Position = UDim2.new(0.05, 0, 0, 225)
        TeleportBtn.Text = "TUTUP TELEPORT"
    else
        MainFrame.Size = UDim2.new(0, 160, 0, 170)
        AutoSellBtn.Position = UDim2.new(0.05, 0, 0, 110)
        TeleportBtn.Text = "TELEPORT"
    end
end)

-- =============================================
-- FUNGSI AUTO SELL
-- =============================================
local npcPosition = Vector3.new(2617.40, 5.41, -914.38)

local function sellAndReturn()
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local root = character.HumanoidRootPart
    local originalCFrame = root.CFrame

    -- Teleport ke NPC
    root.CFrame = CFrame.new(npcPosition) * CFrame.new(0, 5, 0)
    task.wait(0.5)

    -- Jual ikan
    local remotesFolder = ReplicatedStorage:FindFirstChild("Remotes", true)
    local sellRemote = remotesFolder and remotesFolder:FindFirstChild("SellFish")
    
    if sellRemote then
        sellRemote:FireServer("All")
        task.wait(0.3)
        sellRemote:FireServer("All")
    end

    task.wait(0.4)

    -- Kembali ke posisi semula
    root.CFrame = originalCFrame

    StarterGui:SetCore("SendNotification", {
        Title = "✅ Yuki Auto Sell",
        Text = "Ikan terjual & kembali!",
        Duration = 3
    })
end

-- Aktifkan Auto Sell
local function AktifkanAutoSell()
    if AutoSellAktif then return end
    AutoSellAktif = true
    AutoSellBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
    AutoSellBtn.Text = "MATI AUTO SELL"

    -- Buat GUI kecil Auto Sell
    AutoSellGui = Instance.new("ScreenGui")
    AutoSellGui.Name = "YukiAutoSell"
    AutoSellGui.ResetOnSpawn = false
    AutoSellGui.Parent = PlayerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 95, 0, 75)
    frame.Position = UDim2.new(0.88, 0, 0.35, 0)
    frame.BackgroundColor3 = Color3.fromRGB(10, 10, 25)
    frame.BorderSizePixel = 0
    frame.BackgroundTransparency = 0.1
    frame.Parent = AutoSellGui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 25)
    title.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
    title.Text = "Yuki Auto Sell"
    title.TextColor3 = Color3.new(1,1,1)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.BorderSizePixel = 0
    title.Parent = frame
    Instance.new("UICorner", title).CornerRadius = UDim.new(0, 6)

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0.45, 0)
    btn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    btn.Text = "SELL"
    btn.TextColor3 = Color3.new(0,0,0)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = frame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)

    -- Bisa digeser
    local dragging, dragInput, dragStart, startPos
    title.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)
    title.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- Tombol sell
    btn.MouseButton1Click:Connect(sellAndReturn)

    -- Hotkey H
    HotkeyTerhubung = UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.H then
            sellAndReturn()
        end
    end)

    StarterGui:SetCore("SendNotification", {
        Title = "✅ Auto Sell Aktif",
        Text = "Tekan H atau tombol SELL",
        Duration = 2
    })
end

-- Matikan & Hapus Auto Sell
local function MatikanAutoSell()
    if not AutoSellAktif then return end
    AutoSellAktif = false
    AutoSellBtn.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
    AutoSellBtn.Text = "AUTO SELL"

    if AutoSellGui then AutoSellGui:Destroy() end
    if HotkeyTerhubung then HotkeyTerhubung:Disconnect() end

    StarterGui:SetCore("SendNotification", {
        Title = "❌ Auto Sell Dimatikan",
        Text = "Fitur dihapus",
        Duration = 2
    })
end

-- Toggle Auto Sell
AutoSellBtn.MouseButton1Click:Connect(function()
    if AutoSellAktif then
        MatikanAutoSell()
    else
        AktifkanAutoSell()
    end
end)

-- Fungsi Minimize
local function ToggleMinimize()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame.Size = UDim2.new(0, 40, 0, 40)
        Title.Visible = false
        MinimizeBtn.Visible = false
        ShrinkBtn.Visible = false
        EnlargeBtn.Visible = false
        DeleteBtn.Visible = false
        TeleportBtn.Visible = false
        AutoSellBtn.Visible = false
        ScrollingFrame.Visible = false
        
        local MinBtn = Instance.new("TextButton")
        MinBtn.Size = UDim2.new(1, -6, 1, -6)
        MinBtn.Position = UDim2.new(0, 3, 0, 3)
        MinBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
        MinBtn.Text = "Y"
        MinBtn.TextColor3 = Color3.new(1,1,1)
        MinBtn.Font = Enum.Font.GothamBold
        MinBtn.TextSize = 16
        MinBtn.Parent = MainFrame
        Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 4)
        
        MinBtn.MouseButton1Click:Connect(ToggleMinimize)
    else
        MainFrame.Size = TampilPulau and UDim2.new(0, 160, 0, 260) or UDim2.new(0, 160, 0, 170)
        Title.Visible = true
        MinimizeBtn.Visible = true
        ShrinkBtn.Visible = true
        EnlargeBtn.Visible = true
        DeleteBtn.Visible = true
        TeleportBtn.Visible = true
        AutoSellBtn.Visible = true
        ScrollingFrame.Visible = TampilPulau
        
        for _,v in pairs(MainFrame:GetChildren()) do
            if v:IsA("TextButton") and v.Text == "Y" then v:Destroy() end
        end
    end
end
MinimizeBtn.MouseButton1Click:Connect(ToggleMinimize)

-- Fungsi Geser
local SedangGeser, PosisiAwal, TitikSentuh
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        SedangGeser = true
        TitikSentuh = input.Position
        PosisiAwal = MainFrame.Position
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if SedangGeser then
        local Delta = input.Position - TitikSentuh
        MainFrame.Position = UDim2.new(PosisiAwal.X.Scale, PosisiAwal.X.Offset + Delta.X, PosisiAwal.Y.Scale, PosisiAwal.Y.Offset + Delta.Y)
    end
end)
MainFrame.InputEnded:Connect(function() SedangGeser = false end)

-- Fungsi Perbesar & Perkecil
EnlargeBtn.MouseButton1Click:Connect(function()
    local L = math.min(MainFrame.Size.X.Offset + 20, 220)
    local T = math.min(MainFrame.Size.Y.Offset + 25, 320)
    MainFrame.Size = UDim2.new(0, L, 0, T)
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #DaftarPulau * 33)
end)
ShrinkBtn.MouseButton1Click:Connect(function()
    local L = math.max(MainFrame.Size.X.Offset - 20, 130)
    local T = math.max(MainFrame.Size.Y.Offset - 25, 140)
    MainFrame.Size = UDim2.new(0, L, 0, T)
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #DaftarPulau * 33)
end)

-- Fungsi Hapus Semua
DeleteBtn.MouseButton1Click:Connect(function()
    MatikanAutoSell()
    ScreenGui:Destroy()
end)
