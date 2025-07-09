
-- Versi ini memperbaiki masalah tab dan konten, serta memperbesar sedikit lebar container + memperkecil tinggi

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

    local sidebar = Instance.new("ScrollingFrame", mainFrame)
    sidebar.Name = "Sidebar"
    sidebar.Size = UDim2.new(0, 120, 1, 0)
    sidebar.Position = UDim2.new(0, 0, 0, 0)
    sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    sidebar.BorderSizePixel = 0
    sidebar.ScrollBarThickness = 4
    sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)

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
    title.TextColor3 = Color3.new(1, 1, 1)

    local toggleButton = Instance.new("TextButton", gui)
    toggleButton.Size = UDim2.new(0, 50, 0, 50)
    toggleButton.Position = UDim2.new(0, 10, 0.5, -25)
    toggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    toggleButton.BackgroundTransparency = 0.4
    toggleButton.Text = "H"
    toggleButton.Font = Enum.Font.Cartoon
    toggleButton.TextSize = 24
    toggleButton.TextColor3 = Color3.fromRGB(0, 255, 0)
    toggleButton.Active = true
    toggleButton.Draggable = true

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

    function window:MakeTab(tabOptions)
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

        local tabContent = Instance.new("ScrollingFrame", mainFrame)
        tabContent.Name = tabName .. "_Content"
        tabContent.Position = UDim2.new(0, 130, 0, 10)
        tabContent.Size = UDim2.new(1, -140, 1, -20)
        tabContent.BackgroundTransparency = 1
        tabContent.Visible = false
        tabContent.ScrollBarThickness = 6
        tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)

        local contentLayout = Instance.new("UIListLayout", tabContent)
        contentLayout.Padding = UDim.new(0, 6)
        contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            tabContent.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 20)
        end)

        local tabObj = {
            Name = tabName,
            Button = tabButton,
            Frame = tabContent
        }

        function tabObj:AddButton(text, callback)
            local container = Instance.new("Frame", tabContent)
            container.Size = UDim2.new(1, -20, 0, 38) -- Sedikit lebih pendek
            container.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            container.BorderSizePixel = 0
            container.Position = UDim2.new(0, 10, 0, 0)
            local corner = Instance.new("UICorner", container)
            corner.CornerRadius = UDim.new(0, 8)

            local label = Instance.new("TextLabel", container)
            label.AnchorPoint = Vector2.new(0, 0.5)
            label.Position = UDim2.new(0, 12, 0.5, 0)
            label.Size = UDim2.new(1, -120, 0, 28)
            label.BackgroundTransparency = 1
            label.Text = text
            label.Font = Enum.Font.Cartoon
            label.TextSize = 16
            label.TextColor3 = Color3.new(1, 1, 1)
            label.TextXAlignment = Enum.TextXAlignment.Left

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
            end
            tabContent.Visible = true
            tabButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        end)

        table.insert(window.Tabs, tabObj)
        if #window.Tabs == 1 then
            tabButton:MouseButton1Click()
        end

        return tabObj
    end

    return window
end

return HennHub
