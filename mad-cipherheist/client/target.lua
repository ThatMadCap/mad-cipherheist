-------------
-- TARGETS --
-------------

-- Military Base Panel
local panelhackitems = {Config.Items.PanelHack1, Config.Items.PanelHack2}
exports["qb-target"]:AddBoxZone(
    "mad-cipherheistpanel",
    vector3(Config.Locations.PanelHack),
    0.4,
    0.8,
    {
        name = "mad-cipherheiststart",
        heading = Config.Locations.PanelHackheading,
        debugpoly = Config.Debug,
        minZ = Config.Locations.PanelHackminZ,
        maxZ = Config.Locations.PanelHackmaxZ
    },
    {
        options = {
            {
                type = "client",
                event = "mad-cipherheist:client:heisthackpanel",
                icon = Config.Target.PanelHackIcon,
                label = Config.Target.PanelHackLabel,
                item = panelhackitems
            }
        },
        distance = 1.5
    }
)

-- Military Base Terminal
exports["qb-target"]:AddBoxZone(
    "mad-cipherheisttermianl",
    vector3(Config.Locations.TerminalHack),
    1,
    1.2,
    {
        name = "mad-cipherheisttermianl",
        heading = Config.Locations.TerminalHackheading,
        debugpoly = Config.Debug,
        minZ = Config.Locations.TerminalHackminZ,
        maxZ = Config.Locations.TerminalHackmaxZ
    },
    {
        options = {
            {
                type = "client",
                event = "mad-cipherheist:client:heisthackterminal",
                icon = Config.Target.TerminalHackIcon,
                label = Config.Target.TerminalHackLabel,
                item = Config.Items.TerminalUsb
            }
        },
        distance = 1.5
    }
)

-- Decrypt Ciphers
local itemrequireddecrypt = {Config.Items.Signal1, Config.Items.Signal2, Config.Items.Signal3, Config.Items.Signal4}
exports["qb-target"]:AddBoxZone(
    "mad-cipherheistdecryptsignals",
    vector3(Config.Locations.DecryptSignals),
    1,
    1.2,
    {
        name = "mad-cipherheistdecryptsignals",
        heading = Config.Locations.DecryptSignalsheading,
        debugpoly = Config.Debug,
        minZ = Config.Locations.DecryptSignalsminZ,
        maxZ = Config.Locations.DecryptSignalsmaxZ
    },
    {
        options = {
            {
                type = "client",
                event = "mad-cipherheist:client:decryptsignals",
                icon = Config.Target.DecryptHackIcon,
                label = Config.Target.DecryptHackLabel,
                item = itemrequireddecrypt
            }
        },
        distance = 1.5
    }
)

-- Underwater TrackedLoot
exports["qb-target"]:AddCircleZone(
    "mad-cipherheisttrackedloot",
    vector3(Config.Locations.TrackedLoot),
    5.0,
    {
        name = "madcapcipherheisttrackedloot",
        debugPoly = Config.Debug,
        useZ = true
    },
    {
        options = {
            {
                type = "client",
                event = "mad-cipherheist:client:underwaterloot",
                icon = Config.Target.TrackedLootPickupIcon,
                label = Config.Target.TrackedLootPickupLabel,
                item = Config.Items.DecryptSignals
            }
        },
        distance = 4
    }
)
