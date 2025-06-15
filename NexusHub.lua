-- ✅ Load Rayfield UI with Error Handling
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))() or error("Failed to load Rayfield UI Library")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService") -- Added for audio
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid", 10) or error("Humanoid not found")
local RunService = game:GetService("RunService")

-- ✅ Configuration
local Config = {
    Name = "Nexus Hub",
    Version = "1.1.1", -- Updated version for audio feature
    DiscordInvite = "hdTR2r73t8",
    SupportedGames = {
        BloxFruits = {2753915549, 4442272183, 7449423635},
        DaHood = {2788229376},
        MurderMystery2 = {142823291},
        Brookhaven = {4924922222}
    },
    Themes = {"Dark", "Light", "Abyss", "Blood", "Aqua", "Neon"},
    IntroAudio = {
        SoundId = "rbxassetid://117502688312383", -- Example Roblox audio ID (replace with your own)
        Volume = 0.5,
        Enabled = true
    }
}

-- ✅ Intro Audio Setup
local IntroSound
local function PlayIntroAudio()
    if Config.IntroAudio.Enabled then
        IntroSound = Instance.new("Sound")
        IntroSound.Parent = SoundService
        IntroSound.SoundId = Config.IntroAudio.SoundId
        IntroSound.Volume = Config.IntroAudio.Volume
        IntroSound.PlayOnRemove = false
        IntroSound.Looped = false

        local Success, Error = pcall(function()
            IntroSound:Play()
        end)
        if Success then
            Rayfield:Notify({
                Title = "Welcome to Nexus Hub",
                Content = "Intro audio playing! Enjoy the experience.",
                Duration = 5,
                Image = 7734068321
            })
        else
            Rayfield:Notify({
                Title = "Audio Error",
                Content = "Failed to play intro audio: " .. Error,
                Duration = 5,
                Image = 4483362458
            })
        end
    end
end

-- ✅ Create Main Window
local Window = Rayfield:CreateWindow({
    Name = Config.Name .. " | v" .. Config.Version,
    LoadingTitle = "Initializing Nexus Hub...",
    LoadingSubtitle = "Developed by Nexus Team",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "NexusHub",
        FileName = "NexusHubConfig"
    },
    Discord = {
        Enabled = true,
        Invite = Config.DiscordInvite,
        RememberJoins = false
    },
    KeySystem = true,
    KeySettings = {
        Title = "Authentication Required",
        Subtitle = "Join Discord for Key",
        Note = "https://discord.gg/" .. Config.DiscordInvite,
        FileName = "NexusKey",
        SaveKey = false,
        GrabKeyFromSite = false,
        Key = {"NEXUS", "ACCESS2025", "VIP2025"}
    }
})

-- Play intro audio after window creation
PlayIntroAudio()

-- ✅ Executor Detection with Expanded Support
local SupportedExecutors = {
    Synapse = true,
    KRNL = true,
    Fluxus = true,
    ScriptWare = true,
    Electron = true,
    Delta = true,
    VegaX = true
}
local ExecutorName = identifyexecutor and identifyexecutor() or "Unknown"
local ExecutorStatus = SupportedExecutors[ExecutorName] and "✅ Supported" or "⚠️ Unsupported"
Rayfield:Notify({
    Title = "Executor Detection",
    Content = "Executor: " .. ExecutorName .. " - " .. ExecutorStatus,
    Duration = 5,
    Image = 4483362458
})

-- ✅ Utility Functions
local function Notify(Title, Content, Duration, Image)
    Rayfield:Notify({
        Title = Title,
        Content = Content,
        Duration = Duration or 6,
        Image = Image or 7734068321
    })
end

local function SafeLoadstring(URL)
    local Success, Response = pcall(game.HttpGet, game, URL)
    if Success then
        local Func, Error = loadstring(Response)
        if Func then
            return Func()
        else
            Notify("Script Error", "Failed to load script: " .. Error, 5)
        end
    else
        Notify("Network Error", "Failed to fetch script: " .. Response, 5)
    end
end

local function ToggleProperty(Instance, Property, Value)
    if Instance and Instance:IsA("Instance") then
        local Success, Error = pcall(function()
            Instance[Property] = Value
        end)
        if not Success then
            Notify("Error", "Failed to set " .. Property .. ": " .. Error, 5)
        end
    end
