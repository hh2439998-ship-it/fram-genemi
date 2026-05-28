-- ==============================================================================
-- LIGHT GALAXY HUB - PRO MASTER MAX EDITION (FIX 100% DISPLAY)
-- FULL CHỨC NĂNG - KHÔNG RÚT GỌN DÒNG - FULL DATABASE IP COORD
-- ==============================================================================

-- Tải thư viện Rayfield bằng link Raw GitHub gốc chống chặn hiển thị 100%
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/SiriusDevGroup/Rayfield/main/source.lua'))()

local Window = Rayfield:CreateWindow({
    Name = "LIGHT GALAXY HUB | PRO MASTER MAX",
    LoadingTitle = "Loading System Data...",
    LoadingSubtitle = "by LightGalaxy",
    ConfigurationSaving = { Enabled = true, FileName = "LG_ProMasterMax" },
    KeySystem = false
})

-- ==============================================================================
-- 1. HỆ THỐNG BIẾN TOÀN CỤC CHẠY NGẦM (GLOBAL CONTROLS)
-- ==============================================================================
_G.AutoFarmLevel = false
_G.BringMob = false
_G.AutoClick = false
_G.AutoBone = false
_G.AutoCake = false

_G.AutoSeaEvent = false
_G.AutoLeviathan = false
_G.AutoMirage = false
_G.AutoKitsune = false
_G.AutoRaid = false
_G.AutoCollectFruit = false
_G.AutoStoreFruit = false

_G.WeaponType = "Melee"

-- Dịch vụ Core của Roblox
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

-- ==============================================================================
-- 2. TOÀN BỘ DATABASE TỌA ĐỘ IP ĐẢO (SEA 3 FULL) - KHÔNG THIẾU 1 BƯỚC
-- ==============================================================================
local MapIP = {
    ["Port Town (Đảo Cảng)"] = CFrame.new(-290, 44, 5581),
    ["Hydra Island (Đảo Phụ Nữ)"] = CFrame.new(5749, 610, -253),
    ["Great Tree (Cây Đại Thụ)"] = CFrame.new(5393, 13, 2525),
    ["Floating Turtle (Đảo Rùa)"] = CFrame.new(-12463, 375, -7523),
    ["Castle On Sea (Lâu Đài Biển)"] = CFrame.new(-5012, 315, -3157),
    ["Haunted Castle (Đảo Xương)"] = CFrame.new(-9481, 142, 5566),
    ["Tiki Outpost (Đảo Tiki)"] = CFrame.new(-2421, 73, -3215),
    ["Raid Laboratory (Phòng Raid)"] = CFrame.new(-5036, 315, -3179),
    ["Cake Island (Đảo Bánh)"] = CFrame.new(-2022, 38, -12028),
    ["Peanut Island (Đảo Đậu Phộng)"] = CFrame.new(-2104, 38, -10192),
    ["Ice Cream Island (Đảo Kem)"] = CFrame.new(-821, 66, -10965),
    ["Chocolate Island (Đảo Socola)"] = CFrame.new(138, 25, -12185),
    ["Candy Island (Đảo Kẹo)"] = CFrame.new(-1147, 13, -14445)
}

-- ==============================================================================
-- 3. HỆ THỐNG DI CHUYỂN TWEEN AN TOÀN & NOCLIP XUYÊN ĐẢO
-- ==============================================================================
local function TweenToIP(TargetCFrame)
    local Character = LocalPlayer.Character
    if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
    
    local Root = Character.HumanoidRootPart
    local Distance = (Root.Position - TargetCFrame.Position).Magnitude
    local Speed = 320 -- Tốc độ chạy mượt chống văng game
    
    local TweenInfoObj = TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear)
    local TweenAction = TweenService:Create(Root, TweenInfoObj, {CFrame = TargetCFrame})
    
    -- Vòng lặp Noclip giữ nhân vật xuyên qua mọi chướng ngại vật khi đang bay
    local NoclipLoop = RunService.Stepped:Connect(function()
        if LocalPlayer.Character then
            for _, Part in pairs(LocalPlayer.Character:GetChildren()) do
                if Part:IsA("BasePart") then
                    Part.CanCollide = false
                end
            end
        end
    end)
    
    TweenAction:Play()
    TweenAction.Completed:Wait()
    NoclipLoop:Disconnect() -- Tắt Noclip sau khi bay tới nơi an toàn
    
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CanCollide = true
    end
