-- LIGHT GALAXY HUB V30 PRO MAX - PHẦN 1/10
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")
local VIM = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer
local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
pcall(function() if not LocalPlayer.Team or (LocalPlayer.Team.Name ~= "Marines" and LocalPlayer.Team.Name ~= "Pirates") then CommF:InvokeServer("SetTeam", "Pirates") end end)

local UI_Parent = game:GetService("CoreGui")
if not UI_Parent or not pcall(function() local a = UI_Parent.Name end) then UI_Parent = LocalPlayer:WaitForChild("PlayerGui") end
if UI_Parent:FindFirstChild("LightGalaxyHub") then UI_Parent.LightGalaxyHub:Destroy() end

local Hub = Instance.new("ScreenGui", UI_Parent) Hub.Name = "LightGalaxyHub" Hub.ResetOnSpawn = false
local ToggleBtn = Instance.new("TextButton", Hub) ToggleBtn.Size = UDim2.new(0, 50, 0, 50) ToggleBtn.Position = UDim2.new(0, 15, 0.45, 0) ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255) ToggleBtn.Text = "ẨN UI" ToggleBtn.Font = Enum.Font.GothamBold ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255) ToggleBtn.TextSize = 12 Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
local Main = Instance.new("Frame", Hub) Main.Size = UDim2.new(0, 620, 0, 420) Main.Position = UDim2.new(0.5, -310, 0.5, -210) Main.BackgroundColor3 = Color3.fromRGB(15, 15, 22) Main.Draggable = true Main.Active = true Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
local Top = Instance.new("Frame", Main) Top.Size = UDim2.new(1, 0, 0, 40) Top.BackgroundColor3 = Color3.fromRGB(25, 25, 35) Instance.new("UICorner", Top).CornerRadius = UDim.new(0, 10)
local Title = Instance.new("TextLabel", Top) Title.Size = UDim2.new(1, -30, 1, 0) Title.Position = UDim2.new(0, 15, 0, 0) Title.BackgroundTransparency = 1 Title.Font = Enum.Font.GothamBold Title.Text = "LIGHT GALAXY HUB ◆ V30 PRO MAX" Title.TextColor3 = Color3.fromRGB(255, 255, 255) Title.TextSize = 14 Title.TextXAlignment = Enum.TextXAlignment.Left
ToggleBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible ToggleBtn.Text = Main.Visible and "ẨN UI" or "MỞ UI" end)
local TabSc = Instance.new("ScrollingFrame", Main) TabSc.Size = UDim2.new(0, 160, 1, -50) TabSc.Position = UDim2.new(0, 5, 0, 45) TabSc.BackgroundTransparency = 1 TabSc.ScrollBarThickness = 2 Instance.new("UIListLayout", TabSc).Padding = UDim.new(0, 5)
local Cont = Instance.new("Frame", Main) Cont.Size = UDim2.new(1, -175, 1, -50) Cont.Position = UDim2.new(0, 170, 0, 45) Cont.BackgroundColor3 = Color3.fromRGB(22, 22, 30) Instance.new("UICorner", Cont).CornerRadius = UDim.new(0, 8)
-- LIGHT GALAXY HUB V30 PRO MAX - PHẦN 2/10
local Pages = {}
local function CreatePage(Name)
    local Pg = Instance.new("ScrollingFrame", Cont) Pg.Size = UDim2.new(1, 0, 1, 0) Pg.CanvasSize = UDim2.new(0, 0, 15, 0) Pg.BackgroundTransparency = 1 Pg.ScrollBarThickness = 3 Pg.Visible = false
    local Lyt = Instance.new("UIListLayout", Pg) Lyt.Padding = UDim.new(0, 6)
    local Pad = Instance.new("UIPadding", Pg) Pad.PaddingTop = UDim.new(0, 8) Pad.PaddingLeft = UDim.new(0, 8) Pages[Name] = Pg
    local Btn = Instance.new("TextButton", TabSc) Btn.Size = UDim2.new(1, -10, 0, 35) Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 45) Btn.Font = Enum.Font.GothamSemibold Btn.Text = Name Btn.TextColor3 = Color3.fromRGB(220, 220, 220) Btn.TextSize = 12 Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    Btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end Pg.Visible = true
        for _, b in pairs(TabSc:GetChildren()) do if b:IsA("TextButton") then b.TextColor3 = Color3.fromRGB(220, 220, 220) b.BackgroundColor3 = Color3.fromRGB(30, 30, 45) end end
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255) Btn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    end)
    return Pg
end

