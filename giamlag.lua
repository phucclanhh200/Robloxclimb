-- 📦 Giao diện chính
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "SuperLowGraphicsUI"

-- Giao diện chính
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 200)
frame.Position = UDim2.new(0, 20, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.Visible = false
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local layout = Instance.new("UIListLayout", frame)
layout.Padding = UDim.new(0, 8)
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- Hàm tạo nút
local function createButton(text, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -20, 0, 40)
	btn.Position = UDim2.new(0, 10, 0, 0)
	btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.Text = text
	btn.Parent = frame
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
	btn.MouseButton1Click:Connect(callback)
end

-- 1. Nút giảm đồ họa cực thấp
createButton("🧊 Giảm Đồ Họa Cực Thấp", function()
	for _, v in pairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Material = Enum.Material.SmoothPlastic
			v.Reflectance = 0
		elseif v:IsA("Decal") or v:IsA("Texture") then
			v:Destroy()
		end
	end
	for _, v in pairs(game:GetDescendants()) do
		if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
			v:Destroy()
		end
	end
	local lighting = game:GetService("Lighting")
	lighting.GlobalShadows = false
	lighting.FogEnd = 1e10
	lighting.Brightness = 0
	pcall(function()
		sethiddenproperty(lighting, "Technology", Enum.Technology.Compatibility)
	end)
end)

-- 2. Nút giảm phân giải
createButton("🔲 Giảm Độ Phân Giải 50%", function()
	pcall(function()
		settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
	end)
end)

-- 3. Phục hồi đồ họa
createButton("🔁 Khôi Phục Đồ Họa", function()
	settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
	game:GetService("Lighting").GlobalShadows = true
	game:GetService("Lighting").FogEnd = 100000
end)

-- 4. Chống AFK
game:GetService("Players").LocalPlayer.Idled:Connect(function()
	game:GetService("VirtualUser"):Button2Down(Vector2.new())
	wait(1)
	game:GetService("VirtualUser"):Button2Up(Vector2.new())
end)

-- 📌 Nút bật/tắt UI có thể kéo
local toggleBtn = Instance.new("TextButton", gui)
toggleBtn.Size = UDim2.new(0, 100, 0, 40)
toggleBtn.Position = UDim2.new(0, 10, 0, 40)
toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleBtn.Text = "⚙️ Menu"
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.Gotham
toggleBtn.TextSize = 14
toggleBtn.Active = true
toggleBtn.Draggable = true
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 10)

toggleBtn.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

-- 📈 FPS Hiển thị + Giới hạn FPS
local fpsLabel = Instance.new("TextLabel", gui)
fpsLabel.Size = UDim2.new(0, 120, 0, 30)
fpsLabel.Position = UDim2.new(1, -130, 0, 10)
fpsLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
fpsLabel.TextColor3 = Color3.new(0, 1, 0)
fpsLabel.Text = "FPS: 25"
fpsLabel.TextXAlignment = Enum.TextXAlignment.Left
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.TextSize = 14
fpsLabel.BackgroundTransparency = 0.5
Instance.new("UICorner", fpsLabel).CornerRadius = UDim.new(0, 8)

-- ⚙️ Khóa FPS tầm 25 bằng delay (0.04s/frame)
spawn(function()
	local RunService = game:GetService("RunService")
	local fps = 0
	local lastTime = tick()
	local frames = 0
	while true do
		RunService.RenderStepped:Wait(0.04) -- 1 / 0.04 ≈ 25 FPS
		frames += 1
		if tick() - lastTime >= 1 then
			fps = frames
			fpsLabel.Text = "FPS: " .. tostring(fps)
			frames = 0
			lastTime = tick()
		end
	end
end)
