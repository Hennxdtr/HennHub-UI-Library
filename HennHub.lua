--==[ HennHub UI - Modular Version ]==--

if _G.HennHub then return end
_G.HennHub = {}
local HennHub = _G.HennHub

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "HennHubUI"
gui.ResetOnSpawn = false

-- Sidebar
local sidebar = Instance.new("Frame", gui)
sidebar.Size = UDim2.new(0, 140, 1, 0)
sidebar.Position = UDim2.new(0, 0, 0, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
sidebar.BorderSizePixel = 0
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 8)

local sidebarLayout = Instance.new("UIListLayout", sidebar)
sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
sidebarLayout.Padding = UDim.new(0, 4)

-- Logo
local logo = Instance.new("ImageLabel", sidebar)
logo.Size = UDim2.new(1, 0, 0, 80)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://101077289426466"
logo.ScaleType = Enum.ScaleType.Fit

-- Main Frame
local mainFrame = Instance.new("Frame", gui)
mainFrame.Position = UDim2.new(0, 160, 0.15, 0)
mainFrame.Size = UDim2.new(0, 420, 0, 320)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 0
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

-- Title
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, -20, 0, 40)
title.Position = UDim2.new(0, 10, 0, 10)
title.BackgroundTransparency = 1
title.Text = "Tools"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.Cartoon
title.TextSize = 28
title.TextXAlignment = Enum.TextXAlignment.Left

-- Layout isi konten
local contentLayout = Instance.new("UIListLayout", mainFrame)
contentLayout.Padding = UDim.new(0, 6)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.VerticalAlignment = Enum.VerticalAlignment.Top
contentLayout.FillDirection = Enum.FillDirection.Vertical

-- == Fungsi Publik == --

function HennHub:CreateTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 36)
    btn.Position = UDim2.new(0, 5, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.Text = name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.Parent = sidebar
    return btn
end

function HennHub:AddToggle(text, callback)
    local frame = Instance.new("Frame", mainFrame)
    frame.Size = UDim2.new(1, -20, 0, 40)
    frame.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", frame)
    label.Text = text
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left

    local toggle = Instance.new("TextButton", frame)
    toggle.Size = UDim2.new(0, 60, 0, 28)
    toggle.Position = UDim2.new(1, -70, 0.5, -14)
    toggle.Text = ""
    toggle.BorderSizePixel = 0
    toggle.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 8)

    local isOn = false
    toggle.MouseButton1Click:Connect(function()
        isOn = not isOn
        toggle.BackgroundColor3 = isOn and Color3.fromRGB(50, 220, 50) or Color3.fromRGB(220, 50, 50)
        if callback then
            pcall(function()
                callback(isOn)
            end)
        end
    end)
end
