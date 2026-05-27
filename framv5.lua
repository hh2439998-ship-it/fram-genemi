-- [[ KHỞI TẠO HUB & XÓA BẢN CŨ ]]
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")

local TargetGui = CoreGui:FindFirstChild("RobloxGui") or LocalPlayer:WaitForChild("PlayerGui")
if TargetGui:FindFirstChild("GalaxyHubPro") then TargetGui.GalaxyHubPro:Destroy() end

-- [[ CẤU HÌNH BIẾN TOÀN CỤC ]]
_G.AutoFarmLevel = false
_G.AutoFarmBone = false
_G.AutoFarmCake = false
_G.AutoSeaEvent = false
_G.AutoBuyBoat = false
_G.TargetZone = 6
_G.BoatSpeed = 300

_G.SelectedTargets = { ["Terror Shark"] = false, ["Sea Beast"] = false, ["Piranha"] = false, ["Shark"] = false, ["Ship"] = false }
_G.TargetCFrame = nil 
local FlySpeed = 320 

-- =========================================================
-- 📍 BỘ DATA IP (TỌA ĐỘ CFRAME CHUẨN SEA 3)
-- =========================================================
local ipTikiDock = CFrame.new(-5075, 40, -3153) 
local ipBoneIsland = CFrame.new(-9494, 142, 5521)
local ipCakeIsland = CFrame.new(-2123, 70, -11985)
local ipPortTown = CFrame.new(-290, 20, 5320)

-- Data Nhiệm vụ theo Cấp độ (Level)
local function GetQuestIPData()
    local lvl = LocalPlayer.Data.Level.Value
    if lvl >= 1500 and lvl < 1525 then return "Pirate Port Quest", "Pirate Millionaire", 1
    elseif lvl >= 1525 and lvl < 1575 then return "Pirate Port Quest", "Pistol Billionaire", 2
    elseif lvl >= 1975 and lvl < 2000 then return "Haunted Quest 2", "Possessed Mummy", 2
    elseif lvl >= 2000 and lvl < 2075 then return "Skeleton Warriors Quest", "Reborn Skeleton", 1
    elseif lvl >= 2075 and lvl < 2125 then return "Demonic Souls Quest", "Demonic Soul", 2
    elseif lvl >= 2200 and lvl < 2275 then return "Ice Cream Quest", "Cookie Crafter", 1
    elseif lvl >= 2275 and lvl < 2300 then return "Cake Quest 1", "Cake Guard", 1
    elseif lvl >= 2300 and lvl < 2400 then return "Cake Quest 2", "Baking Subordinate", 2
    elseif lvl >= 2400 then return "Candy Quest 1", "Candy Rebel", 1
    else return "Bandit Quest 1", "Bandit", 1 end
end

-- Tìm IP NPC và Quái
local function FindTargetIP(targetName, isNPC)
    if isNPC then
        for _, v in pairs(Workspace:GetChildren()) do
            if (v.Name:find(targetName) or v.Name:find("Quest Giver")) and v:FindFirstChild("HumanoidRootPart") then 
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
-- 🚀 HỆ THỐNG BAY HEARTBEAT & XUYÊN TƯỜNG (ANTI-KICK)
-- =========================================================
RunService.Stepped:Connect(function()
    local isFarming = _G.AutoFarmLevel or _G.AutoFarmBone or _G.AutoFarmCake or _G.AutoSeaEvent
    if isFarming and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetChildren()) do
            if v:IsA("BasePart") and v.CanCollide then v.CanCollide = false end
        end
    end
end)

RunService.Heartbeat:Connect(function(deltaTime)
    local isFarming = _G.AutoFarmLevel or _G.AutoFarmBone or _G.AutoFarmCake or _G.AutoSeaEvent
    if isFarming and _G.TargetCFrame and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        local dist = (hrp.Position - _G.TargetCFrame.Position).Magnitude
        
        if dist > 40 then
            local direction = (_G.TargetCFrame.Position - hrp.Position).Unit
            hrp.CFrame = hrp.CFrame + (direction * FlySpeed * deltaTime)
            hrp.Velocity = Vector3.new(0, 0, 0)
        else
            hrp.CFrame = _G.TargetCFrame
            hrp.Velocity = Vector3.new(0, 0, 0)
        end
    end
end)

