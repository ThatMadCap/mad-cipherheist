-- QBCORE EXPORTS / VARIABLES -----------------------------------------------------------------------------------
QBCore = exports["qb-core"]:GetCoreObject()

-- SERVER RESOURCE START ----------------------------------------------------------------------------------------

-- Handle resource start
local function OnStart(resource)
    if (GetCurrentResourceName() ~= resource) then
        return
    end
    print(resource .. " started successfully")
end
-- Event Handler for Resource Start event
AddEventHandler("onResourceStart", OnStart)

-- Handle player loading
RegisterNetEvent(
    "QBCore:Client:OnPlayerLoaded",
    function()
        --GetPlayersWithItem()
    end
)

-- Handle player disconnect
RegisterNetEvent(
    "QBCore:Client:OnPlayerUnload",
    function()
        --StopLoop()
    end
)

-- POLICE COUNT CALLBACK ---------------------------------------------------------------------------------------------

--- Retrieves the number of police officers currently on duty.
---@param source number The source of the request.
---@param callback function The function to receive the police count.
function PoliceCount(source, callback)
    local Player_ids = QBCore.Functions.GetPlayers()
    local police_count = 0
    for i = 1, #Player_ids do
        local Player = QBCore.Functions.GetPlayer(Player_ids[i])
        if Player and Player.PlayerData.job and Player.PlayerData.job.name == Config.Police.JobName and Player.PlayerData.job.onduty then
            police_count = police_count + 1
        end
    end
    callback(police_count) -- Return the actual police count
end

-- Callback for PoliceCount
QBCore.Functions.CreateCallback("mad-cipherheist:server:policecount", PoliceCount)


-- WEBHOOKS ---------------------------------------------------------------------------------------------

-- Send a webhook to the specified URL (REPLACE THE EVENT WITH YOUR WEBHOOK RESOURCE TO WORK)

