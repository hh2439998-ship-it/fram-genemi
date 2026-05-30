-- ==============================================================================
-- LIGHT GALAXY HUB ◆ V19.5 PRO MAX (FULL TẤT CẢ TÍNH NĂNG TỪ A-Z)
-- ==============================================================================
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local VIM = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer
local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")

local World1 = game.PlaceId == 2753915549 or game.PlaceId == 85211729168715
local World2 = game.PlaceId == 4442272183 or game.PlaceId == 79091703265657
local World3 = game.PlaceId == 7449423635 or game.PlaceId == 100117331123089

local UI_Parent = game:GetService("CoreGui")
if not UI_Parent or not pcall(function() local a = UI_Parent.Name end) then UI_Parent = LocalPlayer:WaitForChild("PlayerGui") end
if UI_Parent:FindFirstChild("LightGalaxyHub") then UI_Parent.LightGalaxyHub:Destroy() end

local Hub = Instance.new("ScreenGui", UI_Parent) Hub.Name = "LightGalaxyHub" Hub.ResetOnSpawn = false
local ToggleBtn = Instance.new("TextButton", Hub) ToggleBtn.Size = UDim2.new(0, 45, 0, 45) ToggleBtn.Position = UDim2.new(0, 10, 0.5, 0) ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 255) ToggleBtn.Text = "ẨN UI" ToggleBtn.Font = Enum.Font.GothamBold ToggleBtn.TextSize = 11 Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

local Main = Instance.new("Frame", Hub) Main.Size = UDim2.new(0, 600, 0, 380) Main.Position = UDim2.new(0.2, 0, 0.2, 0) Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20) Main.Draggable = true Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
local Top = Instance.new("Frame", Main) Top.Size = UDim2.new(1, 0, 0, 40) Top.BackgroundColor3 = Color3.fromRGB(25, 25, 35) Instance.new("UICorner", Top).CornerRadius = UDim.new(0, 10)
local Title = Instance.new("TextLabel", Top) Title.Size = UDim2.new(1, -30, 1, 0) Title.Position = UDim2.new(0, 15, 0, 0) Title.BackgroundTransparency = 1 Title.Font = Enum.Font.GothamBold Title.Text = "LIGHT GALAXY HUB ◆ V19.5 (CÀY THUÊ PRO MAX)" Title.TextColor3 = Color3.fromRGB(0, 255, 255) Title.TextSize = 14 Title.TextXAlignment = Enum.TextXAlignment.Left

ToggleBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible ToggleBtn.Text = Main.Visible and "ẨN UI" or "MỞ UI" end)

local TabSc = Instance.new("ScrollingFrame", Main) TabSc.Size = UDim2.new(0, 150, 1, -50) TabSc.Position = UDim2.new(0, 5, 0, 45) TabSc.BackgroundTransparency = 1 TabSc.ScrollBarThickness = 2 Instance.new("UIListLayout", TabSc).Padding = UDim.new(0, 4)
local Cont = Instance.new("Frame", Main) Cont.Size = UDim2.new(1, -165, 1, -50) Cont.Position = UDim2.new(0, 160, 0, 45) Cont.BackgroundColor3 = Color3.fromRGB(20, 20, 30) Instance.new("UICorner", Cont).CornerRadius = UDim.new(0, 8)

