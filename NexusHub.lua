-- ✅ Load Rayfield UI with Error Handling
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))() or error("Failed to load Rayfield UI Library")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid", 10) or error("Humanoid not found")
local RunService = game:GetService("RunService")

-- ✅ Configuration
local Config = {
    Name = "Nexus Hub",
    Version = "1.1.2", -- Updated for audio ID change
    DiscordInvite = "hdTR2r73t8",
    SupportedGames = {
        BloxFruits = {2753915549, 4442272183, 7449423635},
        DaHood = {2788229376},
        MurderMystery2 = {142823291},
        Brookhaven = {4924922222}
    },
    Themes = {"Dark", "Light", "Abyss", "Blood", "Aqua", "Neon"},
    IntroAudio = {
        SoundId = "rbxassetid://117502688312383", -- Your provided audio ID
        FallbackSoundId = "rbxassetid://1839246711", -- Fallback in case the provided ID fails
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

        -- Validate audio ID
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
            -- Try fallback audio if the provided ID fails
            IntroSound.SoundId = Config.IntroAudio.FallbackSoundId
            local FallbackSuccess, FallbackError = pcall(function()
                IntroSound:Play()
            end)
            if FallbackSuccess then
                Rayfield:Notify({
                    Title = "Audio Warning",
                    Content = "Provided audio ID failed. Using fallback audio.",
                    Duration = 6,
                    Image = 4483362458
                })
            else
                Rayfield:Notify({
                    Title = "Audio Error",
                    Content = "Failed to play intro audio: " .. Error .. ". Fallback also failed: " .. FallbackError,
                    Duration = 6,
                    Image = 4483362458
                })
            end
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
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"NEXUS", "ACCESS2025", "VIP2025"}
    }
})

-- Play intro audio after window creation
PlayIntroAudio()

-- ✅ Utility Functions
local function Notify(Title, Content, Duration, Image)
    Rayfield:Notify({
        Title = Title,
        Content = Content,
        Duration = Duration or 6,
        Image = Image or 7734068321
    })
end

-- ... (Rest of the utility functions, Hacks, Admin Tools, and Game Hubs tabs remain unchanged)

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

SettingsTab:CreateButton({
    Name = "Test Audio",
    Callback = function()
        if IntroSound then
            IntroSound:Stop() -- Stop any existing playback
        end
        PlayIntroAudio() -- Replay the intro audio for testing
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
    Content = "Executor: " .. (identifyexecutor and identifyexecutor() or "Unknown") .. "\nVersion: " .. Config.Version .. "\nGame: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
})

-- ✅ Changelogs Tab
local ChangelogsTab = Window:CreateTab("Changelogs", 7733960981)
ChangelogsTab:CreateParagraph({Title = "v1.1.2", Content = "- Added custom audio ID support with fallback\n- Added Test Audio button in Settings"})
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

-- ... (Rest of the script: Hacks, Admin Tools, Game Hubs, Auto-Detect, and Anti-Detection remain unchanged)
