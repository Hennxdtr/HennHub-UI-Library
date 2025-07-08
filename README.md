HennHub UI Library Documentation

📦 HennHub is a custom UI library built for Roblox developers. It provides a modular and draggable interface system with tabs, buttons, and beautiful rounded designs — perfect for scripts and utilities.


---

🚀 Getting Started

1. Load the Library

local HennHub = loadstring(game:HttpGet("https://raw.githubusercontent.com/Hennxdtr/HennHub-UI/main/HennHub"))()

> Replace with your own GitHub raw link if needed.




---

2. Create a Window

local Window = HennHub:CreateWindow({
    Name = "HennHub",
    TitleColor = Color3.fromRGB(0, 170, 255),
    Draggable = true,
    Size = UDim2.new(0, 640, 0, 480)
})

Parameters:

Name: Title of the UI window

TitleColor: Color of the title text

Draggable: Whether the frame can be dragged

Size: The size of the main frame


> This window includes the title, a toggle button with a Roblox icon, and a sidebar area.




---

📁 Creating Tabs with MakeTab

local FarmTab = Window:MakeTab({
    Name = "Farm",
    Icon = "rbxassetid://14541090253",
    PremiumOnly = false
})

Parameters:

Name: Tab name (also appears in the sidebar)

Icon: Optional icon (Roblox asset ID)

PremiumOnly: Currently unused, reserved for future features



---

🔘 Adding Buttons with AddButton

FarmTab:AddButton({
    Text = "Dupe Gems",
    Callback = function()
        local args = {
            [1] = 218840,
            [2] = "Equip",
            [3] = 1
        }

        for i = args[3], 38 do
            args[3] = i
            game:GetService("ReplicatedStorage").Remote.ManagePet:FireServer(unpack(args))
        end
    end
})

Parameters:

Text: Label shown on the button

Callback: Function that runs when the button is clicked



---

🎨 Features

✅ Rounded UI design

✅ Draggable and toggle-able window

✅ Sidebar navigation for tabs

✅ Organized and dynamic content area

✅ Scrollable tabs for future extensions



---

👤 Author

Created by: Not Henn

GitHub: https://github.com/Hennxdtr/HennHub-UI

Created: July 2025



---

📄 License

Free to use and modify for personal or public scripts. Credit is appreciated ❤️

