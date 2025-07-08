HennHub UI Library

This documentation is for the stable release of HennHub, a custom UI library made by Not Henn.

Booting the Library

local HennHub = loadstring(game:HttpGet('https://raw.githubusercontent.com/Hennxdtr/HennHub-UI/main/HennHub'))()

Creating a Window

local Window = HennHub:CreateWindow({
    Name = "HennHub",
    TitleColor = Color3.fromRGB(0, 170, 255),
    Draggable = true,
    Size = UDim2.new(0, 640, 0, 480)
})

--[[
Name = <string> - The name/title of the window.
TitleColor = <Color3> - The color of the title text.
Draggable = <bool> - Whether the window can be dragged.
Size = <UDim2> - The size of the main window.
]]

Creating a Tab

local Tab = Window:MakeTab({
    Name = "Farm",
    Icon = "rbxassetid://14541090253",
    PremiumOnly = false
})

--[[
Name = <string> - The name of the tab.
Icon = <string> - The icon of the tab (rbxassetid).
PremiumOnly = <bool> - (Unused) Reserved for future features.
]]

Creating a Button

Tab:AddButton({
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

--[[
Text = <string> - The label shown on the button.
Callback = <function> - What the button does when clicked.
]]

Notes

The UI includes a toggle button with Roblox icon to show/hide the main frame.

All UI corners are rounded.

Tabs are scrollable.

Buttons stack vertically in each tab.


Author

Created by: Not Henn

GitHub: https://github.com/Hennxdtr/HennHub-UI


License

Free to use, modify, and share. Please credit the original creator ❤️

