-- (Phần đầu giữ nguyên như bạn đã viết...)
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local VIM = game:GetService("VirtualInputManager")

local clickX, clickY = 538, 89
local lang = "vi"

local texts = {
	vi = {
		title = "🎣 Auto Câu Cá",
		bong_on = "🟢 Auto Bấm Bong: BẬT",
		bong_off = "🟢 Auto Bấm Bong: TẮT",
		cast_on = "🟢 Auto Quăng Cần: BẬT",
		cast_off = "🟢 Auto Quăng Cần: TẮT",
		lang_title = "🌐 Ngôn ngữ",
		toggle_ui = "👁 Ẩn/Hiện UI",
		lang_vi = "Tiếng Việt",
		lang_en = "English",
		lang_hi = "Tiếng Ấn Độ"
	},
	en = {
		title = "🎣 Auto Fishing",
		bong_on = "🟢 Auto Shake Rod: ON",
		bong_off = "🟢 Auto Shake Rod: OFF",
		cast_on = "🟢 Auto Cast: ON",
		cast_off = "🟢 Auto Cast: OFF",
		lang_title = "🌐 Language",
		toggle_ui = "👁 Toggle UI",
		lang_vi = "Vietnamese",
		lang_en = "English",
		lang_hi = "Hindi"
	},
	hi = {
		title = "🎣 ऑटो मछली पकड़ना",
		bong_on = "🟢 छड़ी हिलाएं: चालू",
		bong_off = "🟢 छड़ी हिलाएं: बंद",
		cast_on = "🟢 कांटा फेंको: चालू",
		cast_off = "🟢 कांटा फेंको: बंद",
		lang_title = "🌐 भाषा",
		toggle_ui = "👁 UI दिखाएं/छिपाएं",
		lang_vi = "वियतनामी",
		lang_en = "अंग्रेज़ी",
		lang_hi = "हिंदी"
	}
}

-- UI
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "FishingUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Position = UDim2.new(0, 100, 0, 100)
frame.Size = UDim2.new(0, 200, 0, 190)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 25)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 16
title.Font = Enum.Font.SourceSansBold

local autoBong = Instance.new("TextButton", frame)
autoBong.Size = UDim2.new(1, -20, 0, 30)
autoBong.Position = UDim2.new(0, 10, 0, 35)
autoBong.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
autoBong.TextColor3 = Color3.new(1, 1, 1)
autoBong.TextSize = 14
autoBong.Font = Enum.Font.SourceSans

local autoCast = Instance.new("TextButton", frame)
autoCast.Size = UDim2.new(1, -20, 0, 30)
autoCast.Position = UDim2.new(0, 10, 0, 70)
autoCast.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
autoCast.TextColor3 = Color3.new(1, 1, 1)
autoCast.TextSize = 14
autoCast.Font = Enum.Font.SourceSans

local langButton = Instance.new("TextButton", frame)
langButton.Size = UDim2.new(1, -20, 0, 25)
langButton.Position = UDim2.new(0, 10, 0, 110)
langButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
langButton.TextColor3 = Color3.new(1, 1, 1)
langButton.TextSize = 14
langButton.Font = Enum.Font.SourceSans

-- Dropdown menu
local langMenu = Instance.new("Frame", frame)
langMenu.Size = UDim2.new(1, -20, 0, 75)
langMenu.Position = UDim2.new(0, 10, 0, 135)
langMenu.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
langMenu.Visible = false
langMenu.BorderSizePixel = 0

local function createLangOption(id, order)
	local btn = Instance.new("TextButton", langMenu)
	btn.Size = UDim2.new(1, 0, 0, 25)
	btn.Position = UDim2.new(0, 0, 0, (order - 1) * 25)
	btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.SourceSans
	btn.TextSize = 14
	btn.Text = texts[lang]["lang_"..id]
	btn.MouseButton1Click:Connect(function()
		lang = id
		updateTexts()
		langMenu.Visible = false
	end)
	return btn
end

createLangOption("vi", 1)
createLangOption("en", 2)
createLangOption("hi", 3)

local toggleBtn = Instance.new("TextButton", gui)
toggleBtn.Size = UDim2.new(0, 120, 0, 30)
toggleBtn.Position = UDim2.new(0, 10, 0, 10)
toggleBtn.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.TextSize = 14
toggleBtn.Font = Enum.Font.SourceSans

-- Biến
local isBong, isCast, isVisible = false, false, true
local remote = game:GetService("ReplicatedStorage"):WaitForChild("Msg"):WaitForChild("RemoteEvent")

-- Cập nhật UI
function updateTexts()
	local t = texts[lang]
	title.Text = t.title
	autoBong.Text = isBong and t.bong_on or t.bong_off
	autoCast.Text = isCast and t.cast_on or t.cast_off
	langButton.Text = t.lang_title
	toggleBtn.Text = t.toggle_ui

	for i, child in ipairs(langMenu:GetChildren()) do
		if child:IsA("TextButton") then
			local id = child.Name
			child.Text = texts[lang]["lang_" .. id]
		end
	end
end

-- Auto run
task.spawn(function()
	while true do
		if isBong then
			pcall(function()
				remote:FireServer("摇晃鱼竿")
			end)
		end
		wait(0.2)
	end
end)

task.spawn(function()
	while true do
		if isCast then
			VIM:SendMouseButtonEvent(clickX, clickY, 0, true, game, 1)
			wait(0.05)
			VIM:SendMouseButtonEvent(clickX, clickY, 0, false, game, 1)
			wait(1.2)
		end
		wait(0.2)
	end
end)

-- Sự kiện
autoBong.MouseButton1Click:Connect(function()
	isBong = not isBong
	updateTexts()
	autoBong.BackgroundColor3 = isBong and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(60, 60, 60)
end)

autoCast.MouseButton1Click:Connect(function()
	isCast = not isCast
	updateTexts()
	autoCast.BackgroundColor3 = isCast and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(60, 60, 60)
end)

langButton.MouseButton1Click:Connect(function()
	langMenu.Visible = not langMenu.Visible
end)

toggleBtn.MouseButton1Click:Connect(function()
	isVisible = not isVisible
	frame.Visible = isVisible
end)

updateTexts()
