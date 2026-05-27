-- ==============================================================================
-- [ LIGHT GALAXY HUB ] - BANA STYLE UI EDITION
-- Tối ưu 100% cho Delta / Không nén dòng / Full IP Database / Full Logic
-- ==============================================================================

-- 1. TẢI GIAO DIỆN KIỂU BANANA HUB (FLUENT UI)
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "LIGHT GALAXY HUB - FULL SCRIPT",
    SubTitle = "Bana Style Edition",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

-- ==============================================================================
-- 2. KHỞI TẠO BIẾN HỆ THỐNG VÀ DỊCH VỤ
-- ==============================================================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

-- BIẾN TOÀN CỤC (GLOBAL VARIABLES) TÁCH BẠCH KHÔNG GỘP
_G.WeaponType = "Melee"
_G.AutoClicker = false
_G.BringMonsters = false

_G.AutoFarmLevel = false
_G.AutoFarmBone = false
_G.AutoFarmCake = false

_G.AutoSeaEvent = false
_G.AutoBuyBoat = false
_G.BoatSpeed = 350
_G.HuntTerrorShark = false
_G.HuntSeaBeast = false
_G.HuntPiranha = false
_G.HuntGhostShip = false

_G.AutoLeviathan = false
_G.AutoMirage = false
_G.AutoKitsune = false
_G.AutoRaid = false
_G.RaidChipType = "Flame"
_G.AutoCollectFruit = false
_G.AutoStoreFruit = false

-- ==============================================================================
-- 3. CƠ SỞ DỮ LIỆU TỌA ĐỘ (FULL IP CFRAME SEA 3)
-- ==============================================================================
local FULL_IP_DATABASE = {
    -- Cảng & Đảo Chính
    PiratePort = CFrame.new(-290, 44, 5581),
    HydraIsland = CFrame.new(5749, 610, -253),
    GreatTree = CFrame.new(5393, 13, 2525),
    FloatingTurtle_Mansion = CFrame.new(-12463, 375, -7523),
    CastleOnTheSea = CFrame.new(-5012, 315, -3157),
    HauntedCastle_Bone = CFrame.new(-9481, 142, 5566),
    TikiOutpost_Dock = CFrame.new(-2421, 73, -3215),
    RaidLaboratory = CFrame.new(-5036, 315, -3179),
    
    -- Quần Đảo Kẹo (Sea of Treats)
    PeanutIsland = CFrame.new(-2104, 38, -10192),
    IceCreamIsland = CFrame.new(-821, 66, -10965),
    CakeIsland = CFrame.new(-2022, 38, -12028),
    ChocolateIsland = CFrame.new(138, 25, -12185),
    CandyIsland = CFrame.new(-1147, 13, -14445)
}

-- ==============================================================================
-- 4. HỆ THỐNG XÁC ĐỊNH NHIỆM VỤ THEO LEVEL (KHÔNG RÚT GỌN)
-- ==============================================================================
local function GetCurrentQuestData()
    local playerLevel = LocalPlayer.Data.Level.Value
    
    if playerLevel >= 1500 and playerLevel < 1575 then 
        return "Pirate Port Quest", "Pirate Millionaire", FULL_IP_DATABASE.PiratePort
    elseif playerLevel >= 1575 and playerLevel < 1700 then 
        return "Amazon Quest", "Dragon Crew Warrior", FULL_IP_DATABASE.HydraIsland
    elseif playerLevel >= 1700 and playerLevel < 1775 then 
        return "Marine Tree Island", "Marine Commodore", FULL_IP_DATABASE.GreatTree
    elseif playerLevel >= 1775 and playerLevel < 1975 then 
        return "Deep Forest Island", "Fishman Raider", FULL_IP_DATABASE.FloatingTurtle_Mansion
    elseif playerLevel >= 1975 and playerLevel < 2125 then 
        return "Haunted Quest 1", "Reborn Skeleton", FULL_IP_DATABASE.HauntedCastle_Bone
    elseif playerLevel >= 2125 and playerLevel < 2200 then 
        return "Peanut Quest", "Peanut Scout", FULL_IP_DATABASE.PeanutIsland
    elseif playerLevel >= 2200 and playerLevel < 2275 then 
        return "Ice Cream Quest", "Cookie Crafter", FULL_IP_DATABASE.IceCreamIsland
    elseif playerLevel >= 2275 and playerLevel < 2350 then 
        return "Cake Quest 1", "Cake Guard", FULL_IP_DATABASE.CakeIsland
    elseif playerLevel >= 2350 and playerLevel < 2400 then 
        return "Choc Quest", "Cocoa Warrior", FULL_IP_DATABASE.ChocolateIsland
    elseif playerLevel >= 2400 and playerLevel < 2450 then 
        return "Candy Quest 1", "Candy Rebel", FULL_IP_DATABASE.CandyIsland
    else 
        return "Tiki Quest", "Isle Champion", FULL_IP_DATABASE.TikiOutpost_Dock 
    end
