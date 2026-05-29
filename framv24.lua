-- ==============================================================================
-- LIGHT GALAXY HUB ◆ V11 (REDZ UI & FAST ATTACK BYPASS EDITION)
-- UI BỞI REDZ HUB - SAFE BRING ĐỘC QUYỀN - TỐI ƯU HÓA CHO MOBILE
-- ==============================================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- [1] TỰ ĐỘNG CHỌN PHE HẢI TẶC ĐỂ FARM
pcall(function()
    local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
    if not LocalPlayer.Team or (LocalPlayer.Team.Name ~= "Marines" and LocalPlayer.Team.Name ~= "Pirates") then
        CommF:InvokeServer("SetTeam", "Pirates")
    end
end)

-- [2] TẢI GIAO DIỆN REDZ HUB V5
local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/PlockScripts/Library-ui/refs/heads/main/redz-V5-remake/main.luau"))()

local Window = redzlib:MakeWindow({
    Title = "Light Galaxy Hub : Blox Fruits",
    SubTitle = "V11 Ultimate (Redz UI)",
    SaveFolder = "LightGalaxyV11.lua"
})

-- Tạo các Tab chuẩn Redz
local TabFarm = Window:MakeTab({"Cày Cuốc", "home"})
local TabESP = Window:MakeTab({"Visual & ESP", "user"})
local TabPVP = Window:MakeTab({"PVP & Hacks", "swords"})
local TabMisc = Window:MakeTab({"Cài Đặt", "settings"})

-- Các biến hệ thống
_G.FastAttackRedz = false
_G.BringMobSafe = false
_G.AutoFarmLevel = false
_G.ESPPlayer = false
_G.ESPChest = false
_G.ESPFruit = false
_G.InfSoru = false
_G.NoDodgeCD = false

-- ==============================================================================
-- MENU: CÀY CUỐC
-- ==============================================================================
TabFarm:AddToggle({
    Name = "Fast Attack (Bypass Netcode Redz)",
    Description = "Đâm dame cực mạnh thẳng vào máy chủ",
    Default = false,
    Callback = function(v) _G.FastAttackRedz = v end
})

TabFarm:AddToggle({
    Name = "Real Bring Mob (Safe Farm Độc Quyền)",
    Description = "Gom quái dưới chân 8 studs - Bất tử",
    Default = false,
    Callback = function(v) _G.BringMobSafe = v end
})

TabFarm:AddToggle({
    Name = "Auto Farm Level (Tối Ưu)",
    Description = "Tự động bay đến quái farm",
    Default = false,
    Callback = function(v) _G.AutoFarmLevel = v end
})

-- ==============================================================================
-- MENU: ESP & VISUAL
-- ==============================================================================
TabESP:AddToggle({
    Name = "ESP Players (Xuyên Tường)",
    Default = false,
    Callback = function(v) _G.ESPPlayer = v end
})

TabESP:AddToggle({
    Name = "ESP Rương Vàng",
    Default = false,
    Callback = function(v) _G.ESPChest = v end
})

TabESP:AddToggle({
    Name = "ESP Trái Ác Quỷ",
    Default = false,
    Callback = function(v) _G.ESPFruit = v end
})

-- ==============================================================================
-- MENU: PVP & HACKS
-- ==============================================================================
TabPVP:AddToggle({
    Name = "Infinite Soru (Lướt Không Hồi Chiêu)",
    Default = false,
    Callback = function(v) _G.InfSoru = v end
})

TabPVP:AddToggle({
    Name = "No Dodge Cooldown (Né Bất Tử)",
    Default = false,
    Callback = function(v) _G.NoDodgeCD = v end
})

