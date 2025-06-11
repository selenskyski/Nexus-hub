-- ✅ Load Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- ✅ Create Main Window
local Window = Rayfield:CreateWindow({
	Name = "Nexus Hub",
	LoadingTitle = "Loading UI...",
	LoadingSubtitle = "Created by Nexus team",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = nil,
		FileName = "KalenHubConfig"
	},
	Discord = {
		Enabled = true,
		Invite = "hdTR2r73t8",
		RememberJoins = false
	},
	KeySystem = true,
	KeySettings = {
		Title = "Key Required",
		Subtitle = "Join Discord for Key",
		Note = "https://discord.gg/hdTR2r73t8",
		FileName = "KalenKeySave",
		SaveKey = false,
		GrabKeyFromSite = false,
		Key = { "NEXUS", "ACCESS2025" }
	}
})

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- ✅ Executor Detection
local supportedExecutors = {
	Synapse = true,
	KRNL = true,
	Fluxus = true,
	ScriptWare = true,
	Electron = true
}
local executor = identifyexecutor and identifyexecutor() or "Unknown"
local status = supportedExecutors[executor] and "✅ Supported" or "❌ Unsupported"
Rayfield:Notify({
	Title = "Executor Check",
	Content = "Executor: " .. executor .. " - " .. status,
	Duration = 6.5
})

-- ✅ Changelogs Tab
local Changelogs = Window:CreateTab("Changelogs", 7733960981)
Changelogs:CreateParagraph({ Title = "v1.0.4", Content = "- Added verified ScriptBlox game hubs (Blox Fruits, Da Hood, Brookhaven, MM2, Grow a Garden)" })
Changelogs:CreateParagraph({ Title = "v1.0.3", Content = "- Added Settings tab with UI themes\n- Executor detection" })
Changelogs:CreateParagraph({ Title = "v1.0.2", Content = "- Renamed General tab to Hacks\n- Moved Shiftlock to Hacks" })
Changelogs:CreateParagraph({ Title = "v1.0.1", Content = "- Added Admin Tools, Game Hubs, and Infinite Yield/Nameless Admin" })
Changelogs:CreateParagraph({ Title = "v1.0.0", Content = "- Core UI, Fly, Speed, Jump, Key System, Auto-detect added" })
Changelogs:CreateButton({
	Name = "📋 Copy Discord Server Link",
	Callback = function()
		setclipboard("https://discord.gg/hdTR2r73t8")
		Rayfield:Notify({
			Title = "Copied!",
			Content = "Discord invite link copied to clipboard.",
			Duration = 4
		})
	end
})

-- ✅ Hacks Tab
local HacksTab = Window:CreateTab("Hacks", 4483362458)
HacksTab:CreateButton({
	Name = "Enable Fly",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/minceda/Nexus-hub/main/fly.lua"))()
	end
})
HacksTab:CreateSlider({
	Name = "Walk Speed",
	Range = { 16, 200 },
	Increment = 1,
	Suffix = "Speed",
	CurrentValue = 16,
	Callback = function(Value)
		if Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
			Player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = Value
		end
	end
})
HacksTab:CreateSlider({
	Name = "Jump Power",
	Range = { 50, 300 },
	Increment = 5,
	Suffix = "Power",
	CurrentValue = 50,
	Callback = function(Value)
		if Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
			Player.Character:FindFirstChildOfClass("Humanoid").JumpPower = Value
		end
	end
})
HacksTab:CreateButton({
	Name = "Shiftlock",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/YourRealjohn/Unnamed-HUB-Lua/main/Advance%20PermShiftlock", true))()
	end
})

-- ✅ Admin Tools Tab
local AdminTab = Window:CreateTab("Admin Tools", 9432610133)
AdminTab:CreateButton({
	Name = "Infinite Yield",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
	end
})
AdminTab:CreateButton({
	Name = "Nameless Admin",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/Source"))()
	end
})

-- ✅ Game Hubs Tab
local GameHubs = Window:CreateTab("Game Hubs", 7734068321)
GameHubs:CreateButton({
	Name = "Blox Fruits – Forge Hub",
	Callback = function()
		loadstring(game:HttpGet("https://scriptblox.com/raw/Forge-Hub-33453"))()
	end
})
GameHubs:CreateButton({
	Name = "Da Hood – Zinc Hub",
	Callback = function()
		loadstring(game:HttpGet("https://scriptblox.com/raw/Zinc-Hub-10720"))()
	end
})
GameHubs:CreateButton({
	Name = "Brookhaven – Mango Hub",
	Callback = function()
		loadstring(game:HttpGet("https://scriptblox.com/raw/Mango-Hub-33726"))()
	end
})
GameHubs:CreateButton({
	Name = "Murder Mystery 2 – Forge Hub",
	Callback = function()
		loadstring(game:HttpGet("https://scriptblox.com/raw/Forge-Hub-35163"))()
	end
})
GameHubs:CreateButton({
	Name = "Grow a Garden – Forge Hub",
	Callback = function()
		loadstring(game:HttpGet("https://scriptblox.com/raw/Forge-Hub-41130"))()
	end
})

-- ✅ Settings Tab
local SettingsTab = Window:CreateTab("Settings", 7734071342)
SettingsTab:CreateDropdown({
	Name = "UI Theme",
	Options = { "Dark", "Light", "Abyss", "Blood" },
	CurrentOption = "Dark",
	Callback = function(Value)
		Rayfield:ChangeTheme(Value)
	end
})
SettingsTab:CreateParagraph({
	Title = "Executor Status",
	Content = identifyexecutor and ("Executor: " .. identifyexecutor()) or "Unknown or unsupported executor"
})

-- ✅ Auto-Detect System
local GamePlaceId = game.PlaceId
local function Notify(title, content)
	Rayfield:Notify({
		Title = title,
		Content = content,
		Duration = 6.5,
		Image = 7734068321
	})
end

if GamePlaceId == 2753915549 or GamePlaceId == 4442272183 or GamePlaceId == 7449423635 then
	Notify("Blox Fruits Detected", "Loading Blox Fruits Hub...")
elseif GamePlaceId == 2788229376 then
	Notify("Da Hood Detected", "Recommended: Infinite Yield, Fly, Speed Hacks")
elseif GamePlaceId == 142823291 then
	Notify("Murder Mystery 2", "Use Nameless Admin or Speed Hacks carefully!")
elseif GamePlaceId == 4924922222 then
	Notify("Brookhaven", "Fun place for shiftlock and jump hacks!")
else
	Notify("Unknown Game", "You're in a game not currently supported.")
end
