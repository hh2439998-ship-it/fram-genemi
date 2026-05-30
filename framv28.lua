-- ==============================================================================
-- LIGHT GALAXY HUB ◆ V17 OVERLORD (FULL CHỨC NĂNG - PVP - PORTAL BYPASS)
-- ==============================================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local VIM = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer
local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")

-- [TỰ ĐỘNG CHỌN PHE VÀ ĐỊNH VỊ SEA]
pcall(function() if not LocalPlayer.Team then CommF:InvokeServer("SetTeam", "Pirates") end end)
local World1, World2, World3 = false, false, false
if game.PlaceId == 2753915549 or game.PlaceId == 85211729168715 then World1 = true
elseif game.PlaceId == 4442272183 or game.PlaceId == 79091703265657 then World2 = true
elseif game.PlaceId == 7449423635 or game.PlaceId == 100117331123089 then World3 = true end

-- [NÚT ẨN/HIỆN UI DI ĐỘNG]
local UI_Parent = game:GetService("CoreGui")
if not UI_Parent or pcall(function() local a = UI_Parent.Name end) == false then UI_Parent = LocalPlayer:WaitForChild("PlayerGui") end
if UI_Parent:FindFirstChild("LightGalaxyHub") then UI_Parent.LightGalaxyHub:Destroy() end

local Hub = Instance.new("ScreenGui", UI_Parent) Hub.Name = "LightGalaxyHub" Hub.ResetOnSpawn = false

local ToggleBtn = Instance.new("TextButton", Hub)
ToggleBtn.Size = UDim2.new(0, 45, 0, 45) ToggleBtn.Position = UDim2.new(0, 10, 0.5, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 255) ToggleBtn.Text = "ẨN"
ToggleBtn.Font = Enum.Font.GothamBold ToggleBtn.TextSize = 12
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

-- [KHUNG BẢNG ĐIỀU KHIỂN CHÍNH]
local Main = Instance.new("Frame", Hub) Main.Size = UDim2.new(0, 550, 0, 340) Main.Position = UDim2.new(0.2, 0, 0.2, 0) Main.BackgroundColor3 = Color3.fromRGB(15, 15, 25) Main.Active = true Main.Draggable = true Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
local Top = Instance.new("Frame", Main) Top.Size = UDim2.new(1, 0, 0, 40) Top.BackgroundColor3 = Color3.fromRGB(30, 30, 50) Instance.new("UICorner", Top).CornerRadius = UDim.new(0, 10)
local Title = Instance.new("TextLabel", Top) Title.Size = UDim2.new(1, -30, 1, 0) Title.Position = UDim2.new(0, 15, 0, 0) Title.BackgroundTransparency = 1 Title.Font = Enum.Font.GothamBold Title.Text = "LIGHT GALAXY HUB ◆ V17 OVERLORD" Title.TextColor3 = Color3.fromRGB(0, 255, 255) Title.TextSize = 14 Title.TextXAlignment = Enum.TextXAlignment.Left

ToggleBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    ToggleBtn.Text = Main.Visible and "ẨN" or "MỞ"
end)

local TabSc = Instance.new("ScrollingFrame", Main) TabSc.Size = UDim2.new(0, 140, 1, -50) TabSc.Position = UDim2.new(0, 5, 0, 45) TabSc.BackgroundTransparency = 1 TabSc.ScrollBarThickness = 2 Instance.new("UIListLayout", TabSc).Padding = UDim.new(0, 4)
local Cont = Instance.new("Frame", Main) Cont.Size = UDim2.new(1, -155, 1, -50) Cont.Position = UDim2.new(0, 150, 0, 45) Cont.BackgroundColor3 = Color3.fromRGB(20, 20, 35) Instance.new("UICorner", Cont).CornerRadius = UDim.new(0, 8)

local Pages = {}
local function CreatePage(Name)
    local Pg = Instance.new("ScrollingFrame", Cont) Pg.Size = UDim2.new(1, 0, 1, 0) Pg.CanvasSize = UDim2.new(0, 0, 4, 0) Pg.BackgroundTransparency = 1 Pg.ScrollBarThickness = 4 Pg.Visible = false
    local Lyt = Instance.new("UIListLayout", Pg) Lyt.Padding = UDim.new(0, 6) local Pad = Instance.new("UIPadding", Pg) Pad.PaddingTop = UDim.new(0, 6) Pad.PaddingLeft = UDim.new(0, 6) Pages[Name] = Pg
    local Btn = Instance.new("TextButton", TabSc) Btn.Size = UDim2.new(1, -10, 0, 32) Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 60) Btn.Font = Enum.Font.GothamSemibold Btn.Text = Name Btn.TextColor3 = Color3.fromRGB(200, 200, 200) Btn.TextSize = 11 Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    Btn.MouseButton1Click:Connect(function() for _, p in pairs(Pages) do p.Visible = false end Pg.Visible = true for _, b in pairs(TabSc:GetChildren()) do if b:IsA("TextButton") then b.TextColor3 = Color3.fromRGB(200, 200, 200) b.BackgroundColor3 = Color3.fromRGB(35, 35, 60) end end Btn.TextColor3 = Color3.fromRGB(0, 255, 255) Btn.BackgroundColor3 = Color3.fromRGB(50, 40, 90) end)
    return Pg
end

local function AddToggle(Pg, Txt, Var)
    _G[Var] = false
    local Frm = Instance.new("Frame", Pg) Frm.Size = UDim2.new(1, -12, 0, 38) Frm.BackgroundColor3 = Color3.fromRGB(30, 30, 50) Instance.new("UICorner", Frm).CornerRadius = UDim.new(0, 6)
    local Lbl = Instance.new("TextLabel", Frm) Lbl.Size = UDim2.new(0.7, 0, 1, 0) Lbl.Position = UDim2.new(0, 10, 0, 0) Lbl.BackgroundTransparency = 1 Lbl.Font = Enum.Font.Gotham Lbl.Text = Txt Lbl.TextColor3 = Color3.fromRGB(255, 255, 255) Lbl.TextSize = 12 Lbl.TextXAlignment = Enum.TextXAlignment.Left
    local Btn = Instance.new("TextButton", Frm) Btn.Size = UDim2.new(0, 45, 0, 22) Btn.Position = UDim2.new(1, -55, 0, 8) Btn.BackgroundColor3 = Color3.fromRGB(150, 50, 50) Btn.Font = Enum.Font.GothamBold Btn.Text = "OFF" Btn.TextColor3 = Color3.fromRGB(255, 255, 255) Btn.TextSize = 10 Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)
    Btn.MouseButton1Click:Connect(function() _G[Var] = not _G[Var] Btn.BackgroundColor3 = _G[Var] and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50) Btn.Text = _G[Var] and "ON" or "OFF" end)