local Pages = {}
local function CreatePage(Name)
    local Pg = Instance.new("ScrollingFrame", Cont) Pg.Size = UDim2.new(1, 0, 1, 0) Pg.CanvasSize = UDim2.new(0, 0, 15, 0) Pg.BackgroundTransparency = 1 Pg.ScrollBarThickness = 3 Pg.Visible = false
    local Lyt = Instance.new("UIListLayout", Pg) Lyt.Padding = UDim.new(0, 6) local Pad = Instance.new("UIPadding", Pg) Pad.PaddingTop = UDim.new(0, 6) Pad.PaddingLeft = UDim.new(0, 6) Pages[Name] = Pg
    local Btn = Instance.new("TextButton", TabSc) Btn.Size = UDim2.new(1, -10, 0, 32) Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 50) Btn.Font = Enum.Font.GothamSemibold Btn.Text = Name Btn.TextColor3 = Color3.fromRGB(200, 200, 200) Btn.TextSize = 11 Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    Btn.MouseButton1Click:Connect(function() for _, p in pairs(Pages) do p.Visible = false end Pg.Visible = true for _, b in pairs(TabSc:GetChildren()) do if b:IsA("TextButton") then b.TextColor3 = Color3.fromRGB(200, 200, 200) b.BackgroundColor3 = Color3.fromRGB(35, 35, 50) end end Btn.TextColor3 = Color3.fromRGB(0, 255, 255) Btn.BackgroundColor3 = Color3.fromRGB(50, 40, 80) end)
    return Pg
end

local function AddToggle(Pg, Txt, Var)
    _G[Var] = false
    local Frm = Instance.new("Frame", Pg) Frm.Size = UDim2.new(1, -12, 0, 38) Frm.BackgroundColor3 = Color3.fromRGB(30, 30, 45) Instance.new("UICorner", Frm).CornerRadius = UDim.new(0, 6)
    local Lbl = Instance.new("TextLabel", Frm) Lbl.Size = UDim2.new(0.7, 0, 1, 0) Lbl.Position = UDim2.new(0, 10, 0, 0) Lbl.BackgroundTransparency = 1 Lbl.Font = Enum.Font.Gotham Lbl.Text = Txt Lbl.TextColor3 = Color3.fromRGB(255, 255, 255) Lbl.TextSize = 11 Lbl.TextXAlignment = Enum.TextXAlignment.Left
    local Btn = Instance.new("TextButton", Frm) Btn.Size = UDim2.new(0, 45, 0, 22) Btn.Position = UDim2.new(1, -55, 0, 8) Btn.BackgroundColor3 = Color3.fromRGB(150, 50, 50) Btn.Font = Enum.Font.GothamBold Btn.Text = "OFF" Btn.TextColor3 = Color3.fromRGB(255, 255, 255) Btn.TextSize = 10 Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)
    Btn.MouseButton1Click:Connect(function() _G[Var] = not _G[Var] Btn.BackgroundColor3 = _G[Var] and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50) Btn.Text = _G[Var] and "ON" or "OFF" end)
end

local function AddLbl(Pg, Txt, VarStore)
    local Lbl = Instance.new("TextLabel", Pg) Lbl.Size = UDim2.new(1, -12, 0, 25) Lbl.BackgroundTransparency = 1 Lbl.Font = Enum.Font.GothamBold Lbl.Text = Txt Lbl.TextColor3 = Color3.fromRGB(0, 255, 150) Lbl.TextSize = 12 Lbl.TextXAlignment = Enum.TextXAlignment.Left
    if VarStore then _G[VarStore] = Lbl end
end
-- LIGHT GALAXY HUB V19.5 - PHẦN 2
local pFarm = CreatePage("Auto Farm Level")
local pSetFarm = CreatePage("Setting Farm")
local pSeaEv = CreatePage("Sea Events (VIP)")
local pBoss = CreatePage("Boss & Raid")
local pPvP = CreatePage("PVP & Status") -- ĐÃ KHÔI PHỤC TAB STATUS
local pMisc = CreatePage("ESP & Hacks") -- ĐÃ KHÔI PHỤC TAB ESP

Pages["PVP & Status"].Visible = true

_G.FarmLv = false; _G.FarmBone = false; _G.FarmCake = false
_G.BringMob = true; _G.FastAtk = true; _G.AuraM1Fruit = false; _G.DragonStorm = false; _G.SmartPortal = true
_G.AutoSeaEvent = false; _G.UseM1Sea = false; _G.SpamMelee = true; _G.SpamSword = true; _G.SpamGun = true; _G.SpamFruit = true
_G.KillBoss = false; _G.KillAllBoss = false; _G.AutoRaid = false
_G.KillPlr = false; _G.SilentAim = false; _G.ESPPlr = false; _G.PlrName = ""