local function AddToggle(Pg, Txt, Var)
    local Frm = Instance.new("Frame", Pg) Frm.Size = UDim2.new(1, -16, 0, 40) Frm.BackgroundColor3 = Color3.fromRGB(33, 33, 44) Instance.new("UICorner", Frm).CornerRadius = UDim.new(0, 6)
    local Lbl = Instance.new("TextLabel", Frm) Lbl.Size = UDim2.new(0.7, 0, 1, 0) Lbl.Position = UDim2.new(0, 10, 0, 0) Lbl.BackgroundTransparency = 1 Lbl.Font = Enum.Font.Gotham Lbl.Text = Txt Lbl.TextColor3 = Color3.fromRGB(255, 255, 255) Lbl.TextSize = 12 Lbl.TextXAlignment = Enum.TextXAlignment.Left
    local Btn = Instance.new("TextButton", Frm) Btn.Size = UDim2.new(0, 50, 0, 24) Btn.Position = UDim2.new(1, -60, 0, 8) Btn.BackgroundColor3 = Color3.fromRGB(100, 100, 100) Btn.Font = Enum.Font.GothamBold Btn.Text = "OFF" Btn.TextColor3 = Color3.fromRGB(255, 255, 255) Btn.TextSize = 11 Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)
    Btn.MouseButton1Click:Connect(function() _G[Var] = not _G[Var] Btn.BackgroundColor3 = _G[Var] and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(100, 100, 100) Btn.Text = _G[Var] and "ON" or "OFF" end)
end

local function AddLbl(Pg, Txt, VarStore)
    local Lbl = Instance.new("TextLabel", Pg) Lbl.Size = UDim2.new(1, -16, 0, 25) Lbl.BackgroundTransparency = 1 Lbl.Font = Enum.Font.GothamBold Lbl.Text = Txt Lbl.TextColor3 = Color3.fromRGB(255, 255, 255) Lbl.TextSize = 12 Lbl.TextXAlignment = Enum.TextXAlignment.Left
    if VarStore then _G[VarStore] = Lbl end
end
-- LIGHT GALAXY HUB V30 PRO MAX - PHẦN 3/10
local function AddDropdown(Pg, Txt, List, Var)
    local Frm = Instance.new("Frame", Pg) Frm.Size = UDim2.new(1, -16, 0, 40) Frm.BackgroundColor3 = Color3.fromRGB(33, 33, 44) Instance.new("UICorner", Frm).CornerRadius = UDim.new(0, 6) Frm.ClipsDescendants = true
    local Lbl = Instance.new("TextLabel", Frm) Lbl.Size = UDim2.new(0.5, 0, 0, 40) Lbl.Position = UDim2.new(0, 10, 0, 0) Lbl.BackgroundTransparency = 1 Lbl.Font = Enum.Font.Gotham Lbl.Text = Txt Lbl.TextColor3 = Color3.fromRGB(255, 255, 255) Lbl.TextSize = 11 Lbl.TextXAlignment = Enum.TextXAlignment.Left
    local MainBtn = Instance.new("TextButton", Frm) MainBtn.Size = UDim2.new(0.4, 0, 0, 24) MainBtn.Position = UDim2.new(0.6, -10, 0, 8) MainBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 65) MainBtn.Font = Enum.Font.GothamBold MainBtn.Text = "Chọn ▼" MainBtn.TextColor3 = Color3.fromRGB(255, 255, 255) MainBtn.TextSize = 10 Instance.new("UICorner", MainBtn).CornerRadius = UDim.new(0, 4)
    local DropScroll = Instance.new("ScrollingFrame", Frm) DropScroll.Size = UDim2.new(1, 0, 1, -45) DropScroll.Position = UDim2.new(0, 0, 0, 45) DropScroll.BackgroundTransparency = 1 DropScroll.ScrollBarThickness = 2 Instance.new("UIListLayout", DropScroll).Padding = UDim.new(0, 2)
    local isOpen = false
    local function Populate()
        for _, v in pairs(DropScroll:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
        if #List > 0 then
            for _, item in ipairs(List) do
                local btn = Instance.new("TextButton", DropScroll) btn.Size = UDim2.new(1, -10, 0, 25) btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55) btn.Text = item btn.TextColor3 = Color3.fromRGB(255, 255, 255) btn.Font = Enum.Font.Gotham btn.TextSize = 11
                btn.MouseButton1Click:Connect(function() _G[Var] = item MainBtn.Text = item Frm.Size = UDim2.new(1, -16, 0, 40) isOpen = false end)
            end
        else
            local rfs = Instance.new("TextButton", DropScroll) rfs.Size = UDim2.new(1, -10, 0, 25) rfs.BackgroundColor3 = Color3.fromRGB(0, 150, 255) rfs.Text = "🔄 Làm Mới Danh Sách" rfs.TextColor3 = Color3.fromRGB(255, 255, 255) rfs.Font = Enum.Font.GothamBold rfs.TextSize = 10 rfs.MouseButton1Click:Connect(Populate)
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer then
                    local btn = Instance.new("TextButton", DropScroll) btn.Size = UDim2.new(1, -10, 0, 25) btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50) btn.Text = p.Name btn.TextColor3 = Color3.fromRGB(255, 255, 255) btn.Font = Enum.Font.Gotham btn.TextSize = 11
                    btn.MouseButton1Click:Connect(function() _G[Var] = p.Name MainBtn.Text = p.Name Frm.Size = UDim2.new(1, -16, 0, 40) isOpen = false end)
                end
            end
        end
    end
    MainBtn.MouseButton1Click:Connect(function() isOpen = not isOpen if isOpen then Populate() Frm.Size = UDim2.new(1, -16, 0, 160) else Frm.Size = UDim2.new(1, -16, 0, 40) end end)