end
-- LIGHT GALAXY HUB V17 - PHẦN 2

local pFarm = CreatePage("Auto Farm Level")
local pRaid = CreatePage("Raid & Trái Cây")
local pSea = CreatePage("Săn Tiền & Biển")
local pPvP = CreatePage("PvP Siêu Cấp")
local pHack = CreatePage("ESP & Hệ Thống")
Pages["Auto Farm Level"].Visible = true

-- Cấu hình mặc định biến toàn cục
_G.FastAttackRedz = true; _G.BringMobSafe = true; _G.AutoFarmLevel = false; _G.AutoBone = false; _G.AutoRaid = false
_G.AutoBuyChip = false; _G.StartRaidAfar = false; _G.AutoFruit = false; _G.AutoSeaMoney = false; _G.AutoSeaEvent = false
_G.AutoV3 = false; _G.AutoV4 = false; _G.ESPPlayer = false; _G.ESPChest = false; _G.AutoRejoin30m = true
_G.KillPlayer = false; _G.SilentAimSelect = false; _G.SilentAimNearest = false; _G.SelectPlayer = ""

AddToggle(pFarm, "Bypass Fast Attack (Redz)", "FastAttackRedz")
AddToggle(pFarm, "Gom Quái Siêu Mượt (8m)", "BringMobSafe")
AddToggle(pFarm, "Auto Farm Level (Max 2550)", "AutoFarmLevel")
AddToggle(pFarm, "Auto Farm Xương (Đảo Ám)", "AutoBone")

AddToggle(pRaid, "Auto Mua Chip Từ Xa", "AutoBuyChip")
AddToggle(pRaid, "Tự Bật Raid Từ Xa (Bấm Nút)", "StartRaidAfar")
AddToggle(pRaid, "Auto Đi Phụ Bản (Raid)", "AutoRaid")
AddToggle(pRaid, "Auto Gom & Cất Trái Ác Quỷ", "AutoFruit")

AddToggle(pSea, "Auto Tiền Biển (Sea Beast Cấp 6)", "AutoSeaMoney")
AddToggle(pSea, "Auto Sự Kiện Biển (Shark/Piranha)", "AutoSeaEvent")
AddToggle(pSea, "Auto Nút Tộc V3", "AutoV3")
AddToggle(pSea, "Auto Hóa Tộc V4", "AutoV4")

-- Giao diện PvP nâng cấp theo yêu cầu
AddToggle(pPvP, "Bật Auto Bay Diệt Người Chơi", "KillPlayer")
AddToggle(pPvP, "Silent Aim: Chỉ Người Được Chọn", "SilentAimSelect")
AddToggle(pPvP, "Silent Aim: Người Gần Nhất", "SilentAimNearest")

local TargetLbl = Instance.new("TextLabel", pPvP) TargetLbl.Size = UDim2.new(1, -12, 0, 20) TargetLbl.BackgroundTransparency = 1 TargetLbl.Font = Enum.Font.GothamBold TargetLbl.Text = "MỤC TIÊU: CHƯA CHỌN" TargetLbl.TextColor3 = Color3.fromRGB(0, 255, 255) TargetLbl.TextSize = 11 TargetLbl.TextXAlignment = Enum.TextXAlignment.Left
local RefBtn = Instance.new("TextButton", pPvP) RefBtn.Size = UDim2.new(1, -12, 0, 26) RefBtn.BackgroundColor3 = Color3.fromRGB(45, 140, 90) RefBtn.Font = Enum.Font.GothamBold RefBtn.Text = "LÀM MỚI DANH SÁCH NGƯỜI CHƠI" RefBtn.TextColor3 = Color3.fromRGB(255, 255, 255) RefBtn.TextSize = 11 Instance.new("UICorner", RefBtn).CornerRadius = UDim.new(0, 4)
local PScroll = Instance.new("ScrollingFrame", pPvP) PScroll.Size = UDim2.new(1, -12, 0, 100) PScroll.CanvasSize = UDim2.new(0, 0, 6, 0) PScroll.BackgroundTransparency = 0.9 PScroll.ScrollBarThickness = 3 local PLyt = Instance.new("UIListLayout", PScroll) PLyt.Padding = UDim.new(0, 3)

local function RefreshPlrs()
    for _, child in pairs(PScroll:GetChildren()) do if child:IsA("TextButton") then child:Destroy() end end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local pBtn = Instance.new("TextButton", PScroll) pBtn.Size = UDim2.new(1, 0, 0, 22) pBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60) pBtn.Font = Enum.Font.Gotham pBtn.Text = p.Name pBtn.TextColor3 = Color3.fromRGB(255, 255, 255) pBtn.TextSize = 11 Instance.new("UICorner", pBtn).CornerRadius = UDim.new(0, 4)
            pBtn.MouseButton1Click:Connect(function() _G.SelectPlayer = p.Name TargetLbl.Text = "MỤC TIÊU CẬP NHẬT: " .. p.Name:upper() end)
        end
    end
end
RefBtn.MouseButton1Click:Connect(RefreshPlrs) RefreshPlrs()

AddToggle(pHack, "ESP Người Chơi", "ESPPlayer")
AddToggle(pHack, "ESP Rương Báu", "ESPChest")
AddToggle(pHack, "Chống Admin Server Hop 30 Phút", "AutoRejoin30m")

