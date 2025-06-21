local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Rainbow Border Color
local function getRainbowColor()
	local t = tick() % 5
	return Color3.fromHSV(t / 5, 1, 1)
end

-- GUI setup
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "MultiTabUI"
gui.ResetOnSpawn = false

-- Main Container
local Main = Instance.new("Frame", gui)
Main.Size = UDim2.new(0, 360, 0, 280)
Main.Position = UDim2.new(0.3, 0, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.BorderSizePixel = 0

local MainCorner = Instance.new("UICorner", Main)
MainCorner.CornerRadius = UDim.new(0, 12)

-- Rainbow border frame
local Border = Instance.new("Frame", Main)
Border.Size = UDim2.new(1, 4, 1, 4)
Border.Position = UDim2.new(0, -2, 0, -2)
Border.BackgroundColor3 = Color3.new(1, 0, 0)
Border.ZIndex = 0

local BorderCorner = Instance.new("UICorner", Border)
BorderCorner.CornerRadius = UDim.new(0, 14)

-- Tab Buttons
local tabs = {"Main", "Fram", "Tete"}
local tabFrames = {}

for i, tabName in ipairs(tabs) do
	local tabBtn = Instance.new("TextButton", Main)
	tabBtn.Size = UDim2.new(0, 100, 0, 30)
	tabBtn.Position = UDim2.new(0, 10 + (i - 1) * 110, 0, 10)
	tabBtn.Text = tabName
	tabBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	tabBtn.TextColor3 = Color3.new(1, 1, 1)
	tabBtn.BorderSizePixel = 0

	local tabFrame = Instance.new("Frame", Main)
	tabFrame.Size = UDim2.new(1, -20, 1, -50)
	tabFrame.Position = UDim2.new(0, 10, 0, 45)
	tabFrame.BackgroundTransparency = 1
	tabFrame.Visible = (i == 1)

	tabFrames[tabName] = tabFrame

	tabBtn.MouseButton1Click:Connect(function()
		for _, frame in pairs(tabFrames) do
			frame.Visible = false
		end
		tabFrame.Visible = true
	end)
end

-- TELEPORT TAB CONTENT
local teleFrame = Instance.new("Frame", tabFrames["Tete"])
teleFrame.Size = UDim2.new(1, 0, 1, 0)
teleFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
teleFrame.BorderSizePixel = 0

local teleCorner = Instance.new("UICorner", teleFrame)
teleCorner.CornerRadius = UDim.new(0, 12)

-- Tên và list toạ độ (sẽ cập nhật sau)
local listLabel = Instance.new("TextLabel", teleFrame)
listLabel.Size = UDim2.new(1, -20, 0, 30)
listLabel.Position = UDim2.new(0, 10, 0, 10)
listLabel.Text = "📍 Danh sách tọa độ (sẽ thêm sau)"
listLabel.TextColor3 = Color3.new(1, 1, 1)
listLabel.BackgroundTransparency = 1
listLabel.TextScaled = true

-- Ô nhập delay1
local delay1 = Instance.new("TextBox", teleFrame)
delay1.PlaceholderText = "Delay 1 (giây)"
delay1.Size = UDim2.new(0, 150, 0, 30)
delay1.Position = UDim2.new(0, 10, 0, 50)
delay1.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
delay1.TextColor3 = Color3.new(1, 1, 1)

local corner1 = Instance.new("UICorner", delay1)
corner1.CornerRadius = UDim.new(0, 8)

-- Ô nhập delay2
local delay2 = Instance.new("TextBox", teleFrame)
delay2.PlaceholderText = "Delay 2 (giây)"
delay2.Size = UDim2.new(0, 150, 0, 30)
delay2.Position = UDim2.new(0, 170, 0, 50)
delay2.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
delay2.TextColor3 = Color3.new(1, 1, 1)

local corner2 = Instance.new("UICorner", delay2)
corner2.CornerRadius = UDim.new(0, 8)

-- Toggle Switch
local toggleBtn = Instance.new("TextButton", teleFrame)
toggleBtn.Size = UDim2.new(0, 100, 0, 30)
toggleBtn.Position = UDim2.new(0, 10, 0, 100)
toggleBtn.Text = "Tắt Tele"
toggleBtn.BackgroundColor3 = Color3.fromRGB(100, 40, 40)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)

local toggleCorner = Instance.new("UICorner", toggleBtn)
toggleCorner.CornerRadius = UDim.new(0, 8)

