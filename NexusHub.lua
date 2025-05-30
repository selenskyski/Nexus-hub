-- ✅ Load Rayfield UI local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- ✅ Create Main Window local Window = Rayfield:CreateWindow({ Name = "Nexus Hub", LoadingTitle = "Loading UI...", LoadingSubtitle = "Created by Nexus team", ConfigurationSaving = { Enabled = true, FolderName = nil, FileName = "KalenHubConfig" }, Discord = { Enabled = true, Invite = "hdTR2r73t8", RememberJoins = false }, KeySystem = true, KeySettings = { Title = "Key Required", Subtitle = "Join Discord for Key", Note = "https://discord.gg/hdTR2r73t8", FileName = "KalenKeySave", SaveKey = true, GrabKeyFromSite = false, Key = {"NEXUS", "ACCESS2025"} } })

local Player = game.Players.LocalPlayer local Character = Player.Character or Player.CharacterAdded:Wait() local Humanoid = Character:WaitForChild("Humanoid")

-- ✅ Changelogs Tab local Changelogs = Window:CreateTab("Changelogs", 7733960981) Changelogs:CreateParagraph({ Title = "v1.0.2", Content = "- General Use tab renamed to Hacks\n- Shiftlock script moved to Hacks tab\n- Changelogs now appears first for better visibility \ud83d\udccc" }) Changelogs:CreateParagraph({ Title = "v1.0.1", Content = "- Added more tabs such as Game Hubs & Admin Tools\n- Added tools like Infinite Yield, Nameless Admin, and more \u2728" }) Changelogs:CreateParagraph({ Title = "v1.0.0", Content = "- Added Key System\n- Added Fly, Speed, Jump\n- Admin Tab with Shiftlock\n- Discord Integration\n- Setup for future Game Hubs" })

-- ✅ Hacks Tab local HacksTab = Window:CreateTab("Hacks", 4483362458)

HacksTab:CreateButton({ Name = "Enable Fly", Callback = function() loadstring(game:HttpGet("loadstring(game:HttpGet("https://raw.githubusercontent.com/minceda/Nexus-hub/main/NexusHub.lua"))()"))() end })

HacksTab:CreateSlider({ Name = "Walk Speed", Range = {16, 200}, Increment = 1, Suffix = "Speed", CurrentValue = 16, Callback = function(Value) if Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then Player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = Value end end })

HacksTab:CreateSlider({ Name = "Jump Power", Range = {50, 300}, Increment = 5, Suffix = "Power", CurrentValue = 50, Callback = function(Value) if Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then Player.Character:FindFirstChildOfClass("Humanoid").JumpPower = Value end end })

HacksTab:CreateButton({ Name = "Shiftlock", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/YourRealjohn/Unnamed-HUB-Lua/refs/heads/main/Advance%20PermShiftlock", true))() end })

-- ✅ Admin Tools Tab local AdminTab = Window:CreateTab("Admin Tools", 9432610133)

AdminTab:CreateButton({ Name = "Infinite Yield", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() end })

AdminTab:CreateButton({ Name = "Nameless Admin", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/Source"))() end })

-- ✅ Game Hubs Tab local GameHubs = Window:CreateTab("Game Hubs", 7734068321)

GameHubs:CreateButton({ Name = "Coming Soon Hub", Callback = function() Rayfield:Notify({ Title = "Not Ready", Content = "This hub will be added soon!", Duration = 5, Image = 4483362458 }) end })

-- ✅ Auto-Detect System local GamePlaceId = game.PlaceId

local function Notify(title, content) Rayfield:Notify({ Title = title, Content = content, Duration = 6.5, Image = 7734068321 }) end

if GamePlaceId == 2753915549 or GamePlaceId == 4442272183 or GamePlaceId == 7449423635 then Notify("Blox Fruits Detected", "Loading Blox Fruits Hub...") -- loadstring(game:HttpGet("https://yourdomain.com/bloxfruitshub.lua"))() elseif GamePlaceId == 2788229376 then Notify("Da Hood Detected", "Recommended: Infinite Yield, Fly, Speed Hacks") elseif GamePlaceId == 142823291 then Notify("Murder Mystery 2", "Use Nameless Admin or Speed Hacks carefully!") elseif GamePlaceId == 4924922222 then Notify("Brookhaven", "Fun place for shiftlock and jump hacks!") else Notify("Unknown Game", "You're in a game not currently supported.") end

  
