-- ==============================================================================
-- LIGHT GALAXY HUB ◆ V18 GOD MODE (FIX BAY RƠI, SILENT AIM NAMECALL, SERVER STATUS)
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

pcall(function() if not LocalPlayer.Team then CommF:InvokeServer("SetTeam", "Pirates") end end)
local World1 = game.PlaceId == 2753915549 or game.PlaceId == 85211729168715
local World2 = game.PlaceId == 4442272183 or game.PlaceId == 79091703265657
local World3 = game.PlaceId == 7449423635 or game.PlaceId == 100117331123089

local UI_Parent = game:GetService("CoreGui")
if not UI_Parent or not pcall(function() local a = UI_Parent.Name end) then UI_Parent = LocalPlayer:WaitForChild("PlayerGui") end
if UI_Parent:FindFirstChild("LightGalaxyHub") then UI_Parent.LightGalaxyHub:Destroy() end

local Hub = Instance.new("ScreenGui", UI_Parent) Hub.Name = "LightGalaxyHub" Hub.ResetOnSpawn = false
local ToggleBtn = Instance.new("TextButton", Hub) ToggleBtn.Size = UDim2.new(0, 45, 0, 45) ToggleBtn.Position = UDim2.new(0, 10, 0.5, 0) ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 255) ToggleBtn.Text = "ẨN UI" ToggleBtn.Font = Enum.Font.GothamBold ToggleBtn.TextSize = 11 Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

local Main = Instance.new("Frame", Hub) Main.Size = UDim2.new(0, 560, 0, 360) Main.Position = UDim2.new(0.2, 0, 0.2, 0) Main.BackgroundColor3 = Color3.fromRGB(15, 15, 25) Main.Active = true Main.Draggable = true Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
local Top = Instance.new("Frame", Main) Top.Size = UDim2.new(1, 0, 0, 40) Top.BackgroundColor3 = Color3.fromRGB(30, 30, 50) Instance.new("UICorner", Top).CornerRadius = UDim.new(0, 10)
local Title = Instance.new("TextLabel", Top) Title.Size = UDim2.new(1, -30, 1, 0) Title.Position = UDim2.new(0, 15, 0, 0) Title.BackgroundTransparency = 1 Title.Font = Enum.Font.GothamBold Title.Text = "LIGHT GALAXY HUB ◆ V18 GOD MODE" Title.TextColor3 = Color3.fromRGB(0, 255, 255) Title.TextSize = 14 Title.TextXAlignment = Enum.TextXAlignment.Left

ToggleBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible ToggleBtn.Text = Main.Visible and "ẨN UI" or "MỞ UI" end)

local TabSc = Instance.new("ScrollingFrame", Main) TabSc.Size = UDim2.new(0, 140, 1, -50) TabSc.Position = UDim2.new(0, 5, 0, 45) TabSc.BackgroundTransparency = 1 TabSc.ScrollBarThickness = 2 Instance.new("UIListLayout", TabSc).Padding = UDim.new(0, 4)
local Cont = Instance.new("Frame", Main) Cont.Size = UDim2.new(1, -155, 1, -50) Cont.Position = UDim2.new(0, 150, 0, 45) Cont.BackgroundColor3 = Color3.fromRGB(20, 20, 35) Instance.new("UICorner", Cont).CornerRadius = UDim.new(0, 8)

local Pages = {}
local function CreatePage(Name)
    local Pg = Instance.new("ScrollingFrame", Cont) Pg.Size = UDim2.new(1, 0, 1, 0) Pg.CanvasSize = UDim2.new(0, 0, 7, 0) Pg.BackgroundTransparency = 1 Pg.ScrollBarThickness = 4 Pg.Visible = false
    local Lyt = Instance.new("UIListLayout", Pg) Lyt.Padding = UDim.new(0, 6) local Pad = Instance.new("UIPadding", Pg) Pad.PaddingTop = UDim.new(0, 6) Pad.PaddingLeft = UDim.new(0, 6) Pages[Name] = Pg
    local Btn = Instance.new("TextButton", TabSc) Btn.Size = UDim2.new(1, -10, 0, 32) Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 60) Btn.Font = Enum.Font.GothamSemibold Btn.Text = Name Btn.TextColor3 = Color3.fromRGB(200, 200, 200) Btn.TextSize = 11 Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    Btn.MouseButton1Click:Connect(function() for _, p in pairs(Pages) do p.Visible = false end Pg.Visible = true for _, b in pairs(TabSc:GetChildren()) do if b:IsA("TextButton") then b.TextColor3 = Color3.fromRGB(200, 200, 200) b.BackgroundColor3 = Color3.fromRGB(35, 35, 60) end end Btn.TextColor3 = Color3.fromRGB(0, 255, 255) Btn.BackgroundColor3 = Color3.fromRGB(50, 40, 90) end)
    return Pg
