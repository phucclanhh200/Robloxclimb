local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local remote = ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteEvent")

local function applyRainbowBorder(frame)
	local stroke = Instance.new("UIStroke", frame)
	stroke.Thickness = 4

	task.spawn(function()
		while stroke and stroke.Parent do
			local hue = (tick() % 5) / 5
			stroke.Color = Color3.fromHSV(hue, 1, 1)
			task.wait(0.05)
		end
	end)
end

-- Language system
local currentLanguage = "vi"
local isFramTien = false
local isFramWin = false

local lang = {
	vi = {
		toggleUI = "👁️ Ẩn / Hiện Giao Diện",
		tabFram = "Tự động",
		tabLang = "Ngôn ngữ",
		framTien = "🔁 Bật Cày Tiền",
		framTienOn = "✅ Đang Cày Tiền...",
		framWins = "🔁 Bật Nhận Thưởng",
		framWinsOn = "✅ Đang Nhận Thưởng...",
		heightPlaceholder = "Chiều cao (VD: 14397)",
		stepPlaceholder = "Số bước",
		delayPlaceholder = "Delay mỗi bước"
	},
	en = {
		toggleUI = "👁️ Toggle UI",
		tabFram = "Auto",
		tabLang = "Language",
		framTien = "🔁 Enable Money Farm",
		framTienOn = "✅ Farming Money...",
		framWins = "🔁 Enable Auto Claim",
		framWinsOn = "✅ Claiming Wins...",
		heightPlaceholder = "Enter height (e.g. 14397)",
		stepPlaceholder = "Step count",
		delayPlaceholder = "Step delay"
	},
	hi = {
		toggleUI = "👁️ UI चालू/छिपाएं",
		tabFram = "ऑटो",
		tabLang = "भाषा",
		framTien = "🔁 पैसे कमाएं",
		framTienOn = "✅ पैसे कमाना...",
		framWins = "🔁 जीतें प्राप्त करें",
		framWinsOn = "✅ जीतें प्राप्त कर रहे हैं...",
		heightPlaceholder = "ऊंचाई दर्ज करें",
		stepPlaceholder = "कदमों की संख्या",
		delayPlaceholder = "प्रत्येक कदम की देरी"
	},
	id = {
		toggleUI = "👁️ Tampilkan/Sembunyikan UI",
		tabFram = "Otomatis",
		tabLang = "Bahasa",
		framTien = "🔁 Aktifkan Bertani Uang",
		framTienOn = "✅ Bertani Uang...",
		framWins = "🔁 Klaim Menang",
		framWinsOn = "✅ Mengklaim...",
		heightPlaceholder = "Masukkan tinggi",
		stepPlaceholder = "Jumlah langkah",
		delayPlaceholder = "Delay tiap langkah"
	}
}

-- Main UI
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "FullUI"
local mainFrame = Instance.new("Frame", gui)
mainFrame.Position = UDim2.new(0, 100, 0, 100)
mainFrame.Size = UDim2.new(0, 300, 0, 250)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.Active = true
mainFrame.Draggable = true
applyRainbowBorder(mainFrame)
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

-- Toggle UI button
local toggleUIBtn = Instance.new("TextButton", gui)
toggleUIBtn.Size = UDim2.new(0, 120, 0, 40)
toggleUIBtn.Position = UDim2.new(0, 10, 0, 10)
toggleUIBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggleUIBtn.TextColor3 = Color3.new(1, 1, 1)
toggleUIBtn.TextSize = 5
toggleUIBtn.Text = lang[currentLanguage].toggleUI
Instance.new("UICorner", toggleUIBtn).CornerRadius = UDim.new(0, 12)
toggleUIBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

-- Tabs
local tabFramBtn = Instance.new("TextButton", mainFrame)
tabFramBtn.Position = UDim2.new(0, 10, 0, 10)
tabFramBtn.Size = UDim2.new(0, 120, 0, 30)
tabFramBtn.Text = lang[currentLanguage].tabFram
tabFramBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
tabFramBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", tabFramBtn)

local tabLangBtn = Instance.new("TextButton", mainFrame)
tabLangBtn.Position = UDim2.new(0, 140, 0, 10)
tabLangBtn.Size = UDim2.new(0, 120, 0, 30)
tabLangBtn.Text = lang[currentLanguage].tabLang
tabLangBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
tabLangBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", tabLangBtn)

-- Fram tab
local framTab = Instance.new("Frame", mainFrame)
framTab.Position = UDim2.new(0, 10, 0, 45)
framTab.Size = UDim2.new(1, -20, 1, -55)
framTab.BackgroundColor3 = Color3.fromRGB(50,50,50)
Instance.new("UICorner", framTab)

local btnFramTien = Instance.new("TextButton", framTab)
btnFramTien.Position = UDim2.new(0, 10, 0, 10)
btnFramTien.Size = UDim2.new(1, -20, 0, 35)
btnFramTien.Text = lang[currentLanguage].framTien
btnFramTien.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
btnFramTien.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", btnFramTien)

