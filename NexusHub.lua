-- ✅ Wait for Game to Load
wait(2) -- Wait 2 seconds to ensure game environment is ready
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))() or error("Failed to load Rayfield UI Library")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character and Character:WaitForChild("Humanoid", 10) or nil
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

-- ✅ Configuration
local Config = {
    Name = "Nexus Hub",
    Version = "1.2.1", -- Updated for debugging
    DiscordInvite = "hdTR2r73t8",
    SupportedGames = {
        BloxFruits = {2753915549, 4442272183, 7449423635},
        DaHood = {2788229376},
        MurderMystery2 = {142823291},
        Brookhaven = {4924922222}
    },
    Themes = {"Dark", "Light", "Abyss", "Blood", "Aqua", "Neon"},
    IntroAudio = {
        SoundId = "rbxassetid://117502688312383", -- Replace with your own audio ID
        Volume = 0.5,
        Enabled = true
    },
    Icons = {
        Changelogs = 7733960981,
        Hacks = 4483362458,
        AdminTools = 9432610133,
        GameHubs = 7734068321,
        Settings = 7734071342,
        ChatLogger = 7733964719
    }
}

-- ✅ Notify Utility
local function Notify(Title, Content, Duration, Image)
    pcall(function()
        Rayfield:Notify({
            Title = Title,
            Content = Content,
            Duration = Duration or 6,
            Image = Image or Config.Icons.Hacks
        })
    end)
end

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
            Notify("Welcome to Nexus Hub", "Intro audio playing!", 5)
        else
            Notify("Audio Error", "Failed to play intro audio: " .. Error, 5, Config.Icons.Settings)
        end
    end
end