end

local function AddToggle(Pg, Txt, Var)
    _G[Var] = false
    local Frm = Instance.new("Frame", Pg) Frm.Size = UDim2.new(1, -12, 0, 38) Frm.BackgroundColor3 = Color3.fromRGB(30, 30, 50) Instance.new("UICorner", Frm).CornerRadius = UDim.new(0, 6)
    local Lbl = Instance.new("TextLabel", Frm) Lbl.Size = UDim2.new(0.7, 0, 1, 0) Lbl.Position = UDim2.new(0, 10, 0, 0) Lbl.BackgroundTransparency = 1 Lbl.Font = Enum.Font.Gotham Lbl.Text = Txt Lbl.TextColor3 = Color3.fromRGB(255, 255, 255) Lbl.TextSize = 11 Lbl.TextXAlignment = Enum.TextXAlignment.Left
    local Btn = Instance.new("TextButton", Frm) Btn.Size = UDim2.new(0, 45, 0, 22) Btn.Position = UDim2.new(1, -55, 0, 8) Btn.BackgroundColor3 = Color3.fromRGB(150, 50, 50) Btn.Font = Enum.Font.GothamBold Btn.Text = "OFF" Btn.TextColor3 = Color3.fromRGB(255, 255, 255) Btn.TextSize = 10 Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)
    Btn.MouseButton1Click:Connect(function() _G[Var] = not _G[Var] Btn.BackgroundColor3 = _G[Var] and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50) Btn.Text = _G[Var] and "ON" or "OFF" end)
end

local function AddLbl(Pg, Txt, VarStore)
    local Lbl = Instance.new("TextLabel", Pg) Lbl.Size = UDim2.new(1, -12, 0, 25) Lbl.BackgroundTransparency = 1 Lbl.Font = Enum.Font.GothamBold Lbl.Text = Txt Lbl.TextColor3 = Color3.fromRGB(0, 255, 150) Lbl.TextSize = 12 Lbl.TextXAlignment = Enum.TextXAlignment.Left
    if VarStore then _G[VarStore] = Lbl end
end
-- LIGHT GALAXY HUB V18 - PHẦN 2
local pFarm = CreatePage("Auto Farm")
local pBoss = CreatePage("Boss & Raid")
local pPvP = CreatePage("PVP & Status")
local pMisc = CreatePage("ESP & Hacks")
Pages["Auto Farm"].Visible = true

_G.FastAtk = true; _G.BringMob = true; _G.FarmLv = false; _G.FarmBone = false; _G.FarmCake = false
_G.AutoRaid = false; _G.StartRaidAfar = false; _G.BuyChipAfar = false; _G.RandFruitAfar = false; _G.RandBoneAfar = false
_G.KillBoss = false; _G.KillAllBoss = false; _G.SeaMoney = false; _G.SeaEvent = false
_G.KillPlr = false; _G.SilentAim = false; _G.PlrName = ""; _G.ESPPlr = false; _G.AutoHop = true

AddToggle(pFarm, "Bypass Fast Attack (Đánh Player & Quái)", "FastAtk")
AddToggle(pFarm, "Real Bring Mob 8m (Gom Quái)", "BringMob")
AddToggle(pFarm, "Auto Farm Level (Tự Chuyển Sea)", "FarmLv")
AddToggle(pFarm, "Auto Farm Xương (Đảo Ám)", "FarmBone")
AddToggle(pFarm, "Auto Farm Bánh (Đảo Bánh)", "FarmCake")

AddToggle(pBoss, "Auto Mua Chip Từ Xa Bất Chấp", "BuyChipAfar")
AddToggle(pBoss, "Auto Vô Raid Từ Xa", "StartRaidAfar")
AddToggle(pBoss, "Auto Đi Raid", "AutoRaid")
AddToggle(pBoss, "Auto Mua Random Trái Từ Xa", "RandFruitAfar")
AddToggle(pBoss, "Auto Đổi Xương Từ Xa", "RandBoneAfar")
AddToggle(pBoss, "Auto Săn Tất Cả Boss Server", "KillAllBoss")

