-- ==============================================================================
-- LIGHT GALAXY HUB ◆ VERSION V10 ULTIMATE (REDZ CORE INTEGRATION)
-- PURE LUAU UI - BYPASS REGISTER_HIT FAST ATTACK - PVP HACKS - FPS BOOST
-- ==============================================================================

_G.Settings = _G.Settings or { JoinTeam = "Pirates", Translator = false }

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")

-- [AUTO JOIN TEAM]
local function JoinTeam()
    local targetTeam = "Marines"
    if _G.Settings.JoinTeam == "Pirates" then targetTeam = "Pirates" end
    if not LocalPlayer.Team or (LocalPlayer.Team.Name ~= "Marines" and LocalPlayer.Team.Name ~= "Pirates") then
        pcall(function() CommF:InvokeServer("SetTeam", targetTeam) end)
    end
end
JoinTeam()

local World1, World2, World3 = false, false, false
if game.PlaceId == 2753915549 or game.PlaceId == 85211729168715 then World1 = true
elseif game.PlaceId == 4442272183 or game.PlaceId == 79091703265657 then World2 = true
elseif game.PlaceId == 7449423635 or game.PlaceId == 100117331123089 then World3 = true end

local UI_Parent = game:GetService("CoreGui")
if not UI_Parent or pcall(function() local a = UI_Parent.Name end) == false then
    UI_Parent = LocalPlayer:WaitForChild("PlayerGui")
end
if UI_Parent:FindFirstChild("LightGalaxyHub") then UI_Parent.LightGalaxyHub:Destroy() end

-- ==============================================================================
-- I. HỆ THỐNG GIAO DIỆN (UI)
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
MainFrame.Size = UDim2.new(0, 600, 0, 360)
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
Title.Text = "LIGHT GALAXY HUB ◆ ULTIMATE V10 (REDZ CORE)"
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
    Page.CanvasSize = UDim2.new(0, 0, 5, 0)
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
-- II. TẠO CÁC CHỨC NĂNG TỪ REDZ HUB
-- ==============================================================================
local FarmPage = CreatePage("Cày Cuốc")
local ESPPage = CreatePage("Visuals & ESP")
local HackPage = CreatePage("PVP & Misc")
Pages["Cày Cuốc"].Visible = true

_G.FastAttackRedz = false
_G.BringMob = false
_G.AutoFarmLevel = false
_G.ESPPlayer = false
_G.ESPFruit = false
_G.ESPChest = false
_G.InfiniteSoru = false
_G.NoDodgeCD = false

-- TAB CÀY CUỐC
AddToggle(FarmPage, "[V10] Fast Attack (Netcode Bypass)", "FastAttackRedz")
AddToggle(FarmPage, "Real Bring Mob (Dưới Chân)", "BringMob")
AddToggle(FarmPage, "Auto Farm Level (Bao Mượt)", "AutoFarmLevel")
AddToggle(FarmPage, "Auto Farm Xương", "AutoBone")
AddToggle(FarmPage, "Auto Săn Leviathan", "LeviathanHunt")

-- TAB VISUALS & ESP
AddToggle(ESPPage, "ESP Players (Nhìn Xuyên Tường)", "ESPPlayer")
AddToggle(ESPPage, "ESP Trái Ác Quỷ", "ESPFruit")
AddToggle(ESPPage, "ESP Rương", "ESPChest")

-- TAB PVP & MISC
AddButton(HackPage, "⚡ Boost FPS (Mượt Máy Redmi)", function()
    for _, v in ipairs(game:GetDescendants()) do
        if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") then v:Destroy()
        elseif v:IsA("Lighting") then v.GlobalShadows = false v.FogEnd = 1e10 v.Brightness = 0 end
    end
end)
AddToggle(HackPage, "Infinite Soru (Lướt Vô Hạn)", "InfiniteSoru")
AddToggle(HackPage, "Dodge No Cooldown (Né Liên Tục)", "NoDodgeCD")
AddButton(HackPage, "Anti-Admin (Gặp Admin Tự Đổi Server)", function()
    local Admins = {["rip_indra"] = true, ["Axiore"] = true, ["Uzoth"] = true}
    task.spawn(function()
        while task.wait(1) do
            for _, player in pairs(game.Players:GetPlayers()) do
                if Admins[player.Name] then
                    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
                end
            end
        end
    end)
end)