-- [HÀM BAY TWEEN CHUẨN MƯỢT]
local function TweenTo(TargetCFrame)
    local Char = LocalPlayer.Character if not Char or not Char:FindFirstChild("HumanoidRootPart") then return end
    local Root = Char.HumanoidRootPart Root.Velocity = Vector3.new(0, 0, 0)
    local TweenAction = TweenService:Create(Root, TweenInfo.new((Root.Position - TargetCFrame.Position).Magnitude / 350, Enum.EasingStyle.Linear), {CFrame = TargetCFrame})
    local Noclip = RunService.Stepped:Connect(function()
        if Char and Char:FindFirstChild("HumanoidRootPart") then
            for _, P in pairs(Char:GetChildren()) do if P:IsA("BasePart") then P.CanCollide = false end end
        end
    end)
    TweenAction:Play() TweenAction.Completed:Wait() Noclip:Disconnect() Root.CanCollide = true
end

-- [CƠ CHẾ DỊCH CHUYỂN CỔNG THÔNG MINH - BYPASS RIP INDRA]
local function SmartTween(TargetCFrame)
    local Char = LocalPlayer.Character if not Char or not Char:FindFirstChild("HumanoidRootPart") then return end
    local Root = Char.HumanoidRootPart
    local Distance = (Root.Position - TargetCFrame.Position).Magnitude

    if World3 and Distance > 4000 then
        local Portals = { Castle = Vector3.new(-50, 300, -10), Mansion = Vector3.new(-12463, 331, -7552), Hydra = Vector3.new(5228, 1004, 323) }
        local BestPortal = nil local MinD = Distance
        for Name, Pos in pairs(Portals) do
            local d = (TargetCFrame.Position - Pos).Magnitude
            if d < MinD then MinD = d BestPortal = Name end
        end
        if BestPortal then
            pcall(function() CommF:InvokeServer("PortalTeleport", BestPortal) end)
            task.wait(0.5)
        end
    end
    TweenTo(TargetCFrame)
end

