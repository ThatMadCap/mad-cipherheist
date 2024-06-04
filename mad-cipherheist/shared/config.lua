Config = {

    Debug = false, -- Accetps true/false, turns debug mode on/off
    --------------------------------------------------------

    Police = {
        RequiredPolice = 4, -- Amount of cops required to start the job (triggered on panel hack)
        JobName = "police" -- Don't need to change this unless you've changed the name of your "police" job
    },
    --------------------------------------------------------

    Phone = "qs", -- 'qb' or 'qs' supported (for emails)
    --------------------------------------------------------

    -- TODO: This currently does nothing, implement your own logging feature if needed, or repurpose this
    -- Discord webhook
    WebHook = "", -- enter your api here
    --------------------------------------------------------

    BeepSound = true, -- Accepts true/false, turns TrackedLoot beep sound on/off
    BeepSoundTime = 5000, -- How long between beeps when the player has the TrackedLoot item (in milliseconds)
    BeepSoundVolume = 0.3, -- How loud the beep sound is
    BeepDistance = 10, -- How far away people can hear the beep sound
    --------------------------------------------------------

    -- Heist Rewards
    -- When the UntrackedLoot is opened, it will give all rewards enabled below
    HeistRewards = {
        UnderwaterOpeningTime = 3000, -- Time in milliseconds for grabbing case underwater
        CaseOpeningTime = 16000, -- Time in milliseconds for case opening progress bar

        -- TODO: Giving marked bills doesn't work, need to fixed or remove
        MarkedBillsReward = false, -- Accepts true/false. Enable to give the player marked bills in rewards
        MarkedBillsAmount = 1, -- Amount of Marked Bills to give in rewards

        GoldbarReward = false, -- Accepts true/false. Enable to give the player gold bars in rewards
        GoldbarAmount = 4, -- Amount of Goldbars to give in rewards

        CashReward = false, -- Accepts true/false. Enable to give the player cash in rewards
        CashAmount = 10000, -- Amount of cash to give in rewards

        CryptoReward = false, -- Accepts true/false. Enable to give the player cypto in rewards
        CryptoAmount = 250, -- Amount of crypto to give in rewards

        QSPhoneHackReward = false, -- Accepts true/false. Enable to give the player qs-smartphone phone_hack item in reward
        QSPhoneHackItemName = "phone_hack", -- Name of item (if you've changed yours)

        USBReward = true, -- Accepts true/false. Enable to give the player USBs in rewards
        USBMinItems = 3, -- Minimum amount of different USBs to give in rewards (selects this many at minumum from the list below)
        USBMaxItems = 9, -- Maximum amount of different USBs to give in rewards (selects this many at maxiumum from the list below)
        USBItemsCount = 1, -- Quantity of USBs to give in rewards (TODO: NOT USED?)
        AvailableUSBs = {
            -- Comment out any you don't have / don't want to give as rewards

            -- QB-Core items
            "trojan_usb",
            "gatecrack",
            "cryptostick",
            'electronickit',

            -- mz-hacks items
            --"usb1",
            --"usb2",
            --"usb3",
            --"usb4",
        },

        WeaponReward = true, -- Accepts true/false. Enable to give the player Weapons in rewards
        AvailableWeapons = {
            -- Comment out any you don't have / don't want to give as rewards

            -- QB-Core items
            'weapon_assaultrifle',
            --'weapon_ceramicpistol',
            --'weapon_briefcase',
        },

        BlueprintReward = true, -- Accepts true/false. Enable to use keep-crafting to give a blueprint in rewards
        AvailableBlueprints = {
            -- List of available blueprints

            -- The items you put in here must also exist in the 'local Blueprints' table in keep-crafting blueprints.lua
            -- It will reward one (1) of these blueprints at random

            "weapon_revolver",
            "weapon_assaultrifle_mk2"

            -- Add more if needed
        },

        CustomRewards = true, -- Accepts true/false. Enable to use items below in rewards
        AvailableCustomRewards = {
            -- Add the name of any item below and it will be added to the list of rewards

            -- Example
            "sandwich"
        }
    },
    --------------------------------------------------------

    Blips = {
        BeaconSignalLocationTime = 20000 -- (20000 default) Time in milliseconds to display the beacon location radius blip before it times-out
    },
    --------------------------------------------------------

    Items = {
        -- If you renamed any items, change them here as well

        -- Digiscanner items
        AntennaPart = "scanner_antenna",
        ScreenPart = "scanner_screen",
        Digiscanner = "weapon_digiscanner",

        -- Hack items
        TerminalUsb = "terminalusb",
        PanelHack1 = "trojan_usb",
        PanelHack2 = "electronickit",

        -- Heist items
        Signal1 = "cipherfragment1",
        Signal2 = "cipherfragment2",
        Signal3 = "cipherfragment3",
        Signal4 = "cipherfragment4",
        DecryptSignals = "decryptedtransmissions",

        -- Loot items
        TrackedLoot = "trackedloot",
        UntrackedLoot = "untrackedloot",
        Goldbar = "goldbar",
        MarkedBills = "markedbills",

        -- Keep-crafting
        Blueprint = "blueprint_document"
    },
    --------------------------------------------------------

    Locations = {
        -- If you change any locations, make sure to change the heading/minZ/maxZ as well

        PanelHack = vec3(-2348.9, 3247.3, 33.7), -- Electrical panel next to Zancudo Base Tower 1
        PanelHackheading = 235.0,
        PanelHackminZ = 30.0,
        PanelHackmaxZ = 35.0,

        TerminalHack = vec3(-2357.37, 3250.80, 101.53), -- Top of Tower 1
        TerminalHackheading = 150.0,
        TerminalHackminZ = 99.0,
        TerminalHackmaxZ = 105.0,

        Signal1 = vec3(590.94, -3282.31, 6.07), -- Merryweather Docks
        Signal2 = vec3(2460.30, -384.14, 93.33), -- Back of FIB HQ (Sustancia Road)
        Signal3 = vec3(116.33, -746.79, 44.83), -- Inside of FIB Skyscraper
        Signal4 = vec3(734.51, 2576.77, 75.35), -- Rebel News outbuilding

        DecryptSignals = vec3(751.21, -1908.29, 29.1), -- Patoche-AnonymousMLO
        DecryptSignalsheading = 355.0,
        DecryptSignalsminZ = 27.0,
        DecryptSignalsmaxZ = 35.0,

        TrackedLoot = vec3(478.06, 7463.80, -153.00) -- mad-map-cipherheist (underwater)
    },
    --------------------------------------------------------

    Hacks = {
        -- Military Base Tower 1 Panel Hack (glow_minigames spot minigame)
        PanelHackGridSize = 5, -- Max gridsize is 10
        PanelHackTimeLimit = 8000, -- Time (in seconds)
        PanelHackCharSet = "greek", -- Available charSet: 'numeric', 'alphabet', 'alphanumeric', 'greek', 'runes', 'braille'
        PanelHackRequired = 5, -- Required amount of correct soultions

        -- Military Base Tower 1 Terminal Hack (ps-ui VAR minigame)
        TerminalHackBlocks = 6, -- Number of Blocks
        TerminalHackTime = 10, -- Time (in seconds)

        -- Signal hacks (utk_fingerprint minigame)
        -- Signal 1
        FingerprintLevels1 = 1, -- Minigame level count. Max = 4, Min = 1
        FingerprintLifes1 = 6, -- Minigame lives. Max = 6, Min = 1
        FingerprintTime1 = 5, -- Minigame time. Max = 9, Min = 1. (Recommended to set it between 3-1)

        -- Signal 2
        FingerprintLevels2 = 2,
        FingerprintLifes2 = 5,
        FingerprintTime2 = 4,

        -- Signal 3
        FingerprintLevels3 = 3,
        FingerprintLifes3 = 4,
        FingerprintTime3 = 3,

        -- Signal 4
        FingerprintLevels4 = 4,
        FingerprintLifes4 = 3,
        FingerprintTime4 = 2,

        -- Merge Signals hack (ps-ui Maze minigame)
        MergeSignalsTimeLimit = 20, -- Time to solve minigame (in seconds)

        -- Decrypted Transmissions item hack (glow_minigames path minigame)
        DecryptSignalsItemGridSize = 19, -- Creates a grid (19x19) squares (Max gridsize is 31 and should be an odd number)
        DecryptSignalsItemLives = 3, -- Max gridsize is 10
        DecryptSignalsItemTimeLimit = 10000, -- Time to solve minigame (in milliseconds)

        -- Tracked Loot Sequential Hacks (Colours & Shapes hacking minigame)
        -- Have to complete three hacks in order
        -- Failing any hack will reset the sequence
        TrackedLootHack1Time = 20, -- Time to solve minigame (in seconds)
        TrackedLootHack1Squares = 3, -- Squares in minigame
        TrackedLootHack1Repeats = 2, -- Levels per minigame
        TrackedLootHack1WaitTime = 5, -- Cooldown before able to start hack2 (in minutes)
        TrackedLootHack2Time = 15,
        TrackedLootHack2Squares = 4,
        TrackedLootHack2Repeats = 3,
        TrackedLootHack2WaitTime = 5, -- Cooldown before able to start hack3
        TrackedLootHack3Time = 12,
        TrackedLootHack3Squares = 5,
        TrackedLootHack3Repeats = 4,
        TrackedLootHack3WaitTime = 5 -- Cooldown before able to start hack2 (only applies if hack2 is failed)
    },
    --------------------------------------------------------

    Target = {
        PanelHackIcon = "fa-solid fa-microchip", -- Icons must be a (free) fontawesome icon
        PanelHackLabel = "Hack Panel",

        TerminalHackIcon = "fa-solid fa-microchip",
        TerminalHackLabel = "Hack Terminal",

        DecryptHackIcon = "fa-solid fa-code-merge",
        DecryptHackLabel = "Merge Cipher Fragments",

        TrackedLootPickupIcon = "fa-solid fa-tower-broadcast",
        TrackedLootPickupLabel = "Plug in Decrypted Transmissions"
    },
    --------------------------------------------------------

    Text = {
        Notify = {
            NotEnoughCops = "Not enough police",

            AfterFailedPanelHack = "Unable to bypass security",
            AfterPanelHack = "Panel access granted - door opening",
            DoorAlreadyUnlocked = "This panel has already been hacked",

            AfterFailedTerminalHack = "Unable to bypass security",
            AfterTerminalHack = "Terminal security bypassed",

            AfterFailedSignalHack = "Unable to capture signal",
            AfterSignalHackSuccess = {
                [1] = "You decrypted the first signal and captured the data",
                [2] = "You decrypted the second signal and captured the data",
                [3] = "You decrypted the third signal and captured the data",
                [4] = "You decrypted the last signal and captured the data"
            },

            AfterFailedCiphers = "Failed to merge ciphers",
            AfterMergedCiphers = "Ciphers successfully merged",

            DecryptSignals = "Location revealed",
            DecryptBlipShow = "Beacon signal connection established",
            DecryptBlipHide = "Beacon signal connection timed-out",

            TrackedLootHackCooldown1 = "Sequence ",
            TrackedLootHackCooldown2 = " bypassed. System cooldown in effect.",
            TrackedLootHackTimeRemaining = "Sequence processing. System available in ",
            TrackedLootHackFail = "Access denied. Sequence resetting...",

            AfterGrabCase = "You grabbed the case",
            AfterCompleteFinalHack = "Access Accepted. Signal shut down.",
            AfterOpenLoot = "You opened the case and received the rewards",

            CashReward1 = "You got $",
            CashReward2 = " from the crate.",

            CryptoReward1 = "You recieved: ",
            CryptoReward2 = " in crypto from an Anonymous sender"
        },
        Blips = {
            DecryptSignals = "Decrypt Signals",
            TrackedLoot = "Beacon Signal Active",
            PlayerTrackedLoot = "SIGNAL"
        },
        Progressbar = {
            GrabCase = "Jamming Signal Relay",
            OpenCase = "Opening Case"
        },
        Digiscanner = {
            InteractMessage = "Try to decrypt the signal",
            BlipText = "Scanner Signal"
        },
        Email = {
            Sender1 = "Anonymous",
            Subject1 = "Network Signals Exposed",
            Image1 = "",
            Message1 = "#@&A^<%decrypt>^+*$#@&Z>%# <br><br>Impressive work, Operative. <br><br>The prize awaits you. <br><br>Find the location of the first exposed signal. <br><br> Capture a sample of the signal for decryption. <br><br> #@*~*P^<%encrypt>^*~$@x2;Z%#",
            Button1 = {},

            Sender2 = "Anonymous",
            Subject2 = "Amplifying Signals",
            Image2 = "",
            Message2 = "#@&A^<%SIGN_AL1>^+*$#@&Z>%# <br><br>Your mastery is evident. <br><br>But this data isn't enough. <br><br>Keep capturing the exposed signals. <br><br> Four samples will be enough to see the full picture. <br><br> #@*~*P^<%SIGN_AL1>^*~$@x2;Z%#",
            Button2 = {},

            Sender3 = "Anonymous",
            Subject3 = "Samples Collected",
            Image3 = "",
            Message3 = "<-_A$#|^<%SUCCESS>^|#$B_-> <br><br>The way is about to become clear. <br><br>The samples need consolidation. <br><br>I trust someone with your abilities is up to the task. <br><br><-#@&e|^<%SUCCESS>^|e&@#->",
            Button3 = {},

            Sender4 = "Anonymous",
            Subject4 = "Ciphers Analysed",
            Image4 = "",
            Message4 = "start_loc:101.92,7081.89,1.95:_end <br><br>Samples consolidated and analysed. <br><br><b>Results:</b><br><br><i>...<br><br>... ciphers_merged<br><br>... [!beacon_location_established!]</i><br><br><b>The depths await.</b><br><br>Trigger the Decrypted Transmissions to reveal the beacon's location.<br><br>Beware. The prize will not come quietly. Be prepared to silence it.<br><br>You're on your own from here. Good luck.<br><br>!@_end_connection;deletenodes",
            Button4 = {}
        }
    }
}