TabMisc:AddButton({
    Title = "⚡ Boost FPS (Mượt Máy)",
    Description = "Giảm lag giật cực mạnh cho điện thoại",
    Callback = function()
        for _, v in ipairs(game:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") then v:Destroy()
            elseif v:IsA("Lighting") then v.GlobalShadows = false v.FogEnd = 1e10 v.Brightness = 0 end
        end
    end
})

-- ==============================================================================
-- LÕI SỨC MẠNH: FAST ATTACK BYPASS (TỪ REDZ HUB)
-- ==============================================================================
local v1 = next
local v2 = {ReplicatedStorage:WaitForChild("Util"), ReplicatedStorage:WaitForChild("Common"), ReplicatedStorage:WaitForChild("Remotes"), ReplicatedStorage:WaitForChild("Assets"), ReplicatedStorage:WaitForChild("FX")}
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
                if eRoot and eHum and eHum.Health > 0 and (eRoot.Position - root.Position).Magnitude <= 65 then
                    for _, part in ipairs(mob:GetChildren()) do
                        if part:IsA('BasePart') then table.insert(u17, {mob, part}) end
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
-- LÕI SỨC MẠNH: REAL BRING MOB (SAFE FARM ĐỘC QUYỀN - HOÀN HẢO)
-- ==============================================================================
task.spawn(function()
    while task.wait(0.1) do
        if _G.BringMobSafe then
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
                            -- Hút quái xuống dưới chân 8 studs (Quái không thể đánh lại)
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
-- LÕI SỨC MẠNH: AUTO FARM CƠ BẢN
-- ==============================================================================
task.spawn(function()
    while task.wait(0.2) do
        if _G.AutoFarmLevel then
            pcall(function()
                local Char = LocalPlayer.Character
                if not Char or not Char:FindFirstChild("HumanoidRootPart") then return end
                -- Móc vũ khí
                if not Char:FindFirstChildOfClass("Tool") then
                    for _, Item in pairs(LocalPlayer.Backpack:GetChildren()) do
                        if Item:IsA("Tool") and (Item.ToolTip == "Melee" or Item.ToolTip == "Sword") then
                            Char.Humanoid:EquipTool(Item) break
                        end
                    end
                end
                
                -- Tìm quái gần nhất và bay tới trên đầu nó
                local Target = nil
                for _, Enemy in pairs(Workspace.Enemies:GetChildren()) do
                    if Enemy:FindFirstChild("Humanoid") and Enemy.Humanoid.Health > 0 then 
                        Target = Enemy break 
                    end
                end
                
                if Target then
                    local Root = Char.HumanoidRootPart
                    local targetCFrame = Target.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
                    local TweenAction = TweenService:Create(Root, TweenInfo.new((Root.Position - targetCFrame.Position).Magnitude / 315, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
                    TweenAction:Play()
                end
            end)
        end
    end
end)

-- ==============================================================================
-- HACKS: PVP & ESP
-- ==============================================================================
task.spawn(function()
    while task.wait(1) do
        if _G.InfSoru and LocalPlayer.Character then
            pcall(function()
                for _, func in next, getgc() do
                    if type(func) == "function" and getfenv(func).script == LocalPlayer.Character:WaitForChild("Soru") then
                        for idx, val in pairs(debug.getupvalues(func)) do
                            if type(val) == "table" and val.LastUse then debug.setupvalue(func, idx, {LastAfter = 0, LastUse = 0}) end
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
                            if tostring(val) == "0.4" then debug.setupvalue(func, idx, 0) end
                        end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if _G.ESPChest then
            for _, chest in pairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
                if not chest:FindFirstChild("ESPC") then
                    local bg = Instance.new("BillboardGui", chest)
                    bg.Name = "ESPC" bg.Size = UDim2.new(0, 100, 0, 40) bg.AlwaysOnTop = true
                    local txt = Instance.new("TextLabel", bg)
                    txt.Size = UDim2.new(1,0,1,0) txt.BackgroundTransparency = 1 txt.TextColor3 = Color3.fromRGB(255, 215, 0)
                    txt.TextScaled = true txt.Font = Enum.Font.GothamBold
                    txt.Text = "Chest\n" .. math.floor((LocalPlayer.Character.Head.Position - chest.Position).Magnitude) .. "m"
                else
                    chest.ESPC.TextLabel.Text = "Chest\n" .. math.floor((LocalPlayer.Character.Head.Position - chest.Position).Magnitude) .. "m"
                end
            end
        else
            for _, chest in pairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
                if chest:FindFirstChild("ESPC") then chest.ESPC:Destroy() end
            end
        end
    end
end)
