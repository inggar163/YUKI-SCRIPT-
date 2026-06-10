-- Script Mancing Indo Yuki Hub - Ukuran Lebih Kecil
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")

-- Daftar Pulau
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

-- GUI Utama (UKURAN DIPERKECIL)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MancingIndoYukiHub"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- Frame Utama - Ukuran default lebih kecil
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 420, 0, 320) -- ✅ Lebih kecil dari sebelumnya
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 1
MainFrame.BorderColor3 = Color3.fromRGB(80, 80, 80)
MainFrame.Parent = ScreenGui

-- Judul Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 26) -- ✅ Lebih pendek
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -100, 1, 0)
TitleText.Position = UDim2.new(0, 6, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "MANCING INDO YUKI HUB"
TitleText.TextColor3 = Color3.new(1,1,1)
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 12 -- ✅ Lebih kecil
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- Tombol Kontrol
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 24, 0, 20) -- ✅ Lebih kecil
MinimizeBtn.Position = UDim2.new(1, -92, 0, 3)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinimizeBtn.Text = "O"
MinimizeBtn.TextColor3 = Color3.new(1,1,1)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 10
MinimizeBtn.BorderSizePixel = 0
MinimizeBtn.Parent = TitleBar

local ShrinkBtn = Instance.new("TextButton")
ShrinkBtn.Size = UDim2.new(0, 24, 0, 20)
ShrinkBtn.Position = UDim2.new(1, -66, 0, 3)
ShrinkBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ShrinkBtn.Text = "-"
ShrinkBtn.TextColor3 = Color3.new(1,1,1)
ShrinkBtn.Font = Enum.Font.GothamBold
ShrinkBtn.TextSize = 12
ShrinkBtn.BorderSizePixel = 0
ShrinkBtn.Parent = TitleBar

local EnlargeBtn = Instance.new("TextButton")
EnlargeBtn.Size = UDim2.new(0, 24, 0, 20)
EnlargeBtn.Position = UDim2.new(1, -40, 0, 3)
EnlargeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
EnlargeBtn.Text = "+"
EnlargeBtn.TextColor3 = Color3.new(1,1,1)
EnlargeBtn.Font = Enum.Font.GothamBold
EnlargeBtn.TextSize = 12
EnlargeBtn.BorderSizePixel = 0
EnlargeBtn.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 24, 0, 20)
CloseBtn.Position = UDim2.new(1, -14, 0, 3)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 10
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TitleBar

-- Menu Kiri
local MenuFrame = Instance.new("ScrollingFrame")
MenuFrame.Size = UDim2.new(0.3, -4, 1, -30)
MenuFrame.Position = UDim2.new(0, 4, 0, 28)
MenuFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MenuFrame.BorderSizePixel = 1
MenuFrame.BorderColor3 = Color3.fromRGB(70, 70, 70)
MenuFrame.ScrollBarThickness = 3
MenuFrame.CanvasSize = UDim2.new(0, 0, 0, 280)
MenuFrame.Parent = MainFrame

-- Konten Kanan
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(0.68, -4, 1, -30)
ContentFrame.Position = UDim2.new(0.31, 4, 0, 28)
ContentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ContentFrame.BorderSizePixel = 1
ContentFrame.BorderColor3 = Color3.fromRGB(70, 70, 70)
ContentFrame.Parent = MainFrame

-- Menu Item
local MenuItems = {
    {Nama = "TENTANG"},
    {Nama = "TELEPORT"},
    {Nama = "AUTO SELL TP"},
    {Nama = "AUTO SELL SILENT"},
    {Nama = "COMING SOON"},
    {Nama = "COMING SOON"},
    {Nama = "COMING SOON"}
}

local TombolMenu = {}
for i, Data in ipairs(MenuItems) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.92, 0, 0, 34) -- ✅ Lebih pendek
    btn.Position = UDim2.new(0.04, 0, 0, (i-1)*38)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(80, 80, 80)
    btn.Text = Data.Nama
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 10 -- ✅ Lebih kecil
    btn.AutoButtonColor = false
    btn.Parent = MenuFrame
    TombolMenu[i] = btn
end

-- Konten Tentang
local TentangText = Instance.new("TextLabel")
TentangText.Size = UDim2.new(1, -10, 1, -10)
TentangText.Position = UDim2.new(0, 5, 0, 5)
TentangText.BackgroundTransparency = 1
TentangText.Text = [[YUKI HUB
MANCING INDO SCRIPT

Script ini dibuat oleh ai, untuk fitur seadanya dulu dan masih banyak bug harap dimaklumi karena ini hanya buatan ai

DEV : - YUKI
          - GROK AI
          - DOLA AI
          - CHAT GPT]]