-- ==============================================================================
-- III. CORE REDZ FAST ATTACK (BYPASS REGISTER HIT - ĐỈNH CAO SÁT THƯƠNG)
-- ==============================================================================
local v1 = next
local v2 = {ReplicatedStorage.Util, ReplicatedStorage.Common, ReplicatedStorage.Remotes, ReplicatedStorage.Assets, ReplicatedStorage.FX}
local v3, u4, u5 = nil, nil, nil

task.spawn(function()
    while true do
        local v6
        v3, v6 = v1(v2, v3)
        if v3 == nil then break end
        local v7 = next
        local v8, v9 = v6:GetChildren()
        while true do
            local v10
            v9, v10 = v7(v8, v9)
            if v9 == nil then break end
            if v10:IsA('RemoteEvent') and v10:GetAttribute('Id') then
                u5 = v10:GetAttribute('Id')
                u4 = v10
            end
        end
        v6.ChildAdded:Connect(function(p11)
            if p11:IsA('RemoteEvent') and p11:GetAttribute('Id') then
                u5 = p11:GetAttribute('Id')
                u4 = p11
            end
        end)
    end
end)

task.spawn(function()
    while task.wait(0.01) do
        if _G.FastAttackRedz then
            local _Character = LocalPlayer.Character
            if not _Character then continue end
            local root = _Character:FindFirstChild('HumanoidRootPart')
            if not root then continue end
            
            local u17 = {}
            for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                local eRoot = mob:FindFirstChild('HumanoidRootPart')
                local eHum = mob:FindFirstChild('Humanoid')
                if eRoot and eHum and eHum.Health > 0 and (eRoot.Position - root.Position).Magnitude <= 60 then
                    for _, part in ipairs(mob:GetChildren()) do
                        if part:IsA('BasePart') then
                            table.insert(u17, {mob, part})
                        end
                    end
                end
            end

            local _Tool = _Character:FindFirstChildOfClass('Tool')
            if #u17 > 0 and (_Tool and (_Tool.ToolTip == 'Melee' or _Tool.ToolTip == 'Sword')) then
                pcall(function()
                    require(ReplicatedStorage.Modules.Net):RemoteEvent('RegisterHit', true)
                    ReplicatedStorage.Modules.Net['RE/RegisterAttack']:FireServer()
                    local _Head = u17[1][1]:FindFirstChild('Head') or u17[1][1]:FindFirstChild('HumanoidRootPart')
                    if _Head and u4 then
                        local key = tostring(LocalPlayer.UserId):sub(2, 4) .. tostring(coroutine.running()):sub(11, 15)
                        ReplicatedStorage.Modules.Net['RE/RegisterHit']:FireServer(_Head, u17, {}, key)
                        -- Giải mã mã hóa chống Hack của Blox Fruits để gửi Damage trực tiếp
                        if cloneref then
                            cloneref(u4):FireServer(string.gsub('RE/RegisterHit', '.', function(p31)
                                return string.char(bit32.bxor(string.byte(p31), math.floor(workspace:GetServerTimeNow() / 10 % 10) + 1))
                            end), bit32.bxor(u5 + 909090, ReplicatedStorage.Modules.Net.seed:InvokeServer() * 2), _Head, u17)
                        end
                    end
                end)
            end
        end
    end
end)