AddToggle(pPvP, "Auto Bay Cắn Player (PVP)", "KillPlr")
AddToggle(pPvP, "SILENT AIM (Skill Tự Bẻ Lái Vào Địch)", "SilentAim")
local TgtLbl = Instance.new("TextLabel", pPvP) TgtLbl.Size = UDim2.new(1,-12,0,20) TgtLbl.BackgroundTransparency=1 TgtLbl.Font=Enum.Font.GothamBold TgtLbl.Text="MỤC TIÊU: CHƯA CÓ" TgtLbl.TextColor3=Color3.fromRGB(255,50,50) TgtLbl.TextSize=11 TgtLbl.TextXAlignment=0
local RfBtn = Instance.new("TextButton", pPvP) RfBtn.Size=UDim2.new(1,-12,0,25) RfBtn.BackgroundColor3=Color3.fromRGB(45,140,90) RfBtn.Text="LÀM MỚI DANH SÁCH NGƯỜI CHƠI" RfBtn.Font=Enum.Font.GothamBold RfBtn.TextColor3=Color3.fromRGB(255,255,255) RfBtn.TextSize=10
local PScrl = Instance.new("ScrollingFrame", pPvP) PScrl.Size=UDim2.new(1,-12,0,80) PScrl.CanvasSize=UDim2.new(0,0,5,0) PScrl.BackgroundTransparency=1 PScrl.ScrollBarThickness=2 Instance.new("UIListLayout", PScrl).Padding=UDim.new(0,2)
RfBtn.MouseButton1Click:Connect(function()
    for _,c in pairs(PScrl:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
    for _,p in pairs(Players:GetPlayers()) do if p~=LocalPlayer then
        local b=Instance.new("TextButton", PScrl) b.Size=UDim2.new(1,0,0,20) b.BackgroundColor3=Color3.fromRGB(40,40,60) b.Text=p.Name b.Font=Enum.Font.Gotham b.TextColor3=Color3.fromRGB(255,255,255) b.TextSize=10
        b.MouseButton1Click:Connect(function() _G.PlrName=p.Name TgtLbl.Text="ĐANG KHÓA MỤC TIÊU: "..p.Name end)
    end end
end)

AddLbl(pPvP, "--- SERVER STATUS ---", nil)
AddLbl(pPvP, "Trăng: Loading...", "lblMoon")
AddLbl(pPvP, "Katakuri: Loading...", "lblKata")
AddLbl(pPvP, "Item Ngon: Loading...", "lblItem")
AddLbl(pPvP, "Thời gian Server: Loading...", "lblTime")

AddToggle(pMisc, "Auto Biển 6 (Săn Sea Beast/Tiền)", "SeaMoney")
AddToggle(pMisc, "ESP Player (Kèm Máu & Level & PVP)", "ESPPlr")
AddToggle(pMisc, "Chống Admin & Anti-AFK 30P", "AutoHop")

-- [HÀM BAY TWEEN FIX LỖI RƠI (DÙNG BODYVELOCITY CỰC MƯỢT)]
local function TweenTo(TargetCFrame)
    local Char = LocalPlayer.Character if not Char or not Char:FindFirstChild("HumanoidRootPart") then return end
    local Root = Char.HumanoidRootPart
    local Dist = (Root.Position - TargetCFrame.Position).Magnitude
    
    -- XÓA TRỌNG LỰC BẰNG BODYVELOCITY ĐỂ KHÔNG RỚT
    local BV = Root:FindFirstChild("FlyBV")
    if not BV then
        BV = Instance.new("BodyVelocity", Root) BV.Name = "FlyBV"
        BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        BV.Velocity = Vector3.new(0, 0, 0)
    end
    
    local TweenAction = TweenService:Create(Root, TweenInfo.new(Dist / 330, Enum.EasingStyle.Linear), {CFrame = TargetCFrame})
    local Noclip = RunService.Stepped:Connect(function()
        if Char and Char:FindFirstChild("HumanoidRootPart") then
            for _, P in pairs(Char:GetChildren()) do if P:IsA("BasePart") then P.CanCollide = false end end
        end
    end)
    TweenAction:Play() TweenAction.Completed:Wait() Noclip:Disconnect()
    if Root:FindFirstChild("FlyBV") then Root.FlyBV:Destroy() end
    Root.CanCollide = true
end
-- LIGHT GALAXY HUB V18 - PHẦN 3

-- [DỊCH CHUYỂN CỔNG THÔNG MINH - PORTAL BYPASS]
local function SmartTween(TargetCFrame)
    local Root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") if not Root then return end
    if World3 and (Root.Position - TargetCFrame.Position).Magnitude > 3000 then
        local Portals = {Castle = Vector3.new(-50, 300, -10), Mansion = Vector3.new(-12463, 331, -7552), Hydra = Vector3.new(5228, 1004, 323)}
        local Best, MinD = nil, (Root.Position - TargetCFrame.Position).Magnitude
        for Name, Pos in pairs(Portals) do
            local d = (TargetCFrame.Position - Pos).Magnitude
            if d < MinD then MinD = d Best = Name end
        end
        if Best then pcall(function() CommF:InvokeServer("PortalTeleport", Best) task.wait(0.5) end) end
    end
    TweenTo(TargetCFrame)
end

-- [SILENT AIM BẰNG HOOK NAMECALL CHÍ MẠNG]
local function GetAimTarget()
    if _G.PlrName ~= "" then
        local p = Players:FindFirstChild(_G.PlrName)
        if p and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.Humanoid.Health > 0 then return p.Character end
    end
    local Near, MinD, MyRoot = nil, math.huge, LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
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

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    if _G.SilentAim and method == "FireServer" and tostring(self) == "RemoteEvent" then
        local target = GetAimTarget()
        if target and target:FindFirstChild("HumanoidRootPart") then
            for i, v in pairs(args) do
                if typeof(v) == "Vector3" then args[i] = target.HumanoidRootPart.Position end
                if typeof(v) == "CFrame" then args[i] = target.HumanoidRootPart.CFrame end
            end
            return oldNamecall(self, unpack(args))
        end
    end
    return oldNamecall(self, ...)
end)
setreadonly(mt, true)

