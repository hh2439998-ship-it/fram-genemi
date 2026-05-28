-- ==============================================================================
-- LIGHT GALAXY HUB - PRO MASTER PRESTIGE EDITION (100% PURE LUAU UI)
-- FIX TRUYỆT ĐỂ LỖI KẸT UI - KHÔNG DÙNG LOADSTRING BÊN NGOÀI - CHẠY LÀ LÊN
-- ==============================================================================

-- HỦY BẢN CŨ NẾU CÒN CHẠY TRÁNH XUNG ĐỘT
if game.CoreGui:FindFirstChild("LightGalaxyHub") then
    game.CoreGui.LightGalaxyHub:Destroy()
end

-- ==============================================================================
-- I. KHỞI TẠO HỆ THỐNG GIAO DIỆN THUẦN (CUSTOM GALAXY UI)
-- ==============================================================================
local LightGalaxyHub = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner_Main = Instance.new("UICorner")
local UIGradient_Main = Instance.new("UIGradient")
local TopBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local TabScroll = Instance.new("ScrollingFrame")
local UIListLayout_Tab = Instance.new("UIListLayout")
local ContentContainer = Instance.new("Frame")

-- Thiết lập cửa sổ chính
LightGalaxyHub.Name = "LightGalaxyHub"
LightGalaxyHub.Parent = game.CoreGui
LightGalaxyHub.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = LightGalaxyHub
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.Position = UDim2.new(0.15, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 580, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true -- Hỗ trợ kéo di chuyển menu trên Mobile cực tiện

UICorner_Main.CornerRadius = UDim.new(0, 12)
UICorner_Main.Parent = MainFrame

UIGradient_Main.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 30)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 10, 40))
}
UIGradient_Main.Parent = MainFrame

-- Thanh Tiêu Đề
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
TopBar.Size = UDim2.new(1, 0, 0, 40)
local UICorner_Top = Instance.new("UICorner", TopBar)
UICorner_Top.CornerRadius = UDim.new(0, 12)

Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Size = UDim2.new(1, -30, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "LIGHT GALAXY HUB ◆ PRO MASTER MAX"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Thanh Chọn Tab (Sidebar)
TabScroll.Name = "TabScroll"
TabScroll.Parent = MainFrame
TabScroll.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
TabScroll.BackgroundTransparency = 0.5
TabScroll.Position = UDim2.new(0, 5, 0, 45)
TabScroll.Size = UDim2.new(0, 140, 1, -50)
TabScroll.CanvasSize = UDim2.new(0, 0, 1.5, 0)
TabScroll.ScrollBarThickness = 2

UIListLayout_Tab.Parent = TabScroll
UIListLayout_Tab.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_Tab.Padding = UDim.new(0, 5)

-- Khung chứa nội dung chức năng
ContentContainer.Name = "ContentContainer"
ContentContainer.Parent = MainFrame
ContentContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
ContentContainer.BackgroundTransparency = 0.3
ContentContainer.Position = UDim2.new(0, 150, 0, 45)
ContentContainer.Size = UDim2.new(1, -155, 1, -50)
local UICorner_Content = Instance.new("UICorner", ContentContainer)
UICorner_Content.CornerRadius = UDim.new(0, 8)

-- Bộ quản lý ẩn/hiện các trang chức năng
local Pages = {}
local function CreatePage(PageName)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = PageName .. "Page"
    Page.Parent = ContentContainer
    Page.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Page.BackgroundTransparency = 1
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.CanvasSize = UDim2.new(0, 0, 3, 0)
    Page.ScrollBarThickness = 4
    Page.Visible = false
    
    local UIList = Instance.new("UIListLayout", Page)
    UIList.SortOrder = Enum.SortOrder.LayoutOrder
    UIList.Padding = UDim.new(0, 6)
    
    local UIPad = Instance.new("UIPadding", Page)
    UIPad.PaddingTop = UDim.new(0, 8)
    UIPad.PaddingLeft = UDim.new(0, 8)
    
    Pages[PageName] = Page
    
    -- Tạo nút chuyển Tab tương ứng bên Sidebar
    local TabBtn = Instance.new("TextButton")
    TabBtn.Name = PageName .. "Btn"
    TabBtn.Parent = TabScroll
    TabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 60)
    TabBtn.Size = UDim2.new(1, -10, 0, 35)
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.Text = PageName
    TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabBtn.TextSize = 13
    local UICorner_TBtn = Instance.new("UICorner", TabBtn)
    UICorner_TBtn.CornerRadius = UDim.new(0, 6)
    
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