function GetQuestData()
    local Lvl = LocalPlayer.Data.Level.Value
    if World1 then
        if Lvl >= 1 and Lvl <= 9 then return "BanditQuest1", 1, "Bandit", CFrame.new(1059.37, 15.44, 1550.42), CFrame.new(1045.96, 27.00, 1560.82)
        elseif Lvl >= 10 and Lvl <= 14 then return "JungleQuest", 1, "Monkey", CFrame.new(-1598.08, 35.55, 153.37), CFrame.new(-1448.51, 67.85, 11.46)
        elseif Lvl >= 15 and Lvl <= 29 then return "JungleQuest", 2, "Gorilla", CFrame.new(-1598.08, 35.55, 153.37), CFrame.new(-1129.88, 40.46, -525.42)
        elseif Lvl >= 30 and Lvl <= 39 then return "BuggyQuest1", 1, "Pirate", CFrame.new(-1141.07, 4.10, 3831.54), CFrame.new(-1103.51, 13.75, 3896.09)
        elseif Lvl >= 40 and Lvl <= 59 then return "BuggyQuest1", 2, "Brute", CFrame.new(-1141.07, 4.10, 3831.54), CFrame.new(-1140.08, 14.80, 4322.92)
        elseif Lvl >= 60 and Lvl <= 74 then return "DesertQuest", 1, "Desert Bandit", CFrame.new(894.48, 5.14, 4392.43), CFrame.new(924.79, 6.44, 4481.58)
        elseif Lvl >= 75 and Lvl <= 89 then return "DesertQuest", 2, "Desert Officer", CFrame.new(894.48, 5.14, 4392.43), CFrame.new(1608.28, 8.61, 4371.00)
        elseif Lvl >= 90 and Lvl <= 99 then return "SnowQuest", 1, "Snow Bandit", CFrame.new(1389.74, 88.15, -1298.90), CFrame.new(1354.34, 87.27, -1393.94)
        elseif Lvl >= 100 and Lvl <= 119 then return "SnowQuest", 2, "Snowman", CFrame.new(1389.74, 88.15, -1298.90), CFrame.new(1201.64, 144.57, -1550.06)
        elseif Lvl >= 120 and Lvl <= 149 then return "MarineQuest2", 1, "Chief Petty Officer", CFrame.new(-5039.58, 27.35, 4324.68), CFrame.new(-4881.23, 22.65, 4273.75)
        elseif Lvl >= 150 and Lvl <= 174 then return "SkyQuest", 1, "Sky Bandit", CFrame.new(-4839.53, 716.36, -2619.44), CFrame.new(-4953.20, 295.74, -2899.22)
        elseif Lvl >= 175 and Lvl <= 189 then return "SkyQuest", 2, "Dark Master", CFrame.new(-4839.53, 716.36, -2619.44), CFrame.new(-5259.84, 391.39, -2229.03)
        elseif Lvl >= 190 and Lvl <= 209 then return "PrisonerQuest", 1, "Prisoner", CFrame.new(5308.93, 1.65, 475.12), CFrame.new(5098.97, -0.32, 474.23)
        elseif Lvl >= 210 and Lvl <= 249 then return "PrisonerQuest", 2, "Dangerous Prisoner", CFrame.new(5308.93, 1.65, 475.12), CFrame.new(5654.56, 15.63, 866.29)
        elseif Lvl >= 250 and Lvl <= 274 then return "ColosseumQuest", 1, "Toga Warrior", CFrame.new(-1580.04, 6.35, -2986.47), CFrame.new(-1820.21, 51.68, -2740.66)
        elseif Lvl >= 275 and Lvl <= 299 then return "ColosseumQuest", 2, "Gladiator", CFrame.new(-1580.04, 6.35, -2986.47), CFrame.new(-1292.83, 56.38, -3339.03)
        elseif Lvl >= 300 and Lvl <= 324 then return "MagmaQuest", 1, "Military Soldier", CFrame.new(-5313.37, 10.95, 8515.29), CFrame.new(-5411.16, 11.08, 8454.29)
        elseif Lvl >= 325 and Lvl <= 374 then return "MagmaQuest", 2, "Military Spy", CFrame.new(-5313.37, 10.95, 8515.29), CFrame.new(-5802.86, 86.26, 8828.85)
        elseif Lvl >= 375 and Lvl <= 399 then return "FishmanQuest", 1, "Fishman Warrior", CFrame.new(61122.65, 18.49, 1569.39), CFrame.new(60878.30, 18.48, 1543.75)
        elseif Lvl >= 400 and Lvl <= 449 then return "FishmanQuest", 2, "Fishman Commando", CFrame.new(61122.65, 18.49, 1569.39), CFrame.new(61922.63, 18.48, 1493.93)
        elseif Lvl >= 450 and Lvl <= 474 then return "SkyExp1Quest", 1, "God's Guard", CFrame.new(-4721.88, 843.87, -1949.96), CFrame.new(-4710.04, 845.27, -1927.30)
        elseif Lvl >= 475 and Lvl <= 524 then return "SkyExp1Quest", 2, "Shanda", CFrame.new(-7859.09, 5544.19, -381.47), CFrame.new(-7678.48, 5566.40, -497.21)
        elseif Lvl >= 525 and Lvl <= 549 then return "SkyExp2Quest", 1, "Royal Squad", CFrame.new(-7906.81, 5634.66, -1411.99), CFrame.new(-7624.25, 5658.13, -1467.35)
        elseif Lvl >= 550 and Lvl <= 624 then return "SkyExp2Quest", 2, "Royal Soldier", CFrame.new(-7906.81, 5634.66, -1411.99), CFrame.new(-7836.75, 5645.66, -1790.62)
        elseif Lvl >= 625 and Lvl <= 649 then return "FountainQuest", 1, "Galley Pirate", CFrame.new(5259.81, 37.35, 4050.02), CFrame.new(5551.02, 78.90, 3930.41)
        else return "FountainQuest", 2, "Galley Captain", CFrame.new(5259.81, 37.35, 4050.02), CFrame.new(5441.95, 42.50, 4950.09) end
    elseif World2 then
        if Lvl >= 700 and Lvl <= 724 then return "Area1Quest", 1, "Raider", CFrame.new(-429.54, 71.76, 1836.18), CFrame.new(-728.32, 52.77, 2345.77)
        elseif Lvl >= 725 and Lvl <= 774 then return "Area1Quest", 2, "Mercenary", CFrame.new(-429.54, 71.76, 1836.18), CFrame.new(-1004.32, 80.15, 1424.61)
        elseif Lvl >= 775 and Lvl <= 799 then return "Area2Quest", 1, "Swan Pirate", CFrame.new(638.43, 71.76, 918.28), CFrame.new(1068.66, 137.61, 1322.10)
        elseif Lvl >= 800 and Lvl <= 874 then return "Area2Quest", 2, "Factory Staff", CFrame.new(632.69, 73.10, 918.66), CFrame.new(73.07, 81.86, -27.47)
        elseif Lvl >= 875 and Lvl <= 899 then return "MarineQuest3", 1, "Marine Lieutenant", CFrame.new(-2440.79, 71.71, -3216.06), CFrame.new(-2821.37, 75.89, -3070.08)
        elseif Lvl >= 900 and Lvl <= 949 then return "MarineQuest3", 2, "Marine Captain", CFrame.new(-2440.79, 71.71, -3216.06), CFrame.new(-1861.23, 80.17, -3254.69)
        elseif Lvl >= 950 and Lvl <= 974 then return "ZombieQuest", 1, "Zombie", CFrame.new(-5497.06, 47.59, -795.23), CFrame.new(-5657.77, 78.96, -928.68)
        elseif Lvl >= 975 and Lvl <= 999 then return "ZombieQuest", 2, "Vampire", CFrame.new(-5497.06, 47.59, -795.23), CFrame.new(-6037.66, 32.18, -1340.65)
        elseif Lvl >= 1000 and Lvl <= 1049 then return "SnowMountainQuest", 1, "Snow Trooper", CFrame.new(609.85, 400.11, -5372.25), CFrame.new(549.14, 427.38, -5563.69)
        elseif Lvl >= 1050 and Lvl <= 1099 then return "SnowMountainQuest", 2, "Winter Warrior", CFrame.new(609.85, 400.11, -5372.25), CFrame.new(1142.74, 475.63, -5199.41)
        elseif Lvl >= 1100 and Lvl <= 1124 then return "IceSideQuest", 1, "Lab Subordinate", CFrame.new(-6064.06, 15.24, -4902.97), CFrame.new(-5707.47, 15.95, -4513.39)
        elseif Lvl >= 1125 and Lvl <= 1174 then return "IceSideQuest", 2, "Horned Warrior", CFrame.new(-6064.06, 15.24, -4902.97), CFrame.new(-6341.36, 15.95, -5723.16)
        elseif Lvl >= 1175 and Lvl <= 1199 then return "FireSideQuest", 1, "Magma Ninja", CFrame.new(-5428.03, 15.06, -5299.43), CFrame.new(-5449.67, 76.65, -5808.20)
        elseif Lvl >= 1200 and Lvl <= 1249 then return "FireSideQuest", 2, "Lava Pirate", CFrame.new(-5428.03, 15.06, -5299.43), CFrame.new(-5213.33, 49.73, -4701.45)
        elseif Lvl >= 1250 and Lvl <= 1274 then return "ShipQuest1", 1, "Ship Deckhand", CFrame.new(1037.80, 125.09, 32911.60), CFrame.new(1212.01, 150.79, 33059.24)
        elseif Lvl >= 1275 and Lvl <= 1299 then return "ShipQuest1", 2, "Ship Engineer", CFrame.new(1037.80, 125.09, 32911.60), CFrame.new(919.47, 43.54, 32779.96)
        elseif Lvl >= 1300 and Lvl <= 1324 then return "ShipQuest2", 1, "Ship Steward", CFrame.new(968.80, 125.09, 33244.12), CFrame.new(919.43, 129.55, 33436.03)
        elseif Lvl >= 1325 and Lvl <= 1349 then return "ShipQuest2", 2, "Ship Officer", CFrame.new(968.80, 125.09, 33244.12), CFrame.new(1036.01, 181.43, 33315.72)
        elseif Lvl >= 1350 and Lvl <= 1374 then return "FrostQuest", 1, "Arctic Warrior", CFrame.new(5667.65, 26.79, -6486.08), CFrame.new(5966.24, 62.97, -6179.38)
        elseif Lvl >= 1375 and Lvl <= 1424 then return "FrostQuest", 2, "Snow Lurker", CFrame.new(5667.65, 26.79, -6486.08), CFrame.new(5407.07, 69.19, -6880.88)
        elseif Lvl >= 1425 and Lvl <= 1449 then return "ForgottenQuest", 1, "Sea Soldier", CFrame.new(-3054.44, 235.54, -10142.81), CFrame.new(-3028.22, 64.67, -9775.42)
        else return "ForgottenQuest", 2, "Water Fighter", CFrame.new(-3054.44, 235.54, -10142.81), CFrame.new(-3352.90, 285.01, -10534.84) end
    elseif World3 then
        if Lvl >= 1500 and Lvl <= 1524 then return "PiratePortQuest", 1, "Pirate Millionaire", CFrame.new(-450.10, 107.68, 5950.72), CFrame.new(-245.99, 47.30, 5584.10)
        elseif Lvl >= 1525 and Lvl <= 1574 then return "PiratePortQuest", 2, "Pistol Billionaire", CFrame.new(-450.10, 107.68, 5950.72), CFrame.new(-54.81, 83.76, 5947.84)
        elseif Lvl >= 1575 and Lvl <= 1599 then return "DragonCrewQuest", 1, "Dragon Crew Warrior", CFrame.new(6750.49, 127.44, -711.03), CFrame.new(6709.76, 52.34, -1139.02)
        elseif Lvl >= 1600 and Lvl <= 1624 then return "DragonCrewQuest", 2, "Dragon Crew Archer", CFrame.new(6750.49, 127.44, -711.03), CFrame.new(6668.76, 481.37, 329.12)
        elseif Lvl >= 1625 and Lvl <= 1649 then return "VenomCrewQuest", 1, "Hydra Enforcer", CFrame.new(5206.40, 1004.10, 748.35), CFrame.new(4547.11, 1003.10, 334.19)
        elseif Lvl >= 1650 and Lvl <= 1699 then return "VenomCrewQuest", 2, "Venomous Assailant", CFrame.new(5206.40, 1004.10, 748.35), CFrame.new(4674.92, 1134.82, 996.30)
        elseif Lvl >= 1700 and Lvl <= 1724 then return "MarineTreeIsland", 1, "Marine Commodore", CFrame.new(2481.09, 74.27, -6779.64), CFrame.new(2577.25, 75.61, -7739.87)
        elseif Lvl >= 1725 and Lvl <= 1774 then return "MarineTreeIsland", 2, "Marine Rear Admiral", CFrame.new(2481.09, 74.27, -6779.64), CFrame.new(3761.81, 123.91, -6823.52)
        elseif Lvl >= 1775 and Lvl <= 1799 then return "DeepForestIsland3", 1, "Fishman Raider", CFrame.new(-10581.65, 330.87, -8761.18), CFrame.new(-10407.52, 331.76, -8368.51)
        elseif Lvl >= 1800 and Lvl <= 1824 then return "DeepForestIsland3", 2, "Fishman Captain", CFrame.new(-10581.65, 330.87, -8761.18), CFrame.new(-10994.70, 352.38, -9002.11)
        elseif Lvl >= 1825 and Lvl <= 1849 then return "DeepForestIsland", 1, "Forest Pirate", CFrame.new(-13234.04, 331.48, -7625.40), CFrame.new(-13274.47, 332.37, -7769.58)
        elseif Lvl >= 1850 and Lvl <= 1899 then return "DeepForestIsland", 2, "Mythological Pirate", CFrame.new(-13234.04, 331.48, -7625.40), CFrame.new(-13680.60, 501.08, -6991.18)
        elseif Lvl >= 1900 and Lvl <= 1924 then return "DeepForestIsland2", 1, "Jungle Pirate", CFrame.new(-12680.38, 389.97, -9902.01), CFrame.new(-12256.16, 331.73, -10485.83)
        elseif Lvl >= 1925 and Lvl <= 1974 then return "DeepForestIsland2", 2, "Musketeer Pirate", CFrame.new(-12680.38, 389.97, -9902.01), CFrame.new(-13457.90, 391.54, -9859.17)
        elseif Lvl >= 1975 and Lvl <= 1999 then return "HauntedQuest1", 1, "Reborn Skeleton", CFrame.new(-9479.21, 141.21, 5566.09), CFrame.new(-8763.72, 165.72, 6159.86)
        elseif Lvl >= 2000 and Lvl <= 2024 then return "HauntedQuest1", 2, "Living Zombie", CFrame.new(-9479.21, 141.21, 5566.09), CFrame.new(-10144.13, 138.62, 5838.08)
        elseif Lvl >= 2025 and Lvl <= 2049 then return "HauntedQuest2", 1, "Demonic Soul", CFrame.new(-9516.99, 172.01, 6078.46), CFrame.new(-9505.87, 172.10, 6158.99)
        elseif Lvl >= 2050 and Lvl <= 2074 then return "HauntedQuest2", 2, "Posessed Mummy", CFrame.new(-9516.99, 172.01, 6078.46), CFrame.new(-9582.02, 6.25, 6205.47)
        elseif Lvl >= 2075 and Lvl <= 2099 then return "NutsIslandQuest", 1, "Peanut Scout", CFrame.new(-2104.39, 38.10, -10194.21), CFrame.new(-2143.24, 47.72, -10029.99)
        elseif Lvl >= 2100 and Lvl <= 2124 then return "NutsIslandQuest", 2, "Peanut President", CFrame.new(-2104.39, 38.10, -10194.21), CFrame.new(-1859.35, 38.10, -10422.43)
        elseif Lvl >= 2125 and Lvl <= 2149 then return "IceCreamIslandQuest", 1, "Ice Cream Chef", CFrame.new(-820.64, 65.81, -10965.79), CFrame.new(-872.24, 65.81, -10919.95)
        elseif Lvl >= 2150 and Lvl <= 2199 then return "IceCreamIslandQuest", 2, "Ice Cream Commander", CFrame.new(-820.64, 65.81, -10965.79), CFrame.new(-558.06, 112.04, -11290.77)
        elseif Lvl >= 2200 and Lvl <= 2224 then return "CakeQuest1", 1, "Cookie Crafter", CFrame.new(-2021.32, 37.79, -12028.72), CFrame.new(-2374.13, 37.79, -12125.30)
        elseif Lvl >= 2225 and Lvl <= 2249 then return "CakeQuest1", 2, "Cake Guard", CFrame.new(-2021.32, 37.79, -12028.72), CFrame.new(-1598.30, 43.77, -12244.58)
        elseif Lvl >= 2250 and Lvl <= 2274 then return "CakeQuest2", 1, "Baking Staff", CFrame.new(-1927.91, 37.79, -12842.53), CFrame.new(-1887.80, 77.61, -12998.35)
        elseif Lvl >= 2275 and Lvl <= 2299 then return "CakeQuest2", 2, "Head Baker", CFrame.new(-1927.91, 37.79, -12842.53), CFrame.new(-2216.18, 82.88, -12869.29)
        elseif Lvl >= 2300 and Lvl <= 2324 then return "ChocQuest1", 1, "Cocoa Warrior", CFrame.new(233.22, 29.87, -12201.23), CFrame.new(-21.55, 80.57, -12352.38)
        elseif Lvl >= 2325 and Lvl <= 2349 then return "ChocQuest1", 2, "Chocolate Bar Battler", CFrame.new(233.22, 29.87, -12201.23), CFrame.new(582.59, 77.18, -12463.16)
        elseif Lvl >= 2350 and Lvl <= 2374 then return "ChocQuest2", 1, "Sweet Thief", CFrame.new(150.50, 30.69, -12774.50), CFrame.new(165.18, 76.05, -12600.83)
        elseif Lvl >= 2375 and Lvl <= 2399 then return "ChocQuest2", 2, "Candy Rebel", CFrame.new(150.50, 30.69, -12774.50), CFrame.new(134.86, 77.24, -12876.54)
        elseif Lvl >= 2400 and Lvl <= 2424 then return "CandyQuest1", 1, "Candy Pirate", CFrame.new(-1150.04, 20.37, -14446.33), CFrame.new(-1310.50, 26.01, -14562.40)
        elseif Lvl >= 2425 and Lvl <= 2449 then return "CandyQuest1", 2, "Snow Demon", CFrame.new(-1150.04, 20.37, -14446.33), CFrame.new(-880.20, 71.24, -14538.60)
        elseif Lvl >= 2450 and Lvl <= 2474 then return "TikiQuest1", 1, "Isle Outlaw", CFrame.new(-16547.74, 61.13, -173.41), CFrame.new(-16442.81, 116.13, -264.46)
        elseif Lvl >= 2475 and Lvl <= 2524 then return "TikiQuest1", 2, "Island Boy", CFrame.new(-16547.74, 61.13, -173.41), CFrame.new(-16901.26, 84.06, -192.88)
        elseif Lvl >= 2525 and Lvl <= 2550 then return "TikiQuest2", 1, "Isle Champion", CFrame.new(-16539.07, 55.68, 1051.57), CFrame.new(-16641.67, 235.78, 1031.28)
        else return "TikiQuest3", 1, "Serpent Hunter", CFrame.new(-16665.19, 104.59, 1579.69), CFrame.new(-16521.06, 106.09, 1488.78) end
    end