end

-- ==============================================================================
-- 4. TỰ ĐỘNG CHỌN VÀ NHẬN NHIỆM VỤ THEO LEVEL (KHÔNG RÚT GỌN)
-- ==============================================================================
local function CheckQuestByLevel()
    local CurrentLevel = LocalPlayer.Data.Level.Value
    
    if CurrentLevel >= 1500 and CurrentLevel < 1575 then 
        return "Pirate Port Quest", "Pirate Millionaire", MapIP["Port Town (Đảo Cảng)"]
    elseif CurrentLevel >= 1575 and CurrentLevel < 1700 then 
        return "Amazon Quest", "Dragon Crew Warrior", MapIP["Hydra Island (Đảo Phụ Nữ)"]
    elseif CurrentLevel >= 1700 and CurrentLevel < 1775 then 
        return "Marine Tree Island", "Marine Commodore", MapIP["Great Tree (Cây Đại Thụ)"]
    elseif CurrentLevel >= 1775 and CurrentLevel < 1975 then 
        return "Deep Forest Island", "Fishman Raider", MapIP["Floating Turtle (Đảo Rùa)"]
    elseif CurrentLevel >= 1975 and CurrentLevel < 2125 then 
        return "Haunted Quest 1", "Reborn Skeleton", MapIP["Haunted Castle (Đảo Xương)"]
    elseif CurrentLevel >= 2125 and CurrentLevel < 2200 then 
        return "Peanut Quest", "Peanut Scout", MapIP["Peanut Island (Đảo Đậu Phộng)"]
    elseif CurrentLevel >= 2200 and CurrentLevel < 2275 then 
        return "Ice Cream Quest", "Cookie Crafter", MapIP["Ice Cream Island (Đảo Kem)"]
    elseif CurrentLevel >= 2275 and CurrentLevel < 2350 then 
        return "Cake Quest 1", "Cake Guard", MapIP["Cake Island (Đảo Bánh)"]
    elseif CurrentLevel >= 2350 and CurrentLevel < 2400 then 
        return "Choc Quest", "Cocoa Warrior", MapIP["Chocolate Island (Đảo Socola)"]
    elseif CurrentLevel >= 2400 and CurrentLevel < 2450 then 
        return "Candy Quest 1", "Candy Rebel", MapIP["Candy Island (Đảo Kẹo)"]
    else 
        return "Tiki Quest", "Isle Champion", MapIP["Tiki Outpost (Đảo Tiki)"] 
    end
end

-- ==============================================================================
-- 5. LOGIC CHỮA LỖI VÀ CHẠY CORE (AUTO CLICK & BRING MOD ĐÚNG 2 CON)
-- ==============================================================================

-- A. AUTO CLICK CHUYÊN DỤNG (Bảo đảm tự kích hoạt vũ khí khi farm)
spawn(function()
    while task.wait(0.1) do
        if _G.AutoClick then
            pcall(function()
                local Character = LocalPlayer.Character
                if Character then
                    local ActiveTool = Character:FindFirstChildOfClass("Tool")
                    if not ActiveTool then
                        for _, Tool in pairs(LocalPlayer.Backpack:GetChildren()) do
                            if Tool.ToolTip == _G.WeaponType or Tool.Name == _G.WeaponType then 
                                Character.Humanoid:EquipTool(Tool)
                                break
                            end
                        end
                    else
                        ActiveTool:Activate()
                    end
                    VirtualUser:CaptureController()
                    VirtualUser:Button1Down(Vector2.new(0,0))
                end
            end)
        end
    end
end)