end
-- LIGHT GALAXY HUB V30 PRO MAX - PHẦN 4/10
local pFarm = CreatePage("Auto Farm")
local pSetFarm = CreatePage("Setting Farm")
local pLevi = CreatePage("Leviathan Hunt")
local pSeaEv = CreatePage("Sea Events")
local pBoss = CreatePage("Boss & Raid")
local pPvP = CreatePage("Chế Độ PVP")
local pStatus = CreatePage("Status Server")
local pMisc = CreatePage("ESP & Extras")
Pages["Auto Farm"].Visible = true

_G.FarmLv = false; _G.FarmBone = false; _G.FarmCake = false; _G.AutoRandomBone = false
_G.BringMob = true; _G.FastAtk = true; _G.AuraM1Fruit = false; _G.DragonStorm = false; _G.SmartPortal = true
_G.AutoSeaEvent = false; _G.UseM1Sea = false; _G.SpamMelee = true; _G.SpamSword = true; _G.SpamFruit = true
_G.KillPlr = false; _G.SilentAim = false; _G.TargetPlayer = ""; _G.AimType = false; _G.ESPPlr = false
_G.BoatSpeed300 = false; _G.BoatNoclip = false; _G.FindLeviMode = false; _G.AutoDriveTiki = false; _G.AutoBuyBoat = false
_G.SelectedBoat = ""; _G.TargetDangerLevel = "6"; _G.TargetSeaMob = ""
_G.AutoBuyChip = false; _G.StartRaidAfar = false; _G.AutoRaid = false; _G.AutoFruit = false; _G.AutoStoreFruit = false; _G.AutoRandomFruit = false; _G.KillAllBoss = false; _G.AutoRejoin30m = true

local BoatList = {"Sloop", "Fishboat", "Grand Brigade", "Lantern", "Galleon", "Swan", "Miracle", "Sentinel", "Guardian", "Beast Hunter"}
local DangerLevels = {"1", "2", "3", "4", "5", "6"}
local SeaMobs = {"Shark", "Terrorshark", "Piranha", "Ghost Ship", "Sea Beast", "Leviathan"}

AddToggle(pSetFarm, "Real Bring Mob 8m (Gom Quái)", "BringMob")
AddToggle(pSetFarm, "Fast Attack (Đánh Siêu Nhanh)", "FastAtk")
AddToggle(pSetFarm, "M1 Fruit Aura (Đánh m1 bằng Trái)", "AuraM1Fruit")
AddToggle(pSetFarm, "Aura Dragon Storm (Quét Sạch 250m)", "DragonStorm")
AddToggle(pSetFarm, "Smart Portal C (Dịch Chuyển Cổng)", "SmartPortal")

AddToggle(pFarm, "Auto Farm Level (Tự Nhận Quest)", "FarmLv")
AddToggle(pFarm, "Auto Farm Xương (Haunted Mansion)", "FarmBone")
AddToggle(pFarm, "Auto Random Bone (Trực Tiếp Từ Xa)", "AutoRandomBone")
AddToggle(pFarm, "Auto Farm Bánh (Cake)", "FarmCake")
-- LIGHT GALAXY HUB V30 PRO MAX - PHẦN 5/10
AddDropdown(pLevi, "1. Chọn Thuyền Mua ở Tiki:", BoatList, "SelectedBoat")
AddDropdown(pLevi, "2. Chọn Zone Danger:", DangerLevels, "TargetDangerLevel")
AddDropdown(pLevi, "3. Chọn Quái Săn Biển:", SeaMobs, "TargetSeaMob")
AddToggle(pLevi, "Tự Động Mua Thuyền Tại Tiki", "AutoBuyBoat")
AddToggle(pLevi, "Boat Speed 300 (Gia Tốc Thuyền)", "BoatSpeed300")
AddToggle(pLevi, "Boat Noclip (Xuyên Qua Đá)", "BoatNoclip")
AddToggle(pLevi, "Find Leviathan (Né Hết Quái Biển)", "FindLeviMode")
AddToggle(pLevi, "Auto Lái Thuyền Về Tiki (Kéo Tim)", "AutoDriveTiki")

