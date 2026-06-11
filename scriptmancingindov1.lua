-- Script Mancing Indo Yuki Hub
-- Fitur: Teleport, Auto Sell TP, Auto Sell Silent, Minimize, SET KECEPATAN LARI, dll

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

-- Simpan kecepatan asli
local KecepatanAsli = Humanoid.WalkSpeed
local KecepatanAktif = KecepatanAsli
local SpeedAktif = false


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


-- Frame Utama - DIPERBESAR untuk fitur baru
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 160, 0, 225) -- Ditambah tinggi
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)


local isMinimized = false
local TampilPulau = false
local AutoSellTPAktif = false
local AutoSellSilentAktif = false
local AutoSellTPGui = nil
local AutoSellSilentGui = nil
local HotkeyTP = nil
local HotkeySilent = nil


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


-- =============================================
-- FITUR KECEPATAN LARI (BARU DITAMBAHKAN)
-- =============================================
local SpeedFrame = Instance.new("Frame")
SpeedFrame.Size = UDim2.new(0.9, 0, 0, 45)
SpeedFrame.Position = UDim2.new(0.05, 0, 0, 112)
SpeedFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
SpeedFrame.BorderSizePixel = 0
SpeedFrame.Parent = MainFrame
Instance.new("UICorner", SpeedFrame).CornerRadius = UDim.new(0, 6)

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, 0, 0, 18)
SpeedLabel.Position = UDim2.new(0, 0, 0, 2)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "KECEPATAN: "..KecepatanAsli
SpeedLabel.TextColor3 = Color3.new(1,1,1)
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.TextSize = 10
SpeedLabel.Parent = SpeedFrame

-- Slider Kecepatan
local SpeedSlider = Instance.new("TextButton")
SpeedSlider.Size = UDim2.new(0.7, -5, 0, 15)
SpeedSlider.Position = UDim2.new(0.02, 0, 0, 22)
SpeedSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SpeedSlider.Text = ""
SpeedSlider.AutoButtonColor = false
SpeedSlider.Parent = SpeedFrame
Instance.new("UICorner", SpeedSlider).CornerRadius = UDim.new(0, 4)

local SliderKnob = Instance.new("Frame")
SliderKnob.Size = UDim2.new(0, 15, 1, 0)
SliderKnob.Position = UDim2.new(0, 0, 0, 0)
SliderKnob.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
SliderKnob.BorderSizePixel = 0
SliderKnob.Parent = SpeedSlider
Instance.new("UICorner", SliderKnob).CornerRadius = UDim.new(0, 4)

-- Tombol Aktif/Reset
local SpeedToggleBtn = Instance.new("TextButton")
SpeedToggleBtn.Size = UDim2.new(0.25, 0, 0, 15)
SpeedToggleBtn.Position = UDim2.new(0.73, 0, 0, 22)
SpeedToggleBtn.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
SpeedToggleBtn.Text = "ON"
SpeedToggleBtn.TextColor3 = Color3.new(1,1,1)
SpeedToggleBtn.Font = Enum.Font.GothamBold
SpeedToggleBtn.TextSize = 9
SpeedToggleBtn.Parent = SpeedFrame
Instance.new("UICorner", SpeedToggleBtn).CornerRadius = UDim.new(0, 4)

-- Fungsi Update Kecepatan
local function UpdateSpeed(nilai)
    nilai = math.clamp(nilai, 16, 300) -- Batas minimal 16, maksimal 300
    KecepatanAktif = nilai
    SpeedLabel.Text = "KECEPATAN: "..math.floor(nilai)
    SliderKnob.Position = UDim2.new((nilai - 16) / 284, 0, 0, 0) -- Sesuai batas
    if SpeedAktif then Humanoid.WalkSpeed = nilai end
end

-- Geser Slider
local sedangGeserSlider = false
SpeedSlider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        sedangGeserSlider = true
        local pos = (input.Position.X - SpeedSlider.AbsolutePosition.X) / SpeedSlider.AbsoluteSize.X
        UpdateSpeed(16 + (pos * 284))
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if sedangGeserSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local pos = math.clamp((input.Position.X - SpeedSlider.AbsolutePosition.X) / SpeedSlider.AbsoluteSize.X, 0, 1)
        UpdateSpeed(16 + (pos * 284))
    end
end)
UserInputService.InputEnded:Connect(function() sedangGeserSlider = false end)

-- Aktif/Matikan Kecepatan
SpeedToggleBtn.MouseButton1Click:Connect(function()
    SpeedAktif = not SpeedAktif
    if SpeedAktif then
        Humanoid.WalkSpeed = KecepatanAktif
        SpeedToggleBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
        SpeedToggleBtn.Text = "ON"
        StarterGui:SetCore("SendNotification", {Title = "✅ Kecepatan Aktif", Text = "Lari: "..math.floor(KecepatanAktif), Duration = 1.5})
    else
        Humanoid.WalkSpeed = KecepatanAsli
        SpeedToggleBtn.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
        SpeedToggleBtn.Text = "OFF"
        StarterGui:SetCore("SendNotification", {Title = "🔄 Kecepatan Normal", Text = "Kembali ke asli: "..KecepatanAsli, Duration = 1.5})
    end
end)

