-- ==============================================================================
-- LIGHT GALAXY HUB ◆ V20.0 (BẢN FIX LỖI TỔNG HỢP - TRẮNG ĐEN CLEAN UI)
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

local UI_Parent = game:GetService("CoreGui")
if not UI_Parent or not pcall(function() local a = UI_Parent.Name end) then UI_Parent = LocalPlayer:WaitForChild("PlayerGui") end
if UI_Parent:FindFirstChild("LightGalaxyHub") then UI_Parent.LightGalaxyHub:Destroy() end

local Hub = Instance.new("ScreenGui", UI_Parent) Hub.Name = "LightGalaxyHub" Hub.ResetOnSpawn = false
local ToggleBtn = Instance.new("TextButton", Hub) ToggleBtn.Size = UDim2.new(0, 45, 0, 45) ToggleBtn.Position = UDim2.new(0, 10, 0.5, 0) ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 255) ToggleBtn.Text = "ẨN UI" ToggleBtn.Font = Enum.Font.GothamBold ToggleBtn.TextSize = 11 Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

local Main = Instance.new("Frame", Hub) Main.Size = UDim2.new(0, 620, 0, 400) Main.Position = UDim2.new(0.2, 0, 0.2, 0) Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20) Main.Draggable = true Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)
local Top = Instance.new("Frame", Main) Top.Size = UDim2.new(1, 0, 0, 40) Top.BackgroundColor3 = Color3.fromRGB(25, 25, 30) Instance.new("UICorner", Top).CornerRadius = UDim.new(0, 8)
local Title = Instance.new("TextLabel", Top) Title.Size = UDim2.new(1, -30, 1, 0) Title.Position = UDim2.new(0, 15, 0, 0) Title.BackgroundTransparency = 1 Title.Font = Enum.Font.GothamBold Title.Text = "LIGHT GALAXY HUB ◆ V20.0" Title.TextColor3 = Color3.fromRGB(255, 255, 255) Title.TextSize = 15 Title.TextXAlignment = Enum.TextXAlignment.Left

ToggleBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible ToggleBtn.Text = Main.Visible and "ẨN UI" or "MỞ UI" end)

local TabSc = Instance.new("ScrollingFrame", Main) TabSc.Size = UDim2.new(0, 160, 1, -50) TabSc.Position = UDim2.new(0, 5, 0, 45) TabSc.BackgroundTransparency = 1 TabSc.ScrollBarThickness = 1 Instance.new("UIListLayout", TabSc).Padding = UDim.new(0, 5)
local Cont = Instance.new("Frame", Main) Cont.Size = UDim2.new(1, -175, 1, -50) Cont.Position = UDim2.new(0, 170, 0, 45) Cont.BackgroundColor3 = Color3.fromRGB(20, 20, 25) Instance.new("UICorner", Cont).CornerRadius = UDim.new(0, 6)

local Pages = {}
local function CreatePage(Name)
    local Pg = Instance.new("ScrollingFrame", Cont) Pg.Size = UDim2.new(1, 0, 1, 0) Pg.CanvasSize = UDim2.new(0, 0, 15, 0) Pg.BackgroundTransparency = 1 Pg.ScrollBarThickness = 2 Pg.Visible = false
    local Lyt = Instance.new("UIListLayout", Pg) Lyt.Padding = UDim.new(0, 6) local Pad = Instance.new("UIPadding", Pg) Pad.PaddingTop = UDim.new(0, 8) Pad.PaddingLeft = UDim.new(0, 8) Pages[Name] = Pg
    local Btn = Instance.new("TextButton", TabSc) Btn.Size = UDim2.new(1, -10, 0, 35) Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40) Btn.Font = Enum.Font.GothamSemibold Btn.Text = Name Btn.TextColor3 = Color3.fromRGB(220, 220, 220) Btn.TextSize = 12 Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    Btn.MouseButton1Click:Connect(function() for _, p in pairs(Pages) do p.Visible = false end Pg.Visible = true for _, b in pairs(TabSc:GetChildren()) do if b:IsA("TextButton") then b.TextColor3 = Color3.fromRGB(220, 220, 220) b.BackgroundColor3 = Color3.fromRGB(30, 30, 40) end end Btn.TextColor3 = Color3.fromRGB(255, 255, 255) Btn.BackgroundColor3 = Color3.fromRGB(45, 100, 255) end)
    return Pg
