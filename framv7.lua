-- [[ LIGHTGUMBALL HUB - THE TRUE ULTIMATE SOURCE ]]
-- Giao diện: Redz UI (Tối ưu Mobile)
-- Không nén code, Full cấu trúc logic, Full Anti-Error (pcall)

local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/RedzUI/main/source.lua"))()
local Window = redzlib:MakeWindow({
    Title = "LIGHTGUMBALL HUB",
    SubTitle = "Premium Uncompressed Edition",
    SaveFolder = "Lightgumball_Config"
})

-- ==========================================
-- 1. KHỞI TẠO DỊCH VỤ & BIẾN HỆ THỐNG
-- ==========================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- Biến Combat
_G.Weapon = "Melee"
_G.AutoClick = false
_G.BringMob = false

-- Biến Farm
_G.AutoFarm = false
_G.AutoBone = false
_G.AutoCake = false

-- Biến Sea Event & Thuyền
_G.SeaEvent = false
_G.BuyBoat = false
_G.BoatSpeed = 350
_G.HuntTerrorShark = false
_G.HuntSeaBeast = false
_G.HuntPiranha = false
_G.HuntShip = false
_G.AutoLeviathan = false

-- Biến Sự kiện Không gian
_G.AutoRaid = false
_G.RaidChip = "Flame"
_G.AutoMirage = false
_G.AutoKitsune = false
_G.AutoFruit = false
_G.StoreFruit = false

-- ==========================================
-- 2. TỪ ĐIỂN TỌA ĐỘ IP (FULL MAP SEA 3)
-- ==========================================
local IP_DATA = {
    -- Đảo chính & Bến cảng
    PortTown = CFrame.new(-290, 44, 5581),
    HydraIsland = CFrame.new(5749, 610, -253),
    GreatTree = CFrame.new(5393, 13, 2525),
    FloatingTurtle = CFrame.new(-12463, 375, -7523),
    CastleOnSea = CFrame.new(-5012, 315, -3157),
    HauntedCastle = CFrame.new(-9481, 142, 5566),
    TikiOutpost = CFrame.new(-2421, 73, -3215),
    RaidLab = CFrame.new(-5036, 315, -3179),
    
    -- Vùng Đảo Kẹo (Sea of Treats)
    PeanutIsland = CFrame.new(-2104, 38, -10192),
    IceCreamIsland = CFrame.new(-821, 66, -10965),
    CakeIsland = CFrame.new(-2022, 38, -12028),
    ChocIsland = CFrame.new(138, 25, -12185),
    CandyIsland = CFrame.new(-1147, 13, -14445)
}

-- ==========================================
-- 3. HỆ THỐNG KIỂM TRA NHIỆM VỤ THEO CẤP ĐỘ
-- ==========================================
local function GetQuest()
    local lvl = LocalPlayer.Data.Level.Value
    if lvl >= 1500 and lvl < 1575 then 
        return "Pirate Port Quest", "Pirate Millionaire", IP_DATA.PortTown
    elseif lvl >= 1575 and lvl < 1700 then 
        return "Amazon Quest", "Dragon Crew Warrior", IP_DATA.HydraIsland
    elseif lvl >= 1700 and lvl < 1775 then 
        return "Marine Tree Island", "Marine Commodore", IP_DATA.GreatTree
    elseif lvl >= 1775 and lvl < 1975 then 
        return "Deep Forest Island", "Fishman Raider", IP_DATA.FloatingTurtle
    elseif lvl >= 1975 and lvl < 2125 then 
        return "Haunted Quest 1", "Reborn Skeleton", IP_DATA.HauntedCastle
    elseif lvl >= 2125 and lvl < 2200 then 
        return "Peanut Quest", "Peanut Scout", IP_DATA.PeanutIsland
    elseif lvl >= 2200 and lvl < 2275 then 
        return "Ice Cream Quest", "Cookie Crafter", IP_DATA.IceCreamIsland
    elseif lvl >= 2275 and lvl < 2350 then 
        return "Cake Quest 1", "Cake Guard", IP_DATA.CakeIsland
    elseif lvl >= 2350 and lvl < 2400 then 
        return "Choc Quest", "Cocoa Warrior", IP_DATA.ChocIsland
    elseif lvl >= 2400 and lvl < 2450 then 
        return "Candy Quest 1", "Candy Rebel", IP_DATA.CandyIsland
    else 
        return "Tiki Quest", "Isle Champion", IP_DATA.TikiOutpost 
    end
end