-- [TAB SETTING FARM]
AddToggle(pSetFarm, "Real Bring Mob 8m (Gom Quái)", "BringMob")
AddToggle(pSetFarm, "Fast Attack (Đánh Nhanh)", "FastAtk")
AddToggle(pSetFarm, "M1 Fruit Aura (Đánh m1 bằng Trái Ác Quỷ)", "AuraM1Fruit")
AddToggle(pSetFarm, "Aura Dragon Storm (Diệt diện rộng 250m)", "DragonStorm")
AddToggle(pSetFarm, "Sử Dụng Smart Portal C (Dịch chuyển bay)", "SmartPortal")

-- [TAB AUTO FARM]
AddToggle(pFarm, "Auto Farm Level (Full Quest Logic)", "FarmLv")
AddToggle(pFarm, "Auto Farm Xương", "FarmBone")
AddToggle(pFarm, "Auto Farm Bánh", "FarmCake")

-- [TAB SEA EVENTS]
AddToggle(pSeaEv, "Auto Sea Events (Mua thuyền + Noclip)", "AutoSeaEvent")
AddToggle(pSeaEv, "Dùng M1 Fruit đánh Sea Event", "UseM1Sea")
AddToggle(pSeaEv, "Auto Spam Skill Melee", "SpamMelee")
AddToggle(pSeaEv, "Auto Spam Skill Sword", "SpamSword")
AddToggle(pSeaEv, "Auto Spam Skill Gun", "SpamGun")
AddToggle(pSeaEv, "Auto Spam Skill Blox Fruit", "SpamFruit")

-- [TAB BOSS & RAID]
AddToggle(pBoss, "Auto Săn Tất Cả Boss Server", "KillAllBoss")
AddToggle(pBoss, "Auto Đi Raid", "AutoRaid")

-- [TAB PVP & STATUS SERVER]
AddToggle(pPvP, "Auto Bay Cắn Player (PVP)", "KillPlr")
AddToggle(pPvP, "SILENT AIM (Skill Tự Bẻ Lái)", "SilentAim")
AddLbl(pPvP, "============ STATUS SERVER ============", nil)
AddLbl(pPvP, "Đếm Ngược Full Moon: Loading...", "lblMoonTime")
AddLbl(pPvP, "Số Quái Kata (Triệu hồi): Loading...", "lblKata")
AddLbl(pPvP, "Thời gian Game (Râu Đen/Cúp): Loading...", "lblSrvTime")
AddLbl(pPvP, "Cúp / Key Râu Đen trong SV: Loading...", "lblItem")
AddLbl(pPvP, "Đảo Mirage (Kì Bí): Loading...", "lblMirage")
AddLbl(pPvP, "Đảo Kitsune (Tyan - Azure): Loading...", "lblKitsune")
AddLbl(pPvP, "Đảo Leviathan / Mắt Terror: Loading...", "lblLevi")
AddLbl(pPvP, "Đảo Núi Lửa (Danger 6): Loading...", "lblVolcano")

-- [TAB ESP & MISC]
AddToggle(pMisc, "ESP Player (Chuẩn Redz - Bật/Tắt PVP)", "ESPPlr")
-- LIGHT GALAXY HUB V19.5 - PHẦN 3

-- [HÀM BAY SMART PORTAL C VÀ BODYVELOCITY]
local function GetPortalFruit()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Portal-Portal") then return char["Portal-Portal"] end
    if LocalPlayer.Backpack:FindFirstChild("Portal-Portal") then return LocalPlayer.Backpack["Portal-Portal"] end return nil
end