-- ✅ Create Main Window
local Window
local Success, Error = pcall(function()
    Window = Rayfield:CreateWindow({
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
end)
if not Success then
    error("Failed to create window: " .. Error)
end
Notify("Window Created", "Main window initialized successfully.", 5)

-- Play intro audio
PlayIntroAudio()

-- ✅ Executor Detection
local SupportedExecutors = {
    Synapse = true, KRNL = true, Fluxus = true, ScriptWare = true, Electron = true, Delta = true, VegaX = true
}
local ExecutorName = identifyexecutor and identifyexecutor() or "Unknown"
local ExecutorStatus = SupportedExecutors[ExecutorName] and "✅ Supported" or "⚠️ Unsupported"
Notify("Executor Detection", "Executor: " .. ExecutorName .. " - " .. ExecutorStatus, 5)

-- ✅ Utility Functions
local function SafeLoadstring(URL)
    local Success, Response = pcall(game.HttpGet, game, URL)
    if Success then
        local Func, Error = loadstring(Response)
        if Func then
            return Func()
        else
            Notify("Script Error", "Failed to load script: " .. Error, 5, Config.Icons.Settings)
        end
    else
        Notify("Network Error", "Failed to fetch script: " .. Response, 5, Config.Icons.Settings)
    end
end

local function ToggleProperty(Instance, Property, Value)
    if Instance and Instance:IsA("Instance") then
        local Success, Error = pcall(function()
            Instance[Property] = Value
        end)
        if not Success then
            Notify("Error", "Failed to set " .. Property .. ": " .. Error, 5, Config.Icons.Settings)
        end
    end
end

-- ✅ Tab Creation with Debugging
local function CreateTabSafe(Name, Icon)
    local Tab
    local Success, Error = pcall(function()
        Tab = Window:CreateTab(Name, Icon)
    end)
    if Success then
        Notify("Tab Created", Name .. " tab created successfully.", 3)
        return Tab
    else
        Notify("Tab Error", "Failed to create " .. Name .. " tab: " .. Error, 5, Config.Icons.Settings)
        return nil
    end
end

-- ✅ Changelogs Tab
local ChangelogsTab = CreateTabSafe("Changelogs", Config.Icons.Changelogs)
if ChangelogsTab then
    ChangelogsTab:CreateParagraph({Title = "v1.2.1", Content = "- Added load delay and debug notifications\n- Fixed tab creation issues"})
    ChangelogsTab:CreateParagraph({Title = "v1.2.0", Content = "- Added Server Hop, Rejoin, FPS Unlocker, Chat Logger, Ping & FPS Overlay"})
    ChangelogsTab:CreateButton({
        Name = "📋 Copy Discord Link",
        Callback = function()
            setclipboard("https://discord.gg/" .. Config.DiscordInvite)
            Notify("Success", "Discord invite copied to clipboard!", 4)
        end
    })
end

-- ✅ Hacks Tab
local HacksTab = CreateTabSafe("Hacks", Config.Icons.Hacks)
if HacksTab then
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
            if Humanoid then
                ToggleProperty(Humanoid, "WalkSpeed", Value)
            else
                Notify("Error", "Humanoid not found. Try rejoining.", 5, Config.Icons.Settings)
            end
        end
    })

    HacksTab:CreateSlider({
        Name = "Jump Power",
        Range = {50, 500},
        Increment = 10,
        Suffix = "Power",
        CurrentValue = 50,
        Callback = function(Value)
            if Humanoid then
                ToggleProperty(Humanoid, "JumpPower", Value)
            else
                Notify("Error", "Humanoid not found. Try rejoining.", 5, Config.Icons.Settings)
            end
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

    HacksTab:CreateButton({
        Name = "Server Hop",
        Callback = function()
            local Success, Error = pcall(function()
                TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId)
            end)
            if Success then
                Notify("Server Hop", "Teleporting to a new server...", 4)
            else
                Notify("Server Hop Failed", "Error: " .. Error, 5, Config.Icons.Settings)
            end
        end
    })

    HacksTab:CreateButton({
        Name = "Rejoin Server",
        Callback = function()
            local Success, Error = pcall(function()
                TeleportService:Teleport(game.PlaceId)
            end)
            if Success then
                Notify("Rejoin Server", "Rejoining the current server...", 4)
            else
                Notify("Rejoin Failed", "Error: " .. Error, 5, Config.Icons.Settings)
            end
        end
    })

    HacksTab:CreateButton({
        Name = "FPS Unlocker (Client)",
        Callback = function()
            local Success, Error = pcall(function()
                setfpscap(0)
            end)
            if Success then
                Notify("FPS Unlocker", "FPS cap removed (client-side).", 4)
            else
                Notify("FPS Unlocker Failed", "Error: " .. Error, 5, Config.Icons.Settings)
            end
        end
    })
end

-- ✅ Chat Logger Tab
local ChatLoggerTab = CreateTabSafe("Chat Logger", Config.Icons.ChatLogger)
if ChatLoggerTab then
    local ChatMessages = {}
    local ChatParagraph = ChatLoggerTab:CreateParagraph({
        Title = "Chat Log",
        Content = "No messages yet."
    })

    local function UpdateChatLog()
        local LogText = table.concat(ChatMessages, "\n")
        pcall(function()
            ChatParagraph:Set({Title = "Chat Log", Content = LogText or "No messages yet."})
        end)
    end

    -- Fallback for chat logging if PlayerChatting is unsupported
    local function LogChat(Player, Message)
        table.insert(ChatMessages, "[" .. Player.Name .. "]: " .. Message)
        if #ChatMessages > 50 then
            table.remove(ChatMessages, 1)
        end
        UpdateChatLog()
    end

    if Players.PlayerChatting then
        Players.PlayerChatting:Connect(LogChat)
    else
        Players.PlayerAdded:Connect(function(Player)
            Player.Chatted:Connect(function(Message)
                LogChat(Player, Message)
            end)
        end)
        for _, Player in pairs(Players:GetPlayers()) do
            Player.Chatted:Connect(function(Message)
                LogChat(Player, Message)
            end)
        end
    end

    ChatLoggerTab:CreateButton({
        Name = "Clear Chat Log",
        Callback = function()
            ChatMessages = {}
            UpdateChatLog()
            Notify("Chat Log Cleared", "All logged messages have been cleared.", 4)
        end
    })
end

-- ✅ Admin Tools Tab
local AdminTab = CreateTabSafe("Admin Tools", Config.Icons.AdminTools)
if AdminTab then
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
end

-- ✅ Game Hubs Tab
local GameHubsTab = CreateTabSafe("Game Hubs", Config.Icons.GameHubs)
if GameHubsTab then
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
end

-- ✅ Settings Tab
local SettingsTab = CreateTabSafe("Settings", Config.Icons.Settings)
if SettingsTab then
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
                        TeleportService:Teleport(game.PlaceId)
                    end
                end)
                Notify("Auto-Rejoin", "Enabled auto-rejoin on kick.", 4)
            end
        end
    })

    local OverlayEnabled = false
    local OverlayGui
    SettingsTab:CreateToggle({
        Name = "Ping & FPS Overlay",
        CurrentValue = false,
        Callback = function(Value)
            OverlayEnabled = Value
            if Value then
                OverlayGui = Instance.new("ScreenGui")
                OverlayGui.Parent = StarterGui
                OverlayGui.IgnoreGuiInset = true

                local Frame = Instance.new("Frame")
                Frame.Parent = OverlayGui
                Frame.Size = UDim2.new(0, 150, 0, 50)
                Frame.Position = UDim2.new(0, 10, 0, 10)
                Frame.BackgroundTransparency = 0.5
                Frame.BackgroundColor3 = Color3.new(0, 0, 0)

                local PingLabel = Instance.new("TextLabel")
                PingLabel.Parent = Frame
                PingLabel.Size = UDim2.new(1, 0, 0.5, 0)
                PingLabel.BackgroundTransparency = 1
                PingLabel.TextColor3 = Color3.new(1, 1, 1)
                PingLabel.Text = "Ping: Calculating..."

                local FPSLabel = Instance.new("TextLabel")
                FPSLabel.Parent = Frame
                FPSLabel.Size = UDim2.new(1, 0, 0.5, 0)
                FPSLabel.Position = UDim2.new(0, 0, 0.5, 0)
                FPSLabel.BackgroundTransparency = 1
                FPSLabel.TextColor3 = Color3.new(1, 1, 1)
                FPSLabel.Text = "FPS: Calculating..."

                RunService.RenderStepped:Connect(function(Delta)
                    if OverlayEnabled then
                        local Ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
                        PingLabel.Text = "Ping: " .. Ping .. " ms"
                        FPSLabel.Text = "FPS: " .. math.floor(1 / Delta)
                    end
                end)
                Notify("Overlay Enabled", "Ping & FPS overlay enabled.", 4)
            else
                if OverlayGui then
                    OverlayGui:Destroy()
                end
                Notify("Overlay Disabled", "Ping & FPS overlay disabled.", 4)
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
            if OverlayGui then
                OverlayGui:Destroy()
            end
            Rayfield:Destroy()
            Notify("UI Destroyed", "Nexus Hub UI has been closed.", 3)
        end
    })

    SettingsTab:CreateParagraph({
        Title = "System Info",
        Content = "Executor: " .. ExecutorName .. "\nVersion: " .. Config.Version .. "\nGame: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    })
end

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

-- ✅ Anti-Detection and Character Handling
LocalPlayer.CharacterAdded:Connect(function(NewCharacter)
    Character = NewCharacter
    Humanoid = Character:WaitForChild("Humanoid", 10)
    if FlyEnabled then
        SafeLoadstring("https://raw.githubusercontent.com/minceda/Nexus-hub/main/fly.lua")
    end
end)

RunService.Heartbeat:Connect(function()
    if LocalPlayer:IsInGroup(game.CreatorId) then
        Notify("Warning", "You are in the game developer's group. Use hacks cautiously!", 10, Config.Icons.Settings)
    end
end)