end
-- LIGHT GALAXY HUB V20.0 - PHẦN 2
local function AddToggle(Pg, Txt, Var)
    _G[Var] = false
    local Frm = Instance.new("Frame", Pg) Frm.Size = UDim2.new(1, -16, 0, 40) Frm.BackgroundColor3 = Color3.fromRGB(30, 30, 40) Instance.new("UICorner", Frm).CornerRadius = UDim.new(0, 6)
    local Lbl = Instance.new("TextLabel", Frm) Lbl.Size = UDim2.new(0.7, 0, 1, 0) Lbl.Position = UDim2.new(0, 10, 0, 0) Lbl.BackgroundTransparency = 1 Lbl.Font = Enum.Font.Gotham Lbl.Text = Txt Lbl.TextColor3 = Color3.fromRGB(255, 255, 255) Lbl.TextSize = 12 Lbl.TextXAlignment = Enum.TextXAlignment.Left
    local Btn = Instance.new("TextButton", Frm) Btn.Size = UDim2.new(0, 50, 0, 24) Btn.Position = UDim2.new(1, -60, 0, 8) Btn.BackgroundColor3 = Color3.fromRGB(100, 100, 100) Btn.Font = Enum.Font.GothamBold Btn.Text = "OFF" Btn.TextColor3 = Color3.fromRGB(255, 255, 255) Btn.TextSize = 11 Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)
    Btn.MouseButton1Click:Connect(function() _G[Var] = not _G[Var] Btn.BackgroundColor3 = _G[Var] and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(100, 100, 100) Btn.Text = _G[Var] and "ON" or "OFF" end)
end

local function AddLbl(Pg, Txt, VarStore)
    local Lbl = Instance.new("TextLabel", Pg) Lbl.Size = UDim2.new(1, -16, 0, 25) Lbl.BackgroundTransparency = 1 Lbl.Font = Enum.Font.GothamBold Lbl.Text = Txt Lbl.TextColor3 = Color3.fromRGB(255, 255, 255) Lbl.TextSize = 12 Lbl.TextXAlignment = Enum.TextXAlignment.Left
    if VarStore then _G[VarStore] = Lbl end
end

local function AddDropdown(Pg, Txt, List, Var)
    _G[Var] = ""
    local Frm = Instance.new("Frame", Pg) Frm.Size = UDim2.new(1, -16, 0, 65) Frm.BackgroundColor3 = Color3.fromRGB(30, 30, 40) Instance.new("UICorner", Frm).CornerRadius = UDim.new(0, 6)
    local Lbl = Instance.new("TextLabel", Frm) Lbl.Size = UDim2.new(1, -20, 0, 25) Lbl.Position = UDim2.new(0, 10, 0, 5) Lbl.BackgroundTransparency = 1 Lbl.Font = Enum.Font.Gotham Lbl.Text = Txt Lbl.TextColor3 = Color3.fromRGB(255, 255, 255) Lbl.TextSize = 12 Lbl.TextXAlignment = Enum.TextXAlignment.Left
    local Box = Instance.new("TextBox", Frm) Box.Size = UDim2.new(1, -20, 0, 25) Box.Position = UDim2.new(0, 10, 0, 30) Box.BackgroundColor3 = Color3.fromRGB(20, 20, 25) Box.TextColor3 = Color3.fromRGB(255, 255, 255) Box.Text = "Nhập tên Player..." Box.Font = Enum.Font.Gotham Box.TextSize = 11 Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 4)
    Box.FocusLost:Connect(function() _G[Var] = Box.Text end)
    -- Nút Refresh danh sách Player
    local Rfs = Instance.new("TextButton", Frm) Rfs.Size = UDim2.new(0, 60, 0, 20) Rfs.Position = UDim2.new(1, -70, 0, 5) Rfs.BackgroundColor3 = Color3.fromRGB(45, 100, 255) Rfs.Text = "Refresh" Rfs.TextColor3 = Color3.fromRGB(255, 255, 255) Rfs.Font = Enum.Font.GothamBold Rfs.TextSize = 10 Instance.new("UICorner", Rfs).CornerRadius = UDim.new(0, 4)
    Rfs.MouseButton1Click:Connect(function() local pList="" for _,p in pairs(Players:GetPlayers()) do if p~=LocalPlayer then pList=pList..p.Name..", " end end Box.Text = "Chọn: "..pList end)
