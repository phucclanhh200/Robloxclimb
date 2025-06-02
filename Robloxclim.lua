-- Roblox Teleport Auto Farm Script with 7 Map Configurations and GUI

local maps = {
    ["Map 1"] = {
        cup = Vector3.new(32.7, 14400.8, -66.6),
        ground = Vector3.new(-63.5, 1.5, 1.8)
    },
    ["Map 2"] = {
        cup = Vector3.new(5046.4, 14402.9, -71.3),
        ground = Vector3.new(4939.3, 2.7, 24.1)
    },
    ["Map 3"] = {
        cup = Vector3.new(9988.9, 14402.5, -48.9),
        ground = Vector3.new(9943.0, 2.1, 27.4)
    },
    ["Map 4"] = {
        cup = Vector3.new(15034.2, 14405.1, -143.5),
        ground = Vector3.new(14932.4, 3.2, -28.7)
    },
    ["Map 5"] = {
        cup = Vector3.new(20000, 14402.1, -82.1),
        ground = Vector3.new(19942.5, -5.2, -6.6)
    },
    ["Map 6"] = {
        cup = Vector3.new(25018.4, 14404.6, -49.4),
        ground = Vector3.new(24997.3, 5.0, -92.5)
    },
    ["Map 7"] = {
        cup = Vector3.new(29998.3, 14401.6, -80.7),
        ground = Vector3.new(29961.1, 1.6, -169.3)
    },
}

local selectedMap = "Map 1"
local delayCup = 5
local delayGround = 5
local running = false
local minimized = false

-- Create GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "AutoFarmGUI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 300, 0, 260)
Frame.Position = UDim2.new(0, 50, 0.5, -130)
Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.Text = "Auto Cup Farm"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20

local Toggle = Instance.new("TextButton", Frame)
Toggle.Size = UDim2.new(0, 280, 0, 30)
Toggle.Position = UDim2.new(0, 10, 0, 40)
Toggle.Text = "BẬT FARM"
Toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Toggle.TextColor3 = Color3.new(1,1,1)
Toggle.Font = Enum.Font.SourceSansBold
Toggle.TextSize = 18

local Drop = Instance.new("TextButton", Frame)
Drop.Size = UDim2.new(0, 280, 0, 30)
Drop.Position = UDim2.new(0, 10, 0, 80)
Drop.Text = "Map: Map 1"
Drop.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Drop.TextColor3 = Color3.new(1,1,1)
Drop.Font = Enum.Font.SourceSans
Drop.TextSize = 16

local Delay1 = Instance.new("TextBox", Frame)
Delay1.Size = UDim2.new(0, 135, 0, 30)
Delay1.Position = UDim2.new(0, 10, 0, 120)
Delay1.PlaceholderText = "Delay trên cúp (giây)"
Delay1.Text = ""
Delay1.BackgroundColor3 = Color3.fromRGB(50,50,50)
Delay1.TextColor3 = Color3.new(1,1,1)
Delay1.Font = Enum.Font.SourceSans
Delay1.TextSize = 16

local Delay2 = Instance.new("TextBox", Frame)
Delay2.Size = UDim2.new(0, 135, 0, 30)
Delay2.Position = UDim2.new(0, 155, 0, 120)
Delay2.PlaceholderText = "Delay dưới đất (giây)"
Delay2.Text = ""
Delay2.BackgroundColor3 = Color3.fromRGB(50,50,50)
Delay2.TextColor3 = Color3.new(1,1,1)
Delay2.Font = Enum.Font.SourceSans
Delay2.TextSize = 16

local Minimize = Instance.new("TextButton", Frame)
Minimize.Size = UDim2.new(0, 135, 0, 30)
Minimize.Position = UDim2.new(0, 10, 0, 170)
Minimize.Text = "THU NHỎ"
Minimize.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Minimize.TextColor3 = Color3.new(1,1,1)
Minimize.Font = Enum.Font.SourceSansBold
Minimize.TextSize = 16

local Close = Instance.new("TextButton", Frame)
Close.Size = UDim2.new(0, 135, 0, 30)
Close.Position = UDim2.new(0, 155, 0, 170)
Close.Text = "THOÁT"
Close.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
Close.TextColor3 = Color3.new(1,1,1)
Close.Font = Enum.Font.SourceSansBold
Close.TextSize = 16

local function teleportTo(position)
    local plr = game.Players.LocalPlayer
    if plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
        plr.Character.HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

local function loopTeleport()
    while running do
        teleportTo(maps[selectedMap].cup)
        task.wait(delayCup)
        teleportTo(maps[selectedMap].ground)
        task.wait(delayGround)
    end
end

Toggle.MouseButton1Click:Connect(function()
    if not running then
        selectedMap = Drop.Text:sub(6)
        delayCup = tonumber(Delay1.Text) or 5
        delayGround = tonumber(Delay2.Text) or 5
        running = true
        Toggle.Text = "ĐANG FARM..."
        spawn(loopTeleport)
    else
        running = false
        Toggle.Text = "BẬT FARM"
    end
end)

Drop.MouseButton1Click:Connect(function()
    local keys = {}
    for k in pairs(maps) do table.insert(keys, k) end
    local idx = table.find(keys, selectedMap) or 1
    idx = (idx % #keys) + 1
    selectedMap = keys[idx]
    Drop.Text = "Map: " .. selectedMap
end)

Minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    for _, child in ipairs(Frame:GetChildren()) do
        if child ~= Title and child ~= Minimize then
            child.Visible = not minimized
        end
    end
    Minimize.Text = minimized and "MỞ RỘNG" or "THU NHỎ"
end)

Close.MouseButton1Click:Connect(function()
    running = false
    ScreenGui:Destroy()
end)