--[[ RegisterNetEvent('mad-cipherheist:server:startheistlog', function()
    --TODO: LAST LEFT OFF HERE
    -- FIX THE SERVER ERROR REUSING THE PLAYER VARIABLE 
    local Player = QBCore.Functions.GetPlayer(source)
    local RobberName = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
    local RobberDiscord = QBCore.Functions.GetIdentifier(source, 'discord'):sub(9)
    local RobberLocation = tostring(QBCore.Functions.GetCoords(GetPlayerPed(source)))

    if (source) then
        TriggerEvent("yume-log:server:CreateLog",
        "mad-cipherheist", -- name
        "Cipher Heist: Start", -- title
        "pink", -- color
        false, -- tagEveryone
        "<@" .. RobberDiscord .. "> **" .. RobberName .. "** attempted to begin Cipher Heist at: \n" .. RobberLocation,
        "Player",
        nil,
        nil)
    end
end)

RegisterNetEvent('mad-cipherheist:server:terminalhacklog', function()
    local Player = QBCore.Functions.GetPlayer(source)
    local RobberName = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
    local RobberDiscord = QBCore.Functions.GetIdentifier(source, 'discord'):sub(9)
    local RobberLocation = tostring(QBCore.Functions.GetCoords(GetPlayerPed(source)))

    if (source) then
        TriggerEvent("yume-log:server:CreateLog",
        "mad-cipherheist", -- name
        "Cipher Heist: Terminal Hack", -- title
        "pink", -- color
        false, -- tagEveryone
        "<@" .. RobberDiscord .. "> **" .. RobberName .. "** attempted Cipher Heist Terminal Hack at: \n" .. RobberLocation,
        "Player",
        nil,
        nil)
    end
end)

RegisterNetEvent('mad-cipherheist:server:hacksignallog1', function()
    local Player = QBCore.Functions.GetPlayer(source)
    local RobberName = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
    local RobberDiscord = QBCore.Functions.GetIdentifier(source, 'discord'):sub(9)
    local RobberLocation = tostring(QBCore.Functions.GetCoords(GetPlayerPed(source)))

    if (source) then
        TriggerEvent("yume-log:server:CreateLog",
        "mad-cipherheist", -- name
        "Cipher Heist: Signal 1", -- title
        "pink", -- color
        false, -- tagEveryone
        "<@" .. RobberDiscord .. "> **" .. RobberName .. "** attempted Cipher Heist Signal hack 1 at: \n" .. RobberLocation,
        "Player",
        nil,
        nil)
    end
end)
RegisterNetEvent('mad-cipherheist:server:hacksignallog2', function()
    local Player = QBCore.Functions.GetPlayer(source)
    local RobberName = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
    local RobberDiscord = QBCore.Functions.GetIdentifier(source, 'discord'):sub(9)
    local RobberLocation = tostring(QBCore.Functions.GetCoords(GetPlayerPed(source)))

    if (source) then
        TriggerEvent("yume-log:server:CreateLog",
        "mad-cipherheist", -- name
        "Cipher Heist: Signal 2", -- title
        "pink", -- color
        false, -- tagEveryone
        "<@" .. RobberDiscord .. "> **" .. RobberName .. "** attempted Cipher Heist Signal 2 hack at: \n" .. RobberLocation,
        "Player",
        nil,
        nil)
    end
end)
RegisterNetEvent('mad-cipherheist:server:hacksignallog3', function()
    local Player = QBCore.Functions.GetPlayer(source)
    local RobberName = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
    local RobberDiscord = QBCore.Functions.GetIdentifier(source, 'discord'):sub(9)
    local RobberLocation = tostring(QBCore.Functions.GetCoords(GetPlayerPed(source)))

    if (source) then
        TriggerEvent("yume-log:server:CreateLog",
        "mad-cipherheist", -- name
        "Cipher Heist: Signal 3", -- title
        "pink", -- color
        false, -- tagEveryone
        "<@" .. RobberDiscord .. "> **" .. RobberName .. "** attempted Cipher Heist Signal 3 hack at: \n" .. RobberLocation,
        "Player",
        nil,
        nil)
    end
end)
RegisterNetEvent('mad-cipherheist:server:hacksignallog4', function()
    local Player = QBCore.Functions.GetPlayer(source)
    local RobberName = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
    local RobberDiscord = QBCore.Functions.GetIdentifier(source, 'discord'):sub(9)
    local RobberLocation = tostring(QBCore.Functions.GetCoords(GetPlayerPed(source)))

    if (source) then
        TriggerEvent("yume-log:server:CreateLog",
        "mad-cipherheist", -- name
        "Cipher Heist: Signal 4", -- title
        "pink", -- color
        false, -- tagEveryone
        "<@" .. RobberDiscord .. "> **" .. RobberName .. "** attempted Cipher Heist Signal 4 hack at: \n" .. RobberLocation,
        "Player",
        nil,
        nil)
    end
end)

RegisterNetEvent('mad-cipherheist:server:mergesignalshacklog', function()
    local Player = QBCore.Functions.GetPlayer(source)
    local RobberName = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
    local RobberDiscord = QBCore.Functions.GetIdentifier(source, 'discord'):sub(9)
    local RobberLocation = tostring(QBCore.Functions.GetCoords(GetPlayerPed(source)))

    if (source) then
        TriggerEvent("yume-log:server:CreateLog",
        "mad-cipherheist", -- name
        "Cipher Heist: Merge Signals Hack", -- title
        "pink", -- color
        false, -- tagEveryone
        "<@" .. RobberDiscord .. "> **" .. RobberName .. "** attempted to Merge 4 Cipher Heist Signals at: \n" .. RobberLocation,
        "Player",
        nil,
        nil)
    end
end)

RegisterNetEvent('mad-cipherheist:server:taketrackedlootlog', function()
    local Player = QBCore.Functions.GetPlayer(source)
    local RobberName = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
    local RobberDiscord = QBCore.Functions.GetIdentifier(source, 'discord'):sub(9)
    local RobberLocation = tostring(QBCore.Functions.GetCoords(GetPlayerPed(source)))

    if (source) then
        TriggerEvent("yume-log:server:CreateLog",
        "mad-cipherheist", -- name
        "Cipher Heist: Merge Signals Hack", -- title
        "pink", -- color
        false, -- tagEveryone
        "<@" .. RobberDiscord .. "> **" .. RobberName .. "** attempted to take Cipher Heist Tracked Loot at: \n" .. RobberLocation,
        "Player",
        nil,
        nil)
    end
end) ]]

-- USABLE ITEMS -------------------------------------------------------------------------------------------------

-- Make TrackedLoot item usable and trigger a client event when it's used
QBCore.Functions.CreateUseableItem(
    Config.Items.TrackedLoot,
    function(source, item)
        local _source = source
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player.Functions.GetItemByName(item.name) then
            return
        end
        TriggerClientEvent("mad-cipherheist:client:usetrackedlootitem", source)
    end
)

-- Make UntrackedLoot item usable and trigger a client event when it's used
QBCore.Functions.CreateUseableItem(
    Config.Items.UntrackedLoot,
    function(source, item)
        local _source = source
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player.Functions.GetItemByName(item.name) then
            return
        end
        TriggerClientEvent("mad-cipherheist:client:useuntrackedlootitem", source)
    end
)

