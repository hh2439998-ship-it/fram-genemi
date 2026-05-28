-- ==============================================================================
-- LIGHT GALAXY HUB - PRO MAX (FULL DATA QUEST & REMOTES)
-- UI: KAVO LIBRARY (MOBILE OPTIMIZED - 100% HIỂN THỊ)
-- ==============================================================================

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("LIGHT GALAXY HUB | PRO MASTER", "BloodTheme")

-- ==============================================================================
-- 1. BIẾN HỆ THỐNG & REMOTES CORE
-- ==============================================================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

-- Giao tiếp Server (Blox Fruits Remotes)
local Remotes = ReplicatedStorage:WaitForChild("Remotes", 9e9)
local CommF = Remotes:WaitForChild("CommF_", 9e9)

_G.AutoFarm = false
_G.AutoBone = false
_G.AutoCake = false
_G.BringMob = false
_G.AutoClick = false
_G.FastAttack = true
_G.WeaponType = "Melee"

-- ==============================================================================
-- 2. DATABASE TỌA ĐỘ IP ĐẢO (SEA 3)
-- ==============================================================================
local FullIP = {
    ["Port Town"] = CFrame.new(-290, 44, 5581),
    ["Hydra Island"] = CFrame.new(5749, 610, -253),
    ["Great Tree"] = CFrame.new(5393, 13, 2525),
    ["Floating Turtle"] = CFrame.new(-12463, 375, -7523),
    ["Castle On Sea"] = CFrame.new(-5012, 315, -3157),
    ["Haunted Castle"] = CFrame.new(-9481, 142, 5566),
    ["Tiki Outpost"] = CFrame.new(-2421, 73, -3215),
    ["Raid Lab"] = CFrame.new(-5036, 315, -3179),
    ["Cake Island"] = CFrame.new(-2022, 38, -12028),
    ["Peanut Island"] = CFrame.new(-2104, 38, -10192),
    ["Ice Cream Island"] = CFrame.new(-821, 66, -10965),
    ["Chocolate Island"] = CFrame.new(138, 25, -12185),
    ["Candy Island"] = CFrame.new(-1147, 13, -14445)
}

-- ==============================================================================
-- 3. DATABASE NHIỆM VỤ (QUEST DICTIONARY CHO AUTO LEVEL)
-- ==============================================================================
local function GetQuestData()
    local Level = LocalPlayer.Data.Level.Value
    if Level >= 1500 and Level <= 1574 then return "Pirate Port Quest", 1, "Pirate Millionaire", FullIP["Port Town"]
    elseif Level >= 1575 and Level <= 1700 then return "Amazon Quest", 1, "Dragon Crew Warrior", FullIP["Hydra Island"]
    elseif Level >= 1700 and Level <= 1774 then return "Marine Tree Island", 1, "Marine Commodore", FullIP["Great Tree"]
    elseif Level >= 1775 and Level <= 1824 then return "Deep Forest Island", 1, "Fishman Raider", FullIP["Floating Turtle"]
    elseif Level >= 1975 and Level <= 2024 then return "Haunted Quest 1", 1, "Reborn Skeleton", FullIP["Haunted Castle"]
    elseif Level >= 2075 and Level <= 2124 then return "Peanut Quest", 1, "Peanut Scout", FullIP["Peanut Island"]
    elseif Level >= 2125 and Level <= 2174 then return "Ice Cream Quest", 1, "Ice Cream Chef", FullIP["Ice Cream Island"]
    elseif Level >= 2200 and Level <= 2249 then return "Cake Quest 1", 1, "Cookie Crafter", FullIP["Cake Island"]
    elseif Level >= 2300 and Level <= 2349 then return "Choc Quest", 1, "Cocoa Warrior", FullIP["Chocolate Island"]
    elseif Level >= 2350 and Level <= 2400 then return "Candy Quest", 1, "Candy Rebel", FullIP["Candy Island"]
    else return "Tiki Quest", 1, "Isle Champion", FullIP["Tiki Outpost"] end
end

