
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
local TabRaid = Window:MakeTab({"Raid",""}) 
local TabEsp = Window:MakeTab({" Esp",""}) 
local TabShop = Window:MakeTab({"Shop",""}) 
local TabDevil Fruit = Window:MakeTab({"Devil Fruit",""}) 
local TabMisc = Window:MakeTab({" Misc",""}) 
local TabServer = Window:MakeTab({" Server",""}) 
_G.Settings = {
	Main = {
		["Select Weapon"] = "Melee",
		["Farm Mode"] = "Normal",
		["Auto Farm"] = false,
		["Auto Farm Fast"] = false,
		["Selected Mastery Mode"] = "Quest",
		["Auto Farm Fruit Mastery"] = false,
		["Auto Farm Gun Mastery"] = false,
		["Selected Mastery Sword"] = nil,
		["Auto Farm Sword Mastery"] = false,
		["Selected Mob"] = nil,
		["Auto Farm Mob"] = false,
		["Selected Boss"] = nil,
		["Auto Farm Boss"] = false,
		["Auto Farm All Boss"] = false
	},
	Event = {},
	Farm = {
		["Auto Elite Hunter"] = false,
		["Auto Elite Hunter Hop"] = false,
		["Selected Bone Farm Mode"] = "Quest",
		["Auto Farm Bone"] = false,
		["Auto Random Surprise"] = false,
		["Auto Pirate Raid"] = false,
		["Auto Farm Observation"] = false,
		["Auto Observation V2"] = false,
		["Auto Musketeer Hat"] = false,
		["Auto Saber"] = false,
		["Auto Farm Chest Tween"] = false,
		["Auto Farm Chest Instant"] = false,
		["Auto Chest Hop"] = false,
		["Auto Farm Chest Mirage"] = false,
		["Auto Stop Items"] = false,
		["Auto Farm Katakuri"] = false,
		["Auto Spawn Cake Prince"] = false,
		["Auto Kill Cake Prince"] = false,
		["Auto Kill Dough King"] = false,
		["Auto Farm Radioactive"] = false,
		["Auto Farm Mystic Droplet"] = false,
		["Auto Farm Magma Ore"] = false,
		["Auto Farm Angel Wings"] = false,
		["Auto Farm Leather"] = false,
		["Auto Farm Scrap Metal"] = false,
		["Auto Farm Conjured Cocoa"] = false,
		["Auto Farm Dragon Scale"] = false,
		["Auto Farm Gunpowder"] = false,
		["Auto Farm Fish Tail"] = false,
		["Auto Farm Mini Tusk"] = false
	},Setting = {
		["Spin Position"] = false,
		["Farm Distance"] = 35,
		["Player Tween Speed"] = 350,
		["Bring Mob"] = true,
		["Bring Mob Mode"] = "Normal",
		["Fast Attack"] = true,
		["Fast Attack Mode"] = "Normal",
		["Fast Attack Type"] = "New",
		["Attack Aura"] = true,
		["Hide Notification"] = false,
		["Hide Damage Text"] = true,
		["Black Screen"] = false,
		["White Screen"] = false,
		["Hide Monster"] = false,
		["Mastery Health"] = 25,
		["Fruit Mastery Skill Z"] = true,
		["Fruit Mastery Skill X"] = true,
		["Fruit Mastery Skill C"] = true,
		["Fruit Mastery Skill V"] = false,
		["Fruit Mastery Skill F"] = false,
		["Gun Mastery Skill Z"] = true,
		["Gun Mastery Skill X"] = true,
		["Auto Set Spawn Point"] = true,
		["Auto Observation"] = false,
		["Auto Haki"] = true,
		["Auto Rejoin"] = true,
		["Bypass Anti Cheat"] = true
	},
	Hold = {
		["Hold Mastery Skill Z"] = 0,
		["Hold Mastery Skill X"] = 0,
		["Hold Mastery Skill C"] = 0,
		["Hold Mastery Skill V"] = 0,
		["Hold Mastery Skill F"] = 0,
		["Hold Sea Skill Z"] = 0,
		["Hold Sea Skill X"] = 0,
		["Hold Sea Skill C"] = 0,
		["Hold Sea Skill V"] = 0,
		["Hold Sea Skill F"] = 0
	},
	Stats = {
		["Auto Add Melee Stats"] = false,
		["Auto Add Defense Stats"] = false,
		["Auto Add Devil Fruit Stats"] = false,
		["Auto Add Sword Stats"] = false,
		["Auto Add Gun Stats"] = false,
		["Point Stats"] = 1
	},
	Items = {
		["Auto Second Sea"] = false,
		["Auto Third Sea"] = false,
		["Auto Farm Factory"] = false,
		["Auto Super Human"] = false,
		["Auto Death Step"] = false,
		["Auto Fishman Karate"] = false,
		["Auto Electric Claw"] = false,
		["Auto Dragon Talon"] = false,
		["Auto God Human"] = false,
		["Auto Buddy Sword"] = false,
		["Auto Soul Guitar"] = false,
		["Auto Rengoku"] = false,
		["Auto Hallow Scythe"] = false,
		["Auto Warden Sword"] = false,
		["Auto Cursed Dual Katana"] = false,
		["Auto Yama"] = false,
		["Auto Tushita"] = false,
		["Auto Canvander"] = false,
		["Auto Dragon Trident"] = false,
		["Auto Pole"] = false,
		["Auto Shawk Saw"] = false,
		["Auto Greybeard"] = false,
		["Auto Swan Glasses"] = false,
		["Auto Arena Trainer"] = false,
		["Auto Dark Dagger"] = false,
		["Auto Press Haki Button"] = false,
		["Auto Rainbow Haki"] = false,
		["Auto Holy Torch"] = false,
		["Auto Bartilo Quest"] = false
	},
