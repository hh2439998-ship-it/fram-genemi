-- [[ KHỬ TRÙNG VÀ KHỞI TẠO ]]
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")

local TargetGui = CoreGui:FindFirstChild("RobloxGui") or LocalPlayer:WaitForChild("PlayerGui")
if TargetGui:FindFirstChild("HuyHoangHubPro") then TargetGui.HuyHoangHubPro:Destroy() end

-- [[ CẤU HÌNH BIẾN TOÀN CỤC ]]
_G.AutoFarmLevel = false
_G.AutoFarmBone = false
_G.AutoFarmCake = false

_G.AutoSeaEvent = false
_G.AutoBuyBoat = false
_G.TargetZone = 6
_G.BoatSpeed = 300
_G.DodgeSpeed = 350

_G.SelectedTargets = {
    ["Terror Shark"] = false,
    ["Sea Beast"] = false,
    ["Piranha"] = false,
    ["Shark"] = false,
    ["Ship"] = false
}

-- =========================================================
-- 📍 DATA "IP" ĐỊA CHỈ (TỌA ĐỘ) - FIX CHUẨN SEA 3
-- =========================================================
-- IP bến thuyền Tiki Outpost (Sea 3)
local ipTikiDock = CFrame.new(-5075, 40, -3153) 

-- IP Tự động lấy Quest theo Level
local function GetQuestIPData()
    local lvl = LocalPlayer.Data.Level.Value
    if lvl >= 2000 and lvl < 2075 then return "Skeleton Warriors Quest", "Reborn Skeleton", 1
    elseif lvl >= 2075 and lvl < 2125 then return "Demonic Souls Quest", "Demonic Soul", 2
    elseif lvl >= 2200 and lvl < 2275 then return "Ice Cream Quest", "Cookie Crafter", 1
    elseif lvl >= 2275 and lvl < 2300 then return "Cake Quest 1", "Cake Guard", 1
    elseif lvl >= 2300 then return "Cake Quest 2", "Baking Subordinate", 2
    else return "Bandit Quest 1", "Bandit", 1 end
end

-- IP Dò tìm vị trí NPC và Bãi Quái
local function FindTargetIP(targetName, isNPC)
    if isNPC then
        for _, v in pairs(Workspace:GetChildren()) do
            if (v.Name:sub(1, #targetName) == targetName or v.Name:find("Quest Giver")) and v:FindFirstChild("HumanoidRootPart") then 
                return v.HumanoidRootPart.CFrame 
            end
        end
    else
        local spawnFolder = Workspace:FindFirstChild("_WorldOrigin") and Workspace._WorldOrigin:FindFirstChild("EnemySpawns")
        if spawnFolder and spawnFolder:FindFirstChild(targetName) then
            return spawnFolder[targetName].CFrame
        end
        for _, v in pairs(Workspace.Enemies:GetChildren()) do
            if v.Name == targetName and v:FindFirstChild("HumanoidRootPart") then return v.HumanoidRootPart.CFrame end
        end
    end
    return nil
end

-- =========================================================
-- 🚀 HỆ THỐNG FLY TWEEN & ANTI-FALL (FIX RỚT XUỐNG BIỂN)
-- =========================================================
local function GetMyBoat()
    for _, v in pairs(Workspace.Boats:GetChildren()) do
        if v:FindFirstChild("Owner") and v.Owner.Value == LocalPlayer then return v end
    end return nil
end

-- Vòng lặp giữ nhân vật bay lơ lửng (Anti-Fall) và Xuyên Tường (Noclip)
RunService.Stepped:Connect(function()
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local hrp = character.HumanoidRootPart
        -- Chỉ giữ lơ lửng khi đang bật Farm hoặc lúc chưa có thuyền
        if _G.AutoFarmLevel or _G.AutoFarmBone or _G.AutoFarmCake or (_G.AutoSeaEvent and not GetMyBoat()) then
            if not hrp:FindFirstChild("AntiFall") then
                local bv = Instance.new("BodyVelocity")
                bv.Name = "AntiFall"
                bv.MaxForce = Vector3.new(99999, 99999, 99999)
                bv.Velocity = Vector3.new(0, 0, 0)
                bv.Parent = hrp
            end
            -- Ép xuyên tường liên tục
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        else
            -- Tắt Farm thì xóa lực giữ
            if hrp:FindFirstChild("AntiFall") then hrp.AntiFall:Destroy() end
        end
    end
end)

-- Hàm bay mượt không rớt
local function TweenToIP(cframe)
    if not cframe then return end
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local hrp = character.HumanoidRootPart
        local dist = (hrp.Position - cframe.Position).Magnitude
        
        if dist > 3500 then 
            hrp.CFrame = cframe 
            task.wait(0.5)
        else
            local tween = TweenService:Create(hrp, TweenInfo.new(dist / 300, Enum.EasingStyle.Linear), {CFrame = cframe})
            tween:Play()
        end
    end
end

local function AutoClick()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton1(Vector2.new(0,0))
end

-- =========================================================
-- 🖥️ GIAO DIỆN BANA HUB STYLE (VUỐT MƯỢT MÀ)
-- =========================================================
local ScreenGui = Instance.new("ScreenGui", TargetGui)
ScreenGui.Name = "HuyHoangHubPro"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 500, 0, 380)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
MainFrame.Active = true; MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 10)

