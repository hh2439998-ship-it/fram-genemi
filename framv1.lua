-- [[ KHỞI TẠO INTERFACE ORION UI ]]
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "HuyHoangHub 🌟 Sea Event & Farm", HidePremium = false, SaveConfig = false, IntroText = "Loading HuyHoangHub..."})

-- [[ CẤU HÌNH BIẾN TOÀN CỤC ]]
_G.AutoFarmLevel = false
_G.AutoFarmBone = false
_G.AutoSeaEvent = false
_G.BoatSpeed = 300
_G.DodgeSpeed = 350
_G.AutoDodge = true

_G.SelectedTargets = {
    ["Terror Shark"] = true,
    ["Piranha"] = true,
    ["Shark"] = true,
    ["Sea Beast"] = true,
    ["Ship"] = true
}

-- Các Dịch Vụ Hệ Thống
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")

local function AutoClick()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton1(Vector2.new(0,0))
end

local function TweenTo(cframe)
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = cframe
    end
end

-- =========================================================
-- 🏠 TAB 1: AUTO FARM (LEVEL & BONE)
-- =========================================================
local FarmTab = Window:MakeTab({Name = "Auto Farm", Icon = "rbxassetid://4483345998", PremiumOnly = false})

FarmTab:AddToggle({
    Name = "Auto Farm Level Max",
    Default = false,
    Callback = function(Value)
        _G.AutoFarmLevel = Value
        if Value then _G.AutoSeaEvent = false end -- Tắt tab biển nếu bật farm level
    end    
})

FarmTab:AddToggle({
    Name = "Auto Farm Xương (Bone)",
    Default = false,
    Callback = function(Value)
        _G.AutoFarmBone = Value
        if Value then _G.AutoSeaEvent = false end
    end    
})

-- Logic Farm Level
task.spawn(function()
    while task.wait(0.1) do
        if _G.AutoFarmLevel and not _G.AutoSeaEvent then
            -- Mẫu lấy Q theo level (Ông cấu hình thêm các đảo của ông ở đây)
            local hasQuest = LocalPlayer.PlayerGui.Main:FindFirstChild("Quest") and LocalPlayer.PlayerGui.Main.Quest.Visible
            if not hasQuest then
                -- Ví dụ tọa độ nhận Q tân thủ, thay bằng logic đảo của ông
                TweenTo(CFrame.new(1059, 15, 1540))
                task.wait(0.5)
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "Bandit Quest 1", 1)
            else
                for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                    if mob.Name == "Bandit" and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
                        TweenTo(mob.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0))
                        AutoClick()
                        break
                    end
                end
            end
        end
    end
end)

-- Logic Farm Bone
task.spawn(function()
    while task.wait(0.1) do
        if _G.AutoFarmBone and not _G.AutoSeaEvent then
            for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                if (mob.Name == "Reborn Skeleton" or mob.Name == "Living Zombie" or mob.Name == "Demonic Soul") 
                and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
                    TweenTo(mob.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0))
                    AutoClick()
                    break
                end
            end
        end
    end
end)

-- =========================================================
-- 🌊 TAB 2: SEA EVENT (SĂN QUÁI BIỂN & NÉ CHIÊU)
-- =========================================================
local SeaTab = Window:MakeTab({Name = "Sea Event", Icon = "rbxassetid://4483345998", PremiumOnly = false})

SeaTab:AddToggle({
    Name = "Bật Auto Sea Event",
    Default = false,
    Callback = function(Value)
        _G.AutoSeaEvent = Value
        if Value then
            _G.AutoFarmLevel = false
            _G.AutoFarmBone = false
        end
    end    
})

SeaTab:AddSlider({
    Name = "Tốc Độ Thuyền (Xuyên Vật Cản)",
    Min = 100,
    Max = 500,
    Default = 300,
    Color = Color3.fromRGB(255,255,255),
    Increment = 10,
    ValueName = "Speed",
    Callback = function(Value)
        _G.BoatSpeed = Value
    end    
})

SeaTab:AddToggle({
    Name = "Tự Động Né Chiêu (Dodge Skill)",
    Default = true,
    Callback = function(Value)
        _G.AutoDodge = Value
    end    
})

-- Hàm tìm thuyền của mình
local function GetMyBoat()
    for _, v in pairs(Workspace.Boats:GetChildren()) do
        if v:FindFirstChild("Owner") and v.Owner.Value == LocalPlayer then
            return v
        end
    end
    return nil
end

-- Vòng lặp Ép Tốc Độ Thuyền + Noclip xuyên đá liên tục
RunService.Stepped:Connect(function()
    if _G.AutoSeaEvent then
        local myBoat = GetMyBoat()
        if myBoat and myBoat:FindFirstChild("VehicleSeat") then
            local seat = myBoat.VehicleSeat
            if seat.Velocity.Magnitude > 0 then
                seat.Velocity = seat.CFrame.LookVector * _G.BoatSpeed
            end
            -- Noclip toàn bộ bộ phận của thuyền
            for _, part in pairs(myBoat:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- Tự động chạy lái thuyền ra biển xa (Autopilot W)
task.spawn(function()
    while task.wait(1) do
        if _G.AutoSeaEvent then
            local myBoat = GetMyBoat()
            if myBoat and not _G.TargetFound then
                local VirtualInputManager = game:GetService("VirtualInputManager")
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.W, false, game)
            end
        end
    end
end)

-- Cơ chế nhảy vút lên trời né chiêu (Speed 350)
local isDodging = false
local function DodgeSkill()
    if isDodging or not _G.AutoDodge then return end
    isDodging = true
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local hrp = character.HumanoidRootPart
        local bv = Instance.new("BodyVelocity")
        bv.Velocity = Vector3.new(0, _G.DodgeSpeed, 0)
        bv.MaxForce = Vector3.new(0, math.huge, 0)
        bv.Parent = hrp
        task.wait(1.5) -- Né trong 1.5 giây rồi hạ xuống đập tiếp
        bv:Destroy()
        isDodging = false
    end
end

-- Quét tìm quái biển và xả chiêu
task.spawn(function()
    while task.wait(0.1) do
        if _G.AutoSeaEvent then
            _G.TargetFound = false
            for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                if _G.SelectedTargets[enemy.Name] and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
                    _G.TargetFound = true
                    
                    -- Check hiệu ứng gồng chiêu của Quái để né
                    if enemy:FindFirstChild("Animate") or enemy:FindFirstChild("AttackEffects") then
                        DodgeSkill()
                    end
                    
                    if not isDodging then
                        -- Giữ khoảng cách an toàn phía trên đầu quái để đánh xuống
                        TweenTo(enemy.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
                        AutoClick()
                    end
                    break
                end
            end
        end
    end
end)

-- Bật Menu lên
OrionLib:Init()