-- ==========================================
-- 4. HỆ THỐNG DI CHUYỂN & XUYÊN TƯỜNG (ANTI-KICK)
-- ==========================================
local function TweenTo(target)
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local dist = (root.Position - target.Position).Magnitude
    
    -- Nếu ở gần (dưới 15 studs), dịch chuyển tức thì
    if dist < 15 then 
        root.CFrame = target
        return 
    end
    
    -- Tính toán thời gian bay dựa trên khoảng cách (Tốc độ 320 studs/s)
    local tweenInfo = TweenInfo.new(dist / 320, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(root, tweenInfo, {CFrame = target})
    
    -- Bật noclip liên tục trong lúc bay để không kẹt đá
    local noclip
    noclip = RunService.Stepped:Connect(function()
        for _, part in pairs(char:GetChildren()) do
            if part:IsA("BasePart") then 
                part.CanCollide = false 
            end
        end
    end)
    
    tween:Play()
    tween.Completed:Wait()
    noclip:Disconnect()
end

-- ==========================================
-- 5. COMBAT ENGINE: AUTO CLICK & BRING MOB
-- ==========================================
-- A. Vòng lặp Auto Click Nhanh
RunService.RenderStepped:Connect(function()
    if _G.AutoClick then
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                -- Tự động móc vũ khí ra
                if not char:FindFirstChildOfClass("Tool") then
                    for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
                        if tool.ToolTip == _G.Weapon then 
                            char.Humanoid:EquipTool(tool)
                            break
                        end
                    end
                end
                
                -- Kích hoạt chém và giả lập chuột
                local weapon = char:FindFirstChildOfClass("Tool")
                if weapon then 
                    weapon:Activate() 
                end
                VirtualUser:CaptureController()
                VirtualUser:Button1Down(Vector2.new(0,0))
            end
        end)
    end
end)

-- B. Vòng lặp Bring Quái (Tối đa 2 con, tọa độ chuẩn Z = -3.5)
RunService.Heartbeat:Connect(function()
    if _G.BringMob then
        pcall(function()
            local char = LocalPlayer.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then return end
            
            local count = 0
            for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                if mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
                    if mob.Humanoid.Health > 0 then
                        local mobRoot = mob.HumanoidRootPart
                        local distance = (mobRoot.Position - root.Position).Magnitude
                        
                        -- Quét phạm vi 350 studs, lấy đúng 2 con
                        if distance < 350 and count < 2 then
                            mobRoot.CanCollide = false
                            mob.Humanoid.WalkSpeed = 0
                            mob.Humanoid.JumpPower = 0
                            mobRoot.Size = Vector3.new(10, 10, 10) -- Mở rộng hitbox
                            
                            -- Khóa quái ngay trước mặt nhân vật
                            mobRoot.CFrame = root.CFrame * CFrame.new(0, 0, -3.5)
                            count = count + 1
                        end
                    end
                end
            end
        end)
    end
end)

-- ==========================================
-- 6. HỆ THỐNG FARM (CẤP ĐỘ, XƯƠNG, BÁNH KẸO)
-- ==========================================
spawn(function()
    while task.wait(0.1) do
        if _G.AutoFarm then
            pcall(function()
                local qName, mName, npcIP = GetQuest()
                local questUI = LocalPlayer.PlayerGui.Main.Quest
                
                if not questUI.Visible then
                    -- Bay đến nhận nhiệm vụ
                    TweenTo(npcIP)
                    local dist = (LocalPlayer.Character.HumanoidRootPart.Position - npcIP.Position).Magnitude
                    if dist < 20 then
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", qName, 1)
                    end
                else
                    -- Bay đến quái
                    local targetMob = nil
                    for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                        if string.find(mob.Name, mName) and mob.Humanoid.Health > 0 then 
                            targetMob = mob
                            break 
                        end
                    end
                    
                    if targetMob then 
                        TweenTo(targetMob.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0)) 
                    else
                        -- Bay về điểm spawn quái chờ
                        TweenTo(npcIP * CFrame.new(0, 50, 0))
                    end
                end
            end)
        end
        
        if _G.AutoBone then
            pcall(function()
                local targetMob = nil
                for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                    if (mob.Name == "Reborn Skeleton" or mob.Name == "Living Zombie") and mob.Humanoid.Health > 0 then 
                        targetMob = mob
                        break 
                    end
                end
                
                if targetMob then 
                    TweenTo(targetMob.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0)) 
                else 
                    TweenTo(IP_DATA.HauntedCastle) 
                end
            end)
        end
        
        if _G.AutoCake then
            pcall(function()
                local targetMob = nil
                for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                    if (string.find(mob.Name, "Cake") or string.find(mob.Name, "Cookie")) and mob.Humanoid.Health > 0 then 
                        targetMob = mob
                        break 
                    end
                end
                
                if targetMob then 
                    TweenTo(targetMob.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0)) 
                else 
                    TweenTo(IP_DATA.CakeIsland) 
                end
            end)
        end
    end
