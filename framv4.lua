-- [[ KHỞI TẠO HUB ]]
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")

local TargetGui = CoreGui:FindFirstChild("RobloxGui") or LocalPlayer:WaitForChild("PlayerGui")
if TargetGui:FindFirstChild("HuyHoangHubPro") then TargetGui.HuyHoangHubPro:Destroy() end

-- [[ CẤU HÌNH TOÀN CỤC ]]
_G.AutoFarmLevel = false
_G.AutoFarmBone = false
_G.AutoFarmCake = false
_G.AutoSeaEvent = false
_G.AutoBuyBoat = false
_G.TargetZone = 6
_G.BoatSpeed = 300

_G.SelectedTargets = {
    ["Terror Shark"] = false,
    ["Sea Beast"] = false,
    ["Piranha"] = false,
    ["Shark"] = false,
    ["Ship"] = false
}

-- Biến điều khiển hướng bay
_G.TargetCFrame = nil 
local FlySpeed = 300 -- Tốc độ bay an toàn chống Anti-Cheat (Kick 267)

-- =========================================================
-- 📍 DATA IP CHUẨN XÁC SEA 3
-- =========================================================
-- IP Mua Thuyền Tiki Outpost
local ipTikiDock = CFrame.new(-5075, 40, -3153) 
-- IP Lâu Đài Bóng Tối (Bãi Xương)
local ipBoneIsland = CFrame.new(-9494, 142, 5521)
-- IP Đảo Bánh (Cake)
local ipCakeIsland = CFrame.new(-2123, 70, -11985)

local function GetQuestIPData()
    local lvl = LocalPlayer.Data.Level.Value
    if lvl >= 2000 and lvl < 2075 then return "Skeleton Warriors Quest", "Reborn Skeleton", 1
    elseif lvl >= 2075 and lvl < 2125 then return "Demonic Souls Quest", "Demonic Soul", 2
    elseif lvl >= 2200 and lvl < 2275 then return "Ice Cream Quest", "Cookie Crafter", 1
    elseif lvl >= 2275 and lvl < 2300 then return "Cake Quest 1", "Cake Guard", 1
    elseif lvl >= 2300 then return "Cake Quest 2", "Baking Subordinate", 2
    else return "Bandit Quest 1", "Bandit", 1 end
end