-- ==============================================================================
-- IV. PVP HACKS (TỪ REDZ HUB MÓC GETGC)
-- ==============================================================================
task.spawn(function()
    while task.wait(1) do
        if _G.InfiniteSoru and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                for _, func in next, getgc() do
                    if type(func) == "function" and getfenv(func).script == LocalPlayer.Character:WaitForChild("Soru") then
                        for idx, val in pairs(debug.getupvalues(func)) do
                            if type(val) == "table" and val.LastUse then
                                debug.setupvalue(func, idx, {LastAfter = 0, LastUse = 0})
                            end
                        end
                    end
                end
            end)
        end
        if _G.NoDodgeCD and LocalPlayer.Character then
            pcall(function()
                for _, func in next, getgc() do
                    if type(func) == "function" and getfenv(func).script == LocalPlayer.Character:WaitForChild("Dodge") then
                        for idx, val in next, debug.getupvalues(func) do
                            if tostring(val) == "0.4" then
                                debug.setupvalue(func, idx, 0)
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- ==============================================================================
-- V. ESP SYSTEM (TỪ REDZ HUB)
-- ==============================================================================
task.spawn(function()
    while task.wait(1) do
        -- ESP Rương
        if _G.ESPChest then
            for _, chest in pairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
                if not chest:FindFirstChild("ESP") then
                    local bg = Instance.new("BillboardGui", chest)
                    bg.Name = "ESP" bg.Size = UDim2.new(0, 100, 0, 40) bg.AlwaysOnTop = true
                    local txt = Instance.new("TextLabel", bg)
                    txt.Size = UDim2.new(1,0,1,0) txt.BackgroundTransparency = 1 txt.TextColor3 = Color3.fromRGB(255, 215, 0)
                    txt.Text = "Chest\n" .. math.floor((LocalPlayer.Character.Head.Position - chest.Position).Magnitude) .. "m"
                    txt.TextScaled = true
                else
                    chest.ESP.TextLabel.Text = "Chest\n" .. math.floor((LocalPlayer.Character.Head.Position - chest.Position).Magnitude) .. "m"
                end
            end
        else
            for _, chest in pairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
                if chest:FindFirstChild("ESP") then chest.ESP:Destroy() end
            end
        end
    end
end)

-- ==============================================================================
-- VI. HỆ THỐNG AUTO FARM (KẾ THỪA V9 BỀN BỈ)
-- ==============================================================================
local function TweenTo(TargetCFrame)
    local Char = LocalPlayer.Character
    if not Char or not Char:FindFirstChild("HumanoidRootPart") then return end
    local Root = Char.HumanoidRootPart
    local TweenAction = TweenService:Create(Root, TweenInfo.new((Root.Position - TargetCFrame.Position).Magnitude / 315, Enum.EasingStyle.Linear), {CFrame = TargetCFrame})
    local Noclip = RunService.Stepped:Connect(function()
        if LocalPlayer.Character then
            for _, Part in pairs(LocalPlayer.Character:GetChildren()) do if Part:IsA("BasePart") then Part.CanCollide = false end end
        end
    end)
    TweenAction:Play()
    TweenAction.Completed:Wait()
    Noclip:Disconnect()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then Root.CanCollide = true end
end

task.spawn(function()
    while task.wait(0.1) do
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
                            Enemy.HumanoidRootPart.Size = Vector3.new(65, 65, 65)
                            Enemy.HumanoidRootPart.CanCollide = false
                            Enemy.HumanoidRootPart.CFrame = MyRoot.CFrame * CFrame.new(0, -8, 0)
                            Count = Count + 1
                        end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.2) do
        if _G.AutoFarmLevel then
            pcall(function()
                -- Hệ thống tự động farm Level chung
                local NPC_IP = CFrame.new(-290, 44, 5581) -- Tọa độ mẫu Sea 3, tự update sau
                if not LocalPlayer.PlayerGui.Main.Quest.Visible then
                    TweenTo(NPC_IP)
                else
                    for _, Enemy in pairs(Workspace.Enemies:GetChildren()) do
                        if Enemy.Humanoid.Health > 0 then TweenTo(Enemy.HumanoidRootPart.CFrame * CFrame.new(0, 25, 0)) break end
                    end
                end
            end)
        end
    end
end)