-- Rainbow border loop
RunService.RenderStepped:Connect(function()
	Border.BackgroundColor3 = getRainbowColor()
end)

-- === BẮT ĐẦU PHẦN THÊM VÀO === --

-- Danh sách toạ độ cố định
local ToaDoList = {
	["Lấy Nước"] = Vector3.new(-42.1, -2.6, -253.1),
	["Trạm Nạp"] = Vector3.new(6.6, 2.2, 12.9),
}

-- Dropdown chọn toạ độ
local selectedName = "Lấy Nước"
local dropdown = Instance.new("TextButton", teleFrame)
dropdown.Size = UDim2.new(0, 310, 0, 30)
dropdown.Position = UDim2.new(0, 10, 0, 140)
dropdown.Text = "📍 Chọn: Lấy Nước"
dropdown.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
dropdown.TextColor3 = Color3.new(1, 1, 1)

local dropdownCorner = Instance.new("UICorner", dropdown)
dropdownCorner.CornerRadius = UDim.new(0, 8)

-- Danh sách chọn
local menu = Instance.new("Frame", teleFrame)
menu.Size = UDim2.new(0, 310, 0, 60)
menu.Position = UDim2.new(0, 10, 0, 170)
menu.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
menu.Visible = false
menu.BorderSizePixel = 0
menu.ZIndex = 2

local menuCorner = Instance.new("UICorner", menu)
menuCorner.CornerRadius = UDim.new(0, 8)

for name, vec in pairs(ToaDoList) do
	local option = Instance.new("TextButton", menu)
	option.Size = UDim2.new(1, 0, 0, 30)
	option.Position = UDim2.new(0, 0, 0, (#menu:GetChildren() - 1) * 30)
	option.Text = name
	option.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	option.TextColor3 = Color3.new(1, 1, 1)
	option.BorderSizePixel = 0

	option.MouseButton1Click:Connect(function()
		selectedName = name
		dropdown.Text = "📍 Chọn: " .. name
		menu.Visible = false
	end)
end

dropdown.MouseButton1Click:Connect(function()
	menu.Visible = not menu.Visible
end)

menu.Parent = teleFrame

-- Teleport Toggle Logic
local teleporting = false
toggleBtn.MouseButton1Click:Connect(function()
	teleporting = not teleporting
	toggleBtn.Text = teleporting and "Đang Tele" or "Tắt Tele"
	toggleBtn.BackgroundColor3 = teleporting and Color3.fromRGB(40, 100, 40) or Color3.fromRGB(100, 40, 40)
end)

-- Teleport loop
spawn(function()
	local toggle = true
	while true do
		if teleporting then
			local pos1 = ToaDoList["Lấy Nước"]
			local pos2 = ToaDoList["Trạm Nạp"]
			local d1 = tonumber(delay1.Text) or 1
			local d2 = tonumber(delay2.Text) or 1

			if toggle then
				LocalPlayer.Character:MoveTo(pos1)
				wait(d1)
			else
				LocalPlayer.Character:MoveTo(pos2)
				wait(d2)
			end
			toggle = not toggle
		end
		wait(0.1)
	end
end)

-- === KẾT THÚC PHẦN THÊM VÀO === --
-- 🌟 Nút bật/tắt UI chính (draggable)
local toggleUIBtn = Instance.new("TextButton", gui)
toggleUIBtn.Size = UDim2.new(0, 120, 0, 35)
toggleUIBtn.Position = UDim2.new(0, 20, 0, 20)
toggleUIBtn.Text = "Ẩn UI"
toggleUIBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleUIBtn.TextColor3 = Color3.new(1, 1, 1)
toggleUIBtn.TextScaled = true
toggleUIBtn.BorderSizePixel = 0
toggleUIBtn.ZIndex = 100

local corner = Instance.new("UICorner", toggleUIBtn)
corner.CornerRadius = UDim.new(0, 8)

-- Kéo nút
local dragging, dragInput, dragStart, startPos

toggleUIBtn.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = toggleUIBtn.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

toggleUIBtn.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

RunService.RenderStepped:Connect(function()
	if dragging and dragInput then
		local delta = dragInput.Position - dragStart
		toggleUIBtn.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

-- Ẩn/hiện UI chính
local uiVisible = true
toggleUIBtn.MouseButton1Click:Connect(function()
	uiVisible = not uiVisible
	Main.Visible = uiVisible
	toggleUIBtn.Text = uiVisible and "Ẩn UI" or "Hiện UI"
end)
