-- [[ HỆ THỐNG KHỬ TRÙNG UI CŨ ]]
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local TargetGui = (CoreGui:FindFirstChild("RobloxGui") and CoreGui) or PlayerGui

if TargetGui:FindFirstChild("HuyHoangHubPure") then
    TargetGui.HuyHoangHubPure:Destroy()
end

-- [[ CẤU HÌNH BIẾN TOÀN CỤC ]]
_G.AutoFarmLevel = false
_G.AutoFarmBone = false
_G.AutoSeaEvent = false
_G.BoatSpeed = 300
_G.DodgeSpeed = 350
_G.AutoDodge = true

_G.SelectedTargets = {
    ["Terror Shark"] = true,
    ["Piranha"] = true,
    ["Shark"] = true,
    ["Sea Beast"] = true,
    ["Ship"] = true
}

local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- [[ HÀM BỔ TRỢ DI CHUYỂN & ATTACK ]]
local function AutoClick()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton1(Vector2.new(0,0))
end

local function TweenTo(cframe)
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local hrp = character.HumanoidRootPart
        local distance = (hrp.Position - cframe.Position).Magnitude
        local speed = 300 -- Tốc độ bay an toàn
        local info = TweenInfo.new(distance / speed, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(hrp, info, {CFrame = cframe})
        tween:Play()
    end
end

-- =========================================================
-- 🖥️ KHỞI TẠO GIAO DIỆN THUỒN LUA (100% XUẤT HIỆN)
-- =========================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HuyHoangHubPure"
ScreenGui.Parent = TargetGui
ScreenGui.ResetOnSpawn = false

-- Khung chính (Main Frame)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 550, 0, 320)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Cho phép vuốt di chuyển bảng trên điện thoại
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Thanh Tiêu Đề (Title Bar)
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -40, 1, 0)
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.Text = "HUY HOÀNG HUB — PREMIUM EDITION"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 16
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.BackgroundTransparency = 1
TitleText.Parent = TitleBar

-- Nút Tắt/Mở Nhanh Giao Diện (Close Button)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseBtn.TextSize = 18
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.BackgroundColor3 = Color3.fromRGB(50, 40, 45)
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Vùng chứa chức năng (Container)
local Container = Instance.new("Frame")
Container.Size = UDim2.new(1, -20, 1, -60)
Container.Position = UDim2.new(0, 10, 0, 50)
Container.BackgroundTransparency = 1
Container.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.FillDirection = Enum.FillDirection.Vertical
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 8)
UIList.Parent = Container

-- HÀM TẠO NÚT TỔNG HỢP (Toggle Function)
local function CreateToggle(name, default, callback)
    local state = default
    
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 45)
    Button.BackgroundColor3 = state and Color3.fromRGB(0, 150, 100) or Color3.fromRGB(40, 40, 50)
    Button.Text = name .. (state and " : [ BẬT ]" or " : [ TẮT ]")
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 15
    Button.Font = Enum.Font.SourceSansBold
    Button.Parent = Container
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = Button
    
    Button.MouseButton1Click:Connect(function()
        state = not state
        Button.BackgroundColor3 = state and Color3.fromRGB(0, 150, 100) or Color3.fromRGB(40, 40, 50)
        Button.Text = name .. (state and " : [ BẬT ]" or " : [ TẮT ]")
        callback(state)
    end)
    
    return Button
end

-- =========================================================
-- 📊 TÍCH HỢP TẤT CẢ CHỨC NĂNG (FARM & SEA EVENT)
-- =========================================================

-- Nút 1: Auto Farm Level
local FarmLvlBtn = CreateToggle("Tự Động Farm Cày Cấp (Level Max)", _G.AutoFarmLevel, function(Value)
    _G.AutoFarmLevel = Value
    if Value then _G.AutoSeaEvent = false end
end)

-- Nút 2: Auto Farm Bone
local FarmBoneBtn = CreateToggle("Tự Động Gom Xương (Farm Bone)", _G.AutoFarmBone, function(Value)
    _G.AutoFarmBone = Value
    if Value then _G.AutoSeaEvent = false end
end)