-- =========================================================
-- ⚔️ HỆ THỐNG BRING QUÁI (MAX 2 CON) & AUTO CLICK
-- =========================================================
local function BringMobs(mobName)
    local count = 0
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
            if enemy.Name == mobName and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
                if (enemy.HumanoidRootPart.Position - hrp.Position).Magnitude < 350 then
                    if count < 2 then -- Chốt chặt chỉ gom 2 con
                        -- Kéo xuống ngay dưới chân người chơi
                        enemy.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, -5, -4)
                        enemy.HumanoidRootPart.Size = Vector3.new(10, 10, 10) -- Mở rộng hitbox quái
                        enemy.HumanoidRootPart.CanCollide = false
                        
                        -- Vô hiệu hóa đòn đánh của quái (Stun)
                        if enemy:FindFirstChild("Humanoid") then
                            enemy.Humanoid.JumpPower = 0
                            enemy.Humanoid.WalkSpeed = 0
                        end
                        count = count + 1
                    end
                end
            end
        end
    end
end

-- Vòng lặp Auto Click Độc Lập Siêu Tốc
RunService.RenderStepped:Connect(function()
    if _G.AutoFarmLevel or _G.AutoFarmBone or _G.AutoFarmCake or (_G.AutoSeaEvent and _G.TargetFound) then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton1(Vector2.new(800, 800))
        
        -- Tự động cầm vũ khí (Melee/Sword)
        local char = LocalPlayer.Character
        if char and not char:FindFirstChildOfClass("Tool") then
            for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
                if tool:IsA("Tool") and (tool.ToolTip == "Melee" or tool.ToolTip == "Sword") then
                    char.Humanoid:EquipTool(tool)
                    break
                end
            end
        end
    end
end)

-- =========================================================
-- 🖥️ GIAO DIỆN GALAXY THEME
-- =========================================================
local ScreenGui = Instance.new("ScreenGui", TargetGui)
ScreenGui.Name = "GalaxyHubPro"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 500, 0, 380)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 25) -- Nền tím đen Galaxy
MainFrame.Active = true; MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(100, 50, 255)

local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 15, 45)
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 10)

local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.Size = UDim2.new(1, -10, 1, 0); TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.Text = "LIGHT GALAXY HUB — PREMIUM AUTO"
TitleText.TextColor3 = Color3.fromRGB(200, 150, 255); TitleText.TextSize = 16
TitleText.Font = Enum.Font.SourceSansBold; TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.BackgroundTransparency = 1

local Container = Instance.new("ScrollingFrame", MainFrame)
Container.Size = UDim2.new(1, -20, 1, -65); Container.Position = UDim2.new(0, 10, 0, 55)
Container.BackgroundTransparency = 1; Container.ScrollBarThickness = 5
Container.CanvasSize = UDim2.new(0, 0, 0, 1000)
local UIList = Instance.new("UIListLayout", Container); UIList.Padding = UDim.new(0, 6)

local function CreateSection(text)
    local Label = Instance.new("TextLabel", Container)
    Label.Size = UDim2.new(1, 0, 0, 30); Label.BackgroundTransparency = 1
    Label.Text = "✧ " .. text .. " ✧"; Label.TextColor3 = Color3.fromRGB(255, 200, 255)
    Label.Font = Enum.Font.SourceSansBold; Label.TextSize = 15
end

local function CreateToggle(text, default, callback)
    local state = default
    local Btn = Instance.new("TextButton", Container)
    Btn.Size = UDim2.new(1, -10, 0, 40)
    Btn.BackgroundColor3 = state and Color3.fromRGB(100, 50, 200) or Color3.fromRGB(30, 20, 50)
    Btn.Text = text .. (state and " [ BẬT ]" or " [ TẮT ]")
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.SourceSansBold; Btn.TextSize = 14
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    
    Btn.MouseButton1Click:Connect(function()
        state = not state
        Btn.BackgroundColor3 = state and Color3.fromRGB(100, 50, 200) or Color3.fromRGB(30, 20, 50)
        Btn.Text = text .. (state and " [ BẬT ]" or " [ TẮT ]")
        callback(state)
    end)
end

-- TẠO CÁC NÚT UI
CreateSection("CHỨC NĂNG FARM ĐẢO")
CreateToggle("Farm Level (Nhận Quest + Gom Quái)", false, function(v) _G.AutoFarmLevel=v if v then _G.AutoSeaEvent=false;_G.AutoFarmBone=false;_G.AutoFarmCake=false end end)
CreateToggle("Farm Xương (Lâu Đài Bóng Tối)", false, function(v) _G.AutoFarmBone=v if v then _G.AutoSeaEvent=false;_G.AutoFarmLevel=false;_G.AutoFarmCake=false end end)
CreateToggle("Farm Bánh (Đảo Cake)", false, function(v) _G.AutoFarmCake=v if v then _G.AutoSeaEvent=false;_G.AutoFarmLevel=false;_G.AutoFarmBone=false end end)