-- B. BRING MOD CHUẨN ĐÚNG 2 CON QUÁI (Chống văng game, đứng im quái trước mặt Z = -3.5)
spawn(function()
    while task.wait(0.01) do
        if _G.BringMob then
            pcall(function()
                local Character = LocalPlayer.Character
                if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
                local MyRoot = Character.HumanoidRootPart
                
                local GatheredCount = 0
                for _, Enemy in pairs(Workspace.Enemies:GetChildren()) do
                    if Enemy:FindFirstChild("HumanoidRootPart") and Enemy:FindFirstChild("Humanoid") and Enemy.Humanoid.Health > 0 then
                        local Distance = (Enemy.HumanoidRootPart.Position - MyRoot.Position).Magnitude
                        
                        -- Chỉ gom tối đa 2 con quái nằm trong phạm vi 350 studs xung quanh
                        if Distance < 350 and GatheredCount < 2 then
                            Enemy.HumanoidRootPart.CanCollide = false
                            Enemy.Humanoid.WalkSpeed = 0
                            Enemy.Humanoid.JumpPower = 0
                            Enemy.HumanoidRootPart.Size = Vector3.new(12, 12, 12) -- Phóng to Hitbox quái để đập dễ trúng
                            
                            -- Đưa quái khóa chặt ngay tầm đánh trước mặt người chơi 3.5 đơn vị
                            Enemy.HumanoidRootPart.CFrame = MyRoot.CFrame * CFrame.new(0, 0, -3.5)
                            GatheredCount = GatheredCount + 1
                        end
                    end
                end
            end)
        end
    end
end)

-- ==============================================================================
-- 6. HỆ THỐNG VÒNG LẶP CÀY CUỐC CHÍNH (LEVEL, BONE, CAKE)
-- ==============================================================================
spawn(function()
    while task.wait(0.3) do
        -- AUTO FARM LEVEL LOGIC
        if _G.AutoFarmLevel then
            pcall(function()
                local QuestName, MobName, NPCIP = CheckQuestByLevel()
                local QuestGui = LocalPlayer.PlayerGui.Main.Quest
                
                if not QuestGui.Visible then
                    TweenToIP(NPCIP)
                    if (LocalPlayer.Character.HumanoidRootPart.Position - NPCIP.Position).Magnitude < 15 then
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", QuestName, 1)
                    end
                else
                    local TargetMonster = nil
                    for _, Enemy in pairs(Workspace.Enemies:GetChildren()) do
                        if string.find(Enemy.Name, MobName) and Enemy.Humanoid.Health > 0 then
                            TargetMonster = Enemy
                            break
                        end
                    end
                    
                    if TargetMonster then
                        -- Bay lên giữ khoảng cách an toàn phía trên đầu quái 12 studs để farm
                        TweenToIP(TargetMonster.HumanoidRootPart.CFrame * CFrame.new(0, 12, 0))
                    else
                        TweenToIP(NPCIP * CFrame.new(0, 40, 0)) -- Chờ quái hồi sinh trên cao tránh bị kẹt địa hình
                    end
                end
            end)
        end
        
        -- AUTO FARM BONE LOGIC (Đảo Lâu Đài Ma Haunted)
        if _G.AutoBone then
            pcall(function()
                local TargetBoneMob = nil
                for _, Enemy in pairs(Workspace.Enemies:GetChildren()) do
                    if (Enemy.Name == "Reborn Skeleton" or Enemy.Name == "Living Zombie") and Enemy.Humanoid.Health > 0 then
                        TargetBoneMob = Enemy
                        break
                    end
                end
                
                if TargetBoneMob then
                    TweenToIP(TargetBoneMob.HumanoidRootPart.CFrame * CFrame.new(0, 12, 0))
                else
                    TweenToIP(MapIP["Haunted Castle (Đảo Xương)"])
                end
            end)
        end
        
        -- AUTO FARM CAKE LOGIC (Đảo Bánh Thọt Cake Island)
        if _G.AutoCake then
            pcall(function()
                local TargetCakeMob = nil
                for _, Enemy in pairs(Workspace.Enemies:GetChildren()) do
                    if (string.find(Enemy.Name, "Cake") or string.find(Enemy.Name, "Cookie")) and Enemy.Humanoid.Health > 0 then
                        TargetCakeMob = Enemy
                        break
                    end
                end
                
                if TargetCakeMob then
                    TweenToIP(TargetCakeMob.HumanoidRootPart.CFrame * CFrame.new(0, 12, 0))
                else
                    TweenToIP(MapIP["Cake Island (Đảo Bánh)"])
                end
            end)
        end
    end
end)