local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.Size = UDim2.new(1, -10, 1, 0); TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.Text = "HUY HOÀNG HUB — PREMIUM EDITION"
TitleText.TextColor3 = Color3.fromRGB(0, 200, 255); TitleText.TextSize = 16
TitleText.Font = Enum.Font.SourceSansBold; TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.BackgroundTransparency = 1

local Container = Instance.new("ScrollingFrame", MainFrame)
Container.Size = UDim2.new(1, -20, 1, -65); Container.Position = UDim2.new(0, 10, 0, 55)
Container.BackgroundTransparency = 1; Container.ScrollBarThickness = 6
Container.CanvasSize = UDim2.new(0, 0, 0, 950)

local UIList = Instance.new("UIListLayout", Container)
UIList.Padding = UDim.new(0, 6)

local function CreateSection(text)
    local Label = Instance.new("TextLabel", Container)
    Label.Size = UDim2.new(1, 0, 0, 30); Label.BackgroundTransparency = 1
    Label.Text = "--- " .. text .. " ---"; Label.TextColor3 = Color3.fromRGB(255, 200, 50)
    Label.Font = Enum.Font.SourceSansBold; Label.TextSize = 15
end

local function CreateToggle(text, default, callback)
    local state = default
    local Btn = Instance.new("TextButton", Container)
    Btn.Size = UDim2.new(1, -10, 0, 40)
    Btn.BackgroundColor3 = state and Color3.fromRGB(0, 160, 100) or Color3.fromRGB(45, 45, 58)
    Btn.Text = text .. (state and " : [ ON ]" or " : [ OFF ]")
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.SourceSansBold; Btn.TextSize = 14
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    
    Btn.MouseButton1Click:Connect(function()
        state = not state
        Btn.BackgroundColor3 = state and Color3.fromRGB(0, 160, 100) or Color3.fromRGB(45, 45, 58)
        Btn.Text = text .. (state and " : [ ON ]" or " : [ OFF ]")
        callback(state)
    end)
end

local function CreateCycleButton(text, prefix, min, max, default, callback)
    local val = default
    local Btn = Instance.new("TextButton", Container)
    Btn.Size = UDim2.new(1, -10, 0, 40)
    Btn.BackgroundColor3 = Color3.fromRGB(80, 50, 150)
    Btn.Text = text .. " : " .. prefix .. " " .. tostring(val)
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.SourceSansBold; Btn.TextSize = 14
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    
    Btn.MouseButton1Click:Connect(function()
        val = val + 1; if val > max then val = min end
        Btn.Text = text .. " : " .. prefix .. " " .. tostring(val)
        callback(val)
    end)
end

-- TẠO CÁC NÚT BẤM (KẾT NỐI VỚI IP)
CreateSection("CHỨC NĂNG FARM TRÊN ĐẢO")
CreateToggle("Tự Động Farm Cày Cấp (Level Max)", _G.AutoFarmLevel, function(v) _G.AutoFarmLevel = v if v then _G.AutoSeaEvent=false;_G.AutoFarmBone=false;_G.AutoFarmCake=false end end)
CreateToggle("Tự Động Farm Xương (Farm Bone)", _G.AutoFarmBone, function(v) _G.AutoFarmBone = v if v then _G.AutoSeaEvent=false;_G.AutoFarmLevel=false;_G.AutoFarmCake=false end end)
CreateToggle("Tự Động Farm Bánh (Farm Cake)", _G.AutoFarmCake, function(v) _G.AutoFarmCake = v if v then _G.AutoSeaEvent=false;_G.AutoFarmLevel=false;_G.AutoFarmBone=false end end)