TentangText.TextColor3 = Color3.new(1,1,1)
TentangText.Font = Enum.Font.Gotham
TentangText.TextSize = 11 -- ✅ Lebih kecil
TentangText.TextXAlignment = Enum.TextXAlignment.Left
TentangText.TextYAlignment = Enum.TextYAlignment.Top
TentangText.TextWrapped = true
TentangText.Visible = false
TentangText.Parent = ContentFrame

-- Konten Teleport
local TeleportScroll = Instance.new("ScrollingFrame")
TeleportScroll.Size = UDim2.new(1, -10, 1, -10)
TeleportScroll.Position = UDim2.new(0, 5, 0, 5)
TeleportScroll.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TeleportScroll.BorderSizePixel = 0
TeleportScroll.ScrollBarThickness = 4
TeleportScroll.CanvasSize = UDim2.new(0, 0, 0, #DaftarPulau * 36)
TeleportScroll.Visible = false
TeleportScroll.Parent = ContentFrame

for i, Pulau in ipairs(DaftarPulau) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.95, 0, 0, 32) -- ✅ Lebih kecil
    btn.Position = UDim2.new(0.025, 0, 0, (i-1)*36)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(90, 90, 90)
    btn.Text = Pulau.Nama
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 9 -- ✅ Lebih kecil
    btn.AutoButtonColor = false
    btn.Parent = TeleportScroll

    btn.MouseButton1Click:Connect(function()
        HRP.CFrame = CFrame.new(Pulau.X, Pulau.Y, Pulau.Z)
        StarterGui:SetCore("SendNotification", {Title = "✅ Teleport", Text = "Ke: "..Pulau.Nama, Duration = 1.2})
    end)
end

-- Konten Auto Sell TP
local AutoSellTPInfo = Instance.new("TextLabel")
AutoSellTPInfo.Size = UDim2.new(1, -10, 1, -10)
AutoSellTPInfo.Position = UDim2.new(0, 5, 0, 5)
AutoSellTPInfo.BackgroundTransparency = 1
AutoSellTPInfo.Text = [[Jual semua ikan dengan teleport

cara kerja: player akan teleport ke penjual ikan dan akan menjual ikan otomatis setelah terjual player akan kembali ke tempat awal]]
AutoSellTPInfo.TextColor3 = Color3.new(1,1,1)
AutoSellTPInfo.Font = Enum.Font.Gotham
AutoSellTPInfo.TextSize = 11
AutoSellTPInfo.TextXAlignment = Enum.TextXAlignment.Left
AutoSellTPInfo.TextYAlignment = Enum.TextYAlignment.Top
AutoSellTPInfo.TextWrapped = true
AutoSellTPInfo.Visible = false
AutoSellTPInfo.Parent = ContentFrame

-- Konten Auto Sell Silent
local AutoSellSilentInfo = Instance.new("TextLabel")
AutoSellSilentInfo.Size = UDim2.new(1, -10, 1, -10)
AutoSellSilentInfo.Position = UDim2.new(0, 5, 0, 5)
AutoSellSilentInfo.BackgroundTransparency = 1
AutoSellSilentInfo.Text = [[Jual otomatis ikan tanpa teleportasi, kamu harus berada di dekat npc penjual ikan untuk menjual ikan tanpa teleportasi]]
AutoSellSilentInfo.TextColor3 = Color3.new(1,1,1)
AutoSellSilentInfo.Font = Enum.Font.Gotham
AutoSellSilentInfo.TextSize = 11
AutoSellSilentInfo.TextXAlignment = Enum.TextXAlignment.Left
AutoSellSilentInfo.TextYAlignment = Enum.TextYAlignment.Top
AutoSellSilentInfo.TextWrapped = true
AutoSellSilentInfo.Visible = false
AutoSellSilentInfo.Parent = ContentFrame

-- Fungsi Tampil Konten
local function TampilkanKonten(nomor)
    TentangText.Visible = nomor == 1
    TeleportScroll.Visible = nomor == 2
    AutoSellTPInfo.Visible = nomor == 3
    AutoSellSilentInfo.Visible = nomor == 4
end

TombolMenu[1].MouseButton1Click:Connect(function() TampilkanKonten(1) end)
TombolMenu[2].MouseButton1Click:Connect(function() TampilkanKonten(2) end)
TombolMenu[3].MouseButton1Click:Connect(function() TampilkanKonten(3) end)
TombolMenu[4].MouseButton1Click:Connect(function() TampilkanKonten(4) end)

-- =============================================
-- FUNGSI AUTO SELL TP
-- =============================================
local npcPosition = Vector3.new(2617.40, 5.41, -914.38)
local AutoSellTPAktif = false
local AutoSellTPGui, HotkeyTP