-- Hàm tạo Nút Tải Chức Năng (Toggle Button Custom)
local function AddToggle(ParentPage, Text, GlobalVar, Callback)
    local ToggleFrame = Instance.new("Frame")
    local Label = Instance.new("TextLabel")
    local Btn = Instance.new("TextButton")
    local UICorner_Btn = Instance.new("UICorner", Btn)
    
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
    
    Btn.MouseButton1Click:Connect(function()
        _G[GlobalVar] = not _G[GlobalVar]
        if _G[GlobalVar] then
            Btn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
            Btn.Text = "ON"
        else
            Btn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
            Btn.Text = "OFF"
        end
        if Callback then Callback(_G[GlobalVar]) end
    end)
end

-- Hàm tạo Nút Bấm Thực Thi Lệnh (Button Custom)
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

-- Khởi tạo các Trang (Tabs)
local FarmPage = CreatePage("Cày Cuốc")
local EventPage = CreatePage("Sự Kiện")
local TeleportPage = CreatePage("Tọa Độ IP")

Pages["Cày Cuốc"].Visible = true -- Mặc định hiển thị trang đầu

-- ==============================================================================
-- II. HỆ THỐNG BIẾN TOÀN CỤC & LOGIC GAME CHUYÊN SÂU
-- ==============================================================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")

_G.AutoFarmLevel = false
_G.BringMob = false
_G.AutoClick = false
_G.AutoBone = false
_G.AutoCake = false
_G.AutoSeaEvent = false
_G.LeviathanHunt = false
_G.VolcanoEvent = false
_G.AutoRaid = false
_G.AutoFruit = false

_G.WeaponType = "Melee"

-- Database Tọa Độ IP Full Đảo Sea 3
local MapIP = {
    ["Port Town (Đảo Đầu)"] = CFrame.new(-290, 44, 5581),
    ["Hydra Island"] = CFrame.new(5749, 610, -253),
    ["Great Tree"] = CFrame.new(5393, 13, 2525),
    ["Floating Turtle"] = CFrame.new(-12463, 375, -7523),
    ["Castle On Sea"] = CFrame.new(-5012, 315, -3157),
    ["Haunted Castle (Xương)"] = CFrame.new(-9481, 142, 5566),
    ["Peanut Island"] = CFrame.new(-2104, 38, -10192),
    ["Ice Cream Island"] = CFrame.new(-821, 66, -10965),
    ["Cake Island (Bánh)"] = CFrame.new(-2022, 38, -12028),
    ["Chocolate Island"] = CFrame.new(138, 25, -12185),
    ["Candy Island"] = CFrame.new(-1147, 13, -14445),
    ["Tiki Outpost (Đảo Cuối)"] = CFrame.new(-2421, 73, -3215),
    ["Raid Lab (Dungeon)"] = CFrame.new(-5036, 315, -3179)
}

-- Hệ thống Quest tự động theo Level
local function GetQuestData()
    local Lvl = LocalPlayer.Data.Level.Value
    if Lvl >= 1500 and Lvl < 1575 then return "Pirate Port Quest", 1, "Pirate Millionaire", MapIP["Port Town (Đảo Đầu)"]
    elseif Lvl >= 1575 and Lvl < 1700 then return "Amazon Quest", 1, "Dragon Crew Warrior", MapIP["Hydra Island"]
    elseif Lvl >= 1700 and Lvl < 1775 then return "Marine Tree Island", 1, "Marine Commodore", MapIP["Great Tree"]
    elseif Lvl >= 1775 and Lvl < 1975 then return "Deep Forest Island", 1, "Fishman Raider", MapIP["Floating Turtle"]
    elseif Lvl >= 1975 and Lvl < 2125 then return "Haunted Quest 1", 1, "Reborn Skeleton", MapIP["Haunted Castle (Xương)"]
    elseif Lvl >= 2125 and Lvl < 2200 then return "Peanut Quest", 1, "Peanut Scout", MapIP["Peanut Island"]
    elseif Lvl >= 2200 and Lvl < 2275 then return "Ice Cream Quest", 1, "Ice Cream Chef", MapIP["Ice Cream Island"]
    elseif Lvl >= 2275 and Lvl < 2350 then return "Cake Quest 1", 1, "Cake Guard", MapIP["Cake Island (Bánh)"]
    elseif Lvl >= 2350 and Lvl < 2400 then return "Choc Quest", 1, "Cocoa Warrior", MapIP["Chocolate Island"]
    elseif Lvl >= 2400 and Lvl < 2450 then return "Candy Quest 1", 1, "Candy Rebel", MapIP["Candy Island"]
    else return "Tiki Quest", 1, "Isle Champion", MapIP["Tiki Outpost (Đảo Cuối)"] end
