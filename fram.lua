-- [[ CẤU HÌNH TỔNG HỢP CẢ 2 TAB ]]
_G.AutoFarmLevel = false
_G.AutoFarmBone = false
_G.AutoSeaEvent = false

-- Cấu hình Sea Event
_G.SelectedTargets = {
    ["Terror Shark"] = true,
    ["Piranha"] = true,
    ["Shark"] = true,
    ["Sea Beast"] = true,
    ["Ship"] = true
}
_G.BoatSpeed = 300
_G.DodgeSpeed = 350
_G.AutoDodge = true

-- Các Service hệ thống
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")

-- Hàm bổ trợ: Tự động Đập/Click chuột
local function AutoClick()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton1(Vector2.new(0,0))
end

-- Hàm bổ trợ: Bay/Tween mượt tới vị trí (Không bị văng)
local function TweenTo(cframe)
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = cframe
    end
end

-- =========================================================
-- 🔥 PHO_PHẦN 1: TAB FARM (LEVEL & BONE)
-- =========================================================

-- 1. Hàm lấy Nhiệm vụ + Tên Quái theo Level hiện tại
local function GetQuestAndMob()
    local myLevel = LocalPlayer.Data.Level.Value
    -- Ví dụ mẫu cấu trúc check level (Ông tự thêm các đảo tương tự vào nhé)
    if myLevel >= 1 and myLevel < 15 then
        return "Bandit Quest 1", "Bandit", CFrame.new(1059, 15, 1540) -- Tên Q, Tên Quái, Vị trí nhận Q
    elseif myLevel >= 15 and myLevel < 30 then
        return "Monkey Quest", "Monkey", CFrame.new(-1600, 30, 150)
    else
        -- Mặc định level cao ở các Sea sau
        return "Latest Quest", "Latest Mob", CFrame.new(0,0,0)
    end
end

-- Vòng lặp Auto Farm Level
task.spawn(function()
    while task.wait(0.1) do
        -- Nếu đang bật Farm Sea Event thì KHÔNG chạy farm level
        if _G.AutoFarmLevel and not _G.AutoSeaEvent then
            local questName, mobName, questCFrame = GetQuestAndMob()
            
            -- Check xem đã nhận Quest chưa (Dựa vào UI Quest của Blox Fruits)
            local hasQuest = LocalPlayer.PlayerGui.Main:FindFirstChild("Quest") and LocalPlayer.PlayerGui.Main.Quest.Visible
            
            if not hasQuest then
                -- Tween tới nhận nhiệm vụ
                TweenTo(questCFrame)
                task.wait(0.5)
                -- Lệnh Remote nhận Q (Cái này tùy Sea, ông sài lệnh Remote nhận Q của ông vào đây)
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", questName, 1)
            else
                -- Nếu đã có Q, tìm quái để đập
                local mobFound = false
                for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                    if mob.Name == mobName and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
                        mobFound = true
                        -- Bay phía trên đầu quái để né skill quái thường
                        TweenTo(mob.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0))
                        AutoClick()
                        break
                    end
                end
                
                -- Nếu không tìm thấy quái sống, bay tới bãi spawn quái chờ nó hồi sinh
                if not mobFound then
                    -- Lấy vị trí bãi quái (Ví dụ tìm trong vị trí mặc định)
                    local spawnPoint = Workspace._WorldOrigin.EnemySpawns:FindFirstChild(mobName)
                    if spawnPoint then
                        TweenTo(spawnPoint.CFrame)
                    end
                end
            end
        end
    end
end)

-- Vòng lặp Auto Farm Xương (Bone) cho dân cày thuê
task.spawn(function()
    while task.wait(0.1) do
        if _G.AutoFarmBone and not _G.AutoSeaEvent then
            for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                -- Các loại quái rớt xương ở Lâu Đài Bóng Đêm (Sea 3)
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
-- 🌊 PHO_PHẦN 2: TAB SEA EVENT (LÁI THUYỀN, NOCKLIP, NÉ CHIÊU)
-- =========================================================

local function GetMyBoat()
    for _, v in pairs(Workspace.Boats:GetChildren()) do
        if v:FindFirstChild("Owner") and v.Owner.Value == LocalPlayer then
            return v
        end
    end
    return nil
end

-- Vòng lặp Tốc độ thuyền + Noclip xuyên đá
RunService.Stepped:Connect(function()
    if _G.AutoSeaEvent then
        -- Ép tắt các tính năng farm thường để tập trung ra khơi
        _G.AutoFarmLevel = false
        _G.AutoFarmBone = false
        
        local myBoat = GetMyBoat()
        if myBoat and myBoat:FindFirstChild("VehicleSeat") then
            local seat = myBoat.VehicleSeat
            if seat.Velocity.Magnitude > 0 then
                seat.Velocity = seat.CFrame.LookVector * _G.BoatSpeed
            end
            for _, part in pairs(myBoat:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- Tự động chạy thẳng ra xa khi không có quái biển
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

-- Cơ chế Né Chiêu Cực Hạn (Dodge Speed 350) khi quái gồng chiêu
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
        task.wait(1.5) -- Bay cao né chiêu 1.5 giây
        bv:Destroy()
        isDodging = false
    end
end

-- Săn Quái Biển & Xả Skill
task.spawn(function()
    while task.wait(0.1) do
        if _G.AutoSeaEvent then
            _G.TargetFound = false
            for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                if _G.SelectedTargets[enemy.Name] and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
                    _G.TargetFound = true
                    local hrp = LocalPlayer.Character.HumanoidRootPart
                    
                    -- Check nếu Terror Shark hoặc Sea Beast dùng skill bự
                    if enemy:FindFirstChild("Animate") or enemy:FindFirstChild("AttackEffects") then
                        DodgeSkill()
                    end
                    
                    if not isDodging then
                        -- Bay bám sát phía trên đầu quái biển để xả chiêu
                        TweenTo(enemy.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
                        AutoClick()
                        
                        -- Code tự động nhấn phím chiêu Z, X, C, V (Ông có thể thêm VirtualInputManager ở đây)
                    end
                    break
                end
            end
        end
    end
end)
