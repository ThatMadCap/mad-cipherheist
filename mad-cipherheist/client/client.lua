-- QBCORE EXPORTS / VARIABLES -----------------------------------------------------------------------------------
QBCore = exports["qb-core"]:GetCoreObject()

-- Initialise variable for the blip we use in static, radius and temporary blips
local blipHandle = nil
-- Initialise variable for the blip we use in looping blips
local blip = nil
-- Initialise variable used to lock/unlock door
local panelDoorHacked = false
-- Initialise variable for handling loops on trackedloot pickup
local trackStarted = false

-- CLIENT RESOURCE START ----------------------------------------------------------------------------------------

-- TODO: USE QB-CORE ONPLAYERLOAD TO HANDLE CASES WHERE PLAYER DISCONNECTS
-- AND WE NEED TO CHECK FOR THE ITEM AGAIN AND RE-BEGIN THE THREADS(?)

-- Event handler for resource start
AddEventHandler(
    "onResourceStart",
    function(name)
        Wait(1000)
        if name == GetCurrentResourceName() then
            -- Close Military Base Door
            TriggerServerEvent("mad-cipherheist:server:closedoor", "mad-cipherheist-military_base")
            -- <3
            print("^9<3 ^4Madcap Cipher Heist ^9<3")
        end
    end
)

-- WRAPPERS -----------------------------------------------------------------------------------------------------

-- Notify wrapper
local function Notify(text, level)
    exports["ps-ui"]:Notify(text, level)
end

-- Dispatch wrapper
local function Dispatch()
    exports["ps-dispatch"]:MadCapCipherHeist()
end

-- Webook wrapper
--[[ function DiscordLog(txt) -- Discord log
    TriggerServerEvent("mad-cipherheist:server:Log", txt)
end ]]


-- FUNCTIONS -----------------------------------------------------------------------------------------------------

--- Table containing email server event names for different phone resources
local emailTable = {
    ["qb"] = "qb-phone:server:sendNewMail", -- QB-phone email server event
    ["qs"] = "qs-smartphone:server:sendNewMail" -- QS-smartphone email server event
}

--- Sends a custom mail to the player's phone.
---@param sender string The sender of the email.
---@param subject string The subject of the email.
---@param image string The image attached to the email.
---@param message string The message content of the email.
---@param button table The action triggered by the button in the email.
function SendCustomMail(sender, subject, image, message, button)
    TriggerServerEvent(
        emailTable[Config.Phone],
        {
            sender = sender, -- Email sender
            subject = subject, -- Email subject
            image = image, -- Email image
            message = message, -- Email message
            button = button -- Email button action
        }
    )
end

-- Play 'casebeep' sound within distance of the player
local function PlayBeepSound()
    -- Get the Player ID
    local player = QBCore.Functions.GetClosestPlayer()
    local playerId = GetPlayerServerId(player)
    -- Trigger interact sound server event
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", Config.BeepDistance, "casebeep", Config.BeepSoundVolume)
    -- Wait 5 seconds (time set in config) before checking item & playing sound again
end

-- BLIPS -----------------------------------------------------------------------------------------------------

-- TODO: HANDLE CASES WHERE PLAYER THAT ORIGINALLY PICKED UP THE ITEM DROPS IT, AND ANOTHER PLAYER PICKS IT UP.