local function sellAndReturn()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local root = char.HumanoidRootPart
    local posAwal = root.CFrame
    root.CFrame = CFrame.new(npcPosition) * CFrame.new(0,5,0)
    task.wait(0.3)
    local sell = ReplicatedStorage:FindFirstChild("Remotes", true) and ReplicatedStorage.Remotes:FindFirstChild("SellFish")
    if sell then sell:FireServer("All") task.wait(0.15) sell:FireServer("All") end
    task.wait(0.25)
    root.CFrame = posAwal
    StarterGui:SetCore("SendNotification", {Title = "✅ Auto Sell TP", Text = "Ikan terjual & kembali", Duration = 1.5})
end

TombolMenu[3].MouseButton1Click:Connect(function()
    if AutoSellTPAktif then
        AutoSellTPAktif = false
        TombolMenu[3].BackgroundColor3 = Color3.fromRGB(50,50,50)
        if AutoSellTPGui then AutoSellTPGui:Destroy() end
        if HotkeyTP then HotkeyTP:Disconnect() end
    else
        AutoSellTPAktif = true
        TombolMenu[3].BackgroundColor3 = Color3.fromRGB(70,120,70)
        AutoSellTPGui = Instance.new("ScreenGui")
        AutoSellTPGui.Name = "YukiAutoSellTP"
        AutoSellTPGui.ResetOnSpawn = false
        AutoSellTPGui.Parent = PlayerGui
        local f = Instance.new("Frame")
        f.Size = UDim2.new(0,80,0,60) -- ✅ Popup lebih kecil
        f.Position = UDim2.new(0.88,0,0.3,0)
        f.BackgroundColor3 = Color3.fromRGB(15,15,30)
        f.BorderSizePixel = 1
        f.BorderColor3 = Color3.fromRGB(70,70,70)
        f.Parent = AutoSellTPGui
        local t = Instance.new("TextLabel")
        t.Size = UDim2.new(1,0,0,22)
        t.BackgroundColor3 = Color3.fromRGB(0,130,230)
        t.Text = "AUTO SELL TP"
        t.TextColor3 = Color3.new(1,1,1)
        t.TextScaled = true
        t.Font = Enum.Font.GothamBold
        t.BorderSizePixel = 0
        t.Parent = f
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0.9,0,0,28)
        b.Position = UDim2.new(0.05,0,0.45,0)
        b.BackgroundColor3 = Color3.fromRGB(0,210,70)
        b.Text = "SELL"
        b.TextColor3 = Color3.new(0,0,0)
        b.TextScaled = true
        b.Font = Enum.Font.GothamBold
        b.BorderSizePixel = 0
        b.Parent = f
        local drag, dragPos, startPos
        t.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                drag = true dragPos = i.Position startPos = f.Position
            end
        end)
        UserInputService.InputChanged:Connect(function(i)
            if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
                f.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + (i.Position - dragPos).X, startPos.Y.Scale, startPos.Y.Offset + (i.Position - dragPos).Y)
            end
        end)
        UserInputService.InputEnded:Connect(function() drag = false end)
        b.MouseButton1Click:Connect(sellAndReturn)
        HotkeyTP = UserInputService.InputBegan:Connect(function(i,g) if not g and i.KeyCode == Enum.KeyCode.H then sellAndReturn() end end)
    end
end)

-- =============================================
-- AUTO SELL SILENT - Kotak Nomor 4
-- =============================================
local AutoSellSilentAktif = false
local SilentGui, HotkeySilent

local function silentSellAll()
    local remotesFolder = ReplicatedStorage:FindFirstChild("Remotes", true)
    local sellRemote = remotesFolder and remotesFolder:FindFirstChild("SellFish")
    
    if sellRemote then
        sellRemote:FireServer("All")
        StarterGui:SetCore("SendNotification", {
            Title = "🛒 JUAL IKAN",
            Text = "Semua ikan berhasil dijual! (Silent)",
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

TombolMenu[4].MouseButton1Click:Connect(function()
    if AutoSellSilentAktif then
        AutoSellSilentAktif = false
        TombolMenu[4].BackgroundColor3 = Color3.fromRGB(50,50,50)
        if SilentGui then SilentGui:Destroy() end
        if HotkeySilent then HotkeySilent:Disconnect() end
    else
        AutoSellSilentAktif = true
        TombolMenu[4].BackgroundColor3 = Color3.fromRGB(70,120,70)
        
        SilentGui = Instance.new("ScreenGui")
        SilentGui.Name = "SilentAutoSell"
        SilentGui.ResetOnSpawn = false
        SilentGui.Parent = PlayerGui
        
        local frame = Instance.new("Frame", SilentGui)
        frame.Size = UDim2.new(0, 180, 0, 120) -- ✅ Popup lebih kecil
        frame.Position = UDim2.new(0.8, 0, 0.3, 0)
        frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        frame.BorderSizePixel = 0
        frame.BackgroundTransparency = 0.1
        
        local title = Instance.new("TextLabel", frame)
        title.Size = UDim2.new(1,0,0,28)
        title.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
        title.Text = "Silent Auto Jual"
        title.TextColor3 = Color3.new(1,1,1)
        title.TextScaled = true
        title.BorderSizePixel = 0
        
        local btn = Instance.new("TextButton", frame)
        btn.Size = UDim2.new(0.9,0,0,45)
        btn.Position = UDim2.new(0.05,0,0.32,0)
        btn.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
        btn.Text = "🛒 JUAL SEMUA IKAN\n(Silent)"
        btn.TextScaled = true
        btn.TextColor3 = Color3.new(0,0,0)
        btn.BorderSizePixel = 0
        
        -- Bisa digeser
        local drag, dragPos, startPos
        title.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                drag = true dragPos = i.Position startPos = frame.Position
            end
        end)
        UserInputService.InputChanged:Connect(function(i)
            if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
                frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + (i.Position - dragPos).X, startPos.Y.Scale, startPos.Y.Offset + (i.Position - dragPos).Y)
            end
        end)
        UserInputService.InputEnded:Connect(function() drag = false end)
        
        btn.MouseButton1Click:Connect(silentSellAll)
        
        -- Hotkey J
        HotkeySilent = UserInputService.InputBegan:Connect(function(input, gp)
            if gp then return end
            if input.KeyCode == Enum.KeyCode.J then
                silentSellAll()
            end
        end)
    end
end)