-- Nút 3: Auto Sea Event
local SeaEventBtn = CreateToggle("Chế Độ Ra Khơi (Auto Sea Event)", _G.AutoSeaEvent, function(Value)
    _G.AutoSeaEvent = Value
    if Value then
        _G.AutoFarmLevel = false
        _G.AutoFarmBone = false
    end
end)

-- Nút 4: Tăng tốc thuyền 300 -> 500
local SpeedState = false
local SpeedBtn = CreateToggle("Tốc Độ Thuyền Siêu Cấp (300 -> 500)", false, function(Value)
    _G.BoatSpeed = Value and 500 or 300
end)


-- [[ VÒNG LẶP LOGIC CHẠY NGẦM ]]

-- 1. Xử lý Farm Level & Bone
task.spawn(function()
    while task.wait(0.1) do
        if _G.AutoFarmLevel and not _G.AutoSeaEvent then
            local hasQuest = LocalPlayer.PlayerGui.Main:FindFirstChild("Quest") and LocalPlayer.PlayerGui.Main.Quest.Visible
            if not hasQuest then
                TweenTo(CFrame.new(1059, 15, 1540)) -- Tọa độ nhận nhiệm vụ mẫu
                task.wait(0.5)
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "Bandit Quest 1", 1)
            else
                for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                    if mob.Name == "Bandit" and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
                        TweenTo(mob.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0))
                        AutoClick()
                        break
                    end
                end
            end
        elseif _G.AutoFarmBone and not _G.AutoSeaEvent then
            for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                if (mob.Name == "Reborn Skeleton" or mob.Name == "Living Zombie" or mob.Name == "Demonic Soul") 
                and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
                    TweenTo(mob.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0))
                    AutoClick()
                    break
                end
            end
        end
    end
end)

-- 2. Xử lý Thuyền (Noclip xuyên mọi vật cản + Tốc độ ép liên tục)
local function GetMyBoat()
    for _, v in pairs(Workspace.Boats:GetChildren()) do
        if v:FindFirstChild("Owner") and v.Owner.Value == LocalPlayer then
            return v
        end
    end
    return nil
end

RunService.Stepped:Connect(function()
    if _G.AutoSeaEvent then
        local myBoat = GetMyBoat()
        if myBoat and myBoat:FindFirstChild("VehicleSeat") then
            local seat = myBoat.VehicleSeat
            if seat.Velocity.Magnitude > 0 then
                seat.Velocity = seat.CFrame.LookVector * _G.BoatSpeed
            end
            for _, part in pairs(myBoat:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- Lái thuyền tự động đi thẳng ra xa khi chưa thấy quái
task.spawn(function()
    while task.wait(1) do
        if _G.AutoSeaEvent then
            local myBoat = GetMyBoat()
            if myBoat and not _G.TargetFound then
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.W, false, game)
            end
        end
    end
end)

-- 3. Cơ chế Né Chiêu Cực Hạn (Dodge Speed 350) bay vút lên trời
local isDodging = false
local function DodgeSkill()
    if isDodging or not _G.AutoDodge then return end
    isDodging = true
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local hrp = character.HumanoidRootPart
        local bv = Instance.new("BodyVelocity")
        bv.Velocity = Vector3.new(0, _G.DodgeSpeed, 0)
        bv.MaxForce = Vector3.new(0, math.huge, 0)
        bv.Parent = hrp
        task.wait(1.5) -- Trụ trên không né đòn 1.5 giây
        bv:Destroy()
        isDodging = false
    end
end

-- 4. Săn Quái Biển (Terror Shark, Piranha, Thuyền Ma...)
task.spawn(function()
    while task.wait(0.1) do
        if _G.AutoSeaEvent then
            _G.TargetFound = false
            for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                if _G.SelectedTargets[enemy.Name] and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
                    _G.TargetFound = true
                    
                    -- Nếu quái bật chiêu lớn, kích hoạt né lập tức
                    if enemy:FindFirstChild("Animate") or enemy:FindFirstChild("AttackEffects") then
                        DodgeSkill()
                    end
                    
                    if not isDodging then
                        -- Bay cố định phía trên đầu quái 20 Studs để xả skill xuống dưới
                        TweenTo(enemy.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
                        AutoClick()
                    end
                    break
                end
            end
        end
    end
end)