-- [FAST ATTACK + TỰ ĐỘNG CHÉM PLAYER/MOB]
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

task.spawn(function()
    while task.wait(0.01) do
        if _G.FastAtk then
            pcall(function()
                local Char = LocalPlayer.Character if not Char or not Char:FindFirstChild('HumanoidRootPart') then return end
                local root = Char.HumanoidRootPart local u17 = {}
                for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                    local eRoot = mob:FindFirstChild('HumanoidRootPart')
                    if eRoot and mob.Humanoid.Health > 0 and (eRoot.Position - root.Position).Magnitude <= 75 then for _, part in ipairs(mob:GetChildren()) do if part:IsA('BasePart') then table.insert(u17, {mob, part}) end end end
                end
                if _G.KillPlr and _G.PlrName ~= "" then
                    local pT = Players:FindFirstChild(_G.PlrName)
                    if pT and pT.Character and pT.Character:FindFirstChild("HumanoidRootPart") and pT.Character.Humanoid.Health > 0 and (pT.Character.HumanoidRootPart.Position - root.Position).Magnitude <= 75 then
                        for _, part in ipairs(pT.Character:GetChildren()) do if part:IsA('BasePart') then table.insert(u17, {pT.Character, part}) end end
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
-- LIGHT GALAXY HUB V18 - PHẦN 4

-- [BRING MOB VÀ VÒNG LẶP CHÍNH]
task.spawn(function()
    while task.wait(0.1) do
        if _G.BringMob then
            pcall(function()
                local MyRoot = LocalPlayer.Character.HumanoidRootPart
                for _, Enemy in pairs(Workspace.Enemies:GetChildren()) do
                    if Enemy:FindFirstChild("HumanoidRootPart") and Enemy.Humanoid.Health > 0 and (Enemy.HumanoidRootPart.Position - MyRoot.Position).Magnitude < 350 then
                        Enemy.HumanoidRootPart.Size = Vector3.new(65, 65, 65) Enemy.HumanoidRootPart.CanCollide = false
                        Enemy.HumanoidRootPart.CFrame = MyRoot.CFrame * CFrame.new(0, -8, 0)
                        Enemy.Humanoid.PlatformStand = true Enemy.Humanoid.WalkSpeed = 0
                    end
                end
            end)
        end
        -- Auto Click Mượt
        if _G.FarmLv or _G.FarmBone or _G.FarmCake or _G.AutoRaid or _G.KillPlr or _G.KillAllBoss or _G.SeaMoney then
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

-- [VÒNG LẶP CÀY CUỐC & RAID TỪ XA BẤT CHẤP]
task.spawn(function()
    while task.wait(0.2) do
        if _G.FarmLv then pcall(function() for _, E in pairs(Workspace.Enemies:GetChildren()) do if E.Humanoid.Health > 0 then SmartTween(E.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)) break end end end) end
        if _G.FarmBone then pcall(function() local t=nil for _, E in pairs(Workspace.Enemies:GetChildren()) do if (E.Name=="Reborn Skeleton" or E.Name=="Living Zombie") and E.Humanoid.Health>0 then t=E break end end if t then SmartTween(t.HumanoidRootPart.CFrame*CFrame.new(0,30,0)) else SmartTween(CFrame.new(-9481, 142, 5566)) end end) end
        if _G.FarmCake then pcall(function() local t=nil for _, E in pairs(Workspace.Enemies:GetChildren()) do if string.find(E.Name, "Cake") and E.Humanoid.Health>0 then t=E break end end if t then SmartTween(t.HumanoidRootPart.CFrame*CFrame.new(0,30,0)) else SmartTween(CFrame.new(-2022, 38, -12028)) end end) end
        if _G.KillAllBoss then pcall(function() local tb=nil for _, B in pairs(Workspace.Enemies:GetChildren()) do if string.find(B.Name, "Boss") and B.Humanoid.Health>0 then tb=B break end end if tb then SmartTween(tb.HumanoidRootPart.CFrame*CFrame.new(0,30,0)) end end) end
        if _G.KillPlr and _G.PlrName ~= "" then pcall(function() local p = Players:FindFirstChild(_G.PlrName) if p and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.Humanoid.Health>0 then SmartTween(p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 5, 4)) end end) end
        
        -- Tính năng TỪ XA BYPASS UI
        if _G.BuyChipAfar then pcall(function() CommF:InvokeServer("RaidsNpc", "Select", "Flame") end) end
        if _G.RandFruitAfar then pcall(function() CommF:InvokeServer("Cousin", "Buy") _G.RandFruitAfar=false end) end
        if _G.RandBoneAfar then pcall(function() CommF:InvokeServer("Bones", "Buy", 1, 1) end) end
        if _G.StartRaidAfar then
            pcall(function()
                if World2 then SmartTween(CFrame.new(-6438, 250, -4501)) task.wait(0.5) fireclickdetector(workspace.Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector) end
                if World3 then SmartTween(CFrame.new(-5017, 314, -2823)) task.wait(0.5) fireclickdetector(workspace.Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector) end
            end)
        end
        if _G.AutoRaid then pcall(function() for _, i in pairs(Workspace:GetChildren()) do if string.find(i.Name, "Island") and i:FindFirstChild("Hitbox") then SmartTween(i.Hitbox.CFrame * CFrame.new(0, 40, 0)) end end for _, m in pairs(Workspace.Enemies:GetChildren()) do if m.Humanoid.Health > 0 then SmartTween(m.HumanoidRootPart.CFrame*CFrame.new(0,30,0)) end end end) end
        if _G.SeaMoney then pcall(function() local sb=nil if Workspace:FindFirstChild("SeaBeasts") then for _,b in pairs(Workspace.SeaBeasts:GetChildren()) do if b.Humanoid.Health>0 then sb=b break end end end if sb then SmartTween(sb.HumanoidRootPart.CFrame*CFrame.new(0,50,0)) for _,k in ipairs({Enum.KeyCode.Z, Enum.KeyCode.X, Enum.KeyCode.C, Enum.KeyCode.V}) do VIM:SendKeyEvent(true,k,false,game) task.wait(0.05) VIM:SendKeyEvent(false,k,false,game) end else SmartTween(CFrame.new(-30000, 100, 30000)) end end) end
    end
end)

-- [SERVER STATUS & ESP PLAYER (XỊN)]
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            -- Status Trăng
            local mId = game:GetService("Lighting").Sky.MoonTextureId
            if mId == "http://www.roblox.com/asset/?id=9709149431" then _G.lblMoon.Text = "Trăng: FULL MOON (Trăng Tròn)" else _G.lblMoon.Text = "Trăng: Bình Thường" end
            -- Status Kata
            local kP = CommF:InvokeServer("CakePrinceSpawner")
            _G.lblKata.Text = "Katakuri: " .. (kP or "Không có")
            -- Status Item
            local ItemTxt = ""
            for _,p in pairs(Players:GetPlayers()) do if p.Backpack:FindFirstChild("God's Chalice") or (p.Character and p.Character:FindFirstChild("God's Chalice")) then ItemTxt=ItemTxt.."Cúp " end if p.Backpack:FindFirstChild("Fist of Darkness") or (p.Character and p.Character:FindFirstChild("Fist of Darkness")) then ItemTxt=ItemTxt.."Fist " end end
            _G.lblItem.Text = "Item Ngon: " .. (ItemTxt == "" and "Trống" or ItemTxt)
            -- Thời gian
            _G.lblTime.Text = "Time SV: " .. math.floor(Workspace.DistributedGameTime / 60) .. " Phút"
        end)
        
        -- ESP Player Full Detail
        if _G.ESPPlr then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    if not p.Character.HumanoidRootPart:FindFirstChild("ESPP") then
                        local bg = Instance.new("BillboardGui", p.Character.HumanoidRootPart) bg.Name = "ESPP" bg.Size = UDim2.new(0, 250, 0, 50) bg.AlwaysOnTop = true bg.StudsOffset = Vector3.new(0, 4, 0)
                        local txt = Instance.new("TextLabel", bg) txt.Size = UDim2.new(1,0,1,0) txt.BackgroundTransparency = 1 txt.TextScaled = true txt.Font = Enum.Font.GothamBold
                    end
                    local tag = p.PlayerGui:FindFirstChild("Main") and p.PlayerGui.Main:FindFirstChild("PvpDisabled") and p.PlayerGui.Main.PvpDisabled.Visible and "[PVP OFF]" or "[PVP ON]"
                    p.Character.HumanoidRootPart.ESPP.TextLabel.TextColor3 = tag == "[PVP ON]" and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(50, 255, 50)
                    p.Character.HumanoidRootPart.ESPP.TextLabel.Text = string.format("%s (Lv.%d) %s\nKhoảng cách: %dm", p.Name, p.Data.Level.Value, tag, math.floor((LocalPlayer.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude))
                end
            end
        else
            for _, p in pairs(Players:GetPlayers()) do if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.HumanoidRootPart:FindFirstChild("ESPP") then p.Character.HumanoidRootPart.ESPP:Destroy() end end
        end
    end
end)

