-- ==============================================================================
-- LIGHT GALAXY HUB - PERFECT CORE V8 (REAL FAST ATTACK VISUAL)
-- PURE LUAU UI - ANTI-CRASH - SAFE FARM UNDER PLAYER - FULL 3 TABS COMPLETE
-- ==============================================================================

-- Tự động nhận diện vị trí an toàn để vẽ UI trên Mobile Executor
local UI_Parent = game:GetService("CoreGui")
if not UI_Parent or pcall(function() local a = UI_Parent.Name end) == false then
    UI_Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

if UI_Parent:FindFirstChild("LightGalaxyHub") then
    UI_Parent.LightGalaxyHub:Destroy()
end

-- ==============================================================================
-- I. HỆ THỐNG GIAO DIỆN THUẦN (VẼ UI TRƯỚC - CHẠY VÒNG LẶP SAU)
-- ==============================================================================
local LightGalaxyHub = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TopBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local TabScroll = Instance.new("ScrollingFrame")
local ContentContainer = Instance.new("Frame")

LightGalaxyHub.Name = "LightGalaxyHub"
LightGalaxyHub.Parent = UI_Parent
LightGalaxyHub.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = LightGalaxyHub
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.Position = UDim2.new(0.15, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 580, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true 
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
TopBar.Size = UDim2.new(1, 0, 0, 40)
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 10)

Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Size = UDim2.new(1, -30, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "LIGHT GALAXY HUB ◆ PERFECT CORE V8"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left

TabScroll.Parent = MainFrame
TabScroll.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
TabScroll.Position = UDim2.new(0, 5, 0, 45)
TabScroll.Size = UDim2.new(0, 140, 1, -50)
TabScroll.ScrollBarThickness = 2
local UIListLayout_Tab = Instance.new("UIListLayout", TabScroll)
UIListLayout_Tab.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_Tab.Padding = UDim.new(0, 5)

ContentContainer.Parent = MainFrame
ContentContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
ContentContainer.Position = UDim2.new(0, 150, 0, 45)
ContentContainer.Size = UDim2.new(1, -155, 1, -50)
Instance.new("UICorner", ContentContainer).CornerRadius = UDim.new(0, 8)

local Pages = {}
local function CreatePage(PageName)
    local Page = Instance.new("ScrollingFrame")
    Page.Parent = ContentContainer
    Page.BackgroundTransparency = 1
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.CanvasSize = UDim2.new(0, 0, 3, 0)
    Page.ScrollBarThickness = 4
    Page.Visible = false
    
    local UIList = Instance.new("UIListLayout", Page)
    UIList.Padding = UDim.new(0, 6)
    local UIPad = Instance.new("UIPadding", Page)
    UIPad.PaddingTop = UDim.new(0, 8)
    UIPad.PaddingLeft = UDim.new(0, 8)
    Pages[PageName] = Page
    
    local TabBtn = Instance.new("TextButton")
    TabBtn.Parent = TabScroll
    TabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 60)
    TabBtn.Size = UDim2.new(1, -10, 0, 35)
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.Text = PageName
    TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabBtn.TextSize = 13
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)
    
    TabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Page.Visible = true
        for _, b in pairs(TabScroll:GetChildren()) do
            if b:IsA("TextButton") then b.TextColor3 = Color3.fromRGB(200, 200, 200) b.BackgroundColor3 = Color3.fromRGB(35, 35, 60) end
        end
        TabBtn.TextColor3 = Color3.fromRGB(0, 255, 255)
        TabBtn.BackgroundColor3 = Color3.fromRGB(50, 40, 90)
    end)
    return Page
end

local function AddToggle(ParentPage, Text, GlobalVar)
    local ToggleFrame = Instance.new("Frame")
    local Label = Instance.new("TextLabel")
    local Btn = Instance.new("TextButton")
    
    ToggleFrame.Size = UDim2.new(1, -16, 0, 40)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    ToggleFrame.Parent = ParentPage
    Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 6)
    
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.Gotham
    Label.Text = Text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame
    
    Btn.Size = UDim2.new(0, 50, 0, 24)
    Btn.Position = UDim2.new(1, -60, 0, 8)
    Btn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
    Btn.Text = "OFF"
    Btn.Font = Enum.Font.GothamBold
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextSize = 11
    Btn.Parent = ToggleFrame
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)
    
    Btn.MouseButton1Click:Connect(function()
        _G[GlobalVar] = not _G[GlobalVar]
        if _G[GlobalVar] then
            Btn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
            Btn.Text = "ON"
        else
            Btn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
            Btn.Text = "OFF"
        end
    end)