end
-- LIGHT GALAXY HUB V17 - PHẦN 3

local v1 = next local v2 = {ReplicatedStorage:WaitForChild("Util"), ReplicatedStorage:WaitForChild("Common"), ReplicatedStorage:WaitForChild("Remotes")}
local v3, u4, u5 = nil, nil, nil
task.spawn(function()
    while true do
        local v6 v3, v6 = v1(v2, v3) if v3 == nil then break end
        local v7 = next local v8, v9 = v6:GetChildren()
        while true do local v10 v9, v10 = v7(v8, v9) if v9 == nil then break end if v10:IsA('RemoteEvent') and v10:GetAttribute('Id') then u5 = v10:GetAttribute('Id') u4 = v10 end end
        v6.ChildAdded:Connect(function(p11) if p11:IsA('RemoteEvent') and p11:GetAttribute('Id') then u5 = p11:GetAttribute('Id') u4 = p11 end end)
    end
end)

-- [HÀM LẤY MỤC TIÊU SILENT AIM CHUẨN]
local function GetAimTarget()
    if _G.SilentAimSelect and _G.SelectPlayer ~= "" then
        local p = Players:FindFirstChild(_G.SelectPlayer)
        if p and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.Humanoid.Health > 0 then return p.Character end
    elseif _G.SilentAimNearest then
        local Near = nil local MinD = math.huge
        local MyRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if MyRoot then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.Humanoid.Health > 0 then
                    local d = (p.Character.HumanoidRootPart.Position - MyRoot.Position).Magnitude
                    if d < MinD then MinD = d Near = p.Character end
                end
            end
        end
        return Near
    end
    return nil
