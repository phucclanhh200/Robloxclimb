-- UI và cấu hình map
local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer

local coords = {
    Map1 = { ground = "-63.7,1.5,1.4", nearCup = "-8.2,14401.1,-123.4", cup = "20,30,20" },
    Map2 = { ground = "4937.7,2.7,21.8", nearCup = "4997.8,14403.7,-104.5", cup = "4997.8,14403.4,-99.6" },
    Map3 = { ground = "9942.8,2.1,26.3", nearCup = "10001.0,14404.2,-97.7", cup = "10000.6,14404.1,-93.1" },
    Map4 = { ground = "14932.3,3.2,-30.9", nearCup = "14993.3,14404.7,-185.7", cup = "14994.4,14404.6,-181.5" },
    Map5 = { ground = "19952.4,2.7,8.3", nearCup = "19999.9,14402.0,-142.2", cup = "20000.3,14402.0,-137.8" },
    Map6 = { ground = "24931.4,4.0,4.1", nearCup = "24993.0,14406.0,-83.9", cup = "24997.2,14406.1,-85.8" },
    Map7 = { ground = "29945.3,1.6,37.2", nearCup = "29991,14401.5,-131.9", cup = "29996.1,14401.5,-131.5" },
    Map8 = { ground = "29945.3,1.6,37.2", nearCup = "29987.6,14401.7,-85.6", cup = "29984.9,14408.6,-80.9" },
}

-- UI Setup
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "CupTeleporter"
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 360)
frame.Position = UDim2.new(0.5, -150, 0.5, -180)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

-- Di chuyển frame
local dragging, dragInput, dragStart, startPos
frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
		local delta = input.Position - dragStart
		frame.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
	end
end)

-- Components
local function makeLabel(text, y)
	local lbl = Instance.new("TextLabel", frame)
	lbl.Position = UDim2.new(0, 10, 0, y)
	lbl.Size = UDim2.new(1, -20, 0, 20)
	lbl.BackgroundTransparency = 1
	lbl.Text = text
	lbl.TextColor3 = Color3.new(1, 1, 1)
	lbl.Font = Enum.Font.SourceSans
	lbl.TextSize = 16
	lbl.TextXAlignment = Enum.TextXAlignment.Left
end

local function makeBox(name, y, w)
	local box = Instance.new("TextBox", frame)
	box.Name = name
	box.Position = UDim2.new(0, 10, 0, y)
	box.Size = UDim2.new(w or 1, (w and -15) or -20, 0, 25)
	box.PlaceholderText = "x,y,z"
	box.Text = ""
	box.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	box.TextColor3 = Color3.new(1, 1, 1)
	box.ClearTextOnFocus = true
	box.Font = Enum.Font.SourceSans
	box.TextSize = 16
	Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)
	return box
end

local credit = Instance.new("TextLabel", frame)
credit.Position = UDim2.new(0, 10, 0, 10)
credit.Size = UDim2.new(1, -20, 0, 20)
credit.BackgroundTransparency = 1
credit.Text = "Script By Plnh"
credit.TextColor3 = Color3.fromRGB(150, 150, 150)
credit.Font = Enum.Font.SourceSansItalic
credit.TextSize = 19
credit.TextXAlignment = Enum.TextXAlignment.Right

local dropdown = Instance.new("TextButton", frame)
dropdown.Size = UDim2.new(1, -20, 0, 30)
dropdown.Position = UDim2.new(0, 10, 0, 10)
dropdown.Text = "Chọn Map"
dropdown.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
dropdown.TextColor3 = Color3.new(1, 1, 1)
dropdown.Font = Enum.Font.SourceSansBold
dropdown.TextSize = 16
Instance.new("UICorner", dropdown).CornerRadius = UDim.new(0, 6)

-- Hộp tọa độ
local groundBox = makeBox("GroundBox", 50)
local delay1Box = makeBox("Delay1", 80, 0.5)
delay1Box.PlaceholderText = "Delay lên gần cúp"

local nearCupBox = makeBox("NearCupBox", 110)
local delay2Box = makeBox("Delay2", 140, 0.5)
delay2Box.PlaceholderText = "Delay đi tới cúp"

