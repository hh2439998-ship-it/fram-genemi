-- ==============================================================================
-- LIGHT GALAXY HUB ◆ VERSION V12 ĐỘC TÔN (PURE LUAU UI + REDZ CORE)
-- UI GỐC CỦA BẠN - BRING MOB ĐỘC QUYỀN - FAST ATTACK/ESP TỪ REDZ HUB
-- ==============================================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- [1] TỰ ĐỘNG CHỌN PHE HẢI TẶC ĐỂ FARM (Lấy từ Redz)
pcall(function()
    local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
    if not LocalPlayer.Team or (LocalPlayer.Team.Name ~= "Marines" and LocalPlayer.Team.Name ~= "Pirates") then
        CommF:InvokeServer("SetTeam", "Pirates")
    end
end)

-- [2] NHẬN DIỆN MÔI TRƯỜNG CHẠY UI AN TOÀN CHO MOBILE
local UI_Parent = game:GetService("CoreGui")
if not UI_Parent or pcall(function() local a = UI_Parent.Name end) == false then
    UI_Parent = LocalPlayer:WaitForChild("PlayerGui")
end
if UI_Parent:FindFirstChild("LightGalaxyHub") then
    UI_Parent.LightGalaxyHub:Destroy()
end

-- ==============================================================================
-- I. HỆ THỐNG GIAO DIỆN THUẦN (UI CỦA BẠN - 100% HIỂN THỊ)
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
MainFrame.Size = UDim2.new(0, 580, 0, 350)
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
Title.Text = "LIGHT GALAXY HUB ◆ V12 ĐỘC TÔN"
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
    Page.CanvasSize = UDim2.new(0, 0, 3, 0)
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
-- II. ĐỊNH HÌNH 4 TAB (TÍCH HỢP TẤT CẢ CHỨC NĂNG)
-- ==============================================================================
local FarmPage = CreatePage("Cày Cuốc")
local ESPPage = CreatePage("Visual & ESP")
local HackPage = CreatePage("Hacks PVP")
local TeleportPage = CreatePage("Tọa Độ IP")
Pages["Cày Cuốc"].Visible = true

_G.FastAttackRedz = false
_G.BringMobSafe = false
_G.AutoFarmLevel = false
_G.AutoBone = false
_G.AutoCake = false
_G.ESPPlayer = false
_G.ESPFruit = false
_G.ESPChest = false
_G.InfSoru = false
_G.NoDodgeCD = false

-- TAB CÀY CUỐC
AddToggle(FarmPage, "[MỚI] Fast Attack Bypass (Redz)", "FastAttackRedz")
AddToggle(FarmPage, "Real Bring Mob (Dưới Chân 8m)", "BringMobSafe")
AddToggle(FarmPage, "Auto Farm Level", "AutoFarmLevel")
AddToggle(FarmPage, "Auto Farm Xương (Haunted)", "AutoBone")
AddToggle(FarmPage, "Auto Farm Bánh (Cake)", "AutoCake")

-- TAB ESP
AddToggle(ESPPage, "ESP Người Chơi (Xuyên Tường)", "ESPPlayer")
AddToggle(ESPPage, "ESP Rương Vàng", "ESPChest")
AddToggle(ESPPage, "ESP Trái Ác Quỷ", "ESPFruit")

-- TAB HACKS PVP
AddToggle(HackPage, "Lướt Vô Hạn (Infinite Soru)", "InfSoru")
AddToggle(HackPage, "Né Bất Tử (No Dodge CD)", "NoDodgeCD")
AddButton(HackPage, "⚡ Tối Ưu Hóa FPS (Giảm Lag)", function()
    for _, v in ipairs(game:GetDescendants()) do
        if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") then v:Destroy()
        elseif v:IsA("Lighting") then v.GlobalShadows = false v.FogEnd = 1e10 v.Brightness = 0 end
    end
end)