AddToggle(pSeaEv, "Auto Sea Events (Săn Thuyền/Quái Thường)", "AutoSeaEvent")
AddToggle(pSeaEv, "Dùng M1 Fruit đánh Sea Event", "UseM1Sea")
AddToggle(pSeaEv, "Auto Spam Melee (Sea Event)", "SpamMelee")
AddToggle(pSeaEv, "Auto Spam Sword (Sea Event)", "SpamSword")
AddToggle(pSeaEv, "Auto Spam Blox Fruit (Sea Event)", "SpamFruit")

AddToggle(pBoss, "Auto Săn Tất Cả Boss Server", "KillAllBoss")
AddToggle(pBoss, "Auto Mua Chip Từ Xa", "BuyChipAfar")
AddToggle(pBoss, "Auto Vô Raid Từ Xa", "StartRaidAfar")
AddToggle(pBoss, "Auto Đi Đánh Raid", "AutoRaid")
AddToggle(pBoss, "Auto Nhặt & Cất Trái Ác Quỷ", "AutoFruit")
AddToggle(pBoss, "Auto Random Trái Từ Xa", "AutoRandomFruit")

AddDropdown(pPvP, "Chọn Player Mục Tiêu:", {}, "TargetPlayer")
AddToggle(pPvP, "Chế Độ Aim: GẦN NHẤT (ON) / LIST CHỌN (OFF)", "AimType")
AddToggle(pPvP, "Auto Bay Tiêu Diệt Player (PVP)", "KillPlr")
AddToggle(pPvP, "SILENT AIM (Bẻ cong mọi skill trúng đích)", "SilentAim")

AddLbl(pStatus, "============ STATUS SERVER ============", nil)
AddLbl(pStatus, "Trăng: Đang lấy dữ liệu...", "lblMoonTime")
AddLbl(pStatus, "Quái Kata: Đang lấy dữ liệu...", "lblKata")
AddLbl(pStatus, "Thời gian Server: Đang lấy dữ liệu...", "lblSrvTime")
AddLbl(pStatus, "Vật phẩm Râu Đen/Cúp: Đang lấy dữ liệu...", "lblItem")
AddLbl(pStatus, "Đảo Mirage (Kì Bí): Đang lấy dữ liệu...", "lblMirage")
AddLbl(pStatus, "Đảo Kitsune (Tyan): Đang lấy dữ liệu...", "lblKitsune")

AddToggle(pMisc, "ESP Player (Chữ Trắng - Không Lỗi)", "ESPPlr")
AddToggle(pMisc, "Chống Admin & Auto Server Hop 30P", "AutoRejoin30m")
-- LIGHT GALAXY HUB V30 PRO MAX - PHẦN 6/10
local function GetPortalFruit()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Portal-Portal") then return char["Portal-Portal"] end
    if LocalPlayer.Backpack:FindFirstChild("Portal-Portal") then return LocalPlayer.Backpack["Portal-Portal"] end return nil
end

local function SmartTween(TargetCFrame)
    local Char = LocalPlayer.Character if not Char or not Char:FindFirstChild("HumanoidRootPart") then return end
    local Root = Char.HumanoidRootPart local Dist = (Root.Position - TargetCFrame.Position).Magnitude
    if _G.SmartPortal and Dist > 1800 then
        local PortalFruit = GetPortalFruit()
        if PortalFruit then
            Char.Humanoid:EquipTool(PortalFruit) task.wait(0.2)
            pcall(function() ReplicatedStorage.Modules.Net:FindFirstChild("RE/Shoot"):FireServer(TargetCFrame.Position, "C") end) task.wait(1.5) return
        end
    end
    local BV = Root:FindFirstChild("FlyBV") or Instance.new("BodyVelocity", Root) BV.Name = "FlyBV"
    BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge) BV.Velocity = Vector3.new(0, 0, 0)
    local TweenAction = TweenService:Create(Root, TweenInfo.new(Dist / 340, Enum.EasingStyle.Linear), {CFrame = TargetCFrame})
    local Noclip = RunService.Stepped:Connect(function() for _, P in pairs(Char:GetChildren()) do if P:IsA("BasePart") then P.CanCollide = false end end end)
    TweenAction:Play() TweenAction.Completed:Wait() Noclip:Disconnect() Root.CanCollide = true if Root:FindFirstChild("FlyBV") then Root.FlyBV:Destroy() end
