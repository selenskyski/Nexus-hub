-- Fly Script by Nexus Hub
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local flying = false
local speed = 5
local UIS = game:GetService("UserInputService")

local bodyGyro = Instance.new("BodyGyro")
bodyGyro.P = 9e4
bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
bodyGyro.CFrame = HumanoidRootPart.CFrame

local bodyVelocity = Instance.new("BodyVelocity")
bodyVelocity.Velocity = Vector3.new(0,0,0)
bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)

local function fly()
    bodyGyro.Parent = HumanoidRootPart
    bodyVelocity.Parent = HumanoidRootPart
    flying = true

    local conn
    conn = game:GetService("RunService").RenderStepped:Connect(function()
        if not flying then conn:Disconnect() return end

        bodyGyro.CFrame = workspace.CurrentCamera.CFrame
        local moveDirection = Vector3.new()
        if UIS:IsKeyDown(Enum.KeyCode.W) then moveDirection = moveDirection + workspace.CurrentCamera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then moveDirection = moveDirection - workspace.CurrentCamera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then moveDirection = moveDirection - workspace.CurrentCamera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then moveDirection = moveDirection + workspace.CurrentCamera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDirection = moveDirection + Vector3.new(0, 1, 0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then moveDirection = moveDirection - Vector3.new(0, 1, 0) end

        bodyVelocity.Velocity = moveDirection.Unit * speed
    end)
end

local function stopFlying()
    flying = false
    bodyGyro:Destroy()
    bodyVelocity:Destroy()
end

-- Toggle with "F" key
UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F then
        if flying then
            stopFlying()
        else
            fly()
        end
    end
end)

game.StarterGui:SetCore("SendNotification", {
    Title = "Fly Script Loaded",
    Text = "Press [F] to toggle fly",
    Duration = 5
})