-- TAB TELEPORT
local MapIP = {
    ["Port Town (Đảo Đầu)"] = CFrame.new(-290, 44, 5581),
    ["Hydra Island (Đảo Nữ)"] = CFrame.new(5749, 610, -253),
    ["Floating Turtle (Đảo Rùa)"] = CFrame.new(-12463, 375, -7523),
    ["Castle On Sea (Lâu Đài)"] = CFrame.new(-5012, 315, -3157),
    ["Haunted Castle (Xương)"] = CFrame.new(-9481, 142, 5566),
    ["Cake Island (Bánh)"] = CFrame.new(-2022, 38, -12028),
    ["Tiki Outpost (Cuối)"] = CFrame.new(-2421, 73, -3215)
}
for Name, Coord in pairs(MapIP) do
    AddButton(TeleportPage, "Dịch Chuyển: " .. Name, function()
        local Char = LocalPlayer.Character
        if Char and Char:FindFirstChild("HumanoidRootPart") then
            Char.HumanoidRootPart.CFrame = Coord
        end
    end)
end

-- ==============================================================================
-- III. LÕI ĐÂM SÁT THƯƠNG: FAST ATTACK BYPASS (SAO CHÉP TỪ REDZ HUB)
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
-- IV. LÕI BẤT TỬ: REAL BRING MOB (CỦA BẠN - HÚT DƯỚI CHÂN AN TOÀN)
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
                            Enemy.HumanoidRootPart.Transparency = 0.7 
                            -- Đưa quái xuống thẳng dưới chân 8 studs - Quái kẹt góc không đánh lại được!
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
-- V. HỆ THỐNG ESP (SAO CHÉP TỪ REDZ)
-- ==============================================================================
task.spawn(function()
    while task.wait(1) do
        -- 1. ESP Chest
        if _G.ESPChest then
            for _, chest in pairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
                if not chest:FindFirstChild("ESP_C") then
                    local bg = Instance.new("BillboardGui", chest)
                    bg.Name = "ESP_C" bg.Size = UDim2.new(0, 100, 0, 40) bg.AlwaysOnTop = true
                    local txt = Instance.new("TextLabel", bg)
                    txt.Size = UDim2.new(1,0,1,0) txt.BackgroundTransparency = 1 txt.TextColor3 = Color3.fromRGB(255, 215, 0)
                    txt.TextScaled = true txt.Font = Enum.Font.GothamBold
                    txt.Text = "Chest [" .. math.floor((LocalPlayer.Character.Head.Position - chest.Position).Magnitude) .. "m]"
                else
                    chest.ESP_C.TextLabel.Text = "Chest [" .. math.floor((LocalPlayer.Character.Head.Position - chest.Position).Magnitude) .. "m]"
                end
            end
        else
            for _, chest in pairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
                if chest:FindFirstChild("ESP_C") then chest.ESP_C:Destroy() end
            end
        end

        -- 2. ESP Fruit
        if _G.ESPFruit then
            for _, fruit in pairs(Workspace:GetChildren()) do
                if fruit:IsA("Tool") and string.find(fruit.Name, "Fruit") and fruit:FindFirstChild("Handle") then
                    if not fruit.Handle:FindFirstChild("ESP_F") then
                        local bg = Instance.new("BillboardGui", fruit.Handle)
                        bg.Name = "ESP_F" bg.Size = UDim2.new(0, 150, 0, 40) bg.AlwaysOnTop = true
                        local txt = Instance.new("TextLabel", bg)
                        txt.Size = UDim2.new(1,0,1,0) txt.BackgroundTransparency = 1 txt.TextColor3 = Color3.fromRGB(255, 50, 50)
                        txt.TextScaled = true txt.Font = Enum.Font.GothamBold
                        txt.Text = fruit.Name .. " [" .. math.floor((LocalPlayer.Character.Head.Position - fruit.Handle.Position).Magnitude) .. "m]"
                    else
                        fruit.Handle.ESP_F.TextLabel.Text = fruit.Name .. " [" .. math.floor((LocalPlayer.Character.Head.Position - fruit.Handle.Position).Magnitude) .. "m]"
                    end
                end
            end
        else
            for _, fruit in pairs(Workspace:GetChildren()) do
                if fruit:IsA("Tool") and fruit:FindFirstChild("Handle") and fruit.Handle:FindFirstChild("ESP_F") then fruit.Handle.ESP_F:Destroy() end
            end
        end
        
        -- 3. ESP Player
        if _G.ESPPlayer then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") then
                    if not p.Character.HumanoidRootPart:FindFirstChild("ESP_P") then
                        local bg = Instance.new("BillboardGui", p.Character.HumanoidRootPart)
                        bg.Name = "ESP_P" bg.Size = UDim2.new(0, 200, 0, 40) bg.AlwaysOnTop = true bg.StudsOffset = Vector3.new(0, 3, 0)
                        local txt = Instance.new("TextLabel", bg)
                        txt.Size = UDim2.new(1,0,1,0) txt.BackgroundTransparency = 1 txt.TextColor3 = Color3.fromRGB(0, 255, 255)
                        txt.TextScaled = true txt.Font = Enum.Font.SourceSansBold
                    end
                    p.Character.HumanoidRootPart.ESP_P.TextLabel.Text = p.Name .. " [" .. math.floor((LocalPlayer.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude) .. "m]\nHP: " .. math.floor(p.Character.Humanoid.Health)
                end
            end
        else
            for _, p in pairs(Players:GetPlayers()) do
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.HumanoidRootPart:FindFirstChild("ESP_P") then
                    p.Character.HumanoidRootPart.ESP_P:Destroy()
                end
            end
        end
    end
end)

-- ==============================================================================
-- VI. PVP HACKS (TỪ REDZ MÓC THẲNG VÀO BỘ NHỚ)
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

-- ==============================================================================
-- VII. AUTO FARM & DI CHUYỂN
--- ==============================================================================
-- VIII. AUTO CLICK & AUTO EQUIP (PHẦN BỔ SUNG CÒN THIẾU)
-- ==============================================================================
local VirtualUser = game:GetService("VirtualUser")

task.spawn(function()
    while task.wait(0.1) do
        -- Kiểm tra nếu 1 trong các chế độ Farm đang bật
        if _G.AutoFarmLevel or _G.AutoBone or _G.AutoCake then
            pcall(function()
                -- 1. Auto Equip (Luôn tự động móc vũ khí ra khi farm)
                local Char = LocalPlayer.Character
                if Char and not Char:FindFirstChildOfClass("Tool") then
                    for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
                        if tool:IsA("Tool") and (tool.ToolTip == "Melee" or tool.ToolTip == "Sword") then
                            Char.Humanoid:EquipTool(tool)
                            break
                        end
                    end
                end
                
                -- 2. Auto Click (Spam click liên tục để chém)
                -- Kết hợp với Bring Mob của ní là quái bốc hơi trong 1 nốt nhạc
                VirtualUser:CaptureController()
                VirtualUser:ClickButton1(Vector2.new(851, 158))
            end)
        end
    end
end)

-- ==============================================================================
-- IX. ANTI-RESET & SERVER HOP (LẤY TỪ SOURCE REDZ NÍ GỬI)
-- ==============================================================================
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
_G.AutoRejoin30m = true -- Mặc định bật luôn cho an toàn, cày thuê treo đêm không sợ bị sút

-- Hàm tìm Server mới mượt hơn, ít người hơn
local function GetNewServer()
    local Servers = {}
    local success, req = pcall(function()
        return game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100")
    end)
    
    if success and req then
        local data = HttpService:JSONDecode(req)
        for _, server in pairs(data.data) do
            -- Tìm server chưa đầy và không trùng với server hiện tại
            if server.playing < server.maxPlayers and server.id ~= game.JobId then
                table.insert(Servers, server.id)
            end
        end
        if #Servers > 0 then
            return Servers[math.random(1, #Servers)]
        end
    end
    return nil
end

-- Vòng lặp chống kích (Server Hop mỗi 30 phút y như Redz Hub Vip)
task.spawn(function()
    while true do
        task.wait(1800) -- Đợi đúng 30 phút (1800 giây)
        if _G.AutoRejoin30m then
            local NewServer = GetNewServer()
            if NewServer then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, NewServer, LocalPlayer)
            else
                TeleportService:Teleport(game.PlaceId, LocalPlayer)
            end
        end
    end
end)

-- THÔNG BÁO LOAD THÀNH CÔNG (Hiển thị góc phải màn hình)
game.StarterGui:SetCore("SendNotification", {
    Title = "Light Galaxy Hub",
    Text = "Đã Load Full Chức Năng Thành Công!",
    Duration = 5
})