end

local CombatFramework = require(LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
task.spawn(function()
    while task.wait() do
        if _G.FastAtk or _G.DragonStorm or _G.AuraM1Fruit then
            pcall(function()
                local Char = LocalPlayer.Character
                if _G.AuraM1Fruit then for _, T in pairs(LocalPlayer.Backpack:GetChildren()) do if T:IsA("Tool") and T.ToolTip == "Blox Fruit" then Char.Humanoid:EquipTool(T) break end end end
                if _G.DragonStorm then
                    for _, v in pairs(Workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - Char.HumanoidRootPart.Position).Magnitude < 250 then
                            v.HumanoidRootPart.Size = Vector3.new(150, 150, 150) v.HumanoidRootPart.Transparency = 0.8 v.HumanoidRootPart.CanCollide = false
                        end
                    end
                end
                local c = CombatFramework.activeController if c and c.blades[1] then c.timeToNextAttack = 0 c.hitboxMagnitude = _G.DragonStorm and 250 or 60 end
            end)
        end
    end
end)
-- LIGHT GALAXY HUB V30 PRO MAX - PHẦN 7/10
local function GetPvPTarget()
    if _G.AimType then 
        local closest = nil local minDist = math.huge
        local myPos = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart.Position
        if myPos then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.Humanoid.Health > 0 then
                    local dist = (p.Character.HumanoidRootPart.Position - myPos).Magnitude
                    if dist < minDist then minDist = dist closest = p end
                end
            end
        end
        return closest
    else return Players:FindFirstChild(_G.TargetPlayer) end
end

local mt = getrawmetatable(game) local oldNamecall = mt.__namecall setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod() local args = {...}
    if _G.SilentAim and method == "FireServer" and tostring(self) == "RemoteEvent" then
        local target = GetPvPTarget()
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            for i, v in pairs(args) do
                if typeof(v) == "Vector3" then args[i] = target.Character.HumanoidRootPart.Position end
                if typeof(v) == "CFrame" then args[i] = target.Character.HumanoidRootPart.CFrame end
            end
            return oldNamecall(self, unpack(args))
        end
    end
    return oldNamecall(self, ...)
end)
setreadonly(mt, true)

local function GetQuestLogic()
    local Lvl = LocalPlayer:FindFirstChild("Data") and LocalPlayer.Data:FindFirstChild("Level") and LocalPlayer.Data.Level.Value or 1
    local QuestName, QuestNum, MobName, QuestCFrame, MobCFrame = "", 1, "", CFrame.new(0,0,0), CFrame.new(0,0,0)
    if Lvl >= 1500 and Lvl <= 1525 then QuestName = "Pirate Millionaire Quest" QuestNum = 1 MobName = "Pirate Millionaire" QuestCFrame = CFrame.new(-318, 44, 5972) MobCFrame = CFrame.new(-318, 44, 5972)
    elseif Lvl >= 1525 and Lvl <= 1575 then QuestName = "Pistol Billionaire Quest" QuestNum = 1 MobName = "Pistol Billionaire" QuestCFrame = CFrame.new(-462, 73, 5325) MobCFrame = CFrame.new(-462, 73, 5325)
    elseif Lvl >= 1575 and Lvl <= 1625 then QuestName = "DragonCrewQuest" QuestNum = 1 MobName = "Dragon Crew Warrior" QuestCFrame = CFrame.new(6338, 52, -1213) MobCFrame = CFrame.new(6338, 52, -1213)
    else QuestName = "Bypass" MobName = "Bypass" end
    return QuestName, QuestNum, MobName, QuestCFrame, MobCFrame
end
-- LIGHT GALAXY HUB V30 PRO MAX - PHẦN 8/10
local function AutoQuestFarm()
    if not _G.FarmLv then return end
    local qName, qNum, mName, qPos, mPos = GetQuestLogic()
    if qName ~= "Bypass" then
        if not LocalPlayer.PlayerGui.Main.Quest.Visible then SmartTween(qPos) task.wait(0.5) CommF:InvokeServer("StartQuest", qName, qNum)
        else
            local tMob = nil for _, E in pairs(Workspace.Enemies:GetChildren()) do if string.find(E.Name, mName) and E.Humanoid.Health > 0 then tMob = E break end end
            if tMob then SmartTween(tMob.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)) else SmartTween(mPos * CFrame.new(0, 50, 0)) end
        end
    else
        for _, E in pairs(Workspace.Enemies:GetChildren()) do if E:FindFirstChild("HumanoidRootPart") and E.Humanoid.Health > 0 then SmartTween(E.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)) break end end
    end