-- Make DecryptSignals item usable and trigger a client event when it's used
QBCore.Functions.CreateUseableItem(
    Config.Items.DecryptSignals,
    function(source, item)
        local _source = source
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player.Functions.GetItemByName(item.name) then
            return
        end
        TriggerClientEvent("mad-cipherheist:client:usedecryptsignalsitem", source)
    end
)

-- ADD/REMOVE ITEMS FUNCTIONS -----------------------------------------------------------------------------------------

--- Gives an item to the player.
---@param item string The item to give.
local function GiveItem(item)
    local Player = QBCore.Functions.GetPlayer(source)

    local itemMappings = {
        [Config.Items.Signal1] = function()
            return Player.Functions.AddItem(Config.Items.Signal1, 1)
        end,
        [Config.Items.Signal2] = function()
            return Player.Functions.AddItem(Config.Items.Signal2, 1)
        end,
        [Config.Items.Signal3] = function()
            return Player.Functions.AddItem(Config.Items.Signal3, 1)
        end,
        [Config.Items.Signal4] = function()
            return Player.Functions.AddItem(Config.Items.Signal4, 1)
        end,
        [Config.Items.DecryptSignals] = function()
            return Player.Functions.AddItem(Config.Items.DecryptSignals, 1)
        end,
        [Config.Items.TrackedLoot] = function()
            return Player.Functions.AddItem(Config.Items.TrackedLoot, 1)
        end,
        [Config.Items.UntrackedLoot] = function()
            return Player.Functions.AddItem(Config.Items.UntrackedLoot, 1)
        end
    }

    local addItemFunction = itemMappings[item]
    if addItemFunction then
        local success = addItemFunction()
        if success then
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item], "add", 1)
        end
    end
end

--- Removes an item from the player's inventory.
---@param item string The item to remove.
local function RemoveItem(item)
    local Player = QBCore.Functions.GetPlayer(source)
    -- Items we allow for removal
    local removeItemMappings = {
        [Config.Items.PanelHack1] = function()
            Player.Functions.RemoveItem(Config.Items.PanelHack1, 1)
        end,
        [Config.Items.PanelHack2] = function()
            Player.Functions.RemoveItem(Config.Items.PanelHack2, 1)
        end,
        [Config.Items.Signal1] = function()
            Player.Functions.RemoveItem(Config.Items.Signal1, 1)
        end,
        [Config.Items.Signal2] = function()
            Player.Functions.RemoveItem(Config.Items.Signal2, 1)
        end,
        [Config.Items.Signal3] = function()
            Player.Functions.RemoveItem(Config.Items.Signal3, 1)
        end,
        [Config.Items.Signal4] = function()
            Player.Functions.RemoveItem(Config.Items.Signal4, 1)
        end,
        [Config.Items.DecryptSignals] = function()
            Player.Functions.RemoveItem(Config.Items.DecryptSignals, 1)
        end,
        [Config.Items.TerminalUsb] = function()
            Player.Functions.RemoveItem(Config.Items.TerminalUsb, 1)
        end,
        [Config.Items.TrackedLoot] = function()
            Player.Functions.RemoveItem(Config.Items.TrackedLoot, 1)
        end,
        [Config.Items.UntrackedLoot] = function()
            Player.Functions.RemoveItem(Config.Items.UntrackedLoot, 1)
        end
    }
    -- If an item was removed, trigger the inventory ItemBox
    local removeItemFunction = removeItemMappings[item]
    if removeItemFunction then
        removeItemFunction()
        TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item], "remove", 1)
    end
end

-- Handle giving the Trackedloot item specifically
RegisterServerEvent("mad-cipherheist:server:givetrackedloot")
AddEventHandler(
    "mad-cipherheist:server:givetrackedloot",
    function()
        print("mad-cipherheist:server:givetrackedloot server event triggered")
        local Player = QBCore.Functions.GetPlayer(source)

        -- If we can remove decrypt signals item and we can give the tracked loot then...
        if
            Player.Functions.RemoveItem(Config.Items.DecryptSignals, 1) and
                Player.Functions.AddItem(Config.Items.TrackedLoot, 1)
         then
            -- Show remove ItemBox for DecryptSignals
            TriggerClientEvent(
                "inventory:client:ItemBox",
                source,
                QBCore.Shared.Items[Config.Items.DecryptSignals],
                "remove",
                1
            )
            -- Add tracked loot item
            print("mad-cipherheist:server:givetrackedloot - added:" .. Config.Items.TrackedLoot)
            -- Show add ItemBox for TrackedLoot
            TriggerClientEvent(
                "inventory:client:ItemBox",
                source,
                QBCore.Shared.Items[Config.Items.TrackedLoot],
                "add",
                1
            )
            -- Notify
            TriggerClientEvent("QBCore:Notify", source, Config.Text.Notify.AfterGrabCase, "success")
            -- Dispatch
            TriggerClientEvent("mad-cipherheist:client:dispatch", source)
            -- Start CLIENT Blip Loop, also starts Beep Loop
            TriggerClientEvent("mad-cipherheist:client:tracklootpickup", source, true) -- Pass true to indicate that tracking should start
            -- Start POLICE blip thread
            StartLoop()
        end
    end
)