end

-- [UPGRADE FAST ATTACK: ĐÁNH NPC + ĐÁNH LUÔN PLAYER TRONG PVP]
task.spawn(function()
    while task.wait(0.01) do
        if _G.FastAttackRedz then
            pcall(function()
                local Char = LocalPlayer.Character if not Char or not Char:FindFirstChild('HumanoidRootPart') then return end
                local root = Char.HumanoidRootPart local u17 = {}
                
                -- Gom NPC quái vào bảng sát thương
                for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                    local eRoot = mob:FindFirstChild('HumanoidRootPart')
                    if eRoot and mob.Humanoid.Health > 0 and (eRoot.Position - root.Position).Magnitude <= 75 then
                        for _, part in ipairs(mob:GetChildren()) do if part:IsA('BasePart') then table.insert(u17, {mob, part}) end end
                    end
                end
                
                -- ÉP THÊM PLAYER PVP VÀO SÁT THƯƠNG GẦN KHÔNG PHÂN BIỆT
                if _G.KillPlayer and _G.SelectPlayer ~= "" then
                    local pTarget = Players:FindFirstChild(_G.SelectPlayer)
                    if pTarget and pTarget.Character and pTarget.Character:FindFirstChild("HumanoidRootPart") and pTarget.Character.Humanoid.Health > 0 then
                        local pRoot = pTarget.Character.HumanoidRootPart
                        if (pRoot.Position - root.Position).Magnitude <= 75 then
                            for _, part in ipairs(pTarget.Character:GetChildren()) do if part:IsA('BasePart') then table.insert(u17, {pTarget.Character, part}) end end
                        end
                    end
                end
                
                if #u17 > 0 then
                    require(ReplicatedStorage.Modules.Net):RemoteEvent('RegisterHit', true)
                    ReplicatedStorage.Modules.Net['RE/RegisterAttack']:FireServer()
                    if u4 then
                        local key = tostring(LocalPlayer.UserId):sub(2, 4) .. tostring(coroutine.running()):sub(11, 15)
                        ReplicatedStorage.Modules.Net['RE/RegisterHit']:FireServer(u17[1][1].HumanoidRootPart, u17, {}, key)
                        if cloneref then cloneref(u4):FireServer(string.gsub('RE/RegisterHit', '.', function(p) return string.char(bit32.bxor(string.byte(p), math.floor(workspace:GetServerTimeNow() / 10 % 10) + 1)) end), bit32.bxor(u5 + 909090, ReplicatedStorage.Modules.Net.seed:InvokeServer() * 2), u17[1][1].HumanoidRootPart, u17) end
                    end
                end
            end)
        end
    end
end)