-- Perbarui kecepatan saat karakter respawn
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    HRP = newChar:WaitForChild("HumanoidRootPart")
    Humanoid = newChar:WaitForChild("Humanoid")
    KecepatanAsli = Humanoid.WalkSpeed
    if SpeedAktif then Humanoid.WalkSpeed = KecepatanAktif end
end)


-- TOMBOL AUTO SELL TP
local AutoSellTPBtn = Instance.new("TextButton")
AutoSellTPBtn.Size = UDim2.new(0.9, 0, 0, 30)
AutoSellTPBtn.Position = UDim2.new(0.05, 0, 0, 162) -- Posisi disesuaikan
AutoSellTPBtn.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
AutoSellTPBtn.BorderSizePixel = 0
AutoSellTPBtn.Text = "AUTO SELL TP"
AutoSellTPBtn.TextColor3 = Color3.new(1,1,1)
AutoSellTPBtn.Font = Enum.Font.GothamBold
AutoSellTPBtn.TextSize = 11
AutoSellTPBtn.Parent = MainFrame
Instance.new("UICorner", AutoSellTPBtn).CornerRadius = UDim.new(0, 6)


-- TOMBOL AUTO SELL SILENT
local AutoSellSilentBtn = Instance.new("TextButton")
AutoSellSilentBtn.Size = UDim2.new(0.9, 0, 0, 30)
AutoSellSilentBtn.Position = UDim2.new(0.05, 0, 0, 197) -- Posisi disesuaikan
AutoSellSilentBtn.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
AutoSellSilentBtn.BorderSizePixel = 0
AutoSellSilentBtn.Text = "AUTO SELL SILENT"
AutoSellSilentBtn.TextColor3 = Color3.new(1,1,1)
AutoSellSilentBtn.Font = Enum.Font.GothamBold
AutoSellSilentBtn.TextSize = 10
AutoSellSilentBtn.Parent = MainFrame
Instance.new("UICorner", AutoSellSilentBtn).CornerRadius = UDim.new(0, 6)


-- Fungsi Tampil/Sembunyi Daftar Pulau
TeleportBtn.MouseButton1Click:Connect(function()
    TampilPulau = not TampilPulau
    ScrollingFrame.Visible = TampilPulau
    
    if TampilPulau then
        MainFrame.Size = UDim2.new(0, 160, 0, 335) -- Tinggi disesuaikan
        SpeedFrame.Position = UDim2.new(0.05, 0, 0, 225)
        AutoSellTPBtn.Position = UDim2.new(0.05, 0, 0, 275)
        AutoSellSilentBtn.Position = UDim2.new(0.05, 0, 0, 310)
        TeleportBtn.Text = "TUTUP TELEPORT"
    else
        MainFrame.Size = UDim2.new(0, 160, 0, 225)
        SpeedFrame.Position = UDim2.new(0.05, 0, 0, 112)
        AutoSellTPBtn.Position = UDim2.new(0.05, 0, 0, 162)
        AutoSellSilentBtn.Position = UDim2.new(0.05, 0, 0, 197)
        TeleportBtn.Text = "TELEPORT"
    end
end)


-- =============================================
-- FUNGSI AUTO SELL TP
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
        Title = "✅ Auto Sell TP",
        Text = "Ikan terjual & kembali!",
        Duration = 2
    })
end

-- Aktifkan Auto Sell TP
local function AktifkanAutoSellTP()
    if AutoSellTPAktif then return end
    AutoSellTPAktif = true
    AutoSellTPBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
    AutoSellTPBtn.Text = "MATI SELL TP"

    AutoSellTPGui = Instance.new("ScreenGui")
    AutoSellTPGui.Name = "YukiAutoSellTP"
    AutoSellTPGui.ResetOnSpawn = false
    AutoSellTPGui.Parent = PlayerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 95, 0, 75)
    frame.Position = UDim2.new(0.88, 0, 0.35, 0)
    frame.BackgroundColor3 = Color3.fromRGB(10, 10, 25)
    frame.BorderSizePixel = 0
    frame.BackgroundTransparency = 0.1
    frame.Parent = AutoSellTPGui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 25)
    title.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
    title.Text = "Auto Sell TP"
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

    local dragging, dragStart, startPos
    title.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function() dragging = false end)

    btn.MouseButton1Click:Connect(sellAndReturn)

    HotkeyTP = UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.H then
            sellAndReturn()
        end
    end)

    StarterGui:SetCore("SendNotification", {
        Title = "✅ Auto Sell TP Aktif",
        Text = "Tekan H atau tombol SELL",
        Duration = 2
    })
end

-- Matikan Auto Sell TP
local function MatikanAutoSellTP()
    if not AutoSellTPAktif then return end
    AutoSellTPAktif = false
    AutoSellTPBtn.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
    AutoSellTPBtn.Text = "AUTO SELL TP"

    if AutoSellTPGui then AutoSellTPGui:Destroy() end
    if HotkeyTP then HotkeyTP:Disconnect() end

    StarterGui:SetCore("SendNotification", {
        Title = "❌ Auto Sell TP Dimatikan",
        Text = "Fitur dinonaktifkan",
        Duration = 2
    })