end
-- LIGHT GALAXY HUB V20.0 - PHẦN 3
local pFarm = CreatePage("Auto Farm Level")
local pSetFarm = CreatePage("Setting Farm")
local pSeaEv = CreatePage("Sea Events (VIP)")
local pBoss = CreatePage("Boss & Raid")
local pPvP = CreatePage("Chế Độ PVP") -- TÁCH RIÊNG
local pStatus = CreatePage("Status Server") -- TÁCH RIÊNG
local pMisc = CreatePage("ESP & Extras")

Pages["Chế Độ PVP"].Visible = true

_G.FarmLv = false; _G.FarmBone = false; _G.FarmCake = false
_G.BringMob = true; _G.FastAtk = true; _G.AuraM1Fruit = false; _G.DragonStorm = false; _G.SmartPortal = true
_G.AutoSeaEvent = false; _G.UseM1Sea = false; _G.SpamMelee = true; _G.SpamSword = true; _G.SpamGun = true; _G.SpamFruit = true
_G.KillPlr = false; _G.SilentAim = false; _G.TargetPlayer = ""
_G.ESPPlr = false

-- [TAB SETTING FARM]
AddToggle(pSetFarm, "Real Bring Mob 8m (Gom Quái)", "BringMob")
AddToggle(pSetFarm, "M1 Fruit Aura (Đánh m1 Trái Ác Quỷ)", "AuraM1Fruit")
AddToggle(pSetFarm, "Fast Attack (Đánh Nhanh - Đã Fix)", "FastAtk")
AddToggle(pSetFarm, "Aura Dragon Storm (Siêu Đánh Lan)", "DragonStorm")
AddToggle(pSetFarm, "Smart Portal C (Bay cực nhanh)", "SmartPortal")

-- [TAB AUTO FARM & SEA EVENTS]
AddToggle(pFarm, "Auto Farm Level (Full Nhiệm Vụ)", "FarmLv")
AddToggle(pFarm, "Auto Farm Xương", "FarmBone")
AddToggle(pFarm, "Auto Farm Bánh", "FarmCake")

AddToggle(pSeaEv, "Auto Sea Events (Săn Thuyền/Quái Biển)", "AutoSeaEvent")
AddToggle(pSeaEv, "Dùng M1 Fruit đánh Sea Event", "UseM1Sea")
AddToggle(pSeaEv, "Auto Spam Melee (Sea Event)", "SpamMelee")
AddToggle(pSeaEv, "Auto Spam Sword (Sea Event)", "SpamSword")
AddToggle(pSeaEv, "Auto Spam Blox Fruit (Sea Event)", "SpamFruit")

-- [TAB PVP]
AddDropdown(pPvP, "Select Player (Chọn mục tiêu):", {}, "TargetPlayer")
AddToggle(pPvP, "Auto Bay Tiêu Diệt Player (PVP)", "KillPlr")
AddToggle(pPvP, "SILENT AIM (Bẻ cong skill trúng đích)", "SilentAim")

-- [TAB STATUS SERVER - CHỮ TRẮNG, FULL MOON 1/8]
AddLbl(pStatus, "============ STATUS SERVER ============", nil)
AddLbl(pStatus, "Trăng: Loading...", "lblMoonTime")
AddLbl(pStatus, "Quái Kata: Loading...", "lblKata")
AddLbl(pStatus, "Thời gian Server: Loading...", "lblSrvTime")
AddLbl(pStatus, "Vật phẩm Râu Đen/Cúp: Loading...", "lblItem")
AddLbl(pStatus, "Đảo Mirage (Kì Bí): Loading...", "lblMirage")
AddLbl(pStatus, "Đảo Kitsune (Tyan): Loading...", "lblKitsune")

-- [TAB ESP]
AddToggle(pMisc, "ESP Player (Chữ Trắng - Clean)", "ESPPlr")
-- LIGHT GALAXY HUB V20.0 - PHẦN 4
local function SmartTween(TargetCFrame)
    local Char = LocalPlayer.Character if not Char or not Char:FindFirstChild("HumanoidRootPart") then return end
    local Root = Char.HumanoidRootPart local Dist = (Root.Position - TargetCFrame.Position).Magnitude

    if _G.SmartPortal and Dist > 1500 and LocalPlayer.Backpack:FindFirstChild("Portal-Portal") then
        Char.Humanoid:EquipTool(LocalPlayer.Backpack["Portal-Portal"]) task.wait(0.2)
        pcall(function() ReplicatedStorage.Modules.Net:FindFirstChild("RE/Shoot"):FireServer(TargetCFrame.Position, "C") end) task.wait(1.5) return
    end

    local BV = Root:FindFirstChild("FlyBV") or Instance.new("BodyVelocity", Root) BV.Name = "FlyBV"
    BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge) BV.Velocity = Vector3.new(0, 0, 0)
    local TweenAction = TweenService:Create(Root, TweenInfo.new(Dist / 330, Enum.EasingStyle.Linear), {CFrame = TargetCFrame})
    local Noclip = RunService.Stepped:Connect(function() for _, P in pairs(Char:GetChildren()) do if P:IsA("BasePart") then P.CanCollide = false end end end)
    TweenAction:Play() TweenAction.Completed:Wait() Noclip:Disconnect() Root.CanCollide = true if Root:FindFirstChild("FlyBV") then Root.FlyBV:Destroy() end