end

RunService.Heartbeat:Connect(function()
    if _G.BringMob then
        pcall(function()
            local MyRoot = LocalPlayer.Character.HumanoidRootPart
            for _, Enemy in pairs(Workspace.Enemies:GetChildren()) do
                if Enemy:FindFirstChild("HumanoidRootPart") and Enemy:FindFirstChild("Humanoid") and Enemy.Humanoid.Health > 0 then
                    if (Enemy.HumanoidRootPart.Position - MyRoot.Position).Magnitude < 350 then
                        Enemy.HumanoidRootPart.CanCollide = false Enemy.HumanoidRootPart.Size = Vector3.new(60, 60, 60) Enemy.Humanoid.WalkSpeed = 0 Enemy.Humanoid.JumpPower = 0 Enemy.HumanoidRootPart.CFrame = MyRoot.CFrame * CFrame.new(0, 0, -15)
                    end
                end
            end
        end)
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if _G.FarmLv or _G.FarmBone or _G.FarmCake or _G.AutoSeaEvent or _G.FindLeviMode or _G.KillAllBoss or _G.KillPlr then
            pcall(function()
                local Char = LocalPlayer.Character if not Char or not Char:FindFirstChild("Humanoid") then return end
                if not Char:FindFirstChildOfClass("Tool") then
                    for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do if tool:IsA("Tool") and (tool.ToolTip == "Melee" or tool.ToolTip == "Sword") then Char.Humanoid:EquipTool(tool) break end end
                end
                VirtualUser:CaptureController() VirtualUser:Button1Down(Vector2.new(0, 0))
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.2) do
        if _G.FarmLv then pcall(AutoQuestFarm) end
        if _G.FarmBone then pcall(function() local t = nil for _, E in pairs(Workspace.Enemies:GetChildren()) do if (E.Name == "Reborn Skeleton" or E.Name == "Living Zombie") and E.Humanoid.Health > 0 then t = E break end end if t then SmartTween(t.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)) else SmartTween(CFrame.new(-9481, 142, 5566)) end end) end
        if _G.FarmCake then pcall(function() local t = nil for _, E in pairs(Workspace.Enemies:GetChildren()) do if string.find(E.Name, "Cake") and E.Humanoid.Health > 0 then t = E break end end if t then SmartTween(t.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)) else SmartTween(CFrame.new(-2022, 38, -12028)) end end) end
        if _G.KillAllBoss then pcall(function() for _, mob in pairs(Workspace.Enemies:GetChildren()) do if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and mob:GetAttribute("IsBoss") then SmartTween(mob.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)) break end end end) end
    end
end)
-- LIGHT GALAXY HUB V30 PRO MAX - PHẦN 9/10
local function GetMyBoat()
    for _, v in pairs(Workspace.Boats:GetChildren()) do if v:FindFirstChild("Owner") and v.Owner.Value == LocalPlayer then return v end end return nil
end

local function SmartSeaEventDetect()
    local detected, threatName = false, ""
    for _, e in pairs(Workspace.Enemies:GetChildren()) do
        if e:FindFirstChild("HumanoidRootPart") and e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0 then
            local name = e.Name:lower()
            if string.find(name, "terror") or string.find(name, "shark") or string.find(name, "ghost") or string.find(name, "piranha") then detected = true threatName = e.Name break end
        end
    end
    if not detected and Workspace:FindFirstChild("SeaBeasts") then
        for _, sb in pairs(Workspace.SeaBeasts:GetChildren()) do if sb:FindFirstChild("HumanoidRootPart") and sb.Humanoid.Health > 0 then detected = true threatName = "Sea Beast" break end end
    end
    return detected, threatName
end