end

-- ==============================================================================
-- 5. HỆ THỐNG DỊCH CHUYỂN AN TOÀN (ANTI-KICK TWEEN)
-- ==============================================================================
local function MoveToTargetSafe(targetCFrame)
    local character = LocalPlayer.Character
    if not character then return end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    
    local distance = (rootPart.Position - targetCFrame.Position).Magnitude
    
    -- Bay tức thời nếu khoảng cách dưới 15
    if distance < 15 then 
        rootPart.CFrame = targetCFrame
        return 
    end
    
    -- Tốc độ an toàn 320 studs/giây
    local tweenDuration = distance / 320
    local tweenInfo = TweenInfo.new(tweenDuration, Enum.EasingStyle.Linear)
    local tweenAction = TweenService:Create(rootPart, tweenInfo, {CFrame = targetCFrame})
    
    -- Vòng lặp chống kẹt tường (Noclip)
    local noclipConnection = RunService.Stepped:Connect(function()
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then 
                part.CanCollide = false 
            end
        end
    end)
    
    tweenAction:Play()
    tweenAction.Completed:Wait()
    noclipConnection:Disconnect()
end

-- ==============================================================================
-- 6. HỆ THỐNG CHIẾN ĐẤU (COMBAT ENGINE: AUTO CLICK & BRING MOB)
-- ==============================================================================

-- A. AUTO CLICK (Bấm chuột siêu tốc)
RunService.RenderStepped:Connect(function()
    if _G.AutoClicker then
        pcall(function()
            local character = LocalPlayer.Character
            if character then
                -- Kiểm tra xem đã cầm vũ khí chưa, chưa thì tự móc ra
                local hasTool = character:FindFirstChildOfClass("Tool")
                if not hasTool then
                    for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
                        if tool.ToolTip == _G.WeaponType then 
                            character.Humanoid:EquipTool(tool)
                            break
                        end
                    end
                end
                
                -- Kích hoạt đòn đánh
                local activeWeapon = character:FindFirstChildOfClass("Tool")
                if activeWeapon then 
                    activeWeapon:Activate() 
                end
                
                -- Giả lập click qua VirtualUser
                VirtualUser:CaptureController()
                VirtualUser:Button1Down(Vector2.new(0,0))
            end
        end)
    end
end)

-- B. BRING MOB (Gom tối đa 2 quái, ngang mặt Z = -3.5)
RunService.Heartbeat:Connect(function()
    if _G.BringMonsters then
        pcall(function()
            local character = LocalPlayer.Character
            if not character then return end
            
            local playerRoot = character:FindFirstChild("HumanoidRootPart")
            if not playerRoot then return end
            
            local monsterCount = 0
            
            for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                if mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
                    if mob.Humanoid.Health > 0 then
                        local mobRoot = mob.HumanoidRootPart
                        local distanceFromPlayer = (mobRoot.Position - playerRoot.Position).Magnitude
                        
                        -- Quét phạm vi 350 studs, lấy đúng 2 con quái để tránh văng game
                        if distanceFromPlayer < 350 and monsterCount < 2 then
                            mobRoot.CanCollide = false
                            mob.Humanoid.WalkSpeed = 0
                            mob.Humanoid.JumpPower = 0
                            mobRoot.Size = Vector3.new(12, 12, 12) -- Mở rộng Hitbox
                            
                            -- Đưa quái ra trước mặt người chơi chuẩn 3.5 studs
                            mobRoot.CFrame = playerRoot.CFrame * CFrame.new(0, 0, -3.5)
                            monsterCount = monsterCount + 1
                        end
                    end
                end
            end
        end)
    end
end)