end)

-- ==========================================
-- 7. HỆ THỐNG SEA EVENT ĐỈNH CAO
-- ==========================================
spawn(function()
    while task.wait(0.3) do
        if _G.SeaEvent then
            pcall(function()
                -- Xác định thuyền của người chơi
                local myBoat = nil
                for _, boat in pairs(Workspace.Boats:GetChildren()) do
                    if boat:FindFirstChild("Owner") and boat.Owner.Value == LocalPlayer then 
                        myBoat = boat
                        break 
                    end
                end
                
                -- Xử lý mua thuyền
                if not myBoat and _G.BuyBoat then
                    TweenTo(IP_DATA.TikiOutpost)
                    local dist = (LocalPlayer.Character.HumanoidRootPart.Position - IP_DATA.TikiOutpost.Position).Magnitude
                    if dist < 30 then
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyBoat", "Sloop")
                        task.wait(1.5)
                    end
                end
                
                -- Tìm Quái Biển theo setting
                local targetSeaMob = nil
                for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                    if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                        if _G.HuntTerrorShark and enemy.Name == "Terror Shark" then targetSeaMob = enemy; break end
                        if _G.HuntSeaBeast and enemy.Name == "Sea Beast" then targetSeaMob = enemy; break end
                        if _G.HuntPiranha and enemy.Name == "Piranha" then targetSeaMob = enemy; break end
                        if _G.HuntShip and string.find(enemy.Name, "Ship") then targetSeaMob = enemy; break end
                    end
                end
                
                -- Logic Đánh / Lái Thuyền
                if targetSeaMob then
                    -- Thoát ghế và bay lên trên đầu quái biển đánh (tránh đòn)
                    if LocalPlayer.Character.Humanoid.Sit then 
                        LocalPlayer.Character.Humanoid.Sit = false 
                    end
                    TweenTo(targetSeaMob.HumanoidRootPart.CFrame * CFrame.new(0, 40, 0))
                elseif myBoat then
                    -- Không có quái -> Đạp ga lái ra biển
                    local seat = myBoat:FindFirstChild("VehicleSeat")
                    if seat then
                        -- Tắt va chạm thuyền để không kẹt đá
                        for _, part in pairs(myBoat:GetChildren()) do 
                            if part:IsA("BasePart") then part.CanCollide = false end 
                        end
                        
                        -- Ép tốc độ thuyền
                        seat.Velocity = seat.CFrame.LookVector * _G.BoatSpeed
                        
                        -- Tự động nhảy vào ghế lái
                        if not LocalPlayer.Character.Humanoid.Sit then 
                            LocalPlayer.Character.HumanoidRootPart.CFrame = seat.CFrame 
                        end
                    end
                end
            end)
        end
        
        -- Săn Leviathan (Vòng lặp riêng)
        if _G.AutoLeviathan then
            pcall(function()
                for _, obj in pairs(Workspace:GetChildren()) do
                    if string.find(obj.Name, "Leviathan") then
                        if obj:FindFirstChild("HumanoidRootPart") then
                            TweenTo(obj.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0))
                        end
                    end
                end
            end)
        end
    end
end)

-- ==========================================
-- 8. SỰ KIỆN KHÔNG GIAN (FRUIT, MIRAGE, KITSUNE, RAID)
-- ==========================================
spawn(function()
    while task.wait(1) do
        -- Trái Ác Quỷ
        if _G.AutoFruit then
            pcall(function()
                for _, tool in pairs(Workspace:GetChildren()) do
                    if tool:IsA("Tool") and string.find(tool.Name, "Fruit") then
                        TweenTo(tool.Handle.CFrame)
                        local dist = (LocalPlayer.Character.HumanoidRootPart.Position - tool.Handle.Position).Magnitude
                        if dist < 10 then
                            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, tool.Handle, 0)
                            task.wait(0.1)
                            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, tool.Handle, 1)
                        end
                    end
                end
            end)
        end
        
        if _G.StoreFruit then
            pcall(function()
                for _, item in pairs(LocalPlayer.Backpack:GetChildren()) do
                    if string.find(item.Name, "Fruit") then 
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", item.Name) 
                    end
                end
            end)
        end
        
        -- Radar Mirage
        if _G.AutoMirage then
            pcall(function()
                local mirage = Workspace.Map:FindFirstChild("Mirage Island")
                if mirage and mirage.PrimaryPart then 
                    TweenTo(mirage.PrimaryPart.CFrame * CFrame.new(0, 150, 0)) 
                end
            end)
        end
        
        -- Radar Kitsune Shrine
        if _G.AutoKitsune then
            pcall(function()
                local kitsune = Workspace.Map:FindFirstChild("Kitsune Island")
                if kitsune then 
                    local shrine = kitsune:FindFirstChild("Shrine")
                    if shrine then
                        TweenTo(shrine.CFrame) 
                    end
                end
            end)
        end
        
        -- Auto Raid
        if _G.AutoRaid then
            pcall(function()
                local inRaid = Workspace:FindFirstChild("Map") and Workspace.Map:FindFirstChild("RaidArena")
                if inRaid then
                    -- Nếu đang trong Raid, quét quái để đánh
                    for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                        if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then 
                            TweenTo(enemy.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)) 
                        end
                    end
                else
                    -- Chưa vào Raid, bay đi mua Chip và khởi động
                    TweenTo(IP_DATA.RaidLab)
                    local dist = (LocalPlayer.Character.HumanoidRootPart.Position - IP_DATA.RaidLab.Position).Magnitude
                    if dist < 20 then
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("RaidsNpc", "Buy", _G.RaidChip)
                        task.wait(1.5)
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("RaidsNpc", "Start")
                    end
                end
            end)
        end
    end
