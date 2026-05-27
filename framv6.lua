-- [[ LIGHT GALAXY HUB - TRUE PREMIUM EDITION ]]
-- Tác giả: Lightgumball / Tối ưu hoá cho Redmi & Delta Executor
-- Cảnh báo: Code chứa toàn bộ Database IP của Sea 3, không cắt xén.

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "LIGHT GALAXY HUB | PREMIUM", HidePremium = false, SaveConfig = false, IntroText = "Welcome to Light Galaxy..."})

-- ==========================================
-- 1. HỆ THỐNG DỊCH VỤ & BIẾN CƠ BẢN
-- ==========================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- Biến lưu trạng thái (Toggles)
_G.AutoFarmLevel = false
_G.AutoFarmBone = false
_G.AutoFarmCake = false
_G.AutoClick = false
_G.BringMob = false
_G.WeaponType = "Melee"

_G.AutoSeaEvent = false
_G.AutoBuyBoat = false
_G.BoatSpeed = 350
_G.SeaTargets = {["Terror Shark"] = false, ["Sea Beast"] = false, ["Piranha"] = false, ["Shark"] = false, ["Ship"] = false}

_G.AutoRaid = false
_G.RaidChip = "Flame"
_G.AutoCollectFruit = false
_G.AutoStoreFruit = false
_G.AutoMirage = false
_G.AutoKitsune = false

_G.AutoStats = false
_G.StatType = "Melee"
_G.StatPoint = 3

-- ==========================================
-- 2. CƠ SỞ DỮ LIỆU TỌA ĐỘ (FULL IP CFRAMES SEA 3)
-- ==========================================
local IP_DATA = {
    -- Bến cảng & Đảo chức năng
    TikiDock = CFrame.new(-2421, 73, -3215),
    Mansion = CFrame.new(-12463, 375, -7523),
    CastleOnTheSea = CFrame.new(-5012, 315, -3157),
    RaidLab = CFrame.new(-5036, 315, -3179),
    BoneIsland = CFrame.new(-9512, 142, 5521),
    CakeIsland = CFrame.new(-2123, 70, -11985),
    
    -- Danh sách NPC Nhận nhiệm vụ (Từ 1500 đến Max Level)
    QuestNPC = {
        Lvl1500 = CFrame.new(-290, 44, 5581),    -- Pirate Port
        Lvl1575 = CFrame.new(-321, 332, 5971),   -- Amazon
        Lvl1700 = CFrame.new(5393, 13, 2525),    -- Great Tree
        Lvl1775 = CFrame.new-9964, 50, 5293),    -- Floating Turtle (Thuyền trưởng)
        Lvl1850 = CFrame.new(-12445, 375, -7535),-- Floating Turtle (Dinh thự)
        Lvl1900 = CFrame.new(-10526, 332, -8753),-- Floating Turtle (Rừng sâu)
        Lvl1975 = CFrame.new(-9481, 142, 5566),  -- Haunted Castle (Nghĩa trang)
        Lvl2075 = CFrame.new(-9473, 142, 5391),  -- Haunted Castle (Lâu đài)
        Lvl2125 = CFrame.new(-2104, 38, -10192), -- Peanut Island
        Lvl2200 = CFrame.new(-821, 66, -10965),  -- Ice Cream Island
        Lvl2275 = CFrame.new(-2022, 38, -12028), -- Cake Island
        Lvl2350 = CFrame.new(138, 25, -12185),   -- Chocolate Island
        Lvl2400 = CFrame.new(-1147, 13, -14445), -- Candy Island
        Lvl2450 = CFrame.new(-2217, 73, -3185)   -- Tiki Outpost
    }
}

