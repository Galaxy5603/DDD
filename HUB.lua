local A_1 = "BLK_Galaxy AutoFarm Earth"
local A_2 = "All"
local Event = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest
Event:FireServer(A_1, A_2)


local npcs = {
    [1] = "Evil Saiyan",
    [2] = "Chi",
    [3] = "Kick",
    [4] = "Android",
    [5] = "Saiba",
    [6] = "Majin",
}

local function load(loadobj)
    repeat wait() until(loadobj)
end

local function dist(v1, v2)
    return(v1 - v2).Magnitude
end

local function kill(path, obj)
    for i, v in ipairs(path) do
        if v.Name == obj then
            v:Destroy()
        end
    end
end

local function twn(char, time, coords)
    game:GetService("TweenService"):Create(char, TweenInfo.new(time, Enum.EasingStyle.Linear), {CFrame = coords}):Play()
end

local function notif(Title, Text, ...)
    if ... == nil then
        Duration = 7
    else
        Duration = ...
    end
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = Title,
        Text = Text,
        Duration = Duration}
    )
end
local tnpc = {}
local function getnpc(NpcName)
    tnpc = {}
    if NpcName ~= "" then
        local lower = NpcName:lower()
        for i, npc in next, game.workspace.Live:GetChildren() do
            if npc.Name:sub(1, #NpcName):lower() == lower then
                if not npc:FindFirstChild("PowerOutput") then
                    table.insert(tnpc, npc)
                end
            end
        end
    end
end

load(game:IsLoaded())
load(game.Players.LocalPlayer.Character)
local plr = game.Players.LocalPlayer
local cam = game.workspace.CurrentCamera
load(plr.Character:FindFirstChild("Block"))

notif("BLK_Galaxy FARM EARTH BETA", "", 10)
local part = Instance.new("Part", game.workspace)
part.Anchored = true
part.Transparency = 1
while wait() do
    part.Position = plr.Character.HumanoidRootPart.CFrame * Vector3.new(0, -3, 0)
    for i, v in ipairs(npcs) do
        getnpc(v)
        for i2, idk in ipairs(tnpc) do
            if idk:FindFirstChild("Humanoid") and idk.Humanoid.Health > 0 then
                repeat wait()
                    local distance = dist(plr.Character.HumanoidRootPart.Position, idk.HumanoidRootPart.Position)
                    if distance > 50000 then
                        DoIBreak2 = true
                        break
                    end
                    twn(plr.Character.HumanoidRootPart, distance/4500, idk.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5))
                    wait(distance/4400)
                until(distance < 500)
                DoIBreak = false
                coroutine.wrap(function()
                    repeat
                        if DoIBreak or DoIBreak2 then
                            break
                        end
                        plr.Backpack.ServerTraits.Input:FireServer({[1] = "md"},CFrame.new(0,0,0),nil,false)
                        wait(.4 - math.random())
                    until(DoIBreak or DoIBreak2)
                end){}
                repeat wait()
                    if not game.workspace.Live:FindFirstChild(idk.Name) then
                        break
                    end
                    if DoIBreak2 then
                        DoIBreak2 = false
                        break
                    end
                    plr.Character.HumanoidRootPart.CFrame = idk.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
                    cam.CFrame = CFrame.new(plr.Character.HumanoidRootPart.Position, Vector3.new(idk.HumanoidRootPart.Position.X, plr.Character.HumanoidRootPart.Position.Y, idk.HumanoidRootPart.Position.Z)) * CFrame.new(0, 2, 10)
                until(not game.workspace.Live:FindFirstChild(idk.Name) or idk.Humanoid.Health <= 0)
                DoIBreak = true
            end
        end
    end
end