local btnFramWin = Instance.new("TextButton", framTab)
btnFramWin.Position = UDim2.new(0, 10, 0, 50)
btnFramWin.Size = UDim2.new(1, -20, 0, 35)
btnFramWin.Text = lang[currentLanguage].framWins
btnFramWin.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
btnFramWin.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", btnFramWin)

local heightBox = Instance.new("TextBox", framTab)
heightBox.Position = UDim2.new(0, 10, 0, 90)
heightBox.Size = UDim2.new(1, -20, 0, 30)
heightBox.PlaceholderText = lang[currentLanguage].heightPlaceholder
heightBox.Text = ""
heightBox.TextColor3 = Color3.new(1,1,1)
heightBox.BackgroundColor3 = Color3.fromRGB(70,70,70)
Instance.new("UICorner", heightBox)

local stepBox = Instance.new("TextBox", framTab)
stepBox.Position = UDim2.new(0, 10, 0, 125)
stepBox.Size = UDim2.new(1, -20, 0, 30)
stepBox.PlaceholderText = lang[currentLanguage].stepPlaceholder
stepBox.Text = "100"
stepBox.TextColor3 = Color3.new(1,1,1)
stepBox.BackgroundColor3 = Color3.fromRGB(70,70,70)
Instance.new("UICorner", stepBox)

local delayBox = Instance.new("TextBox", framTab)
delayBox.Position = UDim2.new(0, 10, 0, 160)
delayBox.Size = UDim2.new(1, -20, 0, 30)
delayBox.PlaceholderText = lang[currentLanguage].delayPlaceholder
delayBox.Text = "0.1"
delayBox.TextColor3 = Color3.new(1,1,1)
delayBox.BackgroundColor3 = Color3.fromRGB(70,70,70)
Instance.new("UICorner", delayBox)

-- Lang tab
local langTab = Instance.new("Frame", mainFrame)
langTab.Position = framTab.Position
langTab.Size = framTab.Size
langTab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
langTab.Visible = false
Instance.new("UICorner", langTab)

-- Tab switch
tabFramBtn.MouseButton1Click:Connect(function()
	framTab.Visible = true
	langTab.Visible = false
end)
tabLangBtn.MouseButton1Click:Connect(function()
	framTab.Visible = false
	langTab.Visible = true
end)

-- Language buttons
local function addLangButton(code, label, y)
	local b = Instance.new("TextButton", langTab)
	b.Size = UDim2.new(1, -20, 0, 30)
	b.Position = UDim2.new(0, 10, 0, y)
	b.Text = label
	b.BackgroundColor3 = Color3.fromRGB(80,80,80)
	b.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner", b)
	b.MouseButton1Click:Connect(function()
		currentLanguage = code
		applyLang()
	end)
end

addLangButton("vi", "🇻🇳 Việt Nam", 10)
addLangButton("en", "🇺🇸 English", 50)
addLangButton("hi", "🇮🇳 Hindi", 90)
addLangButton("id", "🇮🇩 Indo", 130)

-- Apply Language
function applyLang()
	local l = lang[currentLanguage]
	toggleUIBtn.Text = l.toggleUI
	tabFramBtn.Text = l.tabFram
	tabLangBtn.Text = l.tabLang
	btnFramTien.Text = isFramTien and l.framTienOn or l.framTien
	btnFramWin.Text = isFramWin and l.framWinsOn or l.framWins
	heightBox.PlaceholderText = l.heightPlaceholder
	stepBox.PlaceholderText = l.stepPlaceholder
	delayBox.PlaceholderText = l.delayPlaceholder
end

-- Logic Fram
btnFramTien.MouseButton1Click:Connect(function()
	isFramTien = not isFramTien
	btnFramTien.Text = isFramTien and lang[currentLanguage].framTienOn or lang[currentLanguage].framTien
end)
btnFramWin.MouseButton1Click:Connect(function()
	isFramWin = not isFramWin
	btnFramWin.Text = isFramWin and lang[currentLanguage].framWinsOn or lang[currentLanguage].framWins
end)

coroutine.wrap(function()
	while true do
		if isFramTien then
			local h = tonumber(heightBox.Text)
			local s = tonumber(stepBox.Text)
			local d = tonumber(delayBox.Text)
			if h and s and d then
				local stepHeight = h / s
				for i = 1, s do
					if not isFramTien then break end
					remote:FireServer("起跳", stepHeight * i)
					wait(d)
				end
				remote:FireServer("落地", true)
			end
		end
		wait()
	end
end)()

coroutine.wrap(function()
	while true do
		if isFramWin then
			remote:FireServer("领取楼顶wins")
		end
		wait(8)
	end
end)()

local footer = Instance.new("TextLabel", mainFrame)
footer.Size = UDim2.new(1, -20, 0, 20)
footer.Position = UDim2.new(0, 10, 1, -25)
footer.BackgroundTransparency = 1
footer.Text = "py plnh"
footer.TextColor3 = Color3.fromRGB(200, 200, 200)
footer.TextSize = 12
footer.Font = Enum.Font.SourceSansItalic
footer.TextXAlignment = Enum.TextXAlignment.Right

applyLang()