-- Remove Decrypted Signals
local function RemoveDecryptedSignals()
    local player = QBCore.Functions.GetPlayer(source)
    player.Functions.RemoveItem(Config.Items.DecryptSignals, 1)
    TriggerClientEvent(
        "inventory:client:ItemBox",
        source,
        QBCore.Shared.Items[Config.Items.DecryptSignals],
        "remove",
        1
    )
end

-- Handle taking the cipher fragments and giving the decrypted signals specifically
RegisterServerEvent("mad-cipherheist:server:takefragmentsandgivedecryptedsignals")
AddEventHandler(
    "mad-cipherheist:server:takefragmentsandgivedecryptedsignals",
    function()
        local Player = QBCore.Functions.GetPlayer(source)
        -- Remove cipher fragments if we can
        if Player.Functions.RemoveItem(Config.Items.Signal1, 1) then
            TriggerClientEvent(
                "inventory:client:ItemBox",
                source,
                QBCore.Shared.Items[Config.Items.Signal1],
                "remove",
                1
            )
            if Player.Functions.RemoveItem(Config.Items.Signal2, 1) then
                TriggerClientEvent(
                    "inventory:client:ItemBox",
                    source,
                    QBCore.Shared.Items[Config.Items.Signal2],
                    "remove",
                    1
                )
                if Player.Functions.RemoveItem(Config.Items.Signal3, 1) then
                    TriggerClientEvent(
                        "inventory:client:ItemBox",
                        source,
                        QBCore.Shared.Items[Config.Items.Signal3],
                        "remove",
                        1
                    )
                    if Player.Functions.RemoveItem(Config.Items.Signal4, 1) then
                        TriggerClientEvent(
                            "inventory:client:ItemBox",
                            source,
                            QBCore.Shared.Items[Config.Items.Signal4],
                            "remove",
                            1
                        )
                        -- Give decrypted signals item if we can
                        if Player.Functions.AddItem(Config.Items.DecryptSignals, 1) then
                            TriggerClientEvent(
                                "inventory:client:ItemBox",
                                source,
                                QBCore.Shared.Items[Config.Items.DecryptSignals],
                                "add",
                                1
                            )
                        end
                    end
                end
            end
        end
    end
)

-- UNTRACKEDLOOT REWARDS ----------------------------------------------------------------------------------------------------

-- initiliase empty string used for rewards logging  
local rewardLog = ""