end

-- ✅ Changelogs Tab
local ChangelogsTab = Window:CreateTab("Changelogs", 7733960981)
ChangelogsTab:CreateParagraph({Title = "v1.1.1", Content = "- Added intro audio with toggle and volume control\n- Fixed minor bugs"})
ChangelogsTab:CreateParagraph({Title = "v1.1.0", Content = "- Added ESP, Aimbot, Noclip\n- Improved game detection\n- Added new themes\n- Enhanced anti-detection"})
ChangelogsTab:CreateParagraph({Title = "v1.0.4", Content = "- Added verified ScriptBlox game hubs"})
ChangelogsTab:CreateParagraph({Title = "v1.0.3", Content = "- Added Settings tab with UI themes\n- Executor detection"})
ChangelogsTab:CreateButton({
    Name = "📋 Copy Discord Link",
    Callback = function()
        setclipboard("https://discord.gg/" .. Config.DiscordInvite)
        Notify("Success", "Discord invite copied to clipboard!", 4)
    end
})

-- ✅ Hacks Tab
local HacksTab = Window:CreateTab("Hacks", 4483362458)
local FlyEnabled = false
HacksTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Callback = function(Value)
        FlyEnabled = Value
        if Value then
            SafeLoadstring("https://raw.githubusercontent.com/minceda/Nexus-hub/main/fly.lua")
        else
            Notify("Fly Disabled", "Fly hack has been turned off.", 4)
        end
    end
})

HacksTab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 500},
    Increment = 5,
    Suffix = "Speed",
    CurrentValue = 16,
    Callback = function(Value)
        ToggleProperty(Humanoid, "WalkSpeed", Value)
    end
})

HacksTab:CreateSlider({
    Name = "Jump Power",
    Range = {50, 500},
    Increment = 10,
    Suffix = "Power",
    CurrentValue = 50,
    Callback = function(Value)
        ToggleProperty(Humanoid, "JumpPower", Value)
    end
})

HacksTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Callback = function(Value)
        local NoclipConnection
        if Value then
            NoclipConnection = RunService.Stepped:Connect(function()
                if Character then
                    for _, Part in pairs(Character:GetDescendants()) do
                        if Part:IsA("BasePart") then
                            Part.CanCollide = false
                        end
                    end
                end
            end)
            Notify("Noclip Enabled", "You can now pass through walls!", 4)
        else
            if NoclipConnection then
                NoclipConnection:Disconnect()
            end
            if Character then
                for _, Part in pairs(Character:GetDescendants()) do
                    if Part:IsA("BasePart") then
                        Part.CanCollide = true
                    end
                end
            end
            Notify("Noclip Disabled", "Collisions restored.", 4)
        end
    end
})

HacksTab:CreateButton({
    Name = "ESP (Players)",
    Callback = function()
        SafeLoadstring("https://raw.githubusercontent.com/ic3w0lf22/Roblox-Account-Manager/master/Global/ESP.lua")
    end
})

HacksTab:CreateButton({
    Name = "Shiftlock",
    Callback = function()
        SafeLoadstring("https://raw.githubusercontent.com/YourRealjohn/Unnamed-HUB-Lua/main/Advance%20PermShiftlock")
    end
})

-- ✅ Admin Tools Tab
local AdminTab = Window:CreateTab("Admin Tools", 9432610133)
AdminTab:CreateButton({
    Name = "Infinite Yield",
    Callback = function()
        SafeLoadstring("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source")
    end
})
AdminTab:CreateButton({
    Name = "Nameless Admin",
    Callback = function()
        SafeLoadstring("https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/Source")
    end
})

-- ✅ Game Hubs Tab
local GameHubsTab = Window:CreateTab("Game Hubs", 7734068321)
local GameHubs = {
    {Name = "Blox Fruits – Forge Hub", URL = "https://scriptblox.com/raw/Forge-Hub-33453"},
    {Name = "Da Hood – Zinc Hub", URL = "https://scriptblox.com/raw/Zinc-Hub-10720"},
    {Name = "Brookhaven – Mango Hub", URL = "https://scriptblox.com/raw/Mango-Hub-33726"},
    {Name = "Murder Mystery 2 – Forge Hub", URL = "https://scriptblox.com/raw/Forge-Hub-35163"},
    {Name = "Grow a Garden – Forge Hub", URL = "https://scriptblox.com/raw/Forge-Hub-41130"}
}