CreateSection("CẤU HÌNH SEA EVENT (TỌA ĐỘ TIKI)")
CreateToggle("Auto Mua Thuyền Tự Động (Tiki Outpost)", false, function(v) _G.AutoBuyBoat = v end)
CreateCycleButton("Cài Đặt Vùng Biển Farm", "Vùng", 1, 6, 6, function(v) _G.TargetZone = v end)

CreateSection("CHỌN LOẠI QUÁI BIỂN")
CreateToggle("Săn Terror Shark", false, function(v) _G.SelectedTargets["Terror Shark"] = v end)
CreateToggle("Săn Sea Beast", false, function(v) _G.SelectedTargets["Sea Beast"] = v end)
CreateToggle("Săn Piranha", false, function(v) _G.SelectedTargets["Piranha"] = v end)
CreateToggle("Săn Shark", false, function(v) _G.SelectedTargets["Shark"] = v end)
CreateToggle("Săn Thuyền Ma (Ship)", false, function(v) _G.SelectedTargets["Ship"] = v end)

CreateSection("KHỞI ĐỘNG CHỨC NĂNG")
CreateToggle("🚀 CHẠY SEA EVENT", _G.AutoSeaEvent, function(v) 
    _G.AutoSeaEvent = v 
    if v then _G.AutoFarmLevel=false; _G.AutoFarmBone=false; _G.AutoFarmCake=false end
end)

-- =========================================================
-- 🔄 VÒNG LẶP XỬ LÝ NHIỆM VỤ (AUTO FARM IP)
-- =========================================================
task.spawn(function()
    while task.wait(0.1) do
        if _G.AutoFarmLevel then
            local qName, mobName, qIdx = GetQuestIPData()
            local hasQuest = LocalPlayer.PlayerGui.Main:FindFirstChild("Quest") and LocalPlayer.PlayerGui.Main.Quest.Visible
            if not hasQuest then
                local npcIP = FindTargetIP(mobName, true)
                if npcIP then TweenToIP(npcIP); game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", qName, qIdx) end
            else
                local mobFound = false
                for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                    if mob.Name == mobName and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
                        mobFound = true; TweenToIP(mob.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)); AutoClick()
                        break
                    end
                end
                if not mobFound then TweenToIP(FindTargetIP(mobName, false)) end
            end
            
        elseif _G.AutoFarmBone then
            local mobFound = false
            for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                if (mob.Name == "Reborn Skeleton" or mob.Name == "Living Zombie") and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
                    mobFound = true; TweenToIP(mob.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)); AutoClick()
                    break
                end
            end
            if not mobFound then TweenToIP(FindTargetIP("Reborn Skeleton", false)) end

        elseif _G.AutoFarmCake then
            local mobFound = false
            for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                if (mob.Name == "Cake Guard" or mob.Name == "Cookie Crafter") and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
                    mobFound = true; TweenToIP(mob.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)); AutoClick()
                    break
                end
            end
            if not mobFound then TweenToIP(FindTargetIP("Cake Guard", false)) end
        end
    end
end)

-- =========================================================
-- 🌊 VÒNG LẶP XỬ LÝ SEA EVENT IP
-- =========================================================
task.spawn(function()
    while task.wait(1) do
        if _G.AutoSeaEvent then
            local myBoat = GetMyBoat()
            
            -- Bay thẳng ra IP Tiki Outpost mua thuyền
            if not myBoat and _G.AutoBuyBoat then
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = ipTikiDock
                    task.wait(1.5)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Shipwright", "SpawnBoat", "Sloop")
                    task.wait(3) 
                end
            end
            
            -- Nếu có thuyền thì lái ra biển
            if myBoat and not _G.TargetFound then
                local seat = myBoat:FindFirstChild("VehicleSeat")
                if seat then seat.Velocity = seat.CFrame.LookVector * _G.BoatSpeed end
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.W, false, game)
            end
        end
    end
end)

-- Vòng lặp đập quái biển (Đọc IP từ mục Chọn Quái Biển)
task.spawn(function()
    while task.wait(0.1) do
        if _G.AutoSeaEvent then
            _G.TargetFound = false
            for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                if _G.SelectedTargets[enemy.Name] and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
                    _G.TargetFound = true
                    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        if enemy:FindFirstChild("Animate") or enemy:FindFirstChild("AttackEffects") then
                            hrp.CFrame = hrp.CFrame + Vector3.new(0, _G.DodgeSpeed * 0.1, 0)
                        else
                            hrp.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0)
                            AutoClick()
                        end
                    end
                    break
                end
            end
        end
    end
end)
