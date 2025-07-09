
--==[ HennHub UI Library with AddButton ]==--

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
    mainFrame.Size = UDim2.new(0, 420, 0, 350)
    mainFrame.Position = UDim2.new(0.5, -210, 0.5, -175)
    mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    mainFrame.BackgroundTransparency = 0.2
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true

    local corner = Instance.new("UICorner", mainFrame)
    corner.CornerRadius = UDim.new(0, 12)

    local shadow = Instance.new("ImageLabel", mainFrame)
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    shadow.Size = UDim2.new(1, 60, 1, 60)
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.new(0, 0, 0)
    shadow.ImageTransparency = 0.5
    shadow.BackgroundTransparency = 1
    shadow.ZIndex = -1

    local sidebar = Instance.new("ScrollingFrame", mainFrame)
    sidebar.Name = "Sidebar"
    sidebar.Size = UDim2.new(0, 120, 1, 0)
    sidebar.Position = UDim2.new(0, 0, 0, 0)
    sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    sidebar.BorderSizePixel = 0
    sidebar.ScrollBarThickness = 4
    sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)

    local sidebarCorner = Instance.new("UICorner", sidebar)
    sidebarCorner.CornerRadius = UDim.new(0, 12)

    local layout = Instance.new("UIListLayout", sidebar)
    layout.Padding = UDim.new(0, 0)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        sidebar.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
    end)

    local title = Instance.new("TextLabel", sidebar)
    title.Size = UDim2.new(1, 0, 0, 60)
    title.BackgroundTransparency = 1
    title.Text = options.Name or "HennHub"
    title.Font = Enum.Font.Cartoon
    title.TextSize = 18
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
    title.TextStrokeTransparency = 0.7
    title.TextWrapped = true

    local toggleButton = Instance.new("TextButton", gui)
    toggleButton.Size = UDim2.new(0, 50, 0, 50)
    toggleButton.Position = UDim2.new(0, 10, 0.5, -25)
    toggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    toggleButton.BackgroundTransparency = 0.4
    toggleButton.Text = "H"
    toggleButton.TextSize = 24
    toggleButton.Font = Enum.Font.Cartoon
    toggleButton.TextColor3 = Color3.fromRGB(0, 255, 0)
    toggleButton.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.TextStrokeTransparency = 0.7
    toggleButton.Active = true
    toggleButton.Draggable = true
    toggleButton.ZIndex = 99

    local toggleCorner = Instance.new("UICorner", toggleButton)
    toggleCorner.CornerRadius = UDim.new(1, 0)

    local isOpen = true
    toggleButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        mainFrame.Visible = isOpen
        toggleButton.TextColor3 = isOpen and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    end)

    local window = {}
    window.Tabs = {}
    window.CurrentTab = nil

    function window:MakeTab(tabOptions)
        tabOptions = tabOptions or {}
        local tabName = tabOptions.Name or "Tab"

        local tabButton = Instance.new("TextButton", sidebar)
        tabButton.Size = UDim2.new(1, 0, 0, 60)
        tabButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        tabButton.BackgroundTransparency = 0.3
        tabButton.BorderSizePixel = 0
        tabButton.Text = tabName
        tabButton.Font = Enum.Font.Cartoon
        tabButton.TextSize = 16
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.TextStrokeTransparency = 0.7
        tabButton.TextWrapped = true
        tabButton.AutoButtonColor = false
        tabButton.LayoutOrder = #window.Tabs + 1

        local tabContent = Instance.new("ScrollingFrame", mainFrame)
        tabContent.Name = tabName .. "_Content"
        tabContent.Position = UDim2.new(0, 130, 0, 10)
        tabContent.Size = UDim2.new(1, -140, 1, -20)
        tabContent.BackgroundTransparency = 1
        tabContent.ScrollBarThickness = 6
        tabContent.Visible = false
        tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)

        local layout = Instance.new("UIListLayout", tabContent)
        layout.Padding = UDim.new(0, 6)
        layout.SortOrder = Enum.SortOrder.LayoutOrder

        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            tabContent.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
        end)

        local titleLabel = Instance.new("TextLabel", tabContent)
        titleLabel.Size = UDim2.new(1, -20, 0, 30)
        titleLabel.Position = UDim2.new(0, 10, 0, 0)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = tabName
        titleLabel.Font = Enum.Font.Cartoon
        titleLabel.TextSize = 20
        titleLabel.TextColor3 = Color3.new(1, 1, 1)
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
        titleLabel.TextStrokeTransparency = 0.7

        local tabObj = {
            Name = tabName,
            Button = tabButton,
            Frame = tabContent
        }

        function tabObj:AddButton(text, callback)
            local container = Instance.new("Frame", tabContent)
            container.Size = UDim2.new(1, -20, 0, 44)
            container.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            container.BorderSizePixel = 0
            local corner = Instance.new("UICorner", container)
            corner.CornerRadius = UDim.new(0, 8)

            local label = Instance.new("TextLabel", container)
            label.AnchorPoint = Vector2.new(0, 0.5)
            label.Position = UDim2.new(0, 12, 0.5, 0)
            label.Size = UDim2.new(1, -100, 0, 36)
            label.BackgroundTransparency = 1
            label.Text = text
            label.Font = Enum.Font.Cartoon
            label.TextSize = 16
            label.TextColor3 = Color3.new(1, 1, 1)
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
            label.TextStrokeTransparency = 0.7

            local button = Instance.new("TextButton", container)
            button.Size = UDim2.new(0, 36, 0, 36)
            button.AnchorPoint = Vector2.new(1, 0.5)
            button.Position = UDim2.new(1, -12, 0.5, 0)
            button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            button.Text = ""
            button.AutoButtonColor = false

            local buttonCorner = Instance.new("UICorner", button)
            buttonCorner.CornerRadius = UDim.new(1, 0)

            button.MouseButton1Click:Connect(function()
                if callback then callback() end
            end)
        end

        tabButton.MouseButton1Click:Connect(function()
            for _, t in pairs(window.Tabs) do
                t.Frame.Visible = false
                t.Button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                t.Button.BackgroundTransparency = 0.3
            end

            tabContent.Visible = true
            tabButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            tabButton.BackgroundTransparency = 0
            window.CurrentTab = tabObj
        end)

        if #window.Tabs == 0 then
            tabButton:MouseButton1Click()
        end

        table.insert(window.Tabs, tabObj)
        return tabObj
    end

    return window
end

return HennHub