end)

-- ==========================================
-- 9. KHUNG GIAO DIỆN (REDZ UI TẠO TỪNG DÒNG)
-- ==========================================
-- Tab 1: Cày Cuốc Chính
local TabMain = Window:MakeTab({"Main Farm", "swords"})
TabMain:AddDropdown({"Vũ Khí Farm", {"Melee", "Sword", "Blox Fruit"}, "Melee", function(v) 
    _G.Weapon = v 
end})
TabMain:AddToggle({"Tự Động Đánh (Auto Click)", false, function(v) 
    _G.AutoClick = v 
end})
TabMain:AddToggle({"Gom Quái (Bring Z=-3.5, 2 Mobs)", false, function(v) 
    _G.BringMob = v 
end})
TabMain:AddToggle({"🔰 Auto Farm Level (Tự Dò Đảo)", false, function(v) 
    _G.AutoFarm = v 
    if v then _G.AutoClick = true; _G.BringMob = true end 
end})
TabMain:AddToggle({"💀 Auto Farm Xương (Haunted IP)", false, function(v) 
    _G.AutoBone = v 
    if v then _G.AutoClick = true; _G.BringMob = true end 
end})
TabMain:AddToggle({"🎂 Auto Farm Bánh (Cake IP)", false, function(v) 
    _G.AutoCake = v 
    if v then _G.AutoClick = true; _G.BringMob = true end 
end})

-- Tab 2: Sự Kiện Biển Cả
local TabSea = Window:MakeTab({"Sea Event", "ship"})
TabSea:AddToggle({"🛥️ Tự Mua Thuyền Tiki", false, function(v) 
    _G.BuyBoat = v 
end})
TabSea:AddSlider({"Tốc Độ Lái Thuyền Xuyên Đá", 100, 600, 350, function(v) 
    _G.BoatSpeed = v 
end})
TabSea:AddToggle({"Săn Terror Shark", false, function(v) 
    _G.HuntTerrorShark = v 
end})
TabSea:AddToggle({"Săn Sea Beast", false, function(v) 
    _G.HuntSeaBeast = v 
end})
TabSea:AddToggle({"Săn Piranha & Shark", false, function(v) 
    _G.HuntPiranha = v 
end})
TabSea:AddToggle({"Săn Thuyền Ma", false, function(v) 
    _G.HuntShip = v 
end})
TabSea:AddToggle({"🌊 KHỞI ĐỘNG AUTO SEA EVENT", false, function(v) 
    _G.SeaEvent = v 
    if v then _G.AutoClick = true end 
end})
TabSea:AddToggle({"🐉 Auto Hunt Leviathan (Rình Mồi)", false, function(v) 
    _G.AutoLeviathan = v 
end})

-- Tab 3: Raid & Đồ Vật
local TabRaid = Window:MakeTab({"Raid & Fruit", "box"})
TabRaid:AddDropdown({"Chọn Chip Khởi Động Raid", {"Flame", "Ice", "Magma", "Buddha", "Dough"}, "Flame", function(v) 
    _G.RaidChip = v 
end})
TabRaid:AddToggle({"🔥 Tự Động Đi Raid Cày F", false, function(v) 
    _G.AutoRaid = v 
    if v then _G.AutoClick = true end 
end})
TabRaid:AddToggle({"🍎 Auto Bay Nhặt Trái Cây", false, function(v) 
    _G.AutoFruit = v 
end})
TabRaid:AddToggle({"🎒 Auto Cất Trái Cây Vào Rương", false, function(v) 
    _G.StoreFruit = v 
end})

-- Tab 4: Đảo Ảo Ảnh & Hồ Ly
local TabSpecial = Window:MakeTab({"Sự Kiện Không Gian", "eye"})