end

AutoSellTPBtn.MouseButton1Click:Connect(function()
    if AutoSellTPAktif then
        MatikanAutoSellTP()
    else
        AktifkanAutoSellTP()
    end
end)


-- =============================================
-- FUNGSI AUTO SELL SILENT
-- =============================================
local function silentSellAll()
    local remotesFolder = ReplicatedStorage:FindFirstChild("Remotes", true)
    local sellRemote = remotesFolder and remotesFolder:FindFirstChild("SellFish")
    
    if sellRemote then
        sellRemote:FireServer("All")
        StarterGui:SetCore("SendNotification", {
            Title = "🛒 JUAL IKAN",
            Text = "Semua ikan terjual! (Silent)",
            Duration = 2
        })
    else
        StarterGui:SetCore("SendNotification", {
            Title = "❌ Error",
            Text = "Remote SellFish tidak ditemukan",
            Duration = 3
        })
    end
end

-- Aktifkan Auto Sell Silent
local function AktifkanAutoSellSilent()
    if AutoSellSilentAktif then return end
    AutoSellSilentAktif = true
    AutoSellSilentBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
    AutoSellSilentBtn.Text = "MATI SELL SILENT"

    AutoSellSilentGui = Instance.new("ScreenGui")
    AutoSellSilentGui.Name = "YukiAutoSellSilent"
    AutoSellSilentGui.ResetOnSpawn = false
    AutoSellSilentGui.Parent = PlayerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 95, 0, 75)
    frame.Position = UDim2.new(0.88, 0, 0.45, 0)
    frame.BackgroundColor3 = Color3.fromRGB(10, 10, 25)
    frame.BorderSizePixel = 0
    frame.BackgroundTransparency = 0.1
    frame.Parent = AutoSellSilentGui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 25)
    title.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
    title.Text = "Auto Sell Silent"
    title.TextColor3 = Color3.new(1,1,1)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.BorderSizePixel = 0
    title.Parent = frame
    Instance.new("UICorner", title).CornerRadius = UDim.new(0, 6)

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0.45, 0)
    btn.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
    btn.Text = "SELL"
    btn.TextColor3 = Color3.new(0,0,0)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = frame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)

    local dragging, dragStart, startPos
    title.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function() dragging = false end)

    btn.MouseButton1Click:Connect(silentSellAll)

    HotkeySilent = UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.J then
            silentSellAll()
        end
    end)

    StarterGui:SetCore("SendNotification", {
        Title = "✅ Auto Sell Silent Aktif",
        Text = "Tekan J atau tombol SELL",
        Duration = 2
    })
end

-- Matikan Auto Sell Silent
local function MatikanAutoSellSilent()
    if not AutoSellSilentAktif then return end
    AutoSellSilentAktif = false
    AutoSellSilentBtn.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
    AutoSellSilentBtn.Text = "AUTO SELL SILENT"

    if AutoSellSilentGui then AutoSellSilentGui:Destroy() end
    if HotkeySilent then HotkeySilent:Disconnect() end

    StarterGui:SetCore("SendNotification", {
        Title = "❌ Auto Sell Silent Dimatikan",
        Text = "Fitur dinonaktifkan",
        Duration = 2
    })
end

AutoSellSilentBtn.MouseButton1Click:Connect(function()
    if AutoSellSilentAktif then
        MatikanAutoSellSilent()
    else
        AktifkanAutoSellSilent()
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
        SpeedFrame.Visible = false
        AutoSellTPBtn.Visible = false
        AutoSellSilentBtn.Visible = false
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
        MainFrame.Size = TampilPulau and UDim2.new(0, 160, 0, 335) or UDim2.new(0, 160, 0, 225)
        Title.Visible = true
        MinimizeBtn.Visible = true
        ShrinkBtn.Visible = true
        EnlargeBtn.Visible = true
        DeleteBtn.Visible = true
        TeleportBtn.Visible = true
        SpeedFrame.Visible = true
        AutoSellTPBtn.Visible = true
        AutoSellSilentBtn.Visible = true
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
    local T = math.min(MainFrame.Size.Y.Offset + 25, 360)
    MainFrame.Size = UDim2.new(0, L, 0, T)
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #DaftarPulau * 33)
end)
ShrinkBtn.MouseButton1Click:Connect(function()
    local L = math.max(MainFrame.Size.X.Offset - 20, 130)
    local T = math.max(MainFrame.Size.Y.Offset - 25, 225)
    MainFrame.Size = UDim2.new(0, L, 0, T)
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #DaftarPulau * 33)
end)


-- Fungsi Hapus Semua
DeleteBtn.MouseButton1Click:Connect(function()
    MatikanAutoSellTP()
    MatikanAutoSellSilent()
    if SpeedAktif then Humanoid.WalkSpeed = KecepatanAsli end
    ScreenGui:Destroy()
end)