-- Hàm tự động phân tích Level và trả về Nhiệm vụ + Quái tương ứng
local function GetQuestData()
    local lvl = LocalPlayer.Data.Level.Value
    if lvl >= 1500 and lvl < 1525 then return "Pirate Port Quest", "Pirate Millionaire", 1, IP_DATA.QuestNPC.Lvl1500
    elseif lvl >= 1525 and lvl < 1575 then return "Pirate Port Quest", "Pistol Billionaire", 2, IP_DATA.QuestNPC.Lvl1500
    elseif lvl >= 1575 and lvl < 1600 then return "Amazon Quest", "Dragon Crew Warrior", 1, IP_DATA.QuestNPC.Lvl1575
    elseif lvl >= 1600 and lvl < 1700 then return "Amazon Quest", "Dragon Crew Archer", 2, IP_DATA.QuestNPC.Lvl1575
    elseif lvl >= 1700 and lvl < 1775 then return "Marine Tree Island", "Marine Commodore", 1, IP_DATA.QuestNPC.Lvl1700
    elseif lvl >= 1775 and lvl < 1850 then return "Deep Forest Island", "Fishman Raider", 1, IP_DATA.QuestNPC.Lvl1775
    elseif lvl >= 1850 and lvl < 1900 then return "Deep Forest Island 2", "Jungle Pirate", 1, IP_DATA.QuestNPC.Lvl1850
    elseif lvl >= 1900 and lvl < 1975 then return "Deep Forest Island 3", "Musketeer Pirate", 1, IP_DATA.QuestNPC.Lvl1900
    elseif lvl >= 1975 and lvl < 2000 then return "Haunted Quest 1", "Reborn Skeleton", 1, IP_DATA.QuestNPC.Lvl1975
    elseif lvl >= 2000 and lvl < 2075 then return "Haunted Quest 2", "Living Zombie", 1, IP_DATA.QuestNPC.Lvl1975
    elseif lvl >= 2075 and lvl < 2125 then return "Haunted Quest 3", "Demonic Soul", 2, IP_DATA.QuestNPC.Lvl2075
    elseif lvl >= 2125 and lvl < 2200 then return "Peanut Quest", "Peanut Scout", 1, IP_DATA.QuestNPC.Lvl2125
    elseif lvl >= 2200 and lvl < 2275 then return "Ice Cream Quest", "Cookie Crafter", 1, IP_DATA.QuestNPC.Lvl2200
    elseif lvl >= 2275 and lvl < 2300 then return "Cake Quest 1", "Cake Guard", 1, IP_DATA.QuestNPC.Lvl2275
    elseif lvl >= 2300 and lvl < 2350 then return "Cake Quest 2", "Baking Subordinate", 2, IP_DATA.QuestNPC.Lvl2275
    elseif lvl >= 2350 and lvl < 2400 then return "Choc Quest", "Cocoa Warrior", 1, IP_DATA.QuestNPC.Lvl2350
    elseif lvl >= 2400 and lvl < 2450 then return "Candy Quest 1", "Candy Rebel", 1, IP_DATA.QuestNPC.Lvl2400
    else return "Tiki Quest", "Isle Champion", 1, IP_DATA.QuestNPC.Lvl2450 end
end