-- CHỐNG ADMIN & SERVER HOP
task.spawn(function()
    while task.wait(1800) do
        if _G.AutoHop then
            local svrs = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
            for _, s in pairs(svrs.data) do if s.playing < s.maxPlayers and s.id ~= game.JobId then TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id, LocalPlayer) break end end
        end
    end
end)
-- LIGHT GALAXY HUB V18 - PHẦN 5 (HOÀN THIỆN)

-- [TỐI ƯU HÓA FPS - ANTI LAG CHO MÁY YẾU]
local function OptimizeGame()
    local Terrain = Workspace:FindFirstChildOfClass("Terrain")
    if Terrain then Terrain.WaterWaveSize = 0 Terrain.WaterReflectivity = 0 end
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
            v.Material = Enum.Material.Plastic v.Reflectance = 0
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") then
            v.Enabled = false
        end
    end
end

-- [PHÍM TẮT THAO TÁC NHANH]
game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.F then -- Nhấn F để đổi mục tiêu nhanh
        _G.PlrName = "" 
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (p.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if dist < 100 then _G.PlrName = p.Name break end
            end
        end
    end
end)

-- [BẢO VỆ SCRIPT KHỎI LỖI CHẶN LỆNH]
local Success, Error = pcall(function()
    OptimizeGame()
    -- Kiểm tra lại trạng thái server lần cuối
    print("LIGHT GALAXY HUB: System Loaded Successfully!")
end)

if not Success then
    warn("Có lỗi nhỏ khi khởi tạo hệ thống: " .. tostring(Error))
else
    -- Thông báo lên màn hình cho ní biết đã chạy thành công
    local Notify = Instance.new("TextLabel", Hub)
    Notify.Size = UDim2.new(0, 200, 0, 40) Notify.Position = UDim2.new(0.5, -100, 0, 10)
    Notify.BackgroundColor3 = Color3.fromRGB(0, 0, 0) Notify.Text = "SYSTEM READY - LIGHT GALAXY V18"
    Notify.TextColor3 = Color3.fromRGB(0, 255, 255) Notify.Font = Enum.Font.GothamBold Notify.Visible = true
    task.wait(3) Notify:Destroy()
end

-- ==============================================================================
-- HOÀN TẤT: CODE ĐÃ ĐƯỢC CHIA 5 PHẦN. NÍ DÁN LIÊN TIẾP LÀ OK!
-- ==============================================================================