local cupBox = makeBox("CupBox", 170)
local delay3Box = makeBox("Delay3", 200, 0.5)
delay3Box.PlaceholderText = "Delay về lại đất"

-- Nút toggle
local toggle = Instance.new("TextButton", frame)
toggle.Text = "Bắt đầu Ní Ơi"
toggle.Size = UDim2.new(1, -20, 0, 35)
toggle.Position = UDim2.new(0, 10, 0, 240)
toggle.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.Font = Enum.Font.SourceSansBold
toggle.TextSize = 18
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 8)

local credit = Instance.new("TextLabel", frame)
credit.Position = UDim2.new(0, 10, 0, 285)
credit.Size = UDim2.new(1, -20, 0, 20)
credit.BackgroundTransparency = 1
credit.Text = "by Plnh"
credit.TextColor3 = Color3.fromRGB(150, 150, 150)
credit.Font = Enum.Font.SourceSansItalic
credit.TextSize = 14
credit.TextXAlignment = Enum.TextXAlignment.Right

local minimize = Instance.new("TextButton", gui)
minimize.Size = UDim2.new(0, 30, 0, 30)
minimize.Position = UDim2.new(0.5, 120, 0.5, -180)
minimize.Text = "Thu Gọn"
minimize.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
minimize.TextColor3 = Color3.new(1, 1, 1)
minimize.Font = Enum.Font.SourceSansBold
minimize.TextSize = 20
Instance.new("UICorner", minimize).CornerRadius = UDim.new(1, 0)

local minimized = false
minimize.MouseButton1Click:Connect(function()
	minimized = not minimized
	frame.Visible = not minimized
end)

local menu

dropdown.MouseButton1Click:Connect(function()
	if menu and menu.Parent then
		menu:Destroy()
		return
	end

	menu = Instance.new("Frame", frame)
	menu.Size = UDim2.new(1, -20, 0, 7 * 30)
	menu.Position = UDim2.new(0, 10, 0, 40)
	menu.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	menu.BorderSizePixel = 0
	Instance.new("UICorner", menu).CornerRadius = UDim.new(0, 6)

	for i = 1, 8 do
		local name = "Map" .. i
		local v = coords[name]
		if v then
			local b = Instance.new("TextButton", menu)
			b.Size = UDim2.new(1, 0, 0, 30)
			b.Position = UDim2.new(0, 0, 0, (i - 1) * 30)
			b.Text = name
			b.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
			b.TextColor3 = Color3.new(1, 1, 1)
			b.Font = Enum.Font.SourceSans
			b.TextSize = 17
			b.MouseButton1Click:Connect(function()
				groundBox.Text = v.ground
				nearCupBox.Text = v.nearCup
				cupBox.Text = v.cup
				menu:Destroy()
			end)
		end
	end
end)

-- Auto teleport logic
local running = false

local function toVec3(str)
	local s = string.split(str, ",")
	if #s ~= 3 then return nil end
	return Vector3.new(tonumber(s[1]), tonumber(s[2]), tonumber(s[3]))
end

local function teleport(vec)
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if root then root.CFrame = CFrame.new(vec) end
end

local function walkTo(vec)
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if root then
		local tween = TweenService:Create(root, TweenInfo.new(2, Enum.EasingStyle.Linear), {CFrame = CFrame.new(vec)})
		tween:Play()
	end
end

toggle.MouseButton1Click:Connect(function()
	running = not running
	toggle.Text = running and "Đang chạy..." or "Bắt đầu Auto"

	while running do
		local g = toVec3(groundBox.Text)
		local d1 = tonumber(delay1Box.Text)
		local n = toVec3(nearCupBox.Text)
		local d2 = tonumber(delay2Box.Text)
		local c = toVec3(cupBox.Text)
		local d3 = tonumber(delay3Box.Text)

		if g and d1 and n and d2 and c and d3 then
			teleport(g)
			task.wait(d1)
			teleport(n)
			task.wait(d2)
			walkTo(c)
			task.wait(d3)
		else
			warn("Dữ liệu không hợp lệ")
			break
		end
	end
end)

local VirtualUser = game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
	VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
	task.wait(1)
	VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)