--- Static blip function
---@param isEnabled boolean - Boolean indicating whether the blip should be shown or hidden
---@param coords vector3 - The coordinates where the blip should be placed
---@param sprite number - The sprite ID for the blip
---@param scale number - The scale of the blip
---@param color number - The color of the blip
---@param text string - The text to display as the blip's name
local function ShowBlip(isEnabled, coords, sprite, scale, color, text)
    if isEnabled then
        if blipHandle == nil then
            blipHandle = AddBlipForCoord(coords)
            SetBlipSprite(blipHandle, sprite)
            SetBlipScale(blipHandle, scale)
            SetBlipColour(blipHandle, color)
            SetBlipAsShortRange(blipHandle, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(text)
            EndTextCommandSetBlipName(blipHandle)
        end
    else
        if blipHandle ~= nil then
            RemoveBlip(blipHandle)
            blipHandle = nil
        end
    end
end

-- Radius blip function
local function RadiusBlip()
    local blipHandle = AddBlipForRadius(Config.Locations.TrackedLoot, 500.0)
    SetBlipColour(blipHandle, 1)
    SetBlipAlpha(blipHandle, 180)
    return blipHandle -- Return the handle for later use
end

-- Temporary blip function
local function ShowTemporaryBlip()
    local blipHandle = RadiusBlip() -- Call the function and store the handle
    Notify(Config.Text.Notify.DecryptBlipShow, "primary")
    -- Remove the blip after a delay
    Citizen.CreateThread(
        function()
            Citizen.Wait(Config.Blips.BeaconSignalLocationTime) -- Delay for time set in config
            RemoveBlip(blipHandle)
            blipHandle = nil
            Notify(Config.Text.Notify.DecryptBlipHide, "primary")
        end
    )
end

-----------------------
-- TRACKED LOOT BLIP --
-----------------------

-- Because we take the item off the player after they've completed the hacks,
-- We don't need to remove blips, they stay static on the map in the last point
-- that it detected a player having the item in their inventory (not a bug, it's a feature)
-- this means if they drop the item, it stays on the last location it was found (where it was dropped)
-- TODO: Test if this works with another playing picking up the item --

-- BLIP FOR THE LOOT HOLDER
-- Shows a red blip to the player with the trackedloot on their location
-- when they have the item and updates every 0.5 seconds

--- Checks if the player has the TrackedLoot item and creates a blip on their location if they do.
---@param playerLocation vector3 Coordinates of the player's location
---@param blipColor number Color of the blip
local function CheckItemAndTrackPlayer(playerLocation, blipColor)
    -- Check if the player has the TrackedLoot item
    if QBCore.Functions.HasItem(Config.Items.TrackedLoot, 1) then
        if not blip then
            -- Make a blip on their location
            local playerLocation = GetEntityCoords(GetPlayerPed(-1))
            blip = AddBlipForCoord(playerLocation.x, playerLocation.y, playerLocation.z)
            SetBlipSprite(blip, 128)
            ShowHeadingIndicatorOnBlip(blip, true)
            SetBlipScale(blip, 1.0)
            SetBlipColour(blip, blipColor)
            SetBlipAsShortRange(blip, false)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Config.Text.Blips.PlayerTrackedLoot)
            EndTextCommandSetBlipName(blip)
        else
            SetBlipCoords(blip, playerLocation.x, playerLocation.y, playerLocation.z)
        end
        local heading = GetEntityHeading(GetPlayerPed(-1))
        SetBlipRotation(blip, math.ceil(heading))
    end
end


-- Registers a network event handler for tracking loot pickup.
-- When the trackedloot is picked up, only then do we need to begin these threads (for performance)
RegisterNetEvent("mad-cipherheist:client:tracklootpickup")
AddEventHandler(
    "mad-cipherheist:client:tracklootpickup",
    function(isStarted)
        trackStarted = isStarted
        if isStarted then
            -- Update the blip in a thread
            Citizen.CreateThread(
                function()
                    while true do
                        if trackStarted then
                            Citizen.Wait(500) -- Wait for 0.5 seconds
                            CheckItemAndTrackPlayer(GetEntityCoords(GetPlayerPed(-1)), 1) -- Red blip for trackedlootholder to trackedlootholder
                        end
                    end
                end
            )

            -- Play a sound on the player if they have the TrackedLoot item
            if Config.BeepSound then -- Only if BeepSound is set to true
                Citizen.CreateThread(
                    function()
                        while true do
                            if trackStarted then
                                Citizen.Wait(0) -- Wait for the next frame to optimize performance
                                if QBCore.Functions.HasItem(Config.Items.TrackedLoot, 1) then
                                    PlayBeepSound()
                                    Citizen.Wait(Config.BeepSoundTime) -- Wait 5 seconds before checking item & playing sound
                                else
                                    Citizen.Wait(1000) -- Check for item possession every second
                                end
                            end
                        end
                    end
                )
            end
        end
    end
)

-- BLIP FOR POLICE
-- Shows a purple blip to all on duty cops, with the location of the
-- player with the trackedloot item and updates every 0.5 seconds

-- Create a purple blip at the location of the player with the item
RegisterNetEvent("mad-cipherheist:client:transmitterLocation")
AddEventHandler(
    "mad-cipherheist:client:transmitterLocation",
    function(coords)
        if Config.Debug then
            print("Creating blip at:", coords.x, coords.y, coords.z)
        end
        local blipColor = 27
        CheckItemAndTrackPlayer(coords, blipColor) -- Purple blip from trackedlootholder to cops
    end
)

-- HACKS -----------------------------------------------------------------------------------------------------

----------------
-- PANEL HACK --
----------------

local function HeistHackPanel()
    -- Check for on duty cops and door status
    QBCore.Functions.TriggerCallback(
        "mad-cipherheist:server:policecount",
        function(policeCount)
            if policeCount >= Config.Police.RequiredPolice and panelDoorHacked == false then

                -- Webhook
                --TriggerServerEvent("mad-cipherheist:server:startheistlog")
                -- INSERT YOUR WEBHOOK HERE IF NEEDED

                -- Start the glow "spot" minigame
                exports["glow_minigames"]:StartMinigame(
                    function(success)
                        if success then
                            -- Remove Panel Hack items
                            TriggerServerEvent("mad-cipherheist:server:removeitem", Config.Items.PanelHack1)
                            TriggerServerEvent("mad-cipherheist:server:removeitem", Config.Items.PanelHack2)
                            -- Open the Tower Door
                            TriggerServerEvent("mad-cipherheist:server:opendoor", "mad-cipherheist-military_base")
                            -- Notify
                            Notify(Config.Text.Notify.AfterPanelHack, "success")
                            -- Set a variable for the door state
                            panelDoorHacked = true
                        else
                            -- Failed minigame
                        end
                    end,
                    "spot",
                    {
                        -- Minigame settings
                        gridSize = Config.Hacks.PanelHackGridSize,
                        timeLimit = Config.Hacks.PanelHackTimeLimit,
                        charSet = Config.Hacks.PanelHackCharSet,
                        required = Config.Hacks.PanelHackRequired
                    }
                )
            else
                -- Notify
                Notify(Config.Text.Notify.AfterFailedPanelHack, "error")
                if panelDoorHacked then
                    Notify(Config.Text.Notify.DoorAlreadyUnlocked, "error")
                else
                    Notify(Config.Text.Notify.NotEnoughCops, "error")
                end
            end
        end
    )
end

-------------------
-- TERMINAL HACK --
-------------------

-- Zancudo Tower 1 Terminal Hack
-- Start ps-ui "var" minigame
function HeistHackTerminal()
    exports["ps-ui"]:VarHack(
        function(success)
            if success then
                -- Notify
                Notify(Config.Text.Notify.AfterTerminalHack, "success")
                -- Remove terminalusb item
                TriggerServerEvent("mad-cipherheist:server:removeitem", Config.Items.TerminalUsb)

                -- Webhook
                --TriggerServerEvent("mad-cipherheist:server:terminalhacklog")
                -- INSERT YOUR WEBHOOK HERE IF NEEDED

                -- Wait 5 seconds
                Citizen.Wait(5000)
                -- Send Email
                SendCustomMail(
                    Config.Text.Email.Sender1,
                    Config.Text.Email.Subject1,
                    Config.Text.Email.Image1,
                    Config.Text.Email.Message1,
                    Config.Text.Email.Button1
                )
                -- Send first signal location
                exports["pengu_digiscanner"]:SetupDigiScanner(
                    Config.Locations.Signal1,
                    {
                        event = HackSignal1, -- pass HackSignal1 function
                        isAction = true,
                        args = {},
                        blip = {
                            text = Config.Text.Digiscanner.BlipText, -- Blip text
                            sprite = 9, -- Circle blip sprite
                            display = 2, -- Display on minimap and main map
                            scale = 0.7, -- Set scale
                            color = 2, -- Green
                            opacity = 65 -- 65% opacity
                        },
                        interact = {
                            interactKey = 38, -- "E" -- https://docs.fivem.net/docs/game-references/controls/
                            interactMessage = Config.Text.Digiscanner.InteractMessage  -- 2D text drawn in bottom left of screen
                        }
                    }
                )
            else
                -- Failed
                -- Notify
                Notify(Config.Text.Notify.AfterFailedTerminalHack, "error")
            end
        end,
        -- Minigame settings
        Config.Hacks.TerminalHackBlocks, -- Minigame blocks
        Config.Hacks.TerminalHackTime -- Minigame time
    )
end

------------------
-- SIGNAL HACKS --
------------------

-- Initialize the variables to track whether the emails have been sent
local emailSentSignal1 = false
local emailSentSignal4 = false

--- Starts the utk_fingerprint minigame for signal hacking.
---@param signalNumber number The number of the signal being hacked.
---@param nextHackFunction function|string The function or event to execute after successful hacking.
---@param nextHackLocation vector3 The location for the next hack.
---@param levels number The number of levels in the minigame.
---@param lifes number The number of lives in the minigame.
---@param time number The time limit for the minigame.
function SignalHack(signalNumber, nextHackFunction, nextHackLocation, levels, lifes, time)
    TriggerEvent(
        "utk_fingerprint:Start",
        levels,
        lifes,
        time,
        function(outcome, reason) -- TODO: do we need the 'reason' parameter?
            if outcome then
                Citizen.CreateThread(
                    function()
                        -- Set up the next hack location
                        exports["pengu_digiscanner"]:SetupDigiScanner(
                            nextHackLocation,
                            {
                                event = nextHackFunction, -- pass parameter of SignalHack
                                isAction = true,
                                args = {},
                                blip = {
                                    text = Config.Text.Digiscanner.BlipText,
                                    sprite = 9,
                                    display = 2,
                                    scale = 0.7,
                                    color = 2,
                                    opacity = 65
                                },
                                interact = {
                                    interactKey = 38,
                                    interactMessage = Config.Text.Digiscanner.InteractMessage
                                }
                            }
                        )
                    end
                )
                -- Wait 5 seconds
                Citizen.Wait(5000)
                -- Notify
                Notify(Config.Text.Notify.AfterSignalHackSuccess[signalNumber], "success")
                -- Give the player the decrypted signal item
                local signalItem = Config.Items["Signal" .. signalNumber]
                TriggerServerEvent("mad-cipherheist:server:giveitem", signalItem)
                -- Check if it's the first signal hack and send the email
                if signalNumber == 1 and not emailSentSignal1 then
                    -- Send custom email for the first signal
                    SendCustomMail(
                        Config.Text.Email.Sender2,
                        Config.Text.Email.Subject2,
                        Config.Text.Email.Image2,
                        Config.Text.Email.Message2,
                        Config.Text.Email.Button2
                    )
                    emailSentSignal1 = true -- Update the variable to indicate that the email has been sent for the first signal
                end
                -- Check if it's the fourth signal hack and send the email
                if signalNumber == 4 and not emailSentSignal4 then
                    -- Send custom email for the fourth signal
                    SendCustomMail(
                        Config.Text.Email.Sender3,
                        Config.Text.Email.Subject3,
                        Config.Text.Email.Image3,
                        Config.Text.Email.Message3,
                        Config.Text.Email.Button3
                    )
                    emailSentSignal4 = true -- Update the variable to indicate that the email has been sent for the fourth signal
                end
            else
                -- hack failed
                -- Notify
                Notify(Config.Text.Notify.AfterFailedSignalHack, "error")
            end
        end
    )
end

-- Repeat Signal Hacks
function HackSignal1()
    SignalHack(
        1,
        HackSignal2,
        Config.Locations.Signal2, -- Vec3 coords of next signal location
        Config.Hacks.FingerprintLevels1, -- Minigame levels
        Config.Hacks.FingerprintLifes1, -- Minigame lives
        Config.Hacks.FingerprintTime1 -- Minigame time limit
    )

    -- Webhook
    --TriggerServerEvent("mad-cipherheist:server:hacksignallog1")
    -- INSERT YOUR WEBHOOK HERE IF NEEDED
end

function HackSignal2()
    SignalHack(
        2,
        HackSignal3,
        Config.Locations.Signal3,
        Config.Hacks.FingerprintLevels2,
        Config.Hacks.FingerprintLifes2,
        Config.Hacks.FingerprintTime2
    )

    -- Webhook
    --TriggerServerEvent("mad-cipherheist:server:hacksignallog2")
    -- INSERT YOUR WEBHOOK HERE IF NEEDED
end

function HackSignal3()
    SignalHack(
        3,
        HackSignal4,
        Config.Locations.Signal4,
        Config.Hacks.FingerprintLevels3,
        Config.Hacks.FingerprintLifes3,
        Config.Hacks.FingerprintTime3
    )
    
    -- Webhook
    --TriggerServerEvent("mad-cipherheist:server:hacksignallog3")
    -- INSERT YOUR WEBHOOK HERE IF NEEDED
end

function HackSignal4()
    SignalHack(
        4,
        HackSignal4,
        nil, -- TODO: Stop pengu_digiscanner from printing "all arguments must be filled" to client on this line
        Config.Hacks.FingerprintLevels4,
        Config.Hacks.FingerprintLifes4,
        Config.Hacks.FingerprintTime4
    )
    -- Show the blip (location to merge the fragments)
    ShowBlip(true, vector3(Config.Locations.DecryptSignals), 459, 1.5, 1, Config.Text.Blips.DecryptSignals)

    -- Webhook
    --TriggerServerEvent("mad-cipherheist:server:hacksignallog4")
    -- INSERT YOUR WEBHOOK HERE IF NEEDED
end

------------------------
-- MERGE SIGNALS HACK --
------------------------

-- Start the ps-ui maze minigame with the config settings
local function DecryptSignals()
    exports["ps-ui"]:Maze(
        function(success)
            if success then
                -- Minigame success
                -- Notify
                Notify(Config.Text.Notify.AfterMergedCiphers, "success")
                -- Remove the blip we created before
                ShowBlip()
                -- Remove cipher fragments and give decrypted signals item
                TriggerServerEvent("mad-cipherheist:server:takefragmentsandgivedecryptedsignals")
                -- Send email
                SendCustomMail(
                    Config.Text.Email.Sender4,
                    Config.Text.Email.Subject4,
                    Config.Text.Email.Image4,
                    Config.Text.Email.Message4,
                    Config.Text.Email.Button4
                )
            else
                -- Minigame fail
                Notify(Config.Text.Notify.AfterFailedCiphers, "error")
            end
        end,
        Config.Hacks.MergeSignalsTimeLimit
    )

    -- Webhook
    --TriggerServerEvent("mad-cipherheist:server:mergesignalshacklog")
    -- INSERT YOUR WEBHOOK HERE IF NEEDED
end

--------------------------------------------
-- DECRYPTED SIGNALS BEACON LOCATION HACK --
--------------------------------------------

-- Starts the glow "path" minigame with the config settings
function GlowMinigame()
    exports["glow_minigames"]:StartMinigame(
        function(success)
            if success then
                -- Minigame success
                ShowTemporaryBlip() -- Show the temporary radius blip
            else
                -- Minigame fail
            end
        end,
        "path",
        {
            gridSize = Config.Hacks.DecryptSignalsItemGridSize, -- Minigame grid size
            lives = Config.Hacks.DecryptSignalsItemLives, -- Minigame lives
            timeLimit = Config.Hacks.DecryptSignalsItemTimeLimit -- Minigame time limit
        }
    )
end

----------------------------------
-- TRACKED LOOT SEQUENTIAL HACK --
----------------------------------

-- Counter for minigame progress
local currentMinigame = 1

-- Wait times for each minigame (in minutes)
local minigameWaitTimes = {
    [1] = Config.Hacks.TrackedLootHack1WaitTime, -- Cooldown before able to start hack2
    [2] = Config.Hacks.TrackedLootHack2WaitTime, -- Cooldown before able to start hack3
    [3] = Config.Hacks.TrackedLootHack3WaitTime -- Cooldown before able to start hack2 (only applies if hack2 is failed)
}

-- Default wait time if specific wait time is not defined in 'minigameWaitTimes'
local waitTimeBetweenMinigames = 5

-- Difficulty settings for each minigame
local minigameDifficulties = {
    {
        time = Config.Hacks.TrackedLootHack1Time, -- Time to solve the minigame
        squares = Config.Hacks.TrackedLootHack1Squares, -- Minigame squares
        repeatAmount = Config.Hacks.TrackedLootHack1Repeats -- Levels per minigame
    },
    {
        time = Config.Hacks.TrackedLootHack2Time,
        squares = Config.Hacks.TrackedLootHack2Squares,
        repeatAmount = Config.Hacks.TrackedLootHack2Repeats
    },
    {
        time = Config.Hacks.TrackedLootHack3Time,
        squares = Config.Hacks.TrackedLootHack3Squares,
        repeatAmount = Config.Hacks.TrackedLootHack3Repeats
    }
}

-- Initialise the variables used for the minigame Timer
local minigameWaitStartTime = nil
local minigameWaitDuration = nil

-- Function to start the timer
function StartMinigameWaitTimer(duration)
    minigameWaitDuration = duration * 60 -- Convert minutes to seconds
    minigameWaitStartTime = GetGameTimer()
end

-- Function to get the remaining time
function GetRemainingTime()
    if minigameWaitStartTime ~= nil and minigameWaitDuration ~= nil then
        local elapsedTime = GetGameTimer() - minigameWaitStartTime
        local remainingTime = math.max(minigameWaitDuration - elapsedTime / 1000, 0) -- Convert milliseconds to seconds
        return remainingTime
    else
        return 0
    end
end

--- Starts the Colours & Shapes minigame.
---@param time number The time limit for the minigame.
---@param squares number The number of squares in the minigame.
---@param repeatAmount number The number of times to repeat the minigame.
---@param onSuccess function|nil The function to call on successful completion of the minigame.
---@param onFailure function|nil The function to call on failure to complete the minigame.
---@param waitTime number The time to wait after completing the minigame.
function StartHackingMinigame(time, squares, repeatAmount, onSuccess, onFailure, waitTime)
    exports["hacking"]:OpenHackingGame(
        time,
        squares,
        repeatAmount,
        function(success)
            -- TODO: does this if block actually do anything?
            -- Handle the result of the minigame
            if success then
                -- Handle success
                if onSuccess then
                    onSuccess()
                end
            else
                -- Handle failure
                if onFailure then
                    onFailure()
                end
            end
            -- Start the timer
            StartMinigameWaitTimer(waitTime)
            -- Track the start of the timer
            TriggerEvent("trackCooldownStart", true)
        end
    )
end

-- Function to start the next minigame in the sequence
function StartNextMinigame()
    local remainingTime = GetRemainingTime()
    if remainingTime > 0 then
        -- If there's remaining time, notify the player and return
        local remainingTimeInt = math.floor(remainingTime) -- Convert remaining time to an integer for notify
        Notify(Config.Text.Notify.TrackedLootHackTimeRemaining .. remainingTimeInt .. " seconds", "primary")
        return
    end

    if currentMinigame <= #minigameDifficulties then
        local difficulty = minigameDifficulties[currentMinigame]
        local waitTime = minigameWaitTimes[currentMinigame] or waitTimeBetweenMinigames
        StartHackingMinigame(
            difficulty.time, -- Minigame time limit
            difficulty.squares, -- Minigame squares to remember
            difficulty.repeatAmount, -- Minigame level repetitions
            function()
                -- Handle success
                if currentMinigame == 3 then
                    -- Remove tracked loot item and give the new item after a delay
                    Citizen.SetTimeout(
                        2000,
                        function()
                            -- Remove the trackedloot item
                            TriggerServerEvent("mad-cipherheist:server:removeitem", Config.Items.TrackedLoot)
                            Citizen.Wait(0) -- Update for performance
                            -- Give the untrackedloot item
                            TriggerServerEvent("mad-cipherheist:server:giveitem", Config.Items.UntrackedLoot)
                            -- Notify
                            Notify(Config.Text.Notify.AfterCompleteFinalHack, "success")
                            -- Stop any timer tracking
                            TriggerEvent("trackCooldownStart", false)
                            -- Stop client blip & beep threads
                            TriggerClientEvent("mad-cipherheist:client:tracklootpickup", src, false) -- Pass false to indicate that tracking should stop
                            -- Stop police blip loop
                            -- TODO: fix this - does not stop the loop when triggered HERE
                            TriggerServerEvent("mad-cipherheist:server:stoptrackedlootevent")
                        end
                    )
                    -- Exit the function as we don't need to proceed with further minigames
                    return
                end
                -- Notify seconds till item can be used next
                Notify(
                    Config.Text.Notify.TrackedLootHackCooldown1 ..
                        currentMinigame .. Config.Text.Notify.TrackedLootHackCooldown2,
                    "success"
                )
                currentMinigame = currentMinigame + 1 -- Advance to the next minigame
            end,
            function()
                -- Handle failure
                -- Reset the sequence if any minigame fails
                currentMinigame = 1
                StartMinigameWaitTimer(waitTime) -- Reset the timer
                -- Notify
                Notify(Config.Text.Notify.TrackedLootHackFail, "error")
            end,
            waitTime -- Pass the waitTime value to StartHackingMinigame
        )
    else
        -- All minigames completed, end the sequence
    end
end

-- PROGRESS BARS ------------------------------------------------------------------------------------------------

-- Underwater Loot pickup
-- Function to play progress bar and give TrackedLoot item
function OpenUnderwaterAndGiveTrackedLoot()
    QBCore.Functions.Progressbar(
        "mad-cipherheist:trackedloot", -- Name
        Config.Text.Progressbar.GrabCase, -- Label
        Config.HeistRewards.UnderwaterOpeningTime, -- Duration
        false, -- useWhileDead
        true, -- canCancel
        {   -- Controls
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = false
        },
        {}, -- Animation
        {}, -- Prop1
        {}, -- Prop2
        function()
            -- finished
            Citizen.Wait(0) -- Wait so we don't update on the same frame
            -- Give tracked loot item
            TriggerServerEvent("mad-cipherheist:server:givetrackedloot")

            -- Webhook
            --TriggerServerEvent("mad-cipherheist:server:taketrackedlootlog")
            -- INSERT YOUR WEBHOOK HERE IF NEEDED

            ClearPedTasks(PlayerPedId())
        end,
        function()
            -- cancelled
            ClearPedTasks(PlayerPedId())
        end
    )
end

-- Untrackedloot case opening
-- Function to play progress bar then give rewards
function OpenCaseAndGiveRewards()
    QBCore.Functions.Progressbar(
        "mad-cipherheist:openuntrackedloot",  -- Name
        Config.Text.Progressbar.OpenCase,  -- Label
        Config.HeistRewards.CaseOpeningTime, -- Duration
        false, -- useWhileDead
        true, -- canCancel
        {   -- Controls
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true
        },
        {   -- Animation
            animDict = "anim@amb@business@weed@weed_inspecting_high_dry@",
            anim = "weed_inspecting_high_base_inspector",
            flags = 49
        },
        {}, -- Prop1
        {}, -- Prop2
        function()
            -- finished
            TriggerServerEvent("mad-cipherheist:server:givereward")
            ClearPedTasks(PlayerPedId())
        end,
        function()
            -- cancelled
            print("Cancelled")
            ClearPedTasks(PlayerPedId())
        end
    )
end

-- EVENT REGISTRATION ---------------------------------------------------------------------------------------------

-- Register the HeistHackTerminal event
RegisterNetEvent("mad-cipherheist:client:heisthackpanel", HeistHackPanel)

-- Register the HeistHackTerminal event
RegisterNetEvent("mad-cipherheist:client:heisthackterminal", HeistHackTerminal)

-- Register the DecryptSignals event
RegisterNetEvent("mad-cipherheist:client:decryptsignals", DecryptSignals)

-- Register the Dispatch Alert event
RegisterNetEvent("mad-cipherheist:client:dispatch", Dispatch)

-- Register the usedecryptsignalsitem event
-- Plays a minigame when the player uses the decryptsignals item
RegisterNetEvent(
    "mad-cipherheist:client:usedecryptsignalsitem",
    function()
        GlowMinigame()
    end
)

-- Register the underwaterloot event
-- Starts a progress bar and on finish takes decryptedsignals item and gives trackedlootitem
RegisterNetEvent(
    "mad-cipherheist:client:underwaterloot",
    function()
        OpenUnderwaterAndGiveTrackedLoot()
    end
)

-- Register the usetrackedlootitem event
-- Plays the sequential minigame when player uses the TrackedLoot item
RegisterNetEvent(
    "mad-cipherheist:client:usetrackedlootitem",
    function()
        StartNextMinigame()
    end
)

-- Register the useuntrackedlootitem event
-- Starts a progress bar and on finish takes the trackedlootitem and gives rewards
RegisterNetEvent(
    "mad-cipherheist:client:useuntrackedlootitem",
    function()
        OpenCaseAndGiveRewards()
    end
)

-- DEBUG ------------------------------------------------------------------------------------------------------------

-- Function to register commands
local function RegisterDebugCommands()
    -- Test Hacks
    RegisterCommand("madtestpanelhack", HeistHackPanel)
    RegisterCommand("madtestterminalhack", HeistHackTerminal)
    RegisterCommand("madtestsignalhack1", HackSignal1)
    RegisterCommand("madtestsignalhack2", HackSignal2)
    RegisterCommand("madtestsignalhack3", HackSignal3)
    RegisterCommand("madtestsignalhack4", HackSignal4)
    RegisterCommand("madtestdecryptsignalshack", DecryptSignals)
    RegisterCommand("madtesttrackedloothack", StartNextMinigame)
    --  Test Rewards
    RegisterCommand(
        "madtestrewards",
        function()
            TriggerServerEvent("mad-cipherheist:server:givereward")
        end
    )
    -- Give items needed to start heist
    RegisterCommand(
        "madgiveheistitems",
        function()
            TriggerServerEvent("mad-cipherheist:server:debuggiveallheistitems")
        end
    )
    -- Test the server event for picking up the tracked loot and beginning loops
    RegisterCommand(
        "madtestpickuptrackedlootevent",
        function()
            TriggerServerEvent("mad-cipherheist:server:pickuptrackedlootevent")
        end
    )
    -- Test the server event for completing the trackedloot hack and stopping loops
    RegisterCommand(
        "madteststoptrackedlootevent",
        function()
            -- TODO: This command works to stop the loop, but the loop does not stop when triggered after the last minigame.
            TriggerServerEvent("mad-cipherheist:server:stoptrackedlootevent")
        end
    )
    -- Test picking up underwater loot interaction
    RegisterCommand(
        "madtestunderwaterloot",
        function()
            TriggerEvent("mad-cipherheist:client:underwaterloot")
        end
    )
    -- Checks item requirement on client and display result to server
    -- Event to receive item check request from the server and respond with the result
    RegisterNetEvent("checkItemOnClient")
    AddEventHandler(
        "checkItemOnClient",
        function(item)
            local hasItem = QBCore.Functions.HasItem(item, 1)
            TriggerServerEvent("itemCheckResult", hasItem)
        end
    )
end

-- Only enable commands if debug = true
if Config.Debug then
    RegisterDebugCommands()
end