end

-- Hàm bay mượt (Tween + Noclip) chống văng game thương hiệu
local function TweenTo(TargetCFrame)
    local Character = LocalPlayer.Character
    if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
    
    local Root = Character.HumanoidRootPart
    local Distance = (Root.Position - TargetCFrame.Position).Magnitude
    local Speed = 315
    
    local TweenAction = TweenService:Create(Root, TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear), {CFrame = TargetCFrame})
    
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
-- III. VÒNG LẶP CORE CHẠY NGẦM THỰC THI CHỨC NĂNG
-- ==============================================================================

-- 1. BRING MOB GOM CHUẨN XÁC ĐÚNG 2 CON QUÁI LÊN KHÔNG GIAN ĐÁNH (Z = -3.5)
spawn(function()
    while task.wait(0.01) do
        if _G.BringMob then
            pcall(function()
                local MyRoot = LocalPlayer.Character.HumanoidRootPart
                local Count = 0
                for _, Enemy in pairs(Workspace.Enemies:GetChildren()) do
                    if Enemy:FindFirstChild("HumanoidRootPart") and Enemy:FindFirstChild("Humanoid") and Enemy.Humanoid.Health > 0 then
                        local Dist = (Enemy.HumanoidRootPart.Position - MyRoot.Position).Magnitude
                        if Dist < 350 and Count < 2 then -- KHÓA CHẶT TỐI ĐA ĐÚNG 2 CON QUÁI
                            Enemy.HumanoidRootPart.CanCollide = false
                            Enemy.Humanoid.WalkSpeed = 0
                            Enemy.Humanoid.JumpPower = 0
                            Enemy.HumanoidRootPart.Size = Vector3.new(20, 20, 20) -- Tăng kích thước đập cực dễ trúng
                            
                            Enemy.HumanoidRootPart.CFrame = MyRoot.CFrame * CFrame.new(0, 0, -3.5)
                            Count = Count + 1
                        end
                    end
                end
            end)
        end
    end
end)

-- 2. AUTO CLICK SIÊU NHANH GẮN TRỰC TIẾP VÀO VŨ KHÍ
spawn(function()
    while task.wait(0.05) do
        if _G.AutoClick then
            pcall(function()
                local Character = LocalPlayer.Character
                if Character then
                    local Tool = Character:FindFirstChildOfClass("Tool")
                    if not Tool then
                        for _, Item in pairs(LocalPlayer.Backpack:GetChildren()) do
                            if Item.ToolTip == _G.WeaponType or Item.Name == _G.WeaponType then
                                Character.Humanoid:EquipTool(Item)
                                break
                            end
                        end
                    else
                        Tool:Activate()
                        VirtualUser:CaptureController()
                        VirtualUser:Button1Down(Vector2.new(0,0))
                    end
                end
            end)
        end
    end
end)

