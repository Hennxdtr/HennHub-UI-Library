-- HennHub UI Library Final Version (Perbaikan tabContent)
-- ✅ Tab content bisa menampilkan konten karena tingginya dinamis

local HennHub = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

function HennHub:MakeWindow(options)
    options = options or {}

    local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
    gui.Name = options.Name or "HennHubUI"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true

    -- FRAME UTAMA
    local mainFrame = Instance.new("Frame", gui)
    mainFrame.Size = UDim2.new(0, 460, 0, 320)
    mainFrame.Position = UDim2.new(0.5, -230, 0.5, -160)
    mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    mainFrame.BackgroundTransparency = 0.2
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Visible = false

    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", mainFrame).Color = Color3.fromRGB(0, 170, 255)

    -- LABEL JUDUL
    local header = Instance.new("TextLabel", mainFrame)
    header.Size = UDim2.new(1, 0, 0, 30)
    header.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    header.BackgroundTransparency = 0.3
    header.Text = options.Name or "HennHub"
    header.Font = Enum.Font.Cartoon
    header.TextColor3 = Color3.fromRGB(0, 170, 255)
    header.TextSize = 24
    header.TextStrokeTransparency = 0.4
    header.TextXAlignment = Enum.TextXAlignment.Center
    Instance.new("UIStroke", header).Color = Color3.fromRGB(255, 255, 255)

    -- SIDEBAR
    local sidebar = Instance.new("ScrollingFrame", mainFrame)
    sidebar.Size = UDim2.new(0, 120, 1, -30)
    sidebar.Position = UDim2.new(0, 0, 0, 30)
    sidebar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    sidebar.BackgroundTransparency = 0.3
    sidebar.CanvasSize = UDim2.new(0, 0, 1.5, 0)
    sidebar.ScrollBarThickness = 0

    Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", sidebar).Color = Color3.fromRGB(0, 170, 255)
    Instance.new("UIListLayout", sidebar).Padding = UDim.new(0, 0)

    -- FRAME KONTEN
    local contentFrame = Instance.new("Frame", mainFrame)
    contentFrame.Size = UDim2.new(1, -130, 1, -30)
    contentFrame.Position = UDim2.new(0, 130, 0, 30)
    contentFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    contentFrame.BackgroundTransparency = 0.3
    contentFrame.ClipsDescendants = true

    Instance.new("UICorner", contentFrame).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", contentFrame).Color = Color3.fromRGB(0, 170, 255)

    -- TOMBOL H
    local toggleButton = Instance.new("TextButton", gui)
    toggleButton.Size = UDim2.new(0, 50, 0, 50)
    toggleButton.Position = UDim2.new(0, 20, 0.5, -25)
    toggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    toggleButton.BackgroundTransparency = 0.4
    toggleButton.Text = "H"
    toggleButton.Font = Enum.Font.Cartoon
    toggleButton.TextSize = 28
    toggleButton.TextColor3 = Color3.fromRGB(255, 0, 0)
    toggleButton.Draggable = true
    toggleButton.ZIndex = 100

    Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(1, 0)
    Instance.new("UIStroke", toggleButton).Color = Color3.fromRGB(0, 170, 255)

    local shadow = Instance.new("TextLabel", toggleButton)
    shadow.Text = "H"
    shadow.Font = Enum.Font.Cartoon
    shadow.TextSize = 28
    shadow.TextColor3 = Color3.fromRGB(255, 255, 255)
    shadow.Position = UDim2.new(0, 2, 0, 2)
    shadow.Size = UDim2.new(1, 0, 1, 0)
    shadow.BackgroundTransparency = 1
    shadow.ZIndex = 99

    -- Toggle show/hide
    local visible = false
    toggleButton.MouseButton1Click:Connect(function()
        visible = not visible
        mainFrame.Visible = visible
        toggleButton.TextColor3 = visible and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    end)

    local tabs, activeTab = {}, nil

    local function switchTab(tabName)
        for _, t in pairs(tabs) do
            t.button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            t.frame.Visible = false
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

        local tabContent = Instance.new("ScrollingFrame", contentFrame)
        tabContent.Size = UDim2.new(1, -10, 1, 0)
        tabContent.BackgroundTransparency = 1
        tabContent.Visible = false
        tabContent.CanvasSize = UDim2.new(0, 0, 5, 0)
        tabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
        tabContent.ScrollBarThickness = 0

        local layout = Instance.new("UIListLayout", tabContent)
        layout.Padding = UDim.new(0, 6)
        layout.SortOrder = Enum.SortOrder.LayoutOrder

        tabs[name] = {
            name = name,
            button = tabButton,
            frame = tabContent
        }

        tabButton.MouseButton1Click:Connect(function()
            switchTab(name)
        end)

        if not activeTab then
            switchTab(name)
        end

        function tabs[name]:AddButton(text, callback)
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

            Instance.new("UICorner", button).CornerRadius = UDim.new(1, 0)

            local toggled = false
            button.MouseButton1Click:Connect(function()
                toggled = not toggled
                button.BackgroundColor3 = toggled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
                if callback then callback(toggled) end
            end)
        end

        return tabs[name]
    end

    return window
end

return HennHub