-- [REAL GOM QUÁI 8 METERS]
task.spawn(function()
    while task.wait(0.1) do
        if _G.BringMobSafe then
            pcall(function()
                if sethiddenproperty then sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge) end
                local MyRoot = LocalPlayer.Character.HumanoidRootPart local Count = 0
                for _, Enemy in pairs(Workspace.Enemies:GetChildren()) do
                    if Enemy:FindFirstChild("HumanoidRootPart") and Enemy.Humanoid.Health > 0 and (Enemy.HumanoidRootPart.Position - MyRoot.Position).Magnitude < 350 and Count < 3 then
                        Enemy.Humanoid.PlatformStand = true Enemy.Humanoid.WalkSpeed = 0 Enemy.Humanoid.JumpPower = 0
                        Enemy.HumanoidRootPart.Size = Vector3.new(65, 65, 65) Enemy.HumanoidRootPart.CanCollide = false
                        Enemy.HumanoidRootPart.CFrame = MyRoot.CFrame * CFrame.new(0, -8, 0) Count = Count + 1
                    end
                end
            end)
        end
    end
end)

-- [BẺ CON TRỎ CHUỘT: SILENT AIM BẺ TẤT CẢ CHIÊU ĐỘNG VÀ CHIÊU DI CHUYỂN Z GOD/Z SOUL GUITAR]
local Mouse = LocalPlayer:GetMouse()
local Meta = getrawmetatable(game)
local OldIndex = Meta.__index
setreadonly(Meta, false)
Meta.__index = newcclosure(function(self, idx)
    if self == Mouse and (idx == "Hit" or idx == "CFrame") then
        local Target = GetAimTarget()
        if Target and Target:FindFirstChild("HumanoidRootPart") then return Target.HumanoidRootPart.CFrame end
    elseif self == Mouse and idx == "Position" then
        local Target = GetAimTarget()
        if Target and Target:FindFirstChild("HumanoidRootPart") then return Target.HumanoidRootPart.Position end
    end
    return OldIndex(self, idx)
end)
setreadonly(Meta, true)
-- LIGHT GALAXY HUB V17 - PHẦN 4

-- Chuyển thế giới tự động
task.spawn(function()
    while task.wait(5) do
        pcall(function()
            local Lvl = LocalPlayer.Data.Level.Value
            if World1 and Lvl >= 700 then CommF:InvokeServer("TravelDressrosa")
            elseif World2 and Lvl >= 1500 then CommF:InvokeServer("TravelZou") end
        end)
    end
end)

-- [VÒNG LẶP TREO MÁY CHÍNH TỔNG HỢP]
task.spawn(function()
    while task.wait(0.2) do
        -- 1. Tự Động Cày Cấp (Level)
        if _G.AutoFarmLevel and not _G.KillPlayer then
            pcall(function()
                local QName, QNum, MobName, NPC_IP, Mob_IP = GetQuestData()
                if not LocalPlayer.PlayerGui.Main.Quest.Visible then SmartTween(NPC_IP) if (LocalPlayer.Character.HumanoidRootPart.Position - NPC_IP.Position).Magnitude < 15 then CommF:InvokeServer("StartQuest", QName, QNum) end
                else
                    local Target = nil for _, Enemy in pairs(Workspace.Enemies:GetChildren()) do if string.find(Enemy.Name, MobName) and Enemy.Humanoid.Health > 0 then Target = Enemy break end end
                    if Target then SmartTween(Target.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)) else SmartTween(Mob_IP * CFrame.new(0, 45, 0)) end
                end
            end)
        end
        
        -- 2. Tự Động Farm Xương Đảo Ám
        if _G.AutoBone and not _G.KillPlayer then pcall(function() local Target = nil for _, Enemy in pairs(Workspace.Enemies:GetChildren()) do if (Enemy.Name == "Reborn Skeleton" or Enemy.Name == "Living Zombie") and Enemy.Humanoid.Health > 0 then Target = Enemy break end end if Target then SmartTween(Target.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)) else SmartTween(CFrame.new(-9481, 142, 5566)) end end) end
        
        -- 3. Xử Lý Vũ Khí Kèm Click Chuột Tự Động
        if _G.AutoFarmLevel or _G.AutoBone or _G.AutoRaid or _G.AutoSeaEvent or _G.KillPlayer then
            pcall(function()
                local Char = LocalPlayer.Character
                if Char and not Char:FindFirstChildOfClass("Tool") then
                    for _, T in pairs(LocalPlayer.Backpack:GetChildren()) do if T:IsA("Tool") and (T.ToolTip == "Melee" or T.ToolTip == "Sword") then Char.Humanoid:EquipTool(T) break end end
                end
                VirtualUser:CaptureController() VirtualUser:ClickButton1(Vector2.new(850, 850))
            end)
        end
    end