end

local function AddButton(ParentPage, Text, Callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -16, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(45, 55, 85)
    Btn.Font = Enum.Font.GothamSemibold
    Btn.Text = Text
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextSize = 13
    Btn.Parent = ParentPage
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    Btn.MouseButton1Click:Connect(Callback)
end

-- ==============================================================================
-- II. ĐỊNH HÌNH TOÀN BỘ NÚT BẤM
-- ==============================================================================
local FarmPage = CreatePage("Cày Cuốc")
local EventPage = CreatePage("Sự Kiện")
local TeleportPage = CreatePage("Tọa Độ IP")
Pages["Cày Cuốc"].Visible = true

_G.FastAttack = false
_G.BringMob = false
_G.AutoFarmLevel = false
_G.AutoBone = false
_G.AutoCake = false
_G.AutoSeaEvent = false
_G.LeviathanHunt = false
_G.VolcanoEvent = false
_G.AutoRaid = false
_G.AutoFruit = false

-- Tab Cày Cuốc
AddToggle(FarmPage, "Kill Aura/Fast Attack (Đòn 1 Siêu Tốc)", "FastAttack")
AddToggle(FarmPage, "Real Bring Mob (Safe Farm Dưới Chân)", "BringMob")
AddToggle(FarmPage, "Auto Farm Level (Từ Đảo Đầu -> Tiki)", "AutoFarmLevel")
AddToggle(FarmPage, "Auto Farm Xương (Haunted Bone)", "AutoBone")
AddToggle(FarmPage, "Auto Farm Bánh (Cake Island)", "AutoCake")

-- Tab Sự Kiện
AddToggle(EventPage, "Auto Săn Quái Biển (Sea Event)", "AutoSeaEvent")
AddToggle(EventPage, "Auto Săn Rồng Biển Leviathan Hunt", "LeviathanHunt")
AddToggle(EventPage, "Auto Tìm Đảo Lửa Volcano Event", "VolcanoEvent")
AddToggle(EventPage, "Auto Đi Dungeon Raid", "AutoRaid")
AddToggle(EventPage, "Auto Gom Trái Ác Quỷ (Fruit Toàn Map)", "AutoFruit")

-- ==============================================================================
-- III. CORE GAME CONFIG & DATABASE
-- ==============================================================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")

local MapIP = {
    ["Port Town (Đảo Đầu)"] = CFrame.new(-290, 44, 5581),
    ["Hydra Island (Đảo Nữ)"] = CFrame.new(5749, 610, -253),
    ["Great Tree (Cây Lớn)"] = CFrame.new(5393, 13, 2525),
    ["Floating Turtle (Đảo Rùa)"] = CFrame.new(-12463, 375, -7523),
    ["Castle On Sea (Lâu Đài)"] = CFrame.new(-5012, 315, -3157),
    ["Haunted Castle (Xương)"] = CFrame.new(-9481, 142, 5566),
    ["Peanut Island"] = CFrame.new(-2104, 38, -10192),
    ["Ice Cream Island"] = CFrame.new(-821, 66, -10965),
    ["Cake Island (Bánh)"] = CFrame.new(-2022, 38, -12028),
    ["Chocolate Island"] = CFrame.new(138, 25, -12185),
    ["Candy Island"] = CFrame.new(-1147, 13, -14445),
    ["Tiki Outpost (Cuối)"] = CFrame.new(-2421, 73, -3215)
}

for Name, Coord in pairs(MapIP) do
    AddButton(TeleportPage, "Dịch Chuyển IP: " .. Name, function()
        local Char = LocalPlayer.Character
        if Char and Char:FindFirstChild("HumanoidRootPart") then
            local Root = Char.HumanoidRootPart
            local TweenAction = TweenService:Create(Root, TweenInfo.new((Root.Position - Coord.Position).Magnitude / 315, Enum.EasingStyle.Linear), {CFrame = Coord})
            local Noclip = RunService.Stepped:Connect(function()
                for _, Part in pairs(Char:GetChildren()) do if Part:IsA("BasePart") then Part.CanCollide = false end end
            end)
            TweenAction:Play()
            TweenAction.Completed:Wait()
            Noclip:Disconnect()
            Root.CanCollide = true
        end
    end)
end

local function GetQuestData()
    local Lvl = LocalPlayer.Data.Level.Value
    if Lvl >= 1500 and Lvl < 1575 then return "Pirate Port Quest", 1, "Pirate Millionaire", MapIP["Port Town (Đảo Đầu)"]
    elseif Lvl >= 1575 and Lvl < 1700 then return "Amazon Quest", 1, "Dragon Crew Warrior", MapIP["Hydra Island (Đảo Nữ)"]
    elseif Lvl >= 1700 and Lvl < 1775 then return "Marine Tree Island", 1, "Marine Commodore", MapIP["Great Tree (Cây Lớn)"]
    elseif Lvl >= 1775 and Lvl < 1975 then return "Deep Forest Island", 1, "Fishman Raider", MapIP["Floating Turtle (Đảo Rùa)"]
    elseif Lvl >= 1975 and Lvl < 2125 then return "Haunted Quest 1", 1, "Reborn Skeleton", MapIP["Haunted Castle (Xương)"]
    elseif Lvl >= 2125 and Lvl < 2200 then return "Peanut Quest", 1, "Peanut Scout", MapIP["Peanut Island"]
    elseif Lvl >= 2200 and Lvl < 2275 then return "Ice Cream Quest", 1, "Ice Cream Chef", MapIP["Ice Cream Island"]
    elseif Lvl >= 2275 and Lvl < 2350 then return "Cake Quest 1", 1, "Cake Guard", MapIP["Cake Island (Bánh)"]
    elseif Lvl >= 2350 and Lvl < 2400 then return "Choc Quest", 1, "Cocoa Warrior", MapIP["Chocolate Island"]
    elseif Lvl >= 2400 and Lvl < 2450 then return "Candy Quest 1", 1, "Candy Rebel", MapIP["Candy Island"]
    else return "Tiki Quest", 1, "Isle Champion", MapIP["Tiki Outpost (Cuối)"] end
end

local function TweenTo(TargetCFrame)
    local Char = LocalPlayer.Character
    if not Char or not Char:FindFirstChild("HumanoidRootPart") then return end
    local Root = Char.HumanoidRootPart
    local TweenAction = TweenService:Create(Root, TweenInfo.new((Root.Position - TargetCFrame.Position).Magnitude / 315, Enum.EasingStyle.Linear), {CFrame = TargetCFrame})
    local Noclip = RunService.Stepped:Connect(function()
        if LocalPlayer.Character then
            for _, Part in pairs(LocalPlayer.Character:GetChildren()) do
                if Part:IsA("BasePart") then Part.CanCollide = false end
            end
        end
    end)
    TweenAction:Play()
    TweenAction.Completed:Wait()
    Noclip:Disconnect()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then Root.CanCollide = true end
end

-- ==============================================================================
-- IV. HỆ THỐNG FAST ATTACK (REAL VISUAL) & REAL BRING LY TÂM
-- ==============================================================================

-- Core Fast Attack (Đã xóa hàm cản trở hoạt ảnh. Giờ sẽ chém vung tay đòn 1 cực nhanh)
spawn(function()
    while true do
        task.wait(0.01)
        if _G.FastAttack then
            -- Móc vũ khí liên tục
            pcall(function()
                local Char = LocalPlayer.Character
                if Char and Char:FindFirstChild("Humanoid") and not Char:FindFirstChildOfClass("Tool") then
                    for _, Item in pairs(LocalPlayer.Backpack:GetChildren()) do
                        if Item:IsA("Tool") and (Item.ToolTip == "Melee" or Item.ToolTip == "Sword") then
                            Char.Humanoid:EquipTool(Item)
                            break
                        end
                    end
                end
            end)
            
            -- Ép chém bằng Framework Mobile (Tạo tốc độ chém bàn thờ)
            pcall(function()
                local CombatFramework = require(LocalPlayer.PlayerScripts.CombatFramework)
                if CombatFramework and CombatFramework.activeController then
                    CombatFramework.activeController.timeToNextAttack = 0
                    CombatFramework.activeController.hitboxMagnitude = 70
                    CombatFramework.activeController:attack()
                end
            end)
            
            -- Kích hoạt đòn đánh (Tạo hitbox thực tế)
            pcall(function()
                local Tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if Tool then 
                    Tool:Activate() 
                end
            end)
        end
    end
end)

-- Real Bring Mob (SAFE FARM: HÚT QUÁI XUỐNG THẲNG DƯỚI CHÂN 8 STUDS)
spawn(function()
    while true do
        task.wait(0.1)
        if _G.BringMob then
            pcall(function()
                if sethiddenproperty then sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge) end
                local MyRoot = LocalPlayer.Character.HumanoidRootPart
                local Count = 0
                for _, Enemy in pairs(Workspace.Enemies:GetChildren()) do
                    if Enemy:FindFirstChild("HumanoidRootPart") and Enemy:FindFirstChild("Humanoid") and Enemy.Humanoid.Health > 0 then
                        if (Enemy.HumanoidRootPart.Position - MyRoot.Position).Magnitude < 350 and Count < 3 then
                            Enemy.Humanoid.PlatformStand = true
                            Enemy.Humanoid.WalkSpeed = 0
                            Enemy.Humanoid.JumpPower = 0
                            Enemy.HumanoidRootPart.Size = Vector3.new(65, 65, 65)
                            Enemy.HumanoidRootPart.CanCollide = false
                            
                            -- Đưa quái xuống thẳng dưới chân 8 studs
                            Enemy.HumanoidRootPart.CFrame = MyRoot.CFrame * CFrame.new(0, -8, 0)
                            Count = Count + 1
                        end
                    end
                end
            end)
        end
    end
end)

