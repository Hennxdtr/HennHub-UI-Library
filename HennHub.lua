--==[ HennHub UI - Library Version ]==--

if _G.HennHub then return end
_G.HennHub = {}
local HennHub = _G.HennHub

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "HennHubUI"
gui.ResetOnSpawn = false

-- Sidebar
local sidebar = Instance.new("Frame", gui)
sidebar.Size = UDim2.new(0, 160, 1, 0)
sidebar.Position = UDim2.new(0, 0, 0, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
sidebar.BorderSizePixel = 0
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 10)

local sidebarLayout = Instance.new("UIListLayout", sidebar)
sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
sidebarLayout.Padding = UDim.new(0, 4)

-- Logo (ganti ID sesuai logo kamu)
local logo = Instance.new("ImageLabel", sidebar)
logo.Size = UDim2.new(1, 0, 0, 100)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://101077289426466"
logo.ScaleType = Enum.ScaleType.Fit

-- Main Frame
local mainFrame = Instance.new("Frame", gui)
mainFrame.Position = UDim2.new(0, 180, 0.15, 0)
mainFrame.Size = UDim2.new(0, 420, 0, 340)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

-- == Fungsi Public == --

-- Membuat Tab Sidebar
function HennHub:CreateTab(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.Position = UDim2.new(0, 5, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.Text = name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.Parent = sidebar

    btn.MouseButton1Click:Connect(function()
        for _, v in pairs(sidebar:GetChildren()) do
            if v:IsA("TextButton") then
                v.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            end
        end
        btn.BackgroundColor3 = Color3.fromRGB(0, 170, 255) -- Warna aktif
        if callback then
            pcall(callback)
        end
    end)
end

-- Membuat Toggle di Main Frame
function HennHub:AddToggle(text, callback)
    local frame = Instance.new("Frame", mainFrame)
    frame.Size = UDim2.new(1, -20, 0, 50)
    frame.Position = UDim2.new(0, 10, 0, 0)
    frame.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", frame)
    label.Text = text
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left

    local toggle = Instance.new("TextButton", frame)
    toggle.Size = UDim2.new(0, 50, 0, 28)
    toggle.Position = UDim2.new(1, -60, 0.5, -14)
    toggle.Text = ""
    toggle.BorderSizePixel = 0
    toggle.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
    Instance.new("UICorner", toggle).CornerRadius = UDim.new(1, 0)

    local isOn = false
    toggle.MouseButton1Click:Connect(function()
        isOn = not isOn
        toggle.BackgroundColor3 = isOn and Color3.fromRGB(50, 220, 50) or Color3.fromRGB(150, 150, 150)
        if callback then
            pcall(function()
                callback(isOn)
            end)
        end
    end)
end

-- == Example Penggunaan ==
-- HennHub:CreateTab("Contoh Tab", function() print("Tab Dipilih") end)
-- HennHub:AddToggle("Auto Something", function(state) print("Toggle:", state) end)