-- ==========================================
-- 3. HỆ THỐNG TWEEN (DI CHUYỂN AN TOÀN CHỐNG KICK)
-- ==========================================
local function TweenTo(targetCFrame)
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    local root = char.HumanoidRootPart
    local dist = (root.Position - targetCFrame.Position).Magnitude
    
    -- Nếu ở gần thì di chuyển tức thời để tiết kiệm thời gian
    if dist < 20 then 
        root.CFrame = targetCFrame
        return 
    end
    
    -- Tốc độ mượt 320 studs/s, an toàn không bị mã lỗi 267
    local speed = 320 
    local duration = dist / speed
    local tween = TweenService:Create(root, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
    
    -- Liên tục bật Noclip (Xuyên tường) khi bay
    local noclipConnection
    noclipConnection = RunService.Stepped:Connect(function()
        for _, part in pairs(char:GetChildren()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end)
    
    tween:Play()
    tween.Completed:Wait()
    if noclipConnection then noclipConnection:Disconnect() end
end

-- ==========================================
-- 4. HỆ THỐNG COMBAT (AUTO CLICK & BRING QUÁI 2 CON)
-- ==========================================

-- A. Auto Click (Fast Attack - Không Delay)
RunService.RenderStepped:Connect(function()
    if _G.AutoClick then
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                -- Tự động cầm vũ khí đã chọn
                if not char:FindFirstChildOfClass("Tool") then
                    for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
                        if tool.ToolTip == _G.WeaponType or tool.Name == _G.WeaponType then
                            char.Humanoid:EquipTool(tool)
                            break
                        end
                    end
                end
                
                -- Kích hoạt đòn đánh (Click ảo qua hệ thống game)
                local tool = char:FindFirstChildOfClass("Tool")
                if tool then tool:Activate() end
                VirtualUser:CaptureController()
                VirtualUser:Button1Down(Vector2.new(0, 0))
            end
        end)
    end
end)

-- B. Bring Mob (Gom chuẩn Z=-3.5 ngang tầm mắt, Max 2 Quái để chống lag/văng)
RunService.Heartbeat:Connect(function()
    if _G.BringMob then
        pcall(function()
            local root = LocalPlayer.Character.HumanoidRootPart
            local count = 0
            for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                    -- Quét quái trong bán kính 350 mét xung quanh nhân vật
                    if (mob.HumanoidRootPart.Position - root.Position).Magnitude < 350 and count < 2 then
                        mob.HumanoidRootPart.CanCollide = false
                        mob.HumanoidRootPart.Size = Vector3.new(10, 10, 10) -- Mở rộng Hitbox để dễ đánh trúng
                        mob.Humanoid.WalkSpeed = 0
                        mob.Humanoid.JumpPower = 0
                        -- Khóa cứng vị trí quái ngay trước mặt (Z = -3.5)
                        mob.HumanoidRootPart.CFrame = root.CFrame * CFrame.new(0, 0, -3.5)
                        count = count + 1
                    end
                end
            end
        end)
    end
end)

-- ==========================================
-- 5. LOGIC FARM (LEVEL, BONE, CAKE)
-- ==========================================
spawn(function()
    while task.wait(0.2) do
        if _G.AutoFarmLevel then
            pcall(function()
                local qName, mobName, qLevel, npcIP = GetQuestData()
                local hasQuest = LocalPlayer.PlayerGui.Main.Quest.Visible
                
                -- Chưa có nhiệm vụ -> Bay đến NPC IP và nhận
                if not hasQuest then
                    TweenTo(npcIP)
                    if (LocalPlayer.Character.HumanoidRootPart.Position - npcIP.Position).Magnitude < 15 then
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", qName, qLevel)
                    end
                else
                    -- Đã có nhiệm vụ -> Tìm quái và bay đến
                    local targetMob = nil
                    for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                        if string.find(mob.Name, mobName) and mob.Humanoid.Health > 0 then
                            targetMob = mob
                            break
                        end
                    end
                    
                    if targetMob then
                        -- Bay lơ lửng trên đầu quái cách 15 studs (An toàn)
                        TweenTo(targetMob.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0))
                    else
                        -- Nếu hết quái, bay ra chỗ điểm sinh sản của quái chờ
                        local spawns = Workspace._WorldOrigin.EnemySpawns:GetChildren()
                        for _, sp in pairs(spawns) do
                            if sp.Name == mobName then
                                TweenTo(sp.CFrame * CFrame.new(0, 15, 0))
                                break
                            end
                        end
                    end
                end
            end)
        elseif _G.AutoFarmBone then
            -- Logic Farm Xương tại Lâu Đài Bóng Tối
            pcall(function()
                local targetMob = nil
                for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                    if (mob.Name == "Reborn Skeleton" or mob.Name == "Living Zombie") and mob.Humanoid.Health > 0 then
                        targetMob = mob; break
                    end
                end
                if targetMob then 
                    TweenTo(targetMob.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0))
                else 
                    TweenTo(IP_DATA.BoneIsland * CFrame.new(0, 20, 0)) 
                end
            end)
        elseif _G.AutoFarmCake then
            -- Logic Farm Bánh tại Đảo Bánh
            pcall(function()
                local targetMob = nil
                for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                    if (mob.Name == "Cake Guard" or mob.Name == "Cookie Crafter") and mob.Humanoid.Health > 0 then
                        targetMob = mob; break
                    end
                end
                if targetMob then 
                    TweenTo(targetMob.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0))
                else 
                    TweenTo(IP_DATA.CakeIsland * CFrame.new(0, 20, 0)) 
                end
            end)
        end
    end