-- MINIMIZE SUPER RINGAN
local isMin = false
local ukuranAsli = UDim2.new(0,420,0,320) -- ✅ Ukuran asli baru
local posisiAsli = UDim2.new(0.05,0,0.2,0)

local YLabel = Instance.new("TextLabel")
YLabel.Size = UDim2.new(1,0,1,0)
YLabel.BackgroundTransparency = 1
YLabel.Text = "Y"
YLabel.TextColor3 = Color3.new(1,1,1)
YLabel.Font = Enum.Font.GothamBold
YLabel.TextSize = 16
YLabel.Visible = false
YLabel.Parent = MainFrame

local function ToggleMin()
    isMin = not isMin
    if isMin then
        ukuranAsli = MainFrame.Size
        posisiAsli = MainFrame.Position
        TitleBar.Visible = false
        MenuFrame.Visible = false
        ContentFrame.Visible = false
        MainFrame.Size = UDim2.new(0,36,0,36) -- ✅ Kotak minimize lebih kecil
        MainFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
        MainFrame.BorderSizePixel = 1
        YLabel.Visible = true
    else
        TitleBar.Visible = true
        MenuFrame.Visible = true
        ContentFrame.Visible = true
        MainFrame.Size = ukuranAsli
        MainFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
        YLabel.Visible = false
    end
end

MinimizeBtn.MouseButton1Click:Connect(ToggleMin)
YLabel.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then ToggleMin() end end)

-- Ubah Ukuran - BATAS LEBIH KECIL
EnlargeBtn.MouseButton1Click:Connect(function()
    if isMin then return end
    local lebar = math.min(MainFrame.Size.X.Offset + 20, 550)
    local tinggi = math.min(MainFrame.Size.Y.Offset + 20, 420)
    MainFrame.Size = UDim2.new(0, lebar, 0, tinggi)
    TeleportScroll.CanvasSize = UDim2.new(0,0,0, #DaftarPulau * 36)
end)

ShrinkBtn.MouseButton1Click:Connect(function()
    if isMin then return end
    local lebar = math.max(MainFrame.Size.X.Offset - 20, 280) -- ✅ Batas minimal lebih kecil
    local tinggi = math.max(MainFrame.Size.Y.Offset - 20, 220) -- ✅ Batas minimal lebih kecil
    MainFrame.Size = UDim2.new(0, lebar, 0, tinggi)
    TeleportScroll.CanvasSize = UDim2.new(0,0,0, #DaftarPulau * 36)
end)

-- Tutup
CloseBtn.MouseButton1Click:Connect(function()
    if AutoSellTPGui then AutoSellTPGui:Destroy() end
    if SilentGui then SilentGui:Destroy() end
    if HotkeyTP then HotkeyTP:Disconnect() end
    if HotkeySilent then HotkeySilent:Disconnect() end
    ScreenGui:Destroy()
end)

-- Geser Ringan
local sedangGeser, posAwal, titikAwal
MainFrame.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        sedangGeser = true
        titikAwal = i.Position
        posAwal = MainFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(i)
    if sedangGeser and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        MainFrame.Position = UDim2.new(posAwal.X.Scale, math.floor(posAwal.X.Offset + (i.Position - titikAwal).X), posAwal.Y.Scale, math.floor(posAwal.Y.Offset + (i.Position - titikAwal).Y))
    end
end)
UserInputService.InputEnded:Connect(function() sedangGeser = false end)