local function SmartTween(TargetCFrame)
    local Char = LocalPlayer.Character if not Char or not Char:FindFirstChild("HumanoidRootPart") then return end
    local Root = Char.HumanoidRootPart local Dist = (Root.Position - TargetCFrame.Position).Magnitude

    if _G.SmartPortal and Dist > 2000 then
        local PortalFruit = GetPortalFruit()
        if PortalFruit then
            Char.Humanoid:EquipTool(PortalFruit) task.wait(0.2)
            pcall(function() ReplicatedStorage.Modules.Net:FindFirstChild("RE/Shoot"):FireServer(TargetCFrame.Position, "C") end)
            task.wait(1) return
        end
    end

    local BV = Root:FindFirstChild("FlyBV")
    if not BV then BV = Instance.new("BodyVelocity", Root) BV.Name = "FlyBV" BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge) BV.Velocity = Vector3.new(0, 0, 0) end
    local TweenAction = TweenService:Create(Root, TweenInfo.new(Dist / 330, Enum.EasingStyle.Linear), {CFrame = TargetCFrame})
    local Noclip = RunService.Stepped:Connect(function() if Char and Char:FindFirstChild("HumanoidRootPart") then for _, P in pairs(Char:GetChildren()) do if P:IsA("BasePart") then P.CanCollide = false end end end end)
    TweenAction:Play() TweenAction.Completed:Wait() Noclip:Disconnect()
    if Root:FindFirstChild("FlyBV") then Root.FlyBV:Destroy() end Root.CanCollide = true
end

-- [QUEST LOGIC ĐẦY ĐỦ]
local function GetQuestLogic()
    local Lvl = LocalPlayer.Data.Level.Value
    local QuestName, QuestNum, MobName, QuestCFrame, MobCFrame = "", 1, "", CFrame.new(0,0,0), CFrame.new(0,0,0)
    if Lvl >= 1500 and Lvl <= 1525 then QuestName = "Pirate Millionaire Quest" QuestNum = 1 MobName = "Pirate Millionaire" QuestCFrame = CFrame.new(-318, 44, 5972) MobCFrame = CFrame.new(-318, 44, 5972)
    elseif Lvl >= 1525 and Lvl <= 1575 then QuestName = "Pistol Billionaire Quest" QuestNum = 1 MobName = "Pistol Billionaire" QuestCFrame = CFrame.new(-462, 73, 5325) MobCFrame = CFrame.new(-462, 73, 5325)
    else QuestName = "Bypass" MobName = "Bypass" end
    return QuestName, QuestNum, MobName, QuestCFrame, MobCFrame
end

local function AutoQuestFarm()
    if not _G.FarmLv then return end
    local qName, qNum, mName, qPos, mPos = GetQuestLogic()
    if qName ~= "Bypass" then
        if not LocalPlayer.PlayerGui.Main.Quest.Visible then
            SmartTween(qPos) task.wait(0.5) CommF:InvokeServer("StartQuest", qName, qNum)
        else
            local tMob = nil for _, E in pairs(Workspace.Enemies:GetChildren()) do if string.find(E.Name, mName) and E.Humanoid.Health > 0 then tMob = E break end end
            if tMob then SmartTween(tMob.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)) else SmartTween(mPos * CFrame.new(0, 50, 0)) end
        end
    else
        for _, E in pairs(Workspace.Enemies:GetChildren()) do if E.Humanoid.Health > 0 then SmartTween(E.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)) break end end
    end
end
-- LIGHT GALAXY HUB V19.5 - PHẦN 4

