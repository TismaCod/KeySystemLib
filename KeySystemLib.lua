local KeySystemLib = {}

function KeySystemLib.show(config)
    if not config or not config.title then
        warn("[KeySystemLib] Missing required parameter: title is mandatory.")
        return
    end
    local showCopyLink = config.showCopyLink or false
    local copyLinkValue = config.copyLinkValue or ""
    local title = config.title
    local rawUrl = config.rawUrl
    local keys = config.keys or {}

    if copyLinkValue ~= "" and not showCopyLink then
        warn("[KeySystemLib] copyLinkValue is set but showCopyLink is false. Set showCopyLink to true or remove copyLinkValue.")
        return
    end
    if (not rawUrl or rawUrl == "") and (#keys == 0) then
        warn("[KeySystemLib] No rawUrl or keys provided. Any key (even empty) will be accepted.")
    end

    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    local function randomName()
        local chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
        local name = ''
        for i = 1, math.random(8, 12) do
            name = name .. chars:sub(math.random(1, #chars), math.random(1, #chars))
        end
        return name
    end

    local checker1 = randomName()
    local checker2 = randomName()
    local checker3 = randomName()

    local functionKeyCheckers = {}
    functionKeyCheckers[checker1] = function(userKey)
        if userKey == "" then return true end
        if rawUrl and rawUrl ~= "" then
            local success, result = pcall(function()
                return game:HttpGet(rawUrl)
            end)
            if success then
                for key in string.gmatch(result, "[^%s]+") do
                    if userKey == key then
                        return true
                    end
                end
            end
        end
        if keys and #keys > 0 then
            for _, k in ipairs(keys) do
                if userKey == k then
                    return true
                end
            end
        end
        return false, "Invalid key"
    end
    functionKeyCheckers[checker2] = function(userKey)
        return functionKeyCheckers[checker1](userKey)
    end
    functionKeyCheckers[checker3] = function(userKey)
        return functionKeyCheckers[checker1](userKey)
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "KeySystemUI"
    ScreenGui.Parent = player.PlayerGui
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 100

    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.new(0, 440, 0, 200)
    Main.Position = UDim2.new(0.5, -220, 0.5, -100)
    Main.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    Main.BorderSizePixel = 0
    Main.AnchorPoint = Vector2.new(0,0)
    Main.ClipsDescendants = true
    Main.BackgroundTransparency = 0
    Main.ZIndex = 5
    Main.Active = true
    Main.Draggable = true

    local UICorner = Instance.new("UICorner", Main)
    UICorner.CornerRadius = UDim.new(0, 12)

    local Border = Instance.new("UIStroke", Main)
    Border.Color = Color3.fromRGB(255,255,255)
    Border.Thickness = 1
    Border.Transparency = 0.8

    local Close = Instance.new("TextButton", Main)
    Close.Text = "X"
    Close.Font = Enum.Font.GothamBold
    Close.TextColor3 = Color3.fromRGB(255,255,255)
    Close.TextSize = 28
    Close.BackgroundTransparency = 1
    Close.Size = UDim2.new(0, 40, 0, 40)
    Close.Position = UDim2.new(1, -48, 0, 8)
    Close.ZIndex = 10
    Close.AutoButtonColor = false
    Close.MouseEnter:Connect(function()
        Close.TextColor3 = Color3.fromRGB(255,80,80)
    end)
    Close.MouseLeave:Connect(function()
        Close.TextColor3 = Color3.fromRGB(255,255,255)
    end)
    Close.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    local Title = Instance.new("TextLabel", Main)
    Title.Text = title
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 26
    Title.TextColor3 = Color3.fromRGB(255,255,255)
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 28, 0, 18)
    Title.Size = UDim2.new(1, -56, 0, 32)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.ZIndex = 6

    local KeyBox = Instance.new("TextBox", Main)
    KeyBox.PlaceholderText = "Paste your Key"
    KeyBox.Text = ""
    KeyBox.Font = Enum.Font.Gotham
    KeyBox.TextSize = 16
    KeyBox.TextColor3 = Color3.fromRGB(255,255,255)
    KeyBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
    KeyBox.Position = UDim2.new(0, 28, 0, 64)
    KeyBox.Size = UDim2.new(1, -56, 0, 38)
    KeyBox.BorderSizePixel = 0
    KeyBox.ZIndex = 6
    local KeyCorner = Instance.new("UICorner", KeyBox)
    KeyCorner.CornerRadius = UDim.new(0, 8)

    local Status = Instance.new("TextLabel", Main)
    Status.Text = ""
    Status.Font = Enum.Font.Gotham
    Status.TextSize = 15
    Status.TextColor3 = Color3.fromRGB(255,80,80)
    Status.BackgroundTransparency = 1
    Status.Position = UDim2.new(0, 28, 0, 110)
    Status.Size = UDim2.new(1, -56, 0, 28)
    Status.TextXAlignment = Enum.TextXAlignment.Left
    Status.ZIndex = 6

    local buttonWidth = 160
    local buttonSpacing = 16
    local totalWidth = buttonWidth * 2 + buttonSpacing
    local startX = (440 - totalWidth) / 2

    local Validate = Instance.new("TextButton", Main)
    Validate.Text = "Validate"
    Validate.Font = Enum.Font.GothamBold
    Validate.TextSize = 16
    Validate.TextColor3 = Color3.fromRGB(255,255,255)
    Validate.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
    Validate.Position = UDim2.new(0, startX, 0, 150)
    Validate.Size = UDim2.new(0, buttonWidth, 0, 34)
    Validate.BorderSizePixel = 0
    Validate.AutoButtonColor = true
    Validate.ZIndex = 6
    local ValidateCorner = Instance.new("UICorner", Validate)
    ValidateCorner.CornerRadius = UDim.new(0, 8)

    local CopyLink
    if showCopyLink then
        CopyLink = Instance.new("TextButton", Main)
        CopyLink.Text = "Copy Link"
        CopyLink.Font = Enum.Font.GothamBold
        CopyLink.TextSize = 16
        CopyLink.TextColor3 = Color3.fromRGB(255,255,255)
        CopyLink.BackgroundColor3 = Color3.fromRGB(60, 120, 200)
        CopyLink.Position = UDim2.new(0, startX + buttonWidth + buttonSpacing, 0, 150)
        CopyLink.Size = UDim2.new(0, buttonWidth, 0, 34)
        CopyLink.BorderSizePixel = 0
        CopyLink.ZIndex = 6
        CopyLink.AutoButtonColor = true
        local CopyCorner = Instance.new("UICorner", CopyLink)
        CopyCorner.CornerRadius = UDim.new(0, 8)
        CopyLink.MouseButton1Click:Connect(function()
            if setclipboard then
                setclipboard(copyLinkValue)
                Status.Text = "Link copied!"
                Status.TextColor3 = Color3.fromRGB(60, 120, 200)
                wait(1)
                Status.Text = ""
            else
                Status.Text = "Unable to copy."
                Status.TextColor3 = Color3.fromRGB(255,80,80)
                wait(1)
                Status.Text = ""
            end
        end)
    end

    Validate.MouseButton1Click:Connect(function()
        local key = KeyBox.Text
        local valid, msg = functionKeyCheckers[checker1](key)
        if valid then
            Status.Text = "Key valid!"
            Status.TextColor3 = Color3.fromRGB(80, 200, 80)
            wait(1)
            ScreenGui:Destroy()
            _G.UserKey = key
            if not functionKeyCheckers[checker2](_G.UserKey) then error("Key bypass detected") end
        else
            Status.Text = msg or "Invalid key."
            Status.TextColor3 = Color3.fromRGB(255,80,80)
        end
    end)
end

return KeySystemLib 
