
local function tryLoad(url)
    local ok, res = pcall(function() return loadstring(game:HttpGet(url))() end)
    return ok and res or nil
end

local redzlib = tryLoad("https://raw.githubusercontent.com/tbao143/Library-ui/refs/heads/main/Redzhubui")
if not redzlib then
    redzlib = tryLoad("https://raw.githubusercontent.com/tbao143/Library-ui/main/Redzhubui.lua")
end
if not redzlib then
    -- fallback common fluent/ui (alguns usam outra lib); altere para sua lib se necessário
    redzlib = tryLoad("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua")
end
if not redzlib then
    error("Falha ao carregar RedzLib/Fluent. Verifique URL ou acesso HTTP do executor.")
end

-- === Notify seguro (usa redzlib.Notify se disponível) ===
local function Notify(title, text, time)
    time = time or 4
    pcall(function()
        if redzlib and redzlib.Notify then
            redzlib.Notify(title, text, time)
            return
        end
        local gui = Instance.new("ScreenGui")
        gui.Name = "IDKHubNotify"
        gui.ResetOnSpawn = false
        gui.Parent = game:GetService("CoreGui")
        local frame = Instance.new("Frame", gui)
        frame.Size = UDim2.new(0, 320, 0, 64)
        frame.Position = UDim2.new(0.5, -160, 0.07, 0)
        frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
        frame.BorderSizePixel = 0
        frame.BackgroundTransparency = 0.1
        local titleLbl = Instance.new("TextLabel", frame)
        titleLbl.Size = UDim2.new(1, -12, 0, 20)
        titleLbl.Position = UDim2.new(0, 6, 0, 6)
        titleLbl.BackgroundTransparency = 1
        titleLbl.Text = title
        titleLbl.TextColor3 = Color3.new(1,1,1)
        titleLbl.Font = Enum.Font.SourceSansBold
        titleLbl.TextSize = 16
        local txt = Instance.new("TextLabel", frame)
        txt.Size = UDim2.new(1, -12, 0, 34)
        txt.Position = UDim2.new(0, 6, 0, 26)
        txt.BackgroundTransparency = 1
        txt.Text = text
        txt.TextColor3 = Color3.new(1,1,1)
        txt.Font = Enum.Font.SourceSans
        txt.TextSize = 14
        txt.TextWrapped = true
        task.delay(time, function() pcall(function() gui:Destroy() end) end)
    end)
end

-- === Services / locals ===
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local Stats = (pcall(function() return game:GetService("Stats") end) and game:GetService("Stats")) or nil

local function KeyToString(k) return tostring(k):gsub("Enum.KeyCode.", "") end

-- === Build window and tabs ===
local Window = redzlib:MakeWindow({
    Title = "IDK Hub - Blade Ball",
    SubTitle = "by cauezxxxd",
    SaveFolder = "IDK_BladeBall"
})
Window:AddMinimizeButton({ Button = { Image = "rbxassetid://", BackgroundTransparency = 0 }, Corner = { CornerRadius = UDim.new(35,1) } })

local TabMain = Window:MakeTab({" Main",""})
local TabFarming = Window:MakeTab({" Farming",""})
local TabItems = Window:MakeTab({"Items",""})
local TabSetting = Window:MakeTab({" Setting",""})
local TabLocal Player = Window:MakeTab({" Local Player",""})
local TabSea Event = Window:MakeTab({" Sea Event",""})
local TabSetting Sea = Window:MakeTab({" Setting Sea",""})
local TabStack Sea = Window:MakeTab({" Stack Sea",""})
local TabCrafts = Window:MakeTab({" Crafts",""}) 
local TabCombat = Window:MakeTab({" Combat",""}) 
local TabRace V4 = Window:MakeTab({" Race V4",""}) 
local TabStats = Window:MakeTab({" ",""}) 
local TabStats = Window:MakeTab({" Stats",""}) 
local TabStats = Window:MakeTab({" Stats",""}) 
local TabStats = Window:MakeTab({" Stats",""}) 
local TabStats = Window:MakeTab({" Stats",""}) 
local TabStats = Window:MakeTab({" Stats",""}) 
local TabStats = Window:MakeTab({" Stats",""}) 
local TabStats = Window:MakeTab({" Stats",""}) 
local TabStats = Window:MakeTab({" Stats",""}) 
local TabStats = Window:MakeTab({" Stats",""}) 