end)

-- ==========================================
-- 6. FULL LOGIC SEA EVENT (MUA THUYỀN, LÁI, ĐÁNH)
-- ==========================================
spawn(function()
    while task.wait(0.5) do
        if _G.AutoSeaEvent then
            pcall(function()
                -- 1. Tìm thuyền của mình
                local myBoat = nil
                for _, boat in pairs(Workspace.Boats:GetChildren()) do
                    if boat:FindFirstChild("Owner") and boat.Owner.Value == LocalPlayer then
                        myBoat = boat; break
                    end
                end
                
                -- 2. Nếu chưa có thuyền, bay ra Tiki Mua
                if not myBoat and _G.AutoBuyBoat then
                    TweenTo(IP_DATA.TikiDock)
                    if (LocalPlayer.Character.HumanoidRootPart.Position - IP_DATA.TikiDock.Position).Magnitude < 30 then
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyBoat", "Sloop") -- Mua thuyền ván 
                        task.wait(2)
                    end
                end
                
                -- 3. Quét quái biển xung quanh (Theo lựa chọn của ông)
                local seaTarget = nil
                for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                    if _G.SeaTargets[enemy.Name] and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
                        seaTarget = enemy; break
                    end
                end
                
                -- 4. Xử lý Lái thuyền hoặc Chiến đấu
                if seaTarget then
                    -- Thoát khỏi ghế lái thuyền
                    if LocalPlayer.Character.Humanoid.Sit then LocalPlayer.Character.Humanoid.Sit = false end
                    -- Bay lên cao 40 studs so với quái biển để xả skill/chém né sát thương
                    TweenTo(seaTarget.HumanoidRootPart.CFrame * CFrame.new(0, 40, 0))
                elseif myBoat then
                    -- Không có quái -> Tự động ngồi lái và phóng ra biển
                    local seat = myBoat:FindFirstChild("VehicleSeat")
                    if seat then
                        -- Tắt va chạm thuyền để chạy xuyên đá, xuyên đảo
                        for _, v in pairs(myBoat:GetChildren()) do
                            if v:IsA("BasePart") then v.CanCollide = false end
                        end
                        
                        -- Ép tốc độ thuyền chạy cực nhanh ra Zone 6
                        seat.Velocity = seat.CFrame.LookVector * _G.BoatSpeed
                        
                        -- Nếu nhân vật chưa ngồi, tự động bay vào ghế
                        if not LocalPlayer.Character.Humanoid.Sit then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = seat.CFrame
                        end
                    end
                end
            end)
        end
    end
end)

-- ==========================================
-- 7. EVENT KHÔNG GIAN (MIRAGE, KITSUNE, FRUIT, RAID)
-- ==========================================
spawn(function()
    while task.wait(1) do
        -- Auto lụm trái ác quỷ
        if _G.AutoCollectFruit then
            pcall(function()
                for _, obj in pairs(Workspace:GetChildren()) do
                    if obj:IsA("Tool") and string.find(obj.Name, "Fruit") then
                        TweenTo(obj.Handle.CFrame)
                        if (LocalPlayer.Character.HumanoidRootPart.Position - obj.Handle.Position).Magnitude < 15 then
                            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, obj.Handle, 0)
                            task.wait(0.1)
                            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, obj.Handle, 1)
                        end
                    end
                end
            end)
        end
        
        -- Auto cất trái ác quỷ vào rương
        if _G.AutoStoreFruit then
            pcall(function()
                for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
                    if string.find(tool.Name, "Fruit") then
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", tool:GetAttribute("OriginalName") or tool.Name)
                    end
                end
            end)
        end
        
        -- Radar Mirage Island
        if _G.AutoMirage then
            pcall(function()
                local mirage = Workspace.Map:FindFirstChild("Mirage Island")
                if mirage then
                    -- Ưu tiên bay kiếm người bán trái ác quỷ trên đảo
                    local dealer = mirage:FindFirstChild("Advanced Fruit Dealer")
                    if dealer then TweenTo(dealer.HumanoidRootPart.CFrame)
                    else TweenTo(mirage.PrimaryPart.CFrame * CFrame.new(0, 100, 0)) end
                end
            end)
        end
        
        -- Auto Stats (Tự cộng điểm chỉ số)
        if _G.AutoStats then
            pcall(function()
                if LocalPlayer.Data.Points.Value > 0 then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", _G.StatType, _G.StatPoint)
                end
            end)
        end
    end