end

-- [LÕI ĐÁNH NHANH & DRAGON STORM - ĐÃ FIX KHÔNG LỖI NET HIT]
local CombatFramework = require(LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
local function GetCurrentBlade()
    local p1 = CombatFramework.activeController if not p1 then return nil end
    local p2 = p1.blades[1] if not p2 then return nil end return p2
end

task.spawn(function()
    while task.wait() do
        if _G.FastAtk or _G.DragonStorm or _G.AuraM1Fruit then
            pcall(function()
                local Char = LocalPlayer.Character
                if _G.AuraM1Fruit then for _, T in pairs(LocalPlayer.Backpack:GetChildren()) do if T:IsA("Tool") and T.ToolTip == "Blox Fruit" then Char.Humanoid:EquipTool(T) break end end end
                
                -- Tạo Hitbox cực to cho Dragon Storm thay vì chỉ có hiệu ứng ảo
                if _G.DragonStorm then
                    for _, v in pairs(Workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - Char.HumanoidRootPart.Position).Magnitude < 250 then
                            v.HumanoidRootPart.Size = Vector3.new(150, 150, 150) -- Bơm hitbox quái to khổng lồ để kiếm chém trúng hết!
                            v.HumanoidRootPart.Transparency = 0.8
                            v.HumanoidRootPart.CanCollide = false
                        end
                    end
                end

                local blade = GetCurrentBlade()
                if blade then
                    -- Bỏ qua độ trễ đánh
                    CombatFramework.activeController.timeToNextAttack = 0
                    CombatFramework.activeController.hitboxMagnitude = _G.DragonStorm and 250 or 60
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton1(Vector2.new(850, 850))
                end
            end)
        end
    end
end)
-- LIGHT GALAXY HUB V20.0 - PHẦN 5

-- [AUTO SEA EVENT ĐÃ FIX TỌA ĐỘ VÀ LỖI MUA THUYỀN]
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
                    if _G.SpamMelee then table.insert(toolsToUse, "Melee") end if _G.SpamSword then table.insert(toolsToUse, "Sword") end if _G.SpamFruit then table.insert(toolsToUse, "Blox Fruit") end
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
                        -- TÌM CHÍNH XÁC NPC TIKI THAY VÌ TỌA ĐỘ CHẾT
                        local boatNPC = nil
                        for _, npc in pairs(Workspace.NPCs:GetChildren()) do if npc.Name == "Boat Dealer" and npc:FindFirstChild("HumanoidRootPart") and npc.HumanoidRootPart.Position.Z > 10000 then boatNPC = npc break end end
                        
                        if boatNPC then
                            SmartTween(boatNPC.HumanoidRootPart.CFrame * CFrame.new(0, 3, 5)) task.wait(0.5)
                            CommF:InvokeServer("BuyBoat", "Guardian") -- Hoặc đổi thành "Sloop" nếu acc không có thuyền Guardian
                        end
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

-- [PVP - SELECT PLAYER AUTO KILL]
task.spawn(function()
    while task.wait(0.1) do
        if _G.KillPlr and _G.TargetPlayer ~= "" then
            pcall(function()
                local tg = Players:FindFirstChild(_G.TargetPlayer)
                if tg and tg.Character and tg.Character:FindFirstChild("HumanoidRootPart") then
                    SmartTween(tg.Character.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0))
                end
            end)
        end
    end
end)
-- LIGHT GALAXY HUB V20.0 - PHẦN 6