local function FindTargetIP(targetName, isNPC)
    if isNPC then
        for _, v in pairs(Workspace:GetChildren()) do
            if (v.Name:sub(1, #targetName) == targetName or v.Name:find("Quest Giver")) and v:FindFirstChild("HumanoidRootPart") then 
                return v.HumanoidRootPart.CFrame 
            end
        end
    else
        for _, v in pairs(Workspace.Enemies:GetChildren()) do
            if v.Name == targetName and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then 
                return v.HumanoidRootPart.CFrame 
            end
        end
    end
    return nil
end

-- =========================================================
-- 🚀 HỆ THỐNG BAY HEARTBEAT & XUYÊN TƯỜNG (FIX LỖI KICK & ĐỨNG IM)
-- =========================================================
local function AutoClick()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton1(Vector2.new(0,0))
end

-- Vòng lặp Xuyên tường (Noclip)
RunService.Stepped:Connect(function()
    local isFarming = _G.AutoFarmLevel or _G.AutoFarmBone or _G.AutoFarmCake or _G.AutoSeaEvent
    if isFarming and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetChildren()) do
            if v:IsA("BasePart") and v.CanCollide then
                v.CanCollide = false -- Ép xuyên mọi vật cản
            end
        end
    end
end)

-- Vòng lặp Bay mượt mà (Không dùng TweenService để tránh giật lag)
RunService.Heartbeat:Connect(function(deltaTime)
    local isFarming = _G.AutoFarmLevel or _G.AutoFarmBone or _G.AutoFarmCake or _G.AutoSeaEvent
    if isFarming and _G.TargetCFrame and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        local dist = (hrp.Position - _G.TargetCFrame.Position).Magnitude
        
        -- Nếu ở xa thì bay từ từ tới mục tiêu, nếu lại gần thì đánh
        if dist > 30 then
            local direction = (_G.TargetCFrame.Position - hrp.Position).Unit
            hrp.CFrame = hrp.CFrame + (direction * FlySpeed * deltaTime)
            hrp.Velocity = Vector3.new(0, 0, 0) -- Chống trọng lực
        else
            hrp.CFrame = _G.TargetCFrame
            hrp.Velocity = Vector3.new(0, 0, 0)
        end
    end
end)

-- =========================================================
-- 🖥️ GIAO DIỆN VUỐT CHUẨN HUB
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
TitleText.Text = "HUY HOÀNG HUB — PREMIUM V2 (ANTI-KICK)"
TitleText.TextColor3 = Color3.fromRGB(0, 255, 150); TitleText.TextSize = 16
TitleText.Font = Enum.Font.SourceSansBold; TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.BackgroundTransparency = 1

local Container = Instance.new("ScrollingFrame", MainFrame)
Container.Size = UDim2.new(1, -20, 1, -65); Container.Position = UDim2.new(0, 10, 0, 55)
Container.BackgroundTransparency = 1; Container.ScrollBarThickness = 6
Container.CanvasSize = UDim2.new(0, 0, 0, 950)
local UIList = Instance.new("UIListLayout", Container); UIList.Padding = UDim.new(0, 6)

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

-- TẠO CÁC NÚT UI
CreateSection("CHỨC NĂNG FARM TRÊN ĐẢO")
CreateToggle("Tự Động Farm Cày Cấp", false, function(v) _G.AutoFarmLevel=v if v then _G.AutoSeaEvent=false;_G.AutoFarmBone=false;_G.AutoFarmCake=false end end)
CreateToggle("Tự Động Farm Xương (Bone)", false, function(v) _G.AutoFarmBone=v if v then _G.AutoSeaEvent=false;_G.AutoFarmLevel=false;_G.AutoFarmCake=false end end)
CreateToggle("Tự Động Farm Bánh (Cake)", false, function(v) _G.AutoFarmCake=v if v then _G.AutoSeaEvent=false;_G.AutoFarmLevel=false;_G.AutoFarmBone=false end end)

CreateSection("CẤU HÌNH SEA EVENT")
CreateToggle("Auto Mua Thuyền Tại Tiki", false, function(v) _G.AutoBuyBoat = v end)
CreateCycleButton("Cài Đặt Vùng Biển Farm", "Vùng", 1, 6, 6, function(v) _G.TargetZone = v end)

CreateSection("CHỌN LOẠI QUÁI BIỂN")
CreateToggle("Săn Terror Shark", false, function(v) _G.SelectedTargets["Terror Shark"] = v end)
CreateToggle("Săn Sea Beast", false, function(v) _G.SelectedTargets["Sea Beast"] = v end)
CreateToggle("Săn Piranha", false, function(v) _G.SelectedTargets["Piranha"] = v end)
CreateToggle("Săn Shark", false, function(v) _G.SelectedTargets["Shark"] = v end)
CreateToggle("Săn Thuyền Ma (Ship)", false, function(v) _G.SelectedTargets["Ship"] = v end)

CreateSection("KHỞI ĐỘNG CHỨC NĂNG")
CreateToggle("🚀 CHẠY SEA EVENT", false, function(v) _G.AutoSeaEvent=v if v then _G.AutoFarmLevel=false; _G.AutoFarmBone=false; _G.AutoFarmCake=false end end)

-- =========================================================
-- 🔄 VÒNG LẶP ĐIỀU HƯỚNG MỤC TIÊU (GÁN TỌA ĐỘ VÀO HỆ THỐNG BAY)
-- =========================================================
task.spawn(function()
    while task.wait(0.1) do
        -- 1. Xử lý Farm Level
        if _G.AutoFarmLevel then
            local qName, mobName, qIdx = GetQuestIPData()
            local hasQuest = LocalPlayer.PlayerGui.Main:FindFirstChild("Quest") and LocalPlayer.PlayerGui.Main.Quest.Visible
            
            if not hasQuest then
                local npcIP = FindTargetIP(mobName, true)
                if npcIP then 
                    _G.TargetCFrame = npcIP 
                    if (LocalPlayer.Character.HumanoidRootPart.Position - npcIP.Position).Magnitude < 10 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", qName, qIdx)
                    end
                end
            else
                local mobIP = FindTargetIP(mobName, false)
                if mobIP then 
                    _G.TargetCFrame = mobIP * CFrame.new(0, 10, 0) -- Bay trên đầu quái 10 studs
                    AutoClick()
                end
            end
            
        -- 2. Xử lý Farm Bone
        elseif _G.AutoFarmBone then
            local mobIP = FindTargetIP("Reborn Skeleton", false) or FindTargetIP("Living Zombie", false)
            if mobIP then 
                _G.TargetCFrame = mobIP * CFrame.new(0, 10, 0)
                AutoClick()
            else
                _G.TargetCFrame = ipBoneIsland -- Nếu ko thấy quái, bay thẳng ra Đảo Xương chờ
            end

        -- 3. Xử lý Farm Cake
        elseif _G.AutoFarmCake then
            local mobIP = FindTargetIP("Cake Guard", false) or FindTargetIP("Cookie Crafter", false)
            if mobIP then 
                _G.TargetCFrame = mobIP * CFrame.new(0, 10, 0)
                AutoClick()
            else
                _G.TargetCFrame = ipCakeIsland -- Bay thẳng ra Đảo Bánh chờ
            end
        
        -- 4. Khi tắt farm thì dọn dẹp hướng bay
        elseif not _G.AutoSeaEvent then
            _G.TargetCFrame = nil
        end
    end
end)

-- =========================================================
-- 🌊 VÒNG LẶP SEA EVENT
-- =========================================================
local function GetMyBoat()
    for _, v in pairs(Workspace.Boats:GetChildren()) do
        if v:FindFirstChild("Owner") and v.Owner.Value == LocalPlayer then return v end
    end return nil
end

task.spawn(function()
    while task.wait(0.5) do
        if _G.AutoSeaEvent then
            local myBoat = GetMyBoat()
            
            -- Trạng thái 1: Chưa có thuyền -> Bay đi mua
            if not myBoat and _G.AutoBuyBoat then
                _G.TargetCFrame = ipTikiDock
                if LocalPlayer.Character and (LocalPlayer.Character.HumanoidRootPart.Position - ipTikiDock.Position).Magnitude < 15 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Shipwright", "SpawnBoat", "Sloop")
                    task.wait(2)
                end
            end
            
            -- Trạng thái 2: Lái thuyền ra biển
            if myBoat and not _G.TargetFound then
                _G.TargetCFrame = nil -- Tạm dừng hệ thống bay người để lái thuyền
                local seat = myBoat:FindFirstChild("VehicleSeat")
                if seat then seat.Velocity = seat.CFrame.LookVector * _G.BoatSpeed end
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.W, false, game)
            end
            
            -- Trạng thái 3: Gặp quái đúng cấu hình -> Rời vô lăng bay lên đập
            _G.TargetFound = false
            for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                if _G.SelectedTargets[enemy.Name] and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
                    _G.TargetFound = true
                    -- Gán tọa độ bay lên đầu con quái (cách 20 studs để né skill)
                    _G.TargetCFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0)
                    AutoClick()
                    break
                end
            end
        end
    end
end)