RunService.Heartbeat:Connect(function()
    local MyBoat = GetMyBoat()
    if MyBoat and MyBoat:FindFirstChild("PrimaryPart") then
        local Seat = MyBoat:FindFirstChild("VehicleSeat")
        if Seat and Seat.Occupant and Seat.Occupant.Parent == LocalPlayer.Character then
            if _G.BoatNoclip then for _, part in pairs(MyBoat:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end end
            if _G.BoatSpeed300 then MyBoat.PrimaryPart.AssemblyLinearVelocity = MyBoat.PrimaryPart.CFrame.LookVector * 300 end
            if _G.FindLeviMode then
                local hasThreat, threatName = SmartSeaEventDetect()
                if hasThreat and threatName ~= "Leviathan" then
                    MyBoat.PrimaryPart.CFrame = CFrame.new(MyBoat.PrimaryPart.Position.X, 500, MyBoat.PrimaryPart.Position.Z) * CFrame.Angles(0, math.rad(MyBoat.PrimaryPart.Orientation.Y), 0)
                    MyBoat.PrimaryPart.AssemblyLinearVelocity = MyBoat.PrimaryPart.CFrame.LookVector * 300
                else
                    if MyBoat.PrimaryPart.Position.Y > 50 then MyBoat.PrimaryPart.CFrame = CFrame.new(MyBoat.PrimaryPart.Position.X, 20, MyBoat.PrimaryPart.Position.Z) * CFrame.Angles(0, math.rad(MyBoat.PrimaryPart.Orientation.Y), 0) end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        local TikiOutpostCFrame = CFrame.new(-16234, 10, 434)
        if _G.AutoBuyBoat then
            pcall(function()
                local MyBoat = GetMyBoat()
                if not MyBoat then
                    local Char = LocalPlayer.Character
                    if Char and Char:FindFirstChild("HumanoidRootPart") then
                        if (Char.HumanoidRootPart.Position - TikiOutpostCFrame.Position).Magnitude > 50 then SmartTween(TikiOutpostCFrame * CFrame.new(0, 10, 0)) else if _G.SelectedBoat ~= "" then CommF:InvokeServer("BuyBoat", _G.SelectedBoat) task.wait(1) end end
                    end
                else
                    local Seat = MyBoat:FindFirstChild("VehicleSeat") local Char = LocalPlayer.Character if Seat and not Seat.Occupant and Char and Char:FindFirstChild("HumanoidRootPart") then Char.HumanoidRootPart.CFrame = Seat.CFrame end
                end
            end)
        end
        if _G.AutoDriveTiki then
            pcall(function()
                local MyBoat = GetMyBoat()
                if MyBoat and MyBoat:FindFirstChild("PrimaryPart") then
                    local Seat = MyBoat:FindFirstChild("VehicleSeat")
                    if Seat and Seat.Occupant and Seat.Occupant.Parent == LocalPlayer.Character then
                        _G.BoatNoclip = true
                        local currentPos = MyBoat.PrimaryPart.Position local lookAtPos = Vector3.new(TikiOutpostCFrame.X, currentPos.Y, TikiOutpostCFrame.Z)
                        MyBoat.PrimaryPart.CFrame = CFrame.new(currentPos, lookAtPos)
                        MyBoat.PrimaryPart.AssemblyLinearVelocity = MyBoat.PrimaryPart.CFrame.LookVector * 150
                    end
                end
            end)
        end
    end
end)
-- LIGHT GALAXY HUB V30 PRO MAX - PHẦN 10/10
task.spawn(function()
    while task.wait(0.5) do
        if _G.AutoSeaEvent then
            pcall(function()
                local Char = LocalPlayer.Character local Root = Char and Char:FindFirstChild("HumanoidRootPart") if not Root then return end
                local target = nil
                if Workspace:FindFirstChild("SeaBeasts") then for _, sb in pairs(Workspace.SeaBeasts:GetChildren()) do if sb:FindFirstChild("HumanoidRootPart") and sb.Humanoid.Health > 0 then target = sb break end end end
                if not target then for _, b in pairs(Workspace.Enemies:GetChildren()) do if (string.find(b.Name, "Ship") or string.find(b.Name, "Ghost")) and b.Humanoid.Health > 0 then target = b break end end end
                if target then
                    SmartTween(target.HumanoidRootPart.CFrame * CFrame.new(0, 100, 0))
                    if _G.SpamMelee then for _, k in ipairs({Enum.KeyCode.Z, Enum.KeyCode.X, Enum.KeyCode.C, Enum.KeyCode.V}) do VIM:SendKeyEvent(true, k, false, game) task.wait(0.1) VIM:SendKeyEvent(false, k, false, game) end end
                else
                    local MyBoat = GetMyBoat()
                    if not MyBoat then
                        local boatNPC = nil for _, npc in pairs(Workspace.NPCs:GetChildren()) do if npc.Name == "Boat Dealer" and npc:FindFirstChild("HumanoidRootPart") and npc.HumanoidRootPart.Position.Z > 10000 then boatNPC = npc break end end
                        if boatNPC then SmartTween(boatNPC.HumanoidRootPart.CFrame * CFrame.new(0, 3, 5)) task.wait(0.5) CommF:InvokeServer("BuyBoat", "Guardian") end
                    else
                        local Seat = MyBoat:FindFirstChild("VehicleSeat") if Seat and not Seat.Occupant then Root.CFrame = Seat.CFrame else MyBoat:SetPrimaryPartCFrame(MyBoat.PrimaryPart.CFrame * CFrame.new(0, 0, -300)) end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if _G.AutoRandomBone then pcall(function() CommF:InvokeServer("BonesBuy", 1) end) end
        if _G.BuyChipAfar then pcall(function() CommF:InvokeServer("RaidsNpc", "Select", "Flame") end) end
        if _G.AutoRandomFruit then pcall(function() CommF:InvokeServer("Cousin", "Buy") end) end
        if _G.AutoFruit then pcall(function() for _, f in pairs(Workspace:GetChildren()) do if f:IsA("Tool") and string.find(f.Name, "Fruit") and f:FindFirstChild("Handle") then SmartTween(f.Handle.CFrame) task.wait(0.5) if _G.AutoStoreFruit then CommF:InvokeServer("StoreFruit", f:GetAttribute("OriginalName") or f.Name, f) end end end end) end
    end
end)

task.spawn(function()
    while task.wait(1.5) do
        pcall(function()
            local currentPhase = "1"
            if Lighting:FindFirstChild("Sky") then
                local moonTex = Lighting.Sky.MoonTextureId
                local moonPhases = { ["http://www.roblox.com/asset/?id=9709149431"]=8, ["http://www.roblox.com/asset/?id=9709149052"]=7, ["http://www.roblox.com/asset/?id=9709143733"]=1 }
                for tex, phase in pairs(moonPhases) do if string.find(moonTex, tex) then currentPhase = phase break end end
                if currentPhase == 8 or string.find(moonTex, "9709149431") or string.find(moonTex, "9709135895") then _G.lblMoonTime.Text = "Trăng: 8/8 (Full Moon up v4 - Ánh sáng xuyên qua mây)" else _G.lblMoonTime.Text = "Trăng: " .. currentPhase .. "/8" end
            else _G.lblMoonTime.Text = "Trăng: Lỗi load bầu trời" end
            local kP = CommF:InvokeServer("CakePrinceSpawner")
            if type(kP) == "number" then _G.lblKata.Text = "Quái Kata cần giết: " .. (500 - kP) else _G.lblKata.Text = "Kata: " .. tostring(kP or "Đã mở cổng") end
            _G.lblSrvTime.Text = "Thời gian SV: " .. math.floor(Workspace.DistributedGameTime / 60) .. " Phút"
            local ItemTxt = ""
            for _,p in pairs(Players:GetPlayers()) do if p.Backpack:FindFirstChild("God's Chalice") or (p.Character and p.Character:FindFirstChild("God's Chalice")) then ItemTxt=ItemTxt.."Cúp " end if p.Backpack:FindFirstChild("Fist of Darkness") or (p.Character and p.Character:FindFirstChild("Fist of Darkness")) then ItemTxt=ItemTxt.."Fist " end end
            _G.lblItem.Text = "Vật phẩm: " .. (ItemTxt == "" and "Trống" or ItemTxt)
            local map = Workspace:FindFirstChild("Map") and Workspace.Map:GetChildren() or Workspace:GetChildren()
            local hasMirage, hasKitsune = false, false
            for _, v in pairs(map) do if string.find(v.Name, "Mystic") or string.find(v.Name, "Mirage") then hasMirage = true end if string.find(v.Name, "Kitsune") then hasKitsune = true end end
            _G.lblMirage.Text = "Đảo Mirage (Kì Bí): " .. (hasMirage and "🟢 ĐANG CÓ" or "🔴 KHÔNG")
            _G.lblKitsune.Text = "Đảo Kitsune (Tyan): " .. (hasKitsune and "🟢 ĐANG CÓ" or "🔴 KHÔNG")
        end)
        if _G.ESPPlr then pcall(function() for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then if not p.Character.HumanoidRootPart:FindFirstChild("ESPP") then local bg = Instance.new("BillboardGui", p.Character.HumanoidRootPart) bg.Name = "ESPP" bg.Size = UDim2.new(0, 200, 0, 40) bg.AlwaysOnTop = true bg.StudsOffset = Vector3.new(0, 3, 0) local txt = Instance.new("TextLabel", bg) txt.Size = UDim2.new(1,0,1,0) txt.BackgroundTransparency = 1 txt.TextScaled = true txt.Font = Enum.Font.GothamBold end p.Character.HumanoidRootPart.ESPP.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255) p.Character.HumanoidRootPart.ESPP.TextLabel.Text = string.format("[%s]\nLv.%d", p.Name, p:FindFirstChild("Data") and p.Data:FindFirstChild("Level") and p.Data.Level.Value or 0) end end end) else for _, p in pairs(Players:GetPlayers()) do if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.HumanoidRootPart:FindFirstChild("ESPP") then p.Character.HumanoidRootPart.ESPP:Destroy() end end end
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