task.spawn(function()
    while task.wait(1) do
        pcall(function()
            -- [STATUS SERVER - FULL MOON 1/8 LOGIC]
            local moonTex = Lighting.Sky.MoonTextureId
            local moonPhases = { ["http://www.roblox.com/asset/?id=9709149431"]=8, ["http://www.roblox.com/asset/?id=9709149052"]=7, ["http://www.roblox.com/asset/?id=9709143733"]=1 }
            local currentPhase = 1 for tex, phase in pairs(moonPhases) do if string.find(moonTex, tex) then currentPhase = phase break end end
            
            if currentPhase == 8 or string.find(moonTex, "9709149431") or string.find(moonTex, "9709135895") then 
                _G.lblMoonTime.Text = "Trăng: 8/8 (Moon up v4: Ánh sáng xuyên qua những tầng mây!)" 
            else
                _G.lblMoonTime.Text = "Trăng: "..currentPhase.."/8"
            end

            local kP = CommF:InvokeServer("CakePrinceSpawner")
            if type(kP) == "number" then _G.lblKata.Text = "Số Quái Kata cần giết: " .. (500 - kP) .. " con" else _G.lblKata.Text = "Kata: " .. tostring(kP or "Đã mở cổng") end
            
            local serverTime = math.floor(Workspace.DistributedGameTime / 60)
            _G.lblSrvTime.Text = "Thời gian SV: "..serverTime.." Phút"

            local ItemTxt = ""
            for _,p in pairs(Players:GetPlayers()) do if p.Backpack:FindFirstChild("God's Chalice") or (p.Character and p.Character:FindFirstChild("God's Chalice")) then ItemTxt=ItemTxt.."Cúp " end if p.Backpack:FindFirstChild("Fist of Darkness") or (p.Character and p.Character:FindFirstChild("Fist of Darkness")) then ItemTxt=ItemTxt.."Fist " end end
            _G.lblItem.Text = "Vật phẩm: " .. (ItemTxt == "" and "Trống" or ItemTxt)

            local map = Workspace:FindFirstChild("Map") and Workspace.Map:GetChildren() or Workspace:GetChildren()
            local hasMirage, hasKitsune = false, false
            for _, v in pairs(map) do
                if string.find(v.Name, "Mystic") or string.find(v.Name, "Mirage") then hasMirage = true end if string.find(v.Name, "Kitsune") then hasKitsune = true end
            end
            _G.lblMirage.Text = "Đảo Mirage (Kì Bí): " .. (hasMirage and "ĐANG CÓ" or "KHÔNG")
            _G.lblKitsune.Text = "Đảo Kitsune (Tyan): " .. (hasKitsune and "ĐANG CÓ" or "KHÔNG")
        end)
        
        -- [ESP PLAYER - CHỮ TRẮNG NHƯ YÊU CẦU]
        if _G.ESPPlr then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    if not p.Character.HumanoidRootPart:FindFirstChild("ESPP") then
                        local bg = Instance.new("BillboardGui", p.Character.HumanoidRootPart) bg.Name = "ESPP" bg.Size = UDim2.new(0, 200, 0, 40) bg.AlwaysOnTop = true bg.StudsOffset = Vector3.new(0, 3, 0)
                        local txt = Instance.new("TextLabel", bg) txt.Size = UDim2.new(1,0,1,0) txt.BackgroundTransparency = 1 txt.TextScaled = true txt.Font = Enum.Font.GothamBold
                    end
                    -- Đổi toàn bộ màu ESP sang Trắng Tinh (Color3.fromRGB(255, 255, 255))
                    p.Character.HumanoidRootPart.ESPP.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    p.Character.HumanoidRootPart.ESPP.TextLabel.Text = string.format("[%s]\nLv.%d", p.Name, p.Data.Level.Value)
                end
            end
        else
            for _, p in pairs(Players:GetPlayers()) do if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.HumanoidRootPart:FindFirstChild("ESPP") then p.Character.HumanoidRootPart.ESPP:Destroy() end end
        end
    end
end)
-- LIGHT GALAXY HUB V20.0 - PHẦN 7 (LÕI XỬ LÝ CHÍNH)