-- ==============================================================================
-- 7. VÒNG LẶP CÀY CUỐC (FARM LEVEL, BONE, CAKE)
-- ==============================================================================
spawn(function()
    while task.wait(0.2) do
        -- AUTO FARM LEVEL
        if _G.AutoFarmLevel then
            pcall(function()
                local questName, mobName, npcLocation = GetCurrentQuestData()
                local questInterface = LocalPlayer.PlayerGui.Main.Quest
                
                if not questInterface.Visible then
                    -- Chưa có nhiệm vụ thì bay đến NPC
                    MoveToTargetSafe(npcLocation)
                    local distToNPC = (LocalPlayer.Character.HumanoidRootPart.Position - npcLocation.Position).Magnitude
                    if distToNPC < 20 then
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", questName, 1)
                    end
                else
                    -- Có nhiệm vụ thì tìm quái và đánh
                    local targetMonster = nil
                    for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                        if string.find(mob.Name, mobName) and mob.Humanoid.Health > 0 then 
                            targetMonster = mob
                            break 
                        end
                    end
                    
                    if targetMonster then 
                        -- Bay lên cao 15 studs so với đầu quái
                        MoveToTargetSafe(targetMonster.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0)) 
                    else
                        -- Bay lên cao chờ quái spawn
                        MoveToTargetSafe(npcLocation * CFrame.new(0, 50, 0))
                    end
                end
            end)
        end
        
        -- AUTO FARM BONE
        if _G.AutoFarmBone then
            pcall(function()
                local targetSkeleton = nil
                for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                    if (mob.Name == "Reborn Skeleton" or mob.Name == "Living Zombie") and mob.Humanoid.Health > 0 then 
                        targetSkeleton = mob
                        break 
                    end
                end
                
                if targetSkeleton then 
                    MoveToTargetSafe(targetSkeleton.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0)) 
                else 
                    MoveToTargetSafe(FULL_IP_DATABASE.HauntedCastle_Bone) 
                end
            end)
        end
        
        -- AUTO FARM CAKE
        if _G.AutoFarmCake then
            pcall(function()
                local targetCakeMob = nil
                for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                    if (string.find(mob.Name, "Cake") or string.find(mob.Name, "Cookie")) and mob.Humanoid.Health > 0 then 
                        targetCakeMob = mob
                        break 
                    end
                end
                
                if targetCakeMob then 
                    MoveToTargetSafe(targetCakeMob.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0)) 
                else 
                    MoveToTargetSafe(FULL_IP_DATABASE.CakeIsland) 
                end
            end)
        end
    end
end)

-- ==============================================================================
-- 8. HỆ THỐNG SEA EVENT (LÁI THUYỀN VÀ SĂN QUÁI BIỂN)
-- ==============================================================================
spawn(function()
    while task.wait(0.5) do
        if _G.AutoSeaEvent then
            pcall(function()
                -- 1. Tìm thuyền thuộc quyền sở hữu của mình
                local playerBoat = nil
                for _, boat in pairs(Workspace.Boats:GetChildren()) do
                    if boat:FindFirstChild("Owner") and boat.Owner.Value == LocalPlayer then 
                        playerBoat = boat
                        break 
                    end
                end
                
                -- 2. Chưa có thuyền thì đi mua
                if not playerBoat and _G.AutoBuyBoat then
                    MoveToTargetSafe(FULL_IP_DATABASE.TikiOutpost_Dock)
                    local distToDock = (LocalPlayer.Character.HumanoidRootPart.Position - FULL_IP_DATABASE.TikiOutpost_Dock.Position).Magnitude
                    if distToDock < 30 then
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyBoat", "Sloop")
                        task.wait(2)
                    end
                end
                
                -- 3. Quét tìm quái biển
                local targetSeaEnemy = nil
                for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                    if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                        if _G.HuntTerrorShark and enemy.Name == "Terror Shark" then targetSeaEnemy = enemy; break end
                        if _G.HuntSeaBeast and enemy.Name == "Sea Beast" then targetSeaEnemy = enemy; break end
                        if _G.HuntPiranha and enemy.Name == "Piranha" then targetSeaEnemy = enemy; break end
                        if _G.HuntGhostShip and string.find(enemy.Name, "Ship") then targetSeaEnemy = enemy; break end
                    end
                end
                
                -- 4. Xử lý lái thuyền hoặc tấn công
                if targetSeaEnemy then
                    -- Phát hiện quái biển -> Nhảy khỏi ghế lái và bay lên trên đầu đánh
                    if LocalPlayer.Character.Humanoid.Sit then 
                        LocalPlayer.Character.Humanoid.Sit = false 
                    end
                    MoveToTargetSafe(targetSeaEnemy.HumanoidRootPart.CFrame * CFrame.new(0, 40, 0))
                elseif playerBoat then
                    -- Không có quái biển -> Lái thuyền chạy nhanh ra Zone 6
                    local vehicleSeat = playerBoat:FindFirstChild("VehicleSeat")
                    if vehicleSeat then
                        -- Tắt va chạm thuyền để chạy xuyên đảo, không bị kẹt đá
                        for _, part in pairs(playerBoat:GetChildren()) do 
                            if part:IsA("BasePart") then part.CanCollide = false end 
                        end
                        
                        -- Ép tốc độ thuyền
                        vehicleSeat.Velocity = vehicleSeat.CFrame.LookVector * _G.BoatSpeed
                        
                        -- Nếu chưa ngồi vào ghế lái thì tự động bay vào
                        if not LocalPlayer.Character.Humanoid.Sit then 
                            LocalPlayer.Character.HumanoidRootPart.CFrame = vehicleSeat.CFrame 
                        end
                    end
                end
            end)
        end
        
        -- SĂN LEVIATHAN (Chạy độc lập)
        if _G.AutoLeviathan then
            pcall(function()
                for _, object in pairs(Workspace:GetChildren()) do
                    if string.find(object.Name, "Leviathan") then
                        if object:FindFirstChild("HumanoidRootPart") then
                            MoveToTargetSafe(object.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0))
                        end
                    end
                end
            end)
        end
    end