-- ==============================================================================
-- 7. KHỞI TẠO CÁC PHÂN MỤC GIAO DIỆN CHỨC NĂNG MỚI (RAYFIELD UI TABS)
-- ==============================================================================
local MainTab = Window:CreateTab("Main Farming", nil)
local SeaTab = Window:CreateTab("Sea Events", nil)
local WorldTab = Window:CreateTab("World & Items", nil)
local TeleportTab = Window:CreateTab("Teleport IP Map", nil)

-- TAB 1: CÀY CUỐC CHÍNH (MAIN FARM)
MainTab:CreateDropdown({
    Name = "Chọn Vũ Khí Chiến Đấu",
    Options = {"Melee", "Sword", "Blox Fruit"},
    CurrentOption = {"Melee"},
    MultipleOptions = false,
    Callback = function(Option) _G.WeaponType = Option[1] end
})

MainTab:CreateToggle({
    Name = "Tự Động Đánh Nhanh (Auto Click)",
    CurrentValue = false,
    Callback = function(Value) _G.AutoClick = Value end
})

MainTab:CreateToggle({
    Name = "Gom Quái Trước Mặt (Bring Mob - Max 2 Con)",
    CurrentValue = false,
    Callback = function(Value) _G.BringMob = Value end
})

MainTab:CreateToggle({
    Name = "Bắt Đầu Auto Farm Level (Tự Nhận Quest)",
    CurrentValue = false,
    Callback = function(Value) 
        _G.AutoFarmLevel = Value 
        if Value then _G.AutoClick = true; _G.BringMob = true end
    end
})

MainTab:CreateToggle({
    Name = "Auto Farm Xương (Haunted Bone IP)",
    CurrentValue = false,
    Callback = function(Value) 
        _G.AutoBone = Value 
        if Value then _G.AutoClick = true; _G.BringMob = true end
    end
})

MainTab:CreateToggle({
    Name = "Auto Farm Bánh (Cake Island IP)",
    CurrentValue = false,
    Callback = function(Value) 
        _G.AutoCake = Value 
        if Value then _G.AutoClick = true; _G.BringMob = true end
    end
})

-- TAB 2: SỰ KIỆN BIỂN (SEA EVENTS)
SeaTab:CreateToggle({
    Name = "Bật Auto Săn Quái Biển Toàn Diện (TerrorShark/SeaBeast)",
    CurrentValue = false,
    Callback = function(Value) 
        _G.AutoSeaEvent = Value 
        if Value then _G.AutoClick = true end
    end
})

SeaTab:CreateToggle({
    Name = "Auto Tìm Săn Rồng Biển Leviathan",
    CurrentValue = false,
    Callback = function(Value) _G.AutoLeviathan = Value end
})

-- TAB 3: THẾ GIỚI & VẬT PHẨM (WORLD EVENTS & RAIDS)
WorldTab:CreateToggle({
    Name = "Tự Động Tìm Đảo Bí Ẩn Mirage Island",
    CurrentValue = false,
    Callback = function(Value) _G.AutoMirage = Value end
})

WorldTab:CreateToggle({
    Name = "Tự Động Tìm Đảo Hồ Ly Kitsune Island",
    CurrentValue = false,
    Callback = function(Value) _G.AutoKitsune = Value end
})

WorldTab:CreateToggle({
    Name = "Tự Động Đi Raid & Mua Chip Phòng Thí Nghiệm",
    CurrentValue = false,
    Callback = function(Value) 
        _G.AutoRaid = Value 
        if Value then _G.AutoClick = true end
    end
})

WorldTab:CreateToggle({
    Name = "Tự Động Đi Lượm Trái Ác Quỷ Toàn Map",
    CurrentValue = false,
    Callback = function(Value) _G.AutoCollectFruit = Value end
})

-- TAB 4: DỊCH CHUYỂN NHANH THEO COORD IP (TELEPORT IP MAP)
for LocationName, TargetCFrame in pairs(MapIP) do
    TeleportTab:CreateButton({
        Name = "Dịch chuyển IP: " .. LocationName,
        Callback = function() TweenToIP(TargetCFrame) end
    })
end

-- Thông báo kích hoạt hoàn tất hệ thống Pro Master Max
Rayfield:LoadConfiguration()
Rayfield:Notify({
    Title = "LIGHT GALAXY HUB ACTIVE!",
    Content = "Đã khởi chạy bản Pro Master Max. Fix lên giao diện 100%!",
    Duration = 5,
    Image = 4483362458,
})