CreateSection("SỰ KIỆN BIỂN (SEA EVENT)")
CreateToggle("Tự Động Mua Thuyền Tại Tiki", false, function(v) _G.AutoBuyBoat = v end)
CreateToggle("🚀 CHẠY SEA EVENT", false, function(v) _G.AutoSeaEvent=v if v then _G.AutoFarmLevel=false; _G.AutoFarmBone=false; _G.AutoFarmCake=false end end)

CreateSection("CHỌN QUÁI BIỂN (SEA EVENT)")
CreateToggle("Săn Terror Shark", false, function(v) _G.SelectedTargets["Terror Shark"] = v end)
CreateToggle("Săn Sea Beast", false, function(v) _G.SelectedTargets["Sea Beast"] = v end)
CreateToggle("Săn Piranha", false, function(v) _G.SelectedTargets["Piranha"] = v end)
CreateToggle("Săn Shark", false, function(v) _G.SelectedTargets["Shark"] = v end)
CreateToggle("Săn Thuyền Ma (Ship)", false, function(v) _G.SelectedTargets["Ship"] = v end)

-- =========================================================
-- 🔄 VÒNG LẶP XỬ LÝ NHIỆM VỤ & FARM CẤP
-- =========================================================
task.spawn(function()
    while task.wait(0.2) do
        if _G.AutoFarmLevel then
            local qName, mobName, qIdx = GetQuestIPData()
            local hasQuest = LocalPlayer.PlayerGui.Main:FindFirstChild("Quest") and LocalPlayer.PlayerGui.Main.Quest.Visible
            
            if not hasQuest then
                -- Bay đến IP Nhận Quest
                local npcIP = FindTargetIP(mobName, true)
                if npcIP then 
                    _G.TargetCFrame = npcIP 
                    if (LocalPlayer.Character.HumanoidRootPart.Position - npcIP.Position).Magnitude < 15 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", qName, qIdx)
                    end
                end
            else
                -- Bay đến IP Quái, ghim trên đầu rồi kéo 2 con xuống chân
                local mobIP = FindTargetIP(mobName, false)
                if mobIP then 
                    _G.TargetCFrame = mobIP * CFrame.new(0, 15, 0) -- Bay treo lơ lửng cách 15 studs
                    BringMobs(mobName)
                end
            end
            
        elseif _G.AutoFarmBone then
            local mobIP = FindTargetIP("Reborn Skeleton", false) or FindTargetIP("Living Zombie", false)
            if mobIP then 
                _G.TargetCFrame = mobIP * CFrame.new(0, 15, 0)
                BringMobs("Reborn Skeleton")
                BringMobs("Living Zombie")
            else
                _G.TargetCFrame = ipBoneIsland 
            end

        elseif _G.AutoFarmCake then
            local mobIP = FindTargetIP("Cake Guard", false) or FindTargetIP("Cookie Crafter", false)
            if mobIP then 
                _G.TargetCFrame = mobIP * CFrame.new(0, 15, 0)
                BringMobs("Cake Guard")
                BringMobs("Cookie Crafter")
            else
                _G.TargetCFrame = ipCakeIsland
            end
        elseif not _G.AutoSeaEvent then
            _G.TargetCFrame = nil
        end
    end
end)

-- =========================================================
-- 🌊 VÒNG LẶP XỬ LÝ SEA EVENT & MUA THUYỀN
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
            
            if not myBoat and _G.AutoBuyBoat then
                _G.TargetCFrame = ipTikiDock
                if LocalPlayer.Character and (LocalPlayer.Character.HumanoidRootPart.Position - ipTikiDock.Position).Magnitude < 15 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Shipwright", "SpawnBoat", "Sloop")
                    task.wait(2)
                end
            end
            
            if myBoat and not _G.TargetFound then
                _G.TargetCFrame = nil 
                local seat = myBoat:FindFirstChild("VehicleSeat")
                if seat then seat.Velocity = seat.CFrame.LookVector * _G.BoatSpeed end
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.W, false, game)
            end
            
            _G.TargetFound = false
            for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                if _G.SelectedTargets[enemy.Name] and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
                    _G.TargetFound = true
                    _G.TargetCFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0)
                    break
                end
            end
        end
    end
end)