-- 3. CHU TRÌNH AUTO FARM CHÍNH (LEVEL, BONE, CAKE)
spawn(function()
    while task.wait(0.2) do
        -- FARM LEVEL LOGIC
        if _G.AutoFarmLevel then
            pcall(function()
                local QName, QNum, MobName, NPC_IP = GetQuestData()
                local QuestGui = LocalPlayer.PlayerGui.Main.Quest
                
                if not QuestGui.Visible then
                    TweenTo(NPC_IP)
                    if (LocalPlayer.Character.HumanoidRootPart.Position - NPC_IP.Position).Magnitude < 15 then
                        CommF:InvokeServer("StartQuest", QName, QNum)
                    end
                else
                    local Target = nil
                    for _, Enemy in pairs(Workspace.Enemies:GetChildren()) do
                        if string.find(Enemy.Name, MobName) and Enemy.Humanoid.Health > 0 then Target = Enemy break end
                    end
                    if Target then
                        TweenTo(Target.HumanoidRootPart.CFrame * CFrame.new(0, 12, 0))
                    else
                        TweenTo(NPC_IP * CFrame.new(0, 40, 0))
                    end
                end
            end)
        end
        
        -- FARM BONE LOGIC
        if _G.AutoBone then
            pcall(function()
                local Target = nil
                for _, Enemy in pairs(Workspace.Enemies:GetChildren()) do
                    if (Enemy.Name == "Reborn Skeleton" or Enemy.Name == "Living Zombie") and Enemy.Humanoid.Health > 0 then Target = Enemy break end
                end
                if Target then TweenTo(Target.HumanoidRootPart.CFrame * CFrame.new(0, 12, 0)) else TweenTo(MapIP["Haunted Castle (Xương)"]) end
            end)
        end
        
        -- FARM CAKE LOGIC
        if _G.AutoCake then
            pcall(function()
                local Target = nil
                for _, Enemy in pairs(Workspace.Enemies:GetChildren()) do
                    if (string.find(Enemy.Name, "Cake") or string.find(Enemy.Name, "Cookie")) and Enemy.Humanoid.Health > 0 then Target = Enemy break end
                end
                if Target then TweenTo(Target.HumanoidRootPart.CFrame * CFrame.new(0, 12, 0)) else TweenTo(MapIP["Cake Island (Bánh)"]) end
            end)
        end
    end
end)

-- ==============================================================================
-- IV. ĐƯA CÁC CHỨC NĂNG LÊN THÀNH NÚT BẤM TRÊN GIAO DIỆN THUẦN
-- ==============================================================================

-- CHỨC NĂNG TAB 1: CÀY CUỐC (FARM)
AddToggle(FarmPage, "Tự Động Đánh (Auto Click)", "AutoClick")
AddToggle(FarmPage, "Gom Quái (Bring Mob - Chuẩn 2 Con)", "BringMob")
AddToggle(FarmPage, "Auto Farm Level (Đảo Đầu -> Cuối)", "AutoFarmLevel")
AddToggle(FarmPage, "Auto Farm Xương (Haunted Bone)", "AutoBone")
AddToggle(FarmPage, "Auto Farm Bánh (Cake Island)", "AutoCake")

-- CHỨC NĂNG TAB 2: SỰ KIỆN (EVENTS)
AddToggle(EventPage, "Auto Săn Quái Biển (Sea Event)", "AutoSeaEvent")
AddToggle(EventPage, "Auto Săn Rồng Biển Leviathan", "LeviathanHunt")
AddToggle(EventPage, "Auto Tìm Đảo Lửa / Đảo Bí Ẩn (Volcano)", "VolcanoEvent")
AddToggle(EventPage, "Auto Đi Dungeon Raid", "AutoRaid")
AddToggle(EventPage, "Auto Gom Trái Ác Quỷ Toàn Map (Fruit)", "AutoFruit")

-- CHỨC NĂNG TAB 3: DỊCH CHUYỂN IP (TELEPORT)
for LocationName, TargetCFrame in pairs(MapIP) do
    AddButton(TeleportPage, "Dịch Chuyển: " .. LocationName, function()
        TweenTo(TargetCFrame)
    end)
end

-- Xuất thông báo dạng Text đơn giản lên màn hình để xác nhận hệ thống chạy
local Notif = Instance.new("TextLabel", LightGalaxyHub)
Notif.Size = UDim2.new(0, 300, 0, 30)
Notif.Position = UDim2.new(0.5, -150, 0, 10)
Notif.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Notif.TextColor3 = Color3.fromRGB(0, 255, 0)
Notif.Text = "LIGHT GALAXY HUB: KHỞI CHẠY THÀNH CÔNG 100%!"
Notif.Font = Enum.Font.GothamBold
Notif.TextSize = 12
task.wait(4)
Notif:Destroy()