end)

-- [VÒNG LẶP THEO DÕI VÀ SĂN DIỆT NGƯỜI CHƠI (FLY PVP)]
task.spawn(function()
    while task.wait(0.1) do
        if _G.KillPlayer and _G.SelectPlayer ~= "" then
            pcall(function()
                local p = Players:FindFirstChild(_G.SelectPlayer)
                if p and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.Humanoid.Health > 0 then
                    -- Bay bám sát phía sau đầu đối thủ 5 studs để né chiêu và dồn Fast Attack
                    SmartTween(p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 5, 4))
                end
            end)
        end
    end
end)

-- [MUA CHIP, VÀO RAID TỪ XA & THU HOẠCH TRÁI]
task.spawn(function()
    while task.wait(1) do
        if _G.AutoBuyChip then pcall(function() CommF:InvokeServer("RaidsNpc", "Select", "Flame") end) end
        if _G.StartRaidAfar then
            pcall(function()
                if World2 then fireclickdetector(workspace.Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector) end
                if World3 then fireclickdetector(workspace.Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector) end
            end)
        end
        if _G.AutoRaid then
            pcall(function()
                local RaidIsland = nil for _, island in pairs(Workspace:GetChildren()) do if string.find(island.Name, "Island") then RaidIsland = island break end end
                if RaidIsland and RaidIsland:FindFirstChild("Hitbox") then SmartTween(RaidIsland.Hitbox.CFrame * CFrame.new(0, 40, 0)) end
                for _, mob in pairs(Workspace.Enemies:GetChildren()) do if mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then SmartTween(mob.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)) end end
            end)
        end
        if _G.AutoFruit then pcall(function() for _, f in pairs(Workspace:GetChildren()) do if f:IsA("Tool") and string.find(f.Name, "Fruit") and f:FindFirstChild("Handle") then SmartTween(f.Handle.CFrame) task.wait(0.5) CommF:InvokeServer("StoreFruit", f:GetAttribute("OriginalName") or f.Name, f) end end end) end
    end
end)

-- [SĂN TIỀN BIỂN VÀ HÓA TỘC V3/V4]
task.spawn(function()
    while task.wait(0.1) do
        if _G.AutoV3 then pcall(function() game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("ActivateAbility") end) end
        if _G.AutoV4 then pcall(function() local char = LocalPlayer.Character if char and char:FindFirstChild("RaceEnergy") and char.RaceEnergy.Value >= 1 and not char.RaceTransformed.Value then VIM:SendKeyEvent(true, Enum.KeyCode.Y, false, game) task.wait(0.1) VIM:SendKeyEvent(false, Enum.KeyCode.Y, false, game) end end) end
        
        if _G.AutoSeaMoney and (World2 or World3) then
            pcall(function()
                local SeaBeast = nil if Workspace:FindFirstChild("SeaBeasts") then for _, sb in pairs(Workspace.SeaBeasts:GetChildren()) do if sb:FindFirstChild("HumanoidRootPart") and sb.Humanoid.Health > 0 then SeaBeast = sb break end end end
                if SeaBeast then
                    SmartTween(SeaBeast.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0))
                    for _, key in ipairs({Enum.KeyCode.Z, Enum.KeyCode.X, Enum.KeyCode.C, Enum.KeyCode.V}) do VIM:SendKeyEvent(true, key, false, game) task.wait(0.05) VIM:SendKeyEvent(false, key, false, game) end
                else
                    local Sea6CFrame = CFrame.new(-30000, 100, 30000) if (LocalPlayer.Character.HumanoidRootPart.Position - Sea6CFrame.Position).Magnitude > 500 then SmartTween(Sea6CFrame) end
                end
            end)
        end
        if _G.AutoSeaEvent then pcall(function() for _, mob in pairs(Workspace.Enemies:GetChildren()) do if (mob.Name == "Shark" or mob.Name == "Piranha") and mob.Humanoid.Health > 0 then SmartTween(mob.HumanoidRootPart.CFrame * CFrame.new(0, 40, 0)) end end end) end
    end
end)

-- [HỆ THỐNG ESP CHEST & SERVER HOP]
task.spawn(function()
    while task.wait(1) do
        if _G.ESPChest then for _, c in pairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do if not c:FindFirstChild("ESPC") then local bg = Instance.new("BillboardGui", c) bg.Name = "ESPC" bg.Size = UDim2.new(0, 80, 0, 30) bg.AlwaysOnTop = true local txt = Instance.new("TextLabel", bg) txt.Size = UDim2.new(1,0,1,0) txt.BackgroundTransparency = 1 txt.TextColor3 = Color3.fromRGB(255, 200, 0) txt.TextScaled = true txt.Text = "Rương" end end else for _, c in pairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do if c:FindFirstChild("ESPC") then c.ESPC:Destroy() end end end
    end
end)

task.spawn(function()
    while task.wait(1800) do
        if _G.AutoRejoin30m then
            local svrs = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
            for _, s in pairs(svrs.data) do if s.playing < s.maxPlayers and s.id ~= game.JobId then TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id, LocalPlayer) break end end
        end
    end
end)

game.StarterGui:SetCore("SendNotification", {Title = "Light Galaxy Hub V17", Text = "Bản PvP Overlord đã sẵn sàng!", Duration = 5})