-- [AUTO SEA EVENT BÁ ĐẠO]
task.spawn(function()
    while task.wait(0.5) do
        if _G.AutoSeaEvent then
            pcall(function()
                local Char = LocalPlayer.Character local Root = Char and Char:FindFirstChild("HumanoidRootPart") if not Root then return end
                local target = nil
                if Workspace:FindFirstChild("SeaBeasts") then for _, sb in pairs(Workspace.SeaBeasts:GetChildren()) do if sb:FindFirstChild("HumanoidRootPart") and sb.Humanoid.Health > 0 then target = sb break end end end
                if not target then for _, b in pairs(Workspace.Enemies:GetChildren()) do if (string.find(b.Name, "Ship") or string.find(b.Name, "Ghost")) and b.Humanoid.Health > 0 then target = b break end end end

                if target then
                    SmartTween(target.HumanoidRootPart.CFrame * CFrame.new(0, 150, 0))
                    local toolsToUse = {}
                    if _G.SpamMelee then table.insert(toolsToUse, "Melee") end if _G.SpamSword then table.insert(toolsToUse, "Sword") end
                    if _G.SpamGun then table.insert(toolsToUse, "Gun") end if _G.SpamFruit then table.insert(toolsToUse, "Blox Fruit") end
                    for _, toolType in ipairs(toolsToUse) do
                        for _, T in pairs(LocalPlayer.Backpack:GetChildren()) do
                            if T:IsA("Tool") and T.ToolTip == toolType then
                                Char.Humanoid:EquipTool(T)
                                for _, k in ipairs({Enum.KeyCode.Z, Enum.KeyCode.X, Enum.KeyCode.C, Enum.KeyCode.V}) do VIM:SendKeyEvent(true, k, false, game) task.wait(0.1) VIM:SendKeyEvent(false, k, false, game) end break
                            end
                        end
                    end
                else
                    local MyBoat = nil for _, v in pairs(Workspace.Boats:GetChildren()) do if v:FindFirstChild("Owner") and v.Owner.Value == LocalPlayer then MyBoat = v break end end
                    if not MyBoat then
                        SmartTween(CFrame.new(-9428, 20, 18764)) task.wait(1) CommF:InvokeServer("BuyBoat", "Guardian")
                    else
                        local Seat = MyBoat:FindFirstChild("VehicleSeat")
                        if Seat and not Seat.Occupant then Root.CFrame = Seat.CFrame else
                            for _, part in pairs(MyBoat:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end
                            if MyBoat:FindFirstChild("Engine") then
                                local BV = MyBoat.Engine:FindFirstChild("BodyVelocity") or Instance.new("BodyVelocity", MyBoat.Engine)
                                BV.MaxForce = Vector3.new(math.huge, 0, math.huge) BV.Velocity = MyBoat.Engine.CFrame.LookVector * 300
                            end
                            MyBoat:SetPrimaryPartCFrame(MyBoat.PrimaryPart.CFrame * CFrame.new(0, 0, -300))
                        end
                    end
                end
            end)
        end
    end
end)

-- [FAST ATTACK + M1 AURA FRUIT + DRAGON STORM]
task.spawn(function()
    while task.wait(0.01) do
        if _G.FastAtk or _G.AuraM1Fruit or _G.DragonStorm then
            pcall(function()
                local Char = LocalPlayer.Character if not Char or not Char:FindFirstChild('HumanoidRootPart') then return end
                local root = Char.HumanoidRootPart local u17 = {} local range = _G.DragonStorm and 250 or 75
                
                for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                    local eRoot = mob:FindFirstChild('HumanoidRootPart')
                    if eRoot and mob.Humanoid.Health > 0 and (eRoot.Position - root.Position).Magnitude <= range then
                        for _, part in ipairs(mob:GetChildren()) do if part:IsA('BasePart') then table.insert(u17, {mob, part}) end end
                    end
                end

                if #u17 > 0 then
                    if _G.DragonStorm then
                        local storm = Instance.new("Part", Workspace) storm.Size = Vector3.new(range, 2, range) storm.Position = root.Position storm.Anchored = true storm.CanCollide = false storm.Material = Enum.Material.Neon storm.Color = Color3.fromRGB(255, 50, 0) storm.Transparency = 0.5 Instance.new("CylinderMesh", storm) game.Debris:AddItem(storm, 0.1)
                    end
                    if _G.AuraM1Fruit or (_G.UseM1Sea and _G.AutoSeaEvent) then for _, T in pairs(LocalPlayer.Backpack:GetChildren()) do if T:IsA("Tool") and T.ToolTip == "Blox Fruit" then Char.Humanoid:EquipTool(T) break end end
                    elseif not Char:FindFirstChildOfClass("Tool") then for _, T in pairs(LocalPlayer.Backpack:GetChildren()) do if T:IsA("Tool") and (T.ToolTip == "Melee" or T.ToolTip == "Sword") then Char.Humanoid:EquipTool(T) break end end end
                    require(ReplicatedStorage.Modules.Net):RemoteEvent('RegisterHit', true) ReplicatedStorage.Modules.Net['RE/RegisterAttack']:FireServer()
                end
            end)
        end
    end
end)
-- LIGHT GALAXY HUB V19.5 - PHẦN 5

-- [ĐẾM THỜI GIAN SERVER VÀ QUÉT ĐẢO, ESP PVP KIỂU REDZ]
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            -- Status Server
            local moonTex = Lighting.Sky.MoonTextureId
            local moonPhases = { ["http://www.roblox.com/asset/?id=9709149431"]=8, ["http://www.roblox.com/asset/?id=9709149052"]=7, ["http://www.roblox.com/asset/?id=9709143733"]=1 }
            local currentPhase = 0 for tex, phase in pairs(moonPhases) do if string.find(moonTex, tex) then currentPhase = phase break end end
            if currentPhase == 8 or string.find(moonTex, "9709149431") or string.find(moonTex, "9709135895") then _G.lblMoonTime.Text = "Trăng: ĐANG FULL MOON (Moon 8)" else
                local timeToNight = (18 - Lighting.ClockTime) if timeToNight < 0 then timeToNight = timeToNight + 24 end local realMins = math.floor(timeToNight * (20/24))
                _G.lblMoonTime.Text = "Trăng: Moon "..(currentPhase>0 and currentPhase or "?").." (Còn ~"..realMins.." phút tới tối)"
            end

            local kP = CommF:InvokeServer("CakePrinceSpawner")
            if type(kP) == "number" then _G.lblKata.Text = "Số Quái Kata cần giết: " .. (500 - kP) .. " con" else _G.lblKata.Text = "Kata: " .. tostring(kP or "Đã mở cổng") end
            
            local serverTime = math.floor(Workspace.DistributedGameTime / 60) local nextBB = 240 - (serverTime % 240)
            _G.lblSrvTime.Text = "Thời gian SV: "..serverTime.." Phút (~"..nextBB.."p nữa có Cúp/Key Râu đen)"

            local ItemTxt = ""
            for _,p in pairs(Players:GetPlayers()) do if p.Backpack:FindFirstChild("God's Chalice") or (p.Character and p.Character:FindFirstChild("God's Chalice")) then ItemTxt=ItemTxt.."Cúp " end if p.Backpack:FindFirstChild("Fist of Darkness") or (p.Character and p.Character:FindFirstChild("Fist of Darkness")) then ItemTxt=ItemTxt.."Fist " end end
            _G.lblItem.Text = "Người cầm Cúp/Fist: " .. (ItemTxt == "" and "KHÔNG CÓ AI" or ItemTxt)

            local map = Workspace:FindFirstChild("Map") and Workspace.Map:GetChildren() or Workspace:GetChildren()
            local hasMirage, hasKitsune, hasLevi, hasVolcano = false, false, false, false
            for _, v in pairs(map) do
                if string.find(v.Name, "Mystic") or string.find(v.Name, "Mirage") then hasMirage = true end if string.find(v.Name, "Kitsune") then hasKitsune = true end
                if string.find(v.Name, "Leviathan") or string.find(v.Name, "Frozen") then hasLevi = true end if string.find(v.Name, "Volcano") or string.find(v.Name, "Rumling") then hasVolcano = true end
            end
            _G.lblMirage.Text = "Đảo Mirage (Kì Bí): " .. (hasMirage and "🟢 ĐANG CÓ" or "🔴 KHÔNG")
            _G.lblKitsune.Text = "Đảo Kitsune (Tyan): " .. (hasKitsune and "🟢 ĐANG CÓ" or "🔴 KHÔNG")
            _G.lblLevi.Text = "Đảo Leviathan: " .. (hasLevi and "🟢 ĐANG CÓ" or "🔴 KHÔNG")
            _G.lblVolcano.Text = "Đảo Núi Lửa: " .. (hasVolcano and "🟢 ĐANG CÓ" or "🔴 KHÔNG")
        end)
        
        -- ESP REDZ (BẬT/TẮT PVP)
        if _G.ESPPlr then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    if not p.Character.HumanoidRootPart:FindFirstChild("ESPP") then
                        local bg = Instance.new("BillboardGui", p.Character.HumanoidRootPart) bg.Name = "ESPP" bg.Size = UDim2.new(0, 250, 0, 50) bg.AlwaysOnTop = true bg.StudsOffset = Vector3.new(0, 4, 0)
                        local txt = Instance.new("TextLabel", bg) txt.Size = UDim2.new(1,0,1,0) txt.BackgroundTransparency = 1 txt.TextScaled = true txt.Font = Enum.Font.GothamBold
                    end
                    local pvpState, pvpColor = "PVP: BẬT", Color3.fromRGB(255, 50, 50)
                    if p:FindFirstChild("Data") and p.Data:FindFirstChild("PvpDisabled") and p.Data.PvpDisabled.Value == true then pvpState, pvpColor = "PVP: TẮT (SAFE)", Color3.fromRGB(50, 255, 50) elseif p.Character:FindFirstChild("SafeZone") then pvpState, pvpColor = "PVP: TẮT (TRONG VÙNG AN TOÀN)", Color3.fromRGB(50, 255, 50) end
                    p.Character.HumanoidRootPart.ESPP.TextLabel.TextColor3 = pvpColor
                    p.Character.HumanoidRootPart.ESPP.TextLabel.Text = string.format("[%s]\nLv.%d | Khoảng cách: %dm\n%s", p.Name, p.Data.Level.Value, math.floor((LocalPlayer.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude), pvpState)
                end
            end
        else
            for _, p in pairs(Players:GetPlayers()) do if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.HumanoidRootPart:FindFirstChild("ESPP") then p.Character.HumanoidRootPart.ESPP:Destroy() end end
        end
    end
end)

