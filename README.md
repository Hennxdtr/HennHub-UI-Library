# HennHub Library

This documentation is for the stable release of HennHub, a custom UI library made by Henn.

## Booting the Library
```Lua
local HennHub = loadstring(game:HttpGet('https://raw.githubusercontent.com/Hennxdtr/HennHub-UI/main/HennHub'))()
```

## Creating a Window
```Lua
HennHub:CreateWindow({
    Name = "HennHub",
    TitleColor = Color3.fromRGB(0, 170, 255),
    Draggable = true,
    Size = UDim2.new(0, 640, 0, 480)
})
```

## Creating a Tab
```Lua
local Tab = Window:MakeTab({
    Name = "Farm",
    Icon = "rbxassetid://14541090253",
    PremiumOnly = false
})
```

## Creating a Button
```Lua
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
```

## Author

Created by: Not Henn

GitHub: https://github.com/Hennxdtr/HennHub-UI


## License

Free to use and modify. Attribution is appreciated ❤️
