 k)
		return self[k]
	end
})

end

return HennHub

-- HennHub UI Library Module -- Author: Not Henn -- GitHub: https://github.com/Hennxdtr/HennHub-UI -- Version: 1.0.0

local HennHub = {} HennHub.__index = HennHub

local Players = game:GetService("Players") local LocalPlayer = Players.LocalPlayer local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

function HennHub:CreateWindow(config) local self = setmetatable({}, HennHub)

-- Main UI
local ui = Instance.new("ScreenGui")
ui.Name = "HennHubUI"
ui.ResetOnSpawn = false
ui.Parent = PlayerGui

-- Main Frame
local frame = Instance.new("Frame")
frame.Size = config.Size or UDim2.new(0, 640, 0, 480)
frame.Position = UDim2.new(0.5, -frame.Size.X.Offset / 2, 0.5, -frame.Size.Y.Offset / 2)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BorderSizePixel = 0
frame.Visible = false
frame.Parent = ui
frame.Active = true
frame.Draggable = config.Draggable ~= false

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

-- Header
local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 180, 0, 30)
title.Position = UDim2.new(0.5, -90, 0, -15)
title.BackgroundTransparency = 1
title.Text = config.Name or "HennHub"
title.TextColor3 = config.TitleColor or Color3.fromRGB(0, 170, 255)
title.Font = Enum.Font.Cartoon
title.TextSize = 24
title.TextStrokeTransparency = 0.4
title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
title.Parent = frame

-- Toggle Button (H Button)
local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(0, 60, 0, 60)
toggle.Position = UDim2.new(0, 10, 0.5, -30)
toggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
toggle.Text = "H"
toggle.TextSize = 26
toggle.TextColor3 = Color3.fromRGB(255, 0, 0)
toggle.Font = Enum.Font.GothamBold
toggle.Parent = ui
toggle.Active = true
toggle.Draggable = true

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(1, 0)
toggleCorner.Parent = toggle

toggle.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
	toggle.TextColor3 = frame.Visible and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
end)

-- Sidebar
local sidebar = Instance.new("ScrollingFrame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 160, 1, 0)
sidebar.Position = UDim2.new(0, 0, 0, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
sidebar.BorderSizePixel = 0
sidebar.ScrollBarThickness = 6
sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y
sidebar.ScrollingDirection = Enum.ScrollingDirection.Y
sidebar.Parent = frame

local sidebarLayout = Instance.new("UIListLayout")
sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
sidebarLayout.Padding = UDim.new(0, 10)
sidebarLayout.Parent = sidebar

-- Content Frame
local contentFrame = Instance.new("Frame")
contentFrame.Name = "Content"
contentFrame.Size = UDim2.new(1, -180, 1, -20)
contentFrame.Position = UDim2.new(0, 170, 0, 10)
contentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = frame

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 10)
contentCorner.Parent = contentFrame

self.Tabs = {}
self.Sidebar = sidebar
self.Content = contentFrame
self.Frame = frame
self.GUI = ui

function self:Destroy()
	ui:Destroy()
end

return self

end

function HennHub:MakeTab(config) local tab = Instance.new("Frame") tab.Name = config.Name .. "Tab" tab.Size = UDim2.new(1, 0, 1, 0) tab.BackgroundTransparency = 1 tab.Visible = false tab.Parent = self.Content

local layout = Instance.new("UIListLayout")
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 10)
layout.Parent = tab

local button = Instance.new("TextButton")
button.Name = config.Name .. "Button"
button.Size = UDim2.new(1, -20, 0, 40)
button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 20
button.Text = config.Name
button.Parent = self.Sidebar

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = button

button.MouseButton1Click:Connect(function()
	for _, t in pairs(self.Tabs) do
		t.Visible = false
	end
	tab.Visible = true
end)

self.Tabs[config.Name] = tab

return setmetatable({
	Frame = tab,
	AddButton = function(_, btnCfg)
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(0, 140, 0, 40)
		btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		btn.Font = Enum.Font.SourceSansBold
		btn.TextSize = 18
		btn.Text = btnCfg.Text
		btn.Parent = tab

		local btnCorner = Instance.new("UICorner")
		btnCorner.CornerRadius = UDim.new(0, 6)
		btnCorner.Parent = btn

		btn.MouseButton1Click:Connect(function()
			pcall(btnCfg.Callback)
		end)
	end
}, {
	__index = function(_, k)
		return self[k]
	end
})

end

return HennHub