-- [VÒNG LẶP GOM QUÁI & CLICK]
task.spawn(function()
    while task.wait(0.1) do
        if _G.BringMob then pcall(function() local MyRoot = LocalPlayer.Character.HumanoidRootPart for _, Enemy in pairs(Workspace.Enemies:GetChildren()) do if Enemy:FindFirstChild("HumanoidRootPart") and Enemy.Humanoid.Health > 0 and (Enemy.HumanoidRootPart.Position - MyRoot.Position).Magnitude < 350 then Enemy.HumanoidRootPart.Size = Vector3.new(65, 65, 65) Enemy.HumanoidRootPart.CanCollide = false Enemy.HumanoidRootPart.CFrame = MyRoot.CFrame * CFrame.new(0, -8, 0) Enemy.Humanoid.PlatformStand = true Enemy.Humanoid.WalkSpeed = 0 end end end) end
        if _G.FarmLv or _G.FarmBone or _G.FarmCake or _G.AutoSeaEvent then pcall(function() VirtualUser:CaptureController() VirtualUser:ClickButton1(Vector2.new(850, 850)) end) end
    end
end)

-- [THỰC THI FARM]
task.spawn(function()
    while task.wait(0.2) do
        if _G.FarmLv then AutoQuestFarm() end
        if _G.FarmBone then pcall(function() local t=nil for _, E in pairs(Workspace.Enemies:GetChildren()) do if (E.Name=="Reborn Skeleton" or E.Name=="Living Zombie") and E.Humanoid.Health>0 then t=E break end end if t then SmartTween(t.HumanoidRootPart.CFrame*CFrame.new(0,30,0)) else SmartTween(CFrame.new(-9481, 142, 5566)) end end) end
        if _G.FarmCake then pcall(function() local t=nil for _, E in pairs(Workspace.Enemies:GetChildren()) do if string.find(E.Name, "Cake") and E.Humanoid.Health>0 then t=E break end end if t then SmartTween(t.HumanoidRootPart.CFrame*CFrame.new(0,30,0)) else SmartTween(CFrame.new(-2022, 38, -12028)) end end) end
    end
end)
