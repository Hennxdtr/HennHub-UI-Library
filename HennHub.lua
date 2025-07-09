-- HennHub UI Library with Toggle Buttons

local HennHub = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

function HennHub:MakeWindow(options)
    options = options or {}

    local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
    gui.Name = options.Name or "HennHubUI"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true

    local mainFrame = Instance.new("Frame", gui)
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 460, 0, 360)
    mainFrame.Position = UDim2.new(0.5, -230, 0.5, -180)
    mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true

    local sidebar = Instance.new("ScrollingFrame", mainFrame)
    sidebar.Name = "Sidebar"
    sidebar.Size = UDim2.new(0, 120, 1, 0)
    sidebar.Position = UDim2.new(0, 0, 0, 0)
    sidebar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    sidebar.BorderSizePixel = 0
    sidebar.ScrollBarThickness = 5
    sidebar.CanvasSize = UDim2.new(0, 0, 1.5, 0)

    local sidebarLayout = Instance.new("UIListLayout", sidebar)
    sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
    sidebarLayout.Padding = UDim.new(0, 0)

    local contentFrame = Instance.new("ScrollingFrame", mainFrame)
    contentFrame.Name = "Content"
    contentFrame.Position = UDim2.new(0, 130, 0, 0)
    contentFrame.Size = UDim2.new(1, -130, 1, 0)
    contentFrame.BackgroundTransparency = 1
    contentFrame.BorderSizePixel = 0
    contentFrame.ScrollBarThickness = 6
    contentFrame.CanvasSize = UDim2.new(0, 0, 1.5, 0)

    local contentLayout = Instance.new("UIListLayout", contentFrame)
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, 6)

    local tabs = {}
    local activeTab = nil

    local function switchTab(tabName)
        for _, tab in pairs(tabs) do
            tab.button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            tab.frame.Visible = false
        end
        if tabs[tabName] then
            tabs[tabName].button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            tabs[tabName].frame.Visible = true
            activeTab = tabName
        end
    end

    local window = {}

    function window:MakeTab(tabOptions)
        local name = tabOptions.Name or "Tab"

        local tabButton = Instance.new("TextButton", sidebar)
        tabButton.Size = UDim2.new(1, 0, 0, 50)
        tabButton.Text = name
        tabButton.Font = Enum.Font.Cartoon
        tabButton.TextSize = 18
        tabButton.TextColor3 = Color3.new(1, 1, 1)
        tabButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        tabButton.BorderSizePixel = 0

        local tabContent = Instance.new("Frame")
        tabContent.Size = UDim2.new(1, 0, 0, 0)
        tabContent.BackgroundTransparency = 1
        tabContent.Visible = false
        tabContent.Parent = contentFrame

        local tabContentLayout = Instance.new("UIListLayout", tabContent)
        tabContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        tabContentLayout.Padding = UDim.new(0, 6)

        local tab = {
            name = name,
            button = tabButton,
            frame = tabContent
        }

        tabs[name] = tab

        tabButton.MouseButton1Click:Connect(function()
            switchTab(name)
        end)

        if not activeTab then
            switchTab(name)
        end

        function tab:AddButton(text, callback)
            local row = Instance.new("Frame", tabContent)
            row.Size = UDim2.new(1, -10, 0, 44)
            row.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            row.BorderSizePixel = 0

            local label = Instance.new("TextLabel", row)
            label.AnchorPoint = Vector2.new(0, 0.5)
            label.Position = UDim2.new(0, 12, 0.5, 0)
            label.Size = UDim2.new(1, -100, 0, 30)
            label.BackgroundTransparency = 1
            label.Text = text
            label.Font = Enum.Font.Cartoon
            label.TextSize = 18
            label.TextColor3 = Color3.new(1, 1, 1)
            label.TextXAlignment = Enum.TextXAlignment.Left

            local button = Instance.new("TextButton", row)
            button.Size = UDim2.new(0, 36, 0, 36)
            button.AnchorPoint = Vector2.new(1, 0.5)
            button.Position = UDim2.new(1, -10, 0.5, 0)
            button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            button.Text = ""
            button.AutoButtonColor = false

            local corner = Instance.new("UICorner", button)
            corner.CornerRadius = UDim.new(1, 0)

            local toggled = false
            button.MouseButton1Click:Connect(function()
                toggled = not toggled
                button.BackgroundColor3 = toggled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
                if callback then callback(toggled) end
            end)
        end

        return tab
    end

    return window
end

return HennHub