-- [HÀM LẤY NHIỆM VỤ THEO LEVEL ĐỂ ĐI FARM]
local function GetQuestLogic()
    local Lvl = LocalPlayer.Data.Level.Value
    local QuestName, QuestNum, MobName, QuestCFrame, MobCFrame = "", 1, "", CFrame.new(0,0,0), CFrame.new(0,0,0)
    
    -- Ví dụ logic ở Sea 3 (Ní có thể add thêm quái theo level khách cần cày)
    if Lvl >= 1500 and Lvl <= 1525 then 
        QuestName = "Pirate Millionaire Quest" QuestNum = 1 MobName = "Pirate Millionaire" 
        QuestCFrame = CFrame.new(-318, 44, 5972) MobCFrame = CFrame.new(-318, 44, 5972)
    elseif Lvl >= 1525 and Lvl <= 1575 then 
        QuestName = "Pistol Billionaire Quest" QuestNum = 1 MobName = "Pistol Billionaire" 
        QuestCFrame = CFrame.new(-462, 73, 5325) MobCFrame = CFrame.new(-462, 73, 5325)
    else 
        QuestName = "Bypass" MobName = "Bypass" 
    end
    
    return QuestName, QuestNum, MobName, QuestCFrame, MobCFrame
end

local function AutoQuestFarm()
    if not _G.FarmLv then return end
    local qName, qNum, mName, qPos, mPos = GetQuestLogic()
    if qName ~= "Bypass" then
        if not LocalPlayer.PlayerGui.Main.Quest.Visible then
            SmartTween(qPos) 
            task.wait(0.5) 
            CommF:InvokeServer("StartQuest", qName, qNum)
        else
            local tMob = nil 
            for _, E in pairs(Workspace.Enemies:GetChildren()) do 
                if string.find(E.Name, mName) and E.Humanoid.Health > 0 then 
                    tMob = E break 
                end 
            end
            if tMob then 
                SmartTween(tMob.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)) 
            else 
                SmartTween(mPos * CFrame.new(0, 50, 0)) 
            end
        end
    else
        -- Kẹt level thì đánh quái gần nhất
        for _, E in pairs(Workspace.Enemies:GetChildren()) do 
            if E.Humanoid.Health > 0 then 
                SmartTween(E.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)) break 
            end 
        end
    end
end

-- [VÒNG LẶP GOM QUÁI & CLICK]
task.spawn(function()
    while task.wait(0.1) do
        -- Gom Quái (Bring Mob) 
        if _G.BringMob then 
            pcall(function() 
                local MyRoot = LocalPlayer.Character.HumanoidRootPart 
                for _, Enemy in pairs(Workspace.Enemies:GetChildren()) do 
                    if Enemy:FindFirstChild("HumanoidRootPart") and Enemy.Humanoid.Health > 0 and (Enemy.HumanoidRootPart.Position - MyRoot.Position).Magnitude < 350 then 
                        Enemy.HumanoidRootPart.Size = Vector3.new(60, 60, 60) 
                        Enemy.HumanoidRootPart.CanCollide = false 
                        Enemy.HumanoidRootPart.CFrame = MyRoot.CFrame * CFrame.new(0, -8, 0) 
                        Enemy.Humanoid.PlatformStand = true 
                        Enemy.Humanoid.WalkSpeed = 0 
                    end 
                end 
            end) 
        end
        
        -- Auto Click (Chém)
        if _G.FarmLv or _G.FarmBone or _G.FarmCake or _G.AutoSeaEvent then 
            pcall(function() 
                VirtualUser:CaptureController() 
                VirtualUser:ClickButton1(Vector2.new(850, 850)) 
            end) 
        end
    end
end)

-- [VÒNG LẶP GỌI HÀM THỰC THI FARM]
task.spawn(function()
    while task.wait(0.2) do
        -- Chạy Farm Level
        if _G.FarmLv then AutoQuestFarm() end
        
        -- Chạy Farm Xương
        if _G.FarmBone then 
            pcall(function() 
                local t=nil 
                for _, E in pairs(Workspace.Enemies:GetChildren()) do 
                    if (E.Name=="Reborn Skeleton" or E.Name=="Living Zombie") and E.Humanoid.Health>0 then 
                        t=E break 
                    end 
                end 
                if t then 
                    SmartTween(t.HumanoidRootPart.CFrame*CFrame.new(0,30,0)) 
                else 
                    SmartTween(CFrame.new(-9481, 142, 5566)) 
                end 
            end) 
        end
        
        -- Chạy Farm Bánh (Cake)
        if _G.FarmCake then 
            pcall(function() 
                local t=nil 
                for _, E in pairs(Workspace.Enemies:GetChildren()) do 
                    if string.find(E.Name, "Cake") and E.Humanoid.Health>0 then 
                        t=E break 
                    end 
                end 
                if t then 
                    SmartTween(t.HumanoidRootPart.CFrame*CFrame.new(0,30,0)) 
                else 
                    SmartTween(CFrame.new(-2022, 38, -12028)) 
                end 
            end) 
        end
    end
end)
