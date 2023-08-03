local Player = game.Players.LocalPlayer
local group_id = 969571
--Credit to Wes
print(game.Players.LocalPlayer:GetRoleInGroup(group_id))
local Ranks = {"loser account holder",
    "actually stupid than everyone 14",
    "low is",
    "dum dums",
    "loser account holder",
    }
for i,v in pairs(game.Players:GetChildren()) do
    for i,x in pairs(Ranks) do
        if v:GetRoleInGroup(group_id) == x then
            Player:Kick("RUN OWNERS JOINED THE GAME")
        end
    end
end
game.Players.PlayerAdded:Connect(function(NewPlayer)
    for i,x in pairs(Ranks) do
        if NewPlayer:GetRoleInGroup(group_id) == x then
            Player:Kick("RUN OWNERS JOINED THE GAME")
        end
    end
end)
spawn(function()
        while task.wait(0.1) do
            for _, tool in ipairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
        if tool:IsA("Tool")  and game:GetService("Players").LocalPlayer.Character then
            tool.Parent = game:GetService("Players").LocalPlayer.Character
        end
    end
        end
    end)
wait(0.5)
task.spawn(function()
        for i,v in pairs(workspace.Map["Kill baseplates"]:GetDescendants()) do
if v:IsA("Part")  or v:IsA("MeshPart") or v:IsA("BasePart") or
                                    v:IsA("UnionOperation") then
                                    v.CanTouch = false
                                    end
                                    end
                                    for i,v in pairs(workspace.Map.TrapsThatDontMove:GetDescendants()) do
if v:IsA("Part")  or v:IsA("MeshPart") or v:IsA("BasePart") or
                                    v:IsA("UnionOperation") then
                                    v.CanTouch = false
                                    end
                                    end
                                            for i,v in pairs(workspace.Map.Magnets:GetDescendants()) do
if v:IsA("Part")  or v:IsA("MeshPart") or v:IsA("BasePart") or
                                    v:IsA("UnionOperation") then
                                    v.CanTouch = false
                                    end
                                    end
                                                    for i,v in pairs(workspace.ClientModels.replicated:GetDescendants()) do
if v:IsA("Part")  or v:IsA("MeshPart") or v:IsA("BasePart") or
                                    v:IsA("UnionOperation") then
                                    v.CanTouch = false
                                    end
                                    end
    end)
task.spawn(function()
        while task.wait() do
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Dynamite") and game.Players.LocalPlayer.Character:FindFirstChild("Dynamite"):FindFirstChild("Handle") then
local args = {
    [1] = "Dynamite",
    [2] = game:GetService("Players").LocalPlayer.Character.Dynamite.Handle,
    [3] = game:GetService("Players").LocalPlayer.Character.Dynamite.Handle.CFrame
}

game:GetService("ReplicatedStorage"):WaitForChild("Connections"):WaitForChild("Throw"):FireServer(unpack(args))
end
end
    end)
local player = game.Players.LocalPlayer
local humanoidRootPart

local function distance(pos1, pos2)
    return (pos1 - pos2).magnitude
end

local function hasLineOfSight(origin, destination)
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
    rayParams.FilterDescendantsInstances = {player.Character, destination.Parent}

    local raycastResult = game.Workspace:Raycast(origin, destination.Position - origin, rayParams)
    return not raycastResult
end

local function findNearestPlayerWithLineOfSight()
    local players = game.Players:GetPlayers()
    local nearestPlayer, minDistance = nil, math.huge
    
    for _, otherPlayer in ipairs(players) do
        if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local otherHumanoidRootPart = otherPlayer.Character.HumanoidRootPart
            local distanceToPlayer = distance(humanoidRootPart.Position, otherHumanoidRootPart.Position)
            
            if distanceToPlayer < minDistance and hasLineOfSight(humanoidRootPart.Position, otherHumanoidRootPart) then
                nearestPlayer = otherPlayer
                minDistance = distanceToPlayer
            end
        end
    end
    
    return nearestPlayer
end

local function updateNearestPlayer()
    wait(1)
    local nearestPlayer = findNearestPlayerWithLineOfSight()
    if nearestPlayer  then
        local nearestUsername = nearestPlayer and nearestPlayer.Name
        local nearestDisplayName = nearestPlayer.DisplayName
        game.Players.LocalPlayer.Character:PivotTo(game:GetService("Players"):WaitForChild(nearestUsername).Character.Head.CFrame + Vector3.new(0,-1,7))
        local args = {
            [1] = game:GetService("Players"):WaitForChild(nearestUsername)
        }
        game:GetService("ReplicatedStorage"):WaitForChild("_objects"):WaitForChild("Tools"):WaitForChild("Hammer"):WaitForChild("Hit"):FireServer(unpack(args))
    else
        if game.Players.LocalPlayer.Character then
            game.Players.LocalPlayer.Character:PivotTo(workspace.Map.TrapsThatDontMove.Xarusa.HoodedAssassin.Handle.CFrame+ Vector3.new(0,7,0))
        end
    end
end

local function onCharacterAdded(character)
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    heartbeatConnection = game:GetService("RunService").Heartbeat:Connect(updateNearestPlayer)
end

local function onCharacterRemoved()
    if heartbeatConnection then
        heartbeatConnection:Disconnect()
    end
    humanoidRootPart = nil
end

player.CharacterAdded:Connect(onCharacterAdded)
player.CharacterRemoving:Connect(onCharacterRemoved)

if player.Character then
    onCharacterAdded(player.Character)
end