end)

-- ==============================================================================
-- 9. SỰ KIỆN KHÔNG GIAN (MIRAGE, KITSUNE, RAID, FRUIT)
-- ==============================================================================
spawn(function()
    while task.wait(1) do
        -- LỤM VÀ CẤT TRÁI ÁC QUỶ
        if _G.AutoCollectFruit then
            pcall(function()
                for _, fruitObj in pairs(Workspace:GetChildren()) do
                    if fruitObj:IsA("Tool") and string.find(fruitObj.Name, "Fruit") then
                        MoveToTargetSafe(fruitObj.Handle.CFrame)
                        local distToFruit = (LocalPlayer.Character.HumanoidRootPart.Position - fruitObj.Handle.Position).Magnitude
                        if distToFruit < 10 then
                            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, fruitObj.Handle, 0)
                            task.wait(0.1)
                            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, fruitObj.Handle, 1)
                        end
                    end
                end
            end)
        end
        
        if _G.AutoStoreFruit then
            pcall(function()
                for _, inventoryItem in pairs(LocalPlayer.Backpack:GetChildren()) do
                    if string.find(inventoryItem.Name, "Fruit") then 
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", inventoryItem.Name) 
                    end
                end
            end)
        end
        
        -- RADAR ĐẢO BÍ ẨN MIRAGE
        if _G.AutoMirage then
            pcall(function()
                local mirageIsland = Workspace.Map:FindFirstChild("Mirage Island")
                if mirageIsland and mirageIsland.PrimaryPart then 
                    MoveToTargetSafe(mirageIsland.PrimaryPart.CFrame * CFrame.new(0, 150, 0)) 
                end
            end)
        end
        
        -- RADAR ĐẢO HỒ LY KITSUNE
        if _G.AutoKitsune then
            pcall(function()
                local kitsuneIsland = Workspace.Map:FindFirstChild("Kitsune Island")
                if kitsuneIsland then 
                    local kitsuneShrine = kitsuneIsland:FindFirstChild("Shrine")
                    if kitsuneShrine then
                        MoveToTargetSafe(kitsuneShrine.CFrame) 
                    end
                end
            end)
        end
        
        -- AUTO RAID NGỤC TỐI
        if _G.AutoRaid then
            pcall(function()
                local insideRaid = Workspace:FindFirstChild("Map") and Workspace.Map:FindFirstChild("RaidArena")
                if insideRaid then
                    for _, raidEnemy in pairs(Workspace.Enemies:GetChildren()) do
                        if raidEnemy:FindFirstChild("Humanoid") and raidEnemy.Humanoid.Health > 0 then 
                            MoveToTargetSafe(raidEnemy.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)) 
                        end
                    end
                else
                    MoveToTargetSafe(FULL_IP_DATABASE.RaidLaboratory)
                    local distToLab = (LocalPlayer.Character.HumanoidRootPart.Position - FULL_IP_DATABASE.RaidLaboratory.Position).Magnitude
                    if distToLab < 20 then
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("RaidsNpc