--- Function to handle giving rewards based on reward type.
---@param source number The source of the event.
---@param rewardType string The type of reward to give.
function SelectRewards(source, rewardType)
    if Config.Debug then
        print("^2Reward type:^7", rewardType)
    end

    local _source = source
    local Player = QBCore.Functions.GetPlayer(source)

    if Player then
        if Config.Debug then
            print("^2Source:^7", source)
            print("^2Player:^7", Player)
        end

        if rewardType == "blueprint" then
            -- Check if blueprint rewards are enabled
            if Config.HeistRewards.BlueprintReward then
                -- Debug print statement
                if Config.Debug then
                    print("^2Blueprint reward is enabled.^7")
                end

                -- Access available blueprints from config
                local availableBlueprints = Config.HeistRewards.AvailableBlueprints
                -- Generate a seed using Player's server ID and current frame count
                local seed = source * GetGameTimer()
                math.randomseed(seed)
                -- Randomly choose a blueprint
                local chosenBlueprint = availableBlueprints[math.random(#availableBlueprints)]
                -- Give blueprint
                exports["keep-crafting"]:GiveBlueprint(source, chosenBlueprint)

                -- log message concat
                rewardLog = rewardLog .. ":blue_book: Given Blueprint: " .. chosenBlueprint .. ", Quantity: 1\n"

                -- Trigger item box for the blueprint
                TriggerClientEvent(
                    "inventory:client:ItemBox",
                    source,
                    QBCore.Shared.Items[Config.Items.Blueprint],
                    "add",
                    1
                )

                -- Print item given
                if Config.Debug then
                    print("^3Given Blueprint:^7", chosenBlueprint)
                    print("^3Quantity:^7 1")
                end
            end
        elseif rewardType == "weapons" then
            -- Check if weapon rewards are enabled
            if Config.HeistRewards.WeaponReward then
                -- Debug print statement
                if Config.Debug then
                    print("^2Weapon reward is enabled.^7")
                end

                -- Access available weapons from config
                local availableWeapons = Config.HeistRewards.AvailableWeapons
                -- Generate a seed using Player's server ID and current frame count
                local seed = source * GetGameTimer()
                math.randomseed(seed)
                -- Randomly choose a weapon
                local chosenWeapon = availableWeapons[math.random(#availableWeapons)]
                -- Give weapon
                if Player.Functions.AddItem(chosenWeapon, 1) then

                    -- log message concat
                    rewardLog = rewardLog .. ":gun: Given Weapon: " .. chosenWeapon .. ", Quantity: 1\n"

                    -- Trigger item box for the weapon
                    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[chosenWeapon], "add", 1)

                    -- Print item given
                    if Config.Debug then
                        print("^3Given Weapon:^7", chosenWeapon)
                        print("^3Quantity:^7 1")
                    end
                end
            end
        elseif rewardType == "usbs" then
            -- Check if USB rewards are enabled
            if Config.HeistRewards.USBReward then
                -- Debug print statement
                if Config.Debug then
                    print("^2USB reward is enabled.^7")
                end

                -- Access available USBs from config
                local availableUSBs = Config.HeistRewards.AvailableUSBs
                -- Generate a seed using the Player's server ID and current frame count
                local seed = source * GetGameTimer()
                math.randomseed(seed)
                -- Loop through the number of items to give
                for i, usb in ipairs(availableUSBs) do
                    -- Calculate the number of items to give
                    local numItemsToGive = math.random(Config.HeistRewards.USBMinItems, Config.HeistRewards.USBMaxItems)
                    -- Give the calculated quantity of this USB
                    if Player.Functions.AddItem(usb, numItemsToGive) then
                        -- Trigger item box for the USB
                        TriggerClientEvent(
                            "inventory:client:ItemBox",
                            source,
                            QBCore.Shared.Items[usb],
                            "add",
                            numItemsToGive
                        )

                        -- log message concat
                        rewardLog = rewardLog .. ":newspaper2: Given USB: " .. usb .. ", Quantity: " .. numItemsToGive .. "\n"

                        -- Print item given
                        if Config.Debug then
                            print("^3Given USB:^7", usb)
                            print("^3Quantity:^7", numItemsToGive)
                        end
                    end
                end
            end
        elseif rewardType == "cash" then
            -- Check if cash rewards are enabled
            if Config.HeistRewards.CashReward then
                -- Debug print statement
                if Config.Debug then
                    print("^2Cash reward is enabled.^7")
                end

                -- Give cash reward
                if Player.Functions.AddMoney("cash", Config.HeistRewards.CashAmount) then
                    TriggerClientEvent(
                        "QBCore:Notify",
                        source,
                        Config.Text.Notify.CashReward1 ..
                            Config.HeistRewards.CashAmount .. Config.Text.Notify.CashReward2,
                        "success"
                    )

                    -- log message concat
                    rewardLog = rewardLog .. ":moneybag: Given Cash: " .. Config.HeistRewards.CashAmount .. "\n"

                    -- Print item given
                    if Config.Debug then
                        print("^3Given Cash:^7 $", Config.HeistRewards.CashAmount)
                    end
                end
            end
        elseif rewardType == "goldbar" then
            -- Check if goldbar rewards are enabled
            if Config.HeistRewards.GoldbarReward then
                -- Debug print statement
                if Config.Debug then
                    print("^2Goldbar reward is enabled.^7")
                end

                -- Give goldbar reward
                if Player.Functions.AddItem(Config.Items.Goldbar, Config.HeistRewards.GoldbarAmount) then
                    -- Trigger item box for the goldbars
                    TriggerClientEvent(
                        "inventory:client:ItemBox",
                        source,
                        QBCore.Shared.Items[Config.Items.Goldbar],
                        "add",
                        Config.HeistRewards.GoldbarAmount
                    )

                    -- log message concat
                    rewardLog = rewardLog .. ":yellow_square: Given Gold Bars: " .. Config.Items.Goldbar .. ", Quantity: " .. Config.HeistRewards.GoldbarAmount .. "\n"

                    -- Print item given
                    if Config.Debug then
                        print("^3Given Goldbar:^7", Config.Items.Goldbar)
                        print("^3Quantity:^7", Config.HeistRewards.GoldbarAmount)
                    end
                end
            end
        elseif rewardType == "markedbills" then
            -- Check if markedbills rewards are enabled
            if Config.HeistRewards.MarkedBillsReward then
                -- Debug print statement
                if Config.Debug then
                    print("^2Marked Bills reward is enabled.^7")
                end

                -- Give markedbills reward
                if Player.Functions.AddItem(Config.Items.MarkedBills, Config.HeistRewards.MarkedBillsAmount) then
                    -- Trigger item box for the Markedbills
                    TriggerClientEvent(
                        "inventory:client:ItemBox",
                        source,
                        QBCore.Shared.Items[Config.Items.MarkedBills],
                        "add",
                        Config.HeistRewards.MarkedBillsAmount
                    )
                    
                    -- log message concat
                    rewardLog = rewardLog .. ":moneybag: Given Marked Bills: " .. Config.Items.MarkedBills .. ", Quantity: " .. Config.HeistRewards.MarkedBillsAmount .. "\n"

                    -- Print item given
                    if Config.Debug then
                        print("^3Given Marked Bills:^7", Config.Items.MarkedBills)
                        print("^3Quantity:^7", Config.HeistRewards.MarkedBillsAmount)
                    end
                end
            end
        elseif rewardType == "qsphonehack" then
            -- Check if QSPhoneHack rewards are enabled
            if Config.HeistRewards.QSPhoneHackReward then
                -- Debug print statement
                if Config.Debug then
                    print("^2QS Phone Hack reward is enabled.^7")
                end

                -- Give QSPhoneHack reward
                if Player.Functions.AddItem(Config.HeistRewards.QSPhoneHackItemName, 1) then
                    -- Trigger item box for the QSPhoneHack
                    TriggerClientEvent(
                        "inventory:client:ItemBox",
                        source,
                        QBCore.Shared.Items[Config.HeistRewards.QSPhoneHackItemName],
                        "add",
                        1
                    )

                    -- log message concat
                    rewardLog = rewardLog .. ":mobile_phone: Given QS-PhoneHack Item\n"

                    -- Print item given
                    if Config.Debug then
                        print("^3Given QS Phone Hack:^7", Config.HeistRewards.QSPhoneHackItemName)
                        print("^3Quantity:^7 1")
                    end
                end
            end
        elseif rewardType == "custom" then
            -- Check if custom rewards are enabled
            if Config.HeistRewards.CustomRewards then
                -- Debug print statement
                if Config.Debug then
                    print("^2Custom reward is enabled.^7")
                end

                -- Access available custom rewards from config
                local availableCustomRewards = Config.HeistRewards.AvailableCustomRewards
                -- Give custom rewards
                for i, rewardItem in ipairs(availableCustomRewards) do
                    if Player.Functions.AddItem(rewardItem, 1) then
                        -- Trigger item box for the custom reward
                        TriggerClientEvent(
                            "inventory:client:ItemBox",
                            source,
                            QBCore.Shared.Items[rewardItem],
                            "add",
                            1
                        )

                        -- log message concat
                        rewardLog = rewardLog .. ":grey_question: Given Custom Item: "  .. rewardItem .. "\n"

                        -- Print item given
                        if Config.Debug then
                            print("^3Given Custom Item:^7", rewardItem)
                            print("^3Quantity:^7 1")
                        end
                    end
                end
            end
        elseif rewardType == "crypto" then
            -- Wait(1000) -- Wait 1 second (to not give crypto at the same time as cash)
            -- This above Wait(1000) will break the function so, can't use it I guess (idk a better way)
            -- Check if crypto rewards are enabled
            if Config.HeistRewards.CryptoReward then
                -- Debug print statement
                if Config.Debug then
                    print("^2Crypto reward is enabled.^7")
                end

                -- Give crypto reward
                if Player.Functions.AddMoney("crypto", Config.HeistRewards.CryptoAmount) then
                    TriggerClientEvent(
                        "QBCore:Notify",
                        source,
                        Config.Text.Notify.CryptoReward1 ..
                            Config.HeistRewards.CryptoAmount .. Config.Text.Notify.CryptoReward2,
                        "success"
                    )

                    -- log message concat
                    rewardLog = rewardLog .. ":coin: Given Crypto: "  .. Config.HeistRewards.CryptoAmount .. "\n"

                    -- Print item given
                    if Config.Debug then
                        print("^3Given Crypto:^7 $", Config.HeistRewards.CryptoAmount)
                    end
                end
            end
        else
            if Config.Debug then
                print("^2Unknown reward type:^7", rewardType)
            end
        end
    else
        if Config.Debug then
            print("^2Player is nil!^7")
        end
    end
end

-- Register the givereward event
RegisterServerEvent("mad-cipherheist:server:givereward")
-- Event Handler for givereward event
AddEventHandler(
    "mad-cipherheist:server:givereward",
    function()
        -- Get the player
        local _source = source
        local Player = QBCore.Functions.GetPlayer(source)
        -- Check if the player has the item
        -- TODO: MAKE THIS 'IF THEN ELSE END' ACTUALLY WORK
        --if QBCore.Functions.HasItem(Config.Items.UntrackedLoot) then
        -- Give rewards
        SelectRewards(source, "blueprint")
        SelectRewards(source, "weapons")
        SelectRewards(source, "usbs")
        SelectRewards(source, "cash")
        SelectRewards(source, "crypto")
        SelectRewards(source, "goldbar")
        SelectRewards(source, "markedbills")
        SelectRewards(source, "qsphonehack")
        SelectRewards(source, "custom")
        -- Remove UntrackedLoot
        -- TESTING REMOVING THIS WAIT BELOW MAYBE IT BREAKS THINGS IDK
        --Citizen.Wait(1000)
        if Player.Functions.RemoveItem(Config.Items.UntrackedLoot, 1) then
            -- Notify
            TriggerClientEvent("QBCore:Notify", source, Config.Text.Notify.AfterOpenLoot, "success")
        end
        --else
        -- TrackedLoot item not found - possible cheater
        -- print(source.. ' tried opening mad-cipherheist loot crate WITHOUT having the item')
        -- TriggerClientEvent('mad-cipherheist:client:Notify', source, 'Dirty rat detected', 'error')
        -- TriggerClientEvent('QBCore:Notify', source, 'Dirty rat detected', 'success')
        -- TODO: SEND CHEATER WEBHOOK HERE
        --end

        -- (REPLACE THE EVENT WITH YOUR WEBHOOK RESOURCE TO WORK)
        --[[ local RobberName = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
        local RobberDiscord = QBCore.Functions.GetIdentifier(source, 'discord'):sub(9)
        local RobberLocation = tostring(QBCore.Functions.GetCoords(GetPlayerPed(source)))

        TriggerEvent("yume-log:server:CreateLog",
        "mad-cipherheist", -- name
        "Cipher Heist: Rewards", -- title
        "pink", -- color
        false, -- tagEveryone
        "<@" .. RobberDiscord .. "> " .. "**" .. RobberName .. "**" .. "\nReceived Cipher Heist Loot Rewards of:\n" .. rewardLog .. "\nat: ".. RobberLocation,
        "Player",
        nil,
        nil)

        rewardLog = "" ]]
    end
)

-- POLICE TRACKED LOOT BLIP --------------------------------------------------------------------------------------

--- Get the list of player IDs who are cops and on duty.
---@param callback function The function to call with the list of cop player IDs.
local function GetCopPlayerIds(callback)
    local Player_ids = QBCore.Functions.GetPlayers()
    local copPlayerIds = {}
    for i = 1, #Player_ids do
        local Player = QBCore.Functions.GetPlayer(Player_ids[i])
        if Player and Player.PlayerData.job and Player.PlayerData.job.name == Config.Police.JobName and Player.PlayerData.job.onduty then
            table.insert(copPlayerIds, Player_ids[i])
        end
    end
    callback(copPlayerIds) -- Return the list of cop player IDs
end

-- Initialise the variables used to slow down prints in the StartLoop function below
-- Define a cooldown interval for the print statement
local printCooldown = 5000 -- 5000 milliseconds (5 seconds)
-- Keep track of the last time a print statement was executed
local lastPrintTime = 0

-- Initialise the isLoopActive variable used in the StartLoop function below
local isLoopActive = false

-- START LOOP
-- Loop the position of the player with the item to the client event (update the blip)
function StartLoop()
    print("StartLoop BEGAN")
    isLoopActive = true
    CreateThread(
        function()
            while isLoopActive do
                Wait(500) -- Update every 500ms for the blip
                -- Get the list of player IDs who are cops and on duty
                GetCopPlayerIds(
                    function(copPlayerIds)
                        for _, playerId in ipairs(copPlayerIds) do
                            -- Check if enough time has passed since the last print statement (dont spam console if debug is on)
                            local currentTime = GetGameTimer()
                            if currentTime - lastPrintTime >= printCooldown then
                                if Config.Debug then
                                    print("Player ID " .. playerId .. " is a cop and is on duty.")
                                    lastPrintTime = currentTime -- Update the last print time
                                end
                            end
                            local coords = GetEntityCoords(GetPlayerPed(playerId))
                            TriggerClientEvent("mad-cipherheist:client:transmitterLocation", playerId, coords)
                        end
                    end
                )
            end
        end
    )
end

-- STOP LOOP
-- Stop the loop created above
function StopLoop()
    print("StartLoop STOPPED")
    isLoopActive = false
end

-- EVENT REGISTRATION ---------------------------------------------------------------------------------------

-- SERVER EVENTS -----------------------------------

-- Register the giveitem event
RegisterServerEvent("mad-cipherheist:server:giveitem", GiveItem)

-- Register the removeitem event
RegisterServerEvent("mad-cipherheist:server:removeitem", RemoveItem)

-- Register the RemoveDecryptedSignals event
RegisterServerEvent("mad-cipherheist:server:removedecryptedsignals", RemoveDecryptedSignals)

-- NET EVENTS -----------------------------------

-- Register the pickuptrackedlootevent event
RegisterNetEvent("mad-cipherheist:server:pickuptrackedlootevent", StartLoop)

-- TODO: Fix this and properly stop the loop after last minigame
-- Low priority I guess, performance can't be that bad to leave this running till restart.
-- Register the stoptrackedlootevent event
RegisterServerEvent('mad-cipherheist:server:stoptrackedlootevent')
AddEventHandler('mad-cipherheist:server:stoptrackedlootevent', function()
    StopLoop() -- Call the StopLoop function when the event is triggered
end)
--RegisterServerEvent("mad-cipherheist:server:stoptrackedlootevent", StopLoop)

-- Register the OpenDoor event
RegisterNetEvent(
    "mad-cipherheist:server:opendoor",
    function(doorid)
        local src = source
        TriggerClientEvent("qb-doorlock:client:setState", -1, src, doorid, false, false, false, false)
    end
)

-- Register the CloseDoor event
RegisterNetEvent(
    "mad-cipherheist:server:closedoor",
    function(doorid)
        local src = source
        TriggerClientEvent("qb-doorlock:client:setState", -1, src, doorid, true, false, false, false)
    end
)

-- DEBUG -------------------------------------------------------------------------------------------------

-- Only enable if debug is true
if Config.Debug then
    -- Check all players and find cops on duty
    RegisterCommand(
        "checkcops",
        function(source, args, rawCommand)
            GetCopPlayerIds(
                function(copPlayerIds)
                    for _, playerId in ipairs(copPlayerIds) do
                        print("Player ID " .. playerId .. " is a cop and is on duty.")
                    end
                end
            )
        end,
        false
    )

    -- Check player and find if they are a cop on duty
    RegisterCommand(
        "checkpolice",
        function(source, args, rawCommand)
            local playerId = source
            local Player = QBCore.Functions.GetPlayer(playerId)

            if
                Player and Player.PlayerData.job and Player.PlayerData.job.name == Config.Police.JobName and
                    Player.PlayerData.job.onduty
             then
                print("^5[Server] You are currently on duty as a police officer.")
            else
                print("^1[Server] You are not on duty as a police officer.")
            end
        end,
        false
    )

    -- Give all items needed to start heist
    local function DebugGiveAllHeistItems()
        local Player = QBCore.Functions.GetPlayer(source)
        TriggerClientEvent("QBCore:Notify", source, "Giving all items needed to start MadCap Cipher Heist", "success")
        Player.Functions.AddItem(Config.Items.AntennaPart, 1)
        TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.Items.AntennaPart], "add", 1)
        Player.Functions.AddItem(Config.Items.ScreenPart, 1)
        TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.Items.ScreenPart], "add", 1)
        Player.Functions.AddItem(Config.Items.PanelHack1, 1)
        TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.Items.PanelHack1], "add", 1)
        Player.Functions.AddItem(Config.Items.PanelHack2, 1)
        TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.Items.PanelHack2], "add", 1)
        Player.Functions.AddItem(Config.Items.TerminalUsb, 1)
        TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.Items.TerminalUsb], "add", 1)
    end

    -- Register the DebugGiveAllHeistItems event
    RegisterServerEvent("mad-cipherheist:server:debuggiveallheistitems", DebugGiveAllHeistItems)

    -- Initialise the item variable used in the handler and function below
    local item = Config.Items.TrackedLoot

    -- Event to request the client to check for the item
    RegisterServerEvent("checkItemOnClient")
    AddEventHandler(
        "checkItemOnClient",
        function()
            TriggerClientEvent("checkItemOnClient", -1, item)
        end
    )

    -- Event to handle the result sent back from the client
    RegisterServerEvent("itemCheckResult")
    AddEventHandler(
        "itemCheckResult",
        function(playerWithItem)
            if playerWithItem then
                print("Player with item found: " .. tostring(playerWithItem))
            else
                print("No player found with the item.")
            end
        end
    )
-- whitespace (this line has been left black intentionally)
end