for _, Hub in ipairs(GameHubs) do
    GameHubsTab:CreateButton({
        Name = Hub.Name,
        Callback = function()
            SafeLoadstring(Hub.URL)
        end
    })
end

-- ✅ Settings Tab
local SettingsTab = Window:CreateTab("Settings", 7734071342)
SettingsTab:CreateDropdown({
    Name = "UI Theme",
    Options = Config.Themes,
    CurrentOption = "Dark",
    Callback = function(Value)
        Rayfield:ChangeTheme(Value)
        Notify("Theme Changed", "Applied " .. Value .. " theme.", 4)
    end
})

SettingsTab:CreateToggle({
    Name = "Intro Audio",
    CurrentValue = Config.IntroAudio.Enabled,
    Callback = function(Value)
        Config.IntroAudio.Enabled = Value
        if not Value and IntroSound and IntroSound.Playing then
            IntroSound:Stop()
            Notify("Intro Audio", "Intro audio disabled.", 4)
        end
    end
})

SettingsTab:CreateSlider({
    Name = "Audio Volume",
    Range = {0, 1},
    Increment = 0.1,
    Suffix = "Volume",
    CurrentValue = Config.IntroAudio.Volume,
    Callback = function(Value)
        Config.IntroAudio.Volume = Value
        if IntroSound then
            IntroSound.Volume = Value
        end
        Notify("Volume Updated", "Intro audio volume set to " .. Value, 4)
    end
})

SettingsTab:CreateToggle({
    Name = "Auto-Rejoin on Kick",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            LocalPlayer.OnTeleport:Connect(function(State)
                if State == Enum.TeleportState.Failed then
                    game:GetService("TeleportService"):Teleport(game.PlaceId)
                end
            end)
            Notify("Auto-Rejoin", "Enabled auto-rejoin on kick.", 4)
        end
    end
})

SettingsTab:CreateButton({
    Name = "Destroy UI",
    Callback = function()
        if IntroSound then
            IntroSound:Stop()
            IntroSound:Destroy()
        end
        Rayfield:Destroy()
        Notify("UI Destroyed", "Nexus Hub UI has been closed.", 3)
    end
})

SettingsTab:CreateParagraph({
    Title = "System Info",
    Content = "Executor: " .. ExecutorName .. "\nVersion: " .. Config.Version .. "\nGame: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
})

-- ✅ Auto-Detect System
local GamePlaceId = game.PlaceId
local function DetectGame()
    if table.find(Config.SupportedGames.BloxFruits, GamePlaceId) then
        Notify("Blox Fruits Detected", "Recommended: Blox Fruits Hub, Fly, ESP", 6)
    elseif GamePlaceId == Config.SupportedGames.DaHood[1] then
        Notify("Da Hood Detected", "Recommended: Zinc Hub, Speed, Noclip", 6)
    elseif GamePlaceId == Config.SupportedGames.MurderMystery2[1] then
        Notify("Murder Mystery 2 Detected", "Recommended: Forge Hub, ESP, Shiftlock", 6)
    elseif GamePlaceId == Config.SupportedGames.Brookhaven[1] then
        Notify("Brookhaven Detected", "Recommended: Mango Hub, Jump, Shiftlock", 6)
    else
        Notify("Unknown Game", "No specific hacks available. Try general hacks!", 6)
    end
end
DetectGame()

-- ✅ Anti-Detection (Basic)
LocalPlayer.CharacterAdded:Connect(function(NewCharacter)
    Character = NewCharacter
    Humanoid = Character:WaitForChild("Humanoid", 10)
    if FlyEnabled then
        SafeLoadstring("https://raw.githubusercontent.com/minceda/Nexus-hub/main/fly.lua")
    end
end)

RunService.Heartbeat:Connect(function()
    if LocalPlayer:IsInGroup(game.CreatorId) then
        Notify("Warning", "You are in the game developer's group. Use hacks cautiously!", 10)
    end
end)