-- ==============================================================================
-- 4. HỆ THỐNG TWEEN & NOCLIP CHỐNG VĂNG
-- ==============================================================================
local function Tween(TargetCFrame)
    local Char = LocalPlayer.Character
    if not Char or not Char:FindFirstChild("HumanoidRootPart") then return end
    
    local Root = Char.HumanoidRootPart
    local Dist = (Root.Position - TargetCFrame.Position).Magnitude
    local TweenInfoObj = TweenInfo.new(Dist/320, Enum.EasingStyle.Linear)
    local T = TweenService:Create(Root, TweenInfoObj, {CFrame = TargetCFrame})
    
    local Noclip = RunService.Stepped:Connect(function()
        if Char then
            for _, v in pairs(Char:GetChildren()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
    
    T:Play()
    T.Completed:Wait()
    Noclip:Disconnect()
    if Char and Char:FindFirstChild("HumanoidRootPart") then Root.CanCollide = true end
end

-- ==============================================================================
-- 5. LOGIC BRING ĐÚNG 2 QUÁI & AUTO CLICK & FAST ATTACK
-- ==============================================================================
spawn(function()
    while task.wait(0.01) do -- Chạy siêu mượt
        if _G.BringMob then
            pcall(function()
                local Char = LocalPlayer.Character
                local Root = Char.HumanoidRootPart
                local Count = 0
                
                for _, Mob in pairs(Workspace.Enemies:GetChildren()) do
                    if Mob:FindFirstChild("Humanoid") and Mob:FindFirstChild("HumanoidRootPart") and Mob.Humanoid.Health > 0 then
                        if (Mob.HumanoidRootPart.Position - Root.Position).Magnitude < 350 then
                            if Count < 2 then
                                Mob.HumanoidRootPart.Size = Vector3.new(20, 20, 20) -- Mở rộng Hitbox
                                Mob.HumanoidRootPart.CanCollide = false
                                Mob.Humanoid.WalkSpeed = 0
                                Mob.Humanoid.JumpPower = 0
                                -- Ép quái vào Z = -3.5 trước mặt
                                Mob.HumanoidRootPart.CFrame = Root.CFrame * CFrame.new(0, 0, -3.5)
                                Count = Count + 1
                            end
                        end
                    end
                end
            end)
        end
    end
end)

spawn(function()
    while task.wait() do
        if _G.AutoClick then
            pcall(function()
                local Char = LocalPlayer.Character
                local Tool = Char:FindFirstChildOfClass("Tool")
                if not Tool then
                    for _, v in pairs(LocalPlayer.Backpack:GetChildren()) do
                        if v.ToolTip == _G.WeaponType or v.Name == _G.WeaponType then
                            Char.Humanoid:EquipTool(v)
                            break
                        end
                    end
                else
                    Tool:Activate()
                    -- Giả lập Fast Attack
                    if _G.FastAttack then
                        VirtualUser:CaptureController()
                        VirtualUser:ClickButton1(Vector2.new(850, 500))
                    end
                end
            end)
        end
    end
end)

-- ==============================================================================
-- 6. HỆ THỐNG AUTO FARM (NHẬN NHIỆM VỤ BẰNG REMOTES)
-- ==============================================================================
spawn(function()
    while task.wait(0.1) do
        if _G.AutoFarm then
            pcall(function()
                local QName, QNum, MobName, NPC_IP = GetQuestData()
                local QuestUI = LocalPlayer.PlayerGui.Main.Quest
                
                if not QuestUI.Visible then
                    Tween(NPC_IP)
                    if (LocalPlayer.Character.HumanoidRootPart.Position - NPC_IP.Position).Magnitude < 15 then
                        -- Gửi lệnh nhận nhiệm vụ lên Server
                        CommF:InvokeServer("StartQuest", QName, QNum)
                    end
                else
                    local Target = nil
                    for _, Mob in pairs(Workspace.Enemies:GetChildren()) do
                        if string.find(Mob.Name, MobName) and Mob.Humanoid.Health > 0 then
                            Target = Mob
                            break
                        end
                    end
                    if Target then
                        Tween(Target.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0))
                    else
                        Tween(NPC_IP * CFrame.new(0, 50, 0)) -- Chờ hồi quái
                    end
                end
            end)
        end
    end
end)

-- Tương tự cho Auto Bone và Auto Cake
spawn(function()
    while task.wait(0.2) do
        if _G.AutoBone then
            pcall(function()
                local T = nil
                for _, M in pairs(Workspace.Enemies:GetChildren()) do
                    if (M.Name == "Reborn Skeleton" or M.Name == "Living Zombie") and M.Humanoid.Health > 0 then T = M break end
                end
                if T then Tween(T.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0)) else Tween(FullIP["Haunted Castle"]) end
            end)
        end
        if _G.AutoCake then
            pcall(function()
                local T = nil
                for _, M in pairs(Workspace.Enemies:GetChildren()) do
                    if (string.find(M.Name, "Cake") or string.find(M.Name, "Cookie")) and M.Humanoid.Health > 0 then T = M break end
                end
                if T then Tween(T.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0)) else Tween(FullIP["Cake Island"]) end
            end)
        end
    end
end)

-- ==============================================================================
-- 7. KAVO UI TABS & TOGGLES (MOBILE FRIENDLY)
-- ==============================================================================
local Tab1 = Window:NewTab("Farming")
local Section1 = Tab1:NewSection("Vũ Khí & Chế Độ")

Section1:NewDropdown("Chọn Vũ Khí", "Chọn vũ khí để farm", {"Melee", "Sword", "Blox Fruit"}, function(v)
    _G.WeaponType = v
end)

Section1:NewToggle("Auto Click (Kèm Fast Attack)", "Đánh siêu nhanh", function(v)
    _G.AutoClick = v
end)

Section1:NewToggle("Bring Mob (Max 2)", "Gom 2 quái trước mặt", function(v)
    _G.BringMob = v
end)

local Section2 = Tab1:NewSection("Nhiệm Vụ Cày Cuốc")
Section2:NewToggle("Auto Farm Level", "Tự nhận quest", function(v)
    _G.AutoFarm = v
end)

Section2:NewToggle("Auto Farm Bone", "Đánh xương Haunted", function(v)
    _G.AutoBone = v
end)

Section2:NewToggle("Auto Farm Cake", "Đánh quái bánh", function(v)
    _G.AutoCake = v
end)

local Tab2 = Window:NewTab("Events & IP")
local Section3 = Tab2:NewSection("Dịch chuyển (Teleport)")

for Name, Coord in pairs(FullIP) do
    Section3:NewButton("Bay tới: " .. Name, "Di chuyển an toàn", function()
        Tween(Coord)
    end)
end
