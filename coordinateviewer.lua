-- 📍 SCRIPT KOORDINAT (LEBIH KECIL + TANPA PEMISAH)
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Ambil karakter
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local RootPart = Character:WaitForChild("HumanoidRootPart")
LocalPlayer.CharacterAdded:Connect(function(c)
    Character = c
    RootPart = c:WaitForChild("HumanoidRootPart")
end)

-- Buat GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KoordinatUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Frame Utama (diperkecil 50%)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 125, 0, 60) -- 50% dari ukuran sebelumnya
MainFrame.Position = UDim2.new(0.02, 0, 0.05, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.BackgroundTransparency = 0.1
MainFrame.Parent = ScreenGui

-- Judul
local Judul = Instance.new("TextLabel")
Judul.Size = UDim2.new(1, -22, 0, 18)
Judul.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Judul.BorderSizePixel = 0
Judul.Text = "KOORDINAT"
Judul.TextColor3 = Color3.new(1, 1, 1)
Judul.Font = Enum.Font.GothamBold
Judul.TextSize = 9
Judul.TextXAlignment = Enum.TextXAlignment.Center
Judul.Parent = MainFrame

-- Tombol Tutup
local TombolTutup = Instance.new("TextButton")
TombolTutup.Size = UDim2.new(0, 18, 0, 18)
TombolTutup.Position = UDim2.new(1, -18, 0, 0)
TombolTutup.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
TombolTutup.BorderSizePixel = 0
TombolTutup.Text = "X"
TombolTutup.TextColor3 = Color3.new(1, 1, 1)
TombolTutup.Font = Enum.Font.GothamBold
TombolTutup.TextSize = 8
TombolTutup.AutoButtonColor = false
TombolTutup.Parent = MainFrame

-- Tampilan Koordinat (tanpa tanda |)
local TeksKoordinat = Instance.new("TextLabel")
TeksKoordinat.Size = UDim2.new(1, -6, 0, 22)
TeksKoordinat.Position = UDim2.new(0, 3, 0, 20)
TeksKoordinat.BackgroundTransparency = 1
TeksKoordinat.TextColor3 = Color3.fromRGB(255, 255, 255)
TeksKoordinat.Font = Enum.Font.GothamSemibold
TeksKoordinat.TextSize = 9
TeksKoordinat.TextWrapped = true
TeksKoordinat.Parent = MainFrame

-- Tombol Salin
local TombolSalin = Instance.new("TextButton")
TombolSalin.Size = UDim2.new(1, -6, 0, 16)
TombolSalin.Position = UDim2.new(0, 3, 0, 43)
TombolSalin.BackgroundColor3 = Color3.fromRGB(45, 130, 255)
TombolSalin.BorderSizePixel = 0
TombolSalin.Text = "SALIN"
TombolSalin.TextColor3 = Color3.new(1, 1, 1)
TombolSalin.Font = Enum.Font.GothamBold
TombolSalin.TextSize = 8
TombolSalin.AutoButtonColor = false
TombolSalin.Parent = MainFrame

-- Fungsi Ambil Koordinat (format tanpa |)
local function AmbilKoordinat()
    local pos = RootPart.Position
    return string.format("X: %.2f Y: %.2f Z: %.2f", pos.X, pos.Y, pos.Z)
end

-- Update koordinat terus
task.spawn(function()
    while task.wait(0.2) do
        TeksKoordinat.Text = AmbilKoordinat()
    end
end)

-- Fungsi Salin
TombolSalin.MouseButton1Click:Connect(function()
    local teks = AmbilKoordinat()
    setclipboard(teks)
    StarterGui:SetCore("SendNotification", {
        Title = "Tersalin!",
        Text = teks,
        Duration = 2
    })
    TombolSalin.Text = "✓"
    task.wait(0.8)
    TombolSalin.Text = "SALIN"
end)

-- Fungsi Tutup
TombolTutup.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Fungsi Geser UI
local sedangGeser = false
local posisiAwal

Judul.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        sedangGeser = true
        posisiAwal = UserInputService:GetMouseLocation() - MainFrame.AbsolutePosition
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if sedangGeser and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        MainFrame.Position = UDim2.new(0, input.Position.X - posisiAwal.X, 0, input.Position.Y - posisiAwal.Y)
    end
end)

UserInputService.InputEnded:Connect(function()
    sedangGeser = false
end)

print("✅ Script Koordinat Siap (Versi Kecil)")