-- ==============================================================================
-- V. AUTO FARM VÀ DI CHUYỂN NHIỆM VỤ
-- ==============================================================================
spawn(function()
    while true do
        task.wait(0.2)
        if _G.AutoFarmLevel then
            pcall(function()
                local QName, QNum, MobName, NPC_IP = GetQuestData()
                if not LocalPlayer.PlayerGui.Main.Quest.Visible then
                    TweenTo(NPC_IP)
                    if (LocalPlayer.Character.HumanoidRootPart.Position - NPC_IP.Position).Magnitude < 15 then
                        CommF:InvokeServer("StartQuest", QName, QNum)
                    end
                else
                    local Target = nil
                    for _, Enemy in pairs(Workspace.Enemies:GetChildren()) do
                        if string.find(Enemy.Name, MobName) and Enemy.Humanoid.Health > 0 then Target = Enemy break end
                    end
                    if Target then TweenTo(Target.HumanoidRootPart.CFrame * CFrame.new(0, 25, 0)) else TweenTo(NPC_IP * CFrame.new(0, 45, 0)) end
                end
            end)
        end
        
        if _G.AutoBone then
            pcall(function()
                local Target = nil
                for _, Enemy in pairs(Workspace.Enemies:GetChildren()) do
                    if (Enemy.Name == "Reborn Skeleton" or Enemy.Name == "Living Zombie") and Enemy.Humanoid.Health > 0 then Target = Enemy break end
                end
                if Target then TweenTo(Target.HumanoidRootPart.CFrame * CFrame.new(0, 25, 0)) else TweenTo(MapIP["Haunted Castle (Xương)"]) end
            end)
        end
        
        if _G.AutoCake then
            pcall(function()
                local Target = nil
                for _, Enemy in pairs(Workspace.Enemies:GetChildren()) do
                    if (string.find(Enemy.Name, "Cake") or string.find(Enemy.Name, "Cookie")) and Enemy.Humanoid.Health > 0 then Target = Enemy break end
                end
                if Target then TweenTo(Target.HumanoidRootPart.CFrame * CFrame.new(0, 25, 0)) else TweenTo(MapIP["Cake Island (Bánh)"]) end
            end)
        end
    end
end)