end)

-- ==========================================
-- 8. GIAO DIỆN NGƯỜI DÙNG (UI TABS - GALAXY THEME)
-- ==========================================
local TabMain = Window:MakeTab({Name = "Main Farm", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local SecCombat = TabMain:AddSection({Name = "Cài Đặt Combat"})
SecCombat:AddDropdown({Name = "Chọn Vũ Khí Cầm Tay", Default = "Melee", Options = {"Melee", "Sword", "Blox Fruit"}, Callback = function(v) _G.WeaponType = v end})
SecCombat:AddToggle({Name = "🗡️ Bật Auto Click Siêu Tốc", Default = false, Callback = function(v) _G.AutoClick = v end})
SecCombat:AddToggle({Name = "🧲 Bật Gom Quái (Bring Mob 2 Con Z=-3.5)", Default = false, Callback = function(v) _G.BringMob = v end})

local SecFarm = TabMain:AddSection({Name = "Chức Năng Farm"})
SecFarm:AddToggle({Name = "🔰 Auto Farm Level (Full IP Database)", Default = false, Callback = function(v) 
    _G.AutoFarmLevel = v
    if v then _G.AutoClick = true; _G.BringMob = true; _G.AutoSeaEvent = false end 
end})
SecFarm:AddToggle({Name = "☠️ Auto Farm Xương (Bone Island IP)", Default = false, Callback = function(v) 
    _G.AutoFarmBone = v
    if v then _G.AutoClick = true; _G.BringMob = true; _G.AutoFarmLevel = false end 
end})
SecFarm:AddToggle({Name = "🎂 Auto Farm Bánh (Cake Island IP)", Default = false, Callback = function(v) 
    _G.AutoFarmCake = v
    if v then _G.AutoClick = true; _G.BringMob = true; _G.AutoFarmLevel = false end 
end})

local TabSea = Window:MakeTab({Name = "Sea Event", Icon = "rbxassetid://4483345998", PremiumOnly = false})
TabSea:AddToggle({Name = "🛥️ Auto Mua Thuyền Tại Bến Tiki", Default = false, Callback = function(v) _G.AutoBuyBoat = v end})
TabSea:AddSlider({Name = "Tốc Độ Thuyền", Min = 200, Max = 600, Default = 350, Increment = 10, ValueName = "Speed", Callback = function(v) _G.BoatSpeed = v end})
TabSea:AddToggle({Name = "🎯 Săn Terror Shark", Default = false, Callback = function(v) _G.SeaTargets["Terror Shark"] = v end})
TabSea:AddToggle({Name = "🎯 Săn Sea Beast", Default = false, Callback = function(v) _G.SeaTargets["Sea Beast"] = v end})
TabSea:AddToggle({Name = "🎯 Săn Piranha & Shark", Default = false, Callback = function(v) _G.SeaTargets["Piranha"] = v; _G.SeaTargets["Shark"] = v end})
TabSea:AddToggle({Name = "🎯 Săn Thuyền Ma (Ship)", Default = false, Callback = function(v) _G.SeaTargets["Ship"] = v end})
TabSea:AddToggle({Name = "🌊 KHỞI ĐỘNG AUTO SEA EVENT", Default = false, Callback = function(v) 
    _G.AutoSeaEvent = v 
    if v then _G.AutoClick = true; _G.AutoFarmLevel = f
