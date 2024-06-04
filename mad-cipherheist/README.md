# mad-cipherheist

## Introduction

Dive into an immersive heist experience unlike any other. Follow a gripping storyline as you acquire crucial components, hack into secure terminals, and decipher cryptic messages to uncover the truth behind a mysterious signal. Are you ready to embark on a daring mission filled with mystery and suspense?

This resource is aimed to give your players an end-game heist. It follows the storyline of a shipment being tracked by an unknown agency, which the player uses their tools and know-how to 

## Preview
youtube link

## Dependencies:

* mad-map-cipherheist (included)
* [qb-core](https://github.com/qbcore-framework/qb-core)
* [qb-doorlock](https://github.com/qbcore-framework/qb-core)
* [qb-target](https://github.com/qbcore-framework/qb-core)
* [ps-ui](https://github.com/Project-Sloth/ps-ui)
* [pengu_digiscanner](https://github.com/PenguScript/pengu_digiscanner/)
* [glow_minigames](https://github.com/christikat/glow_minigames)
* [utk_fingerprint](https://github.com/utkuali/Finger-Print-Hacking-Game)
* [hacking](https://github.com/Prime-Script/prime-vangelico/tree/main/assets) (included)
* [ps-dispatch](https://github.com/Project-Sloth/ps-dispatch) for police alerts
* *(Optional)[Patoche-AnonymousMLO](https://www.gta5-mods.com/maps/mlo-anonymous-fivem-sp-ready)* (need to move a location if you don't use this)
* *(Optional)[keep-crafting](https://github.com/swkeep/keep-crafting)* (for optional loot items)
* *(Optional)[mz-hacks](https://github.com/MrZainRP/mz-hacks)* (for optional loot items)
* Resource tested using qb-inventory/lj-inventory

### Recommended load order

* Dependencies must load before mad-cipherheist. I recommend you setup your load order as such:
* Place all dependencies in ``[standalone]`` - as well as the included ``hacking`` folder.
* Place ``[mad-cipherheist]`` in ``[madcap]`` folder.
* Ensure resources in server cfg:

```cfg
ensure [qb]
ensure [standalone]
ensure [madcap]
```

## INSTALL

* Copy and paste the items below into your shared items, example: ``qb-core/shared/items.lua``

```lua 
------------------------
-- MADCAP CIPHERHEIST -- 
------------------------

-- Digiscanner items
scanner_antenna         = { name = "scanner_antenna",       label = "Scanner Antenna",  weight = 500,   type = "item",                        image = "madantenna.png",                 unique = true,      useable = true,     shouldClose = true,     combinable = nil, description = "A high-frequency antenna designed for the digital scanner, enhancing signal reception." }, 
scanner_screen          = { name = "scanner_screen",        label = "Scanner Screen",   weight = 500,   type = "item",                        image = "maddigiscreen.png",              unique = true,      useable = true,     shouldClose = true,     combinable = { accept = { 'scanner_antenna' }, reward = 'weapon_digiscanner', anim = { dict = 'anim@amb@business@weed@weed_inspecting_high_dry@', lib = 'weed_inspecting_high_base_inspector', text = 'Attaching antenna', timeOut = 10000 } }, description = "An advanced digital display unit, integral to the functionality of the digital scanner." },
weapon_digiscanner      = { name = "weapon_digiscanner",    label = "Digiscanner",      weight = 1000,  type = "weapon", ammotype = nil,      image = "madweapon_digiscanner.png",      unique = true,      useable = true,     shouldClose = true,     combinable = nil, description = "A powerful Digiscanner featuring a built-in HUD for enhanced signal tracking and analysis.", created = nil, decay = 0.04166666667 }, -- 1 hour

-- Hack items
terminalusb             = { name = "terminalusb",           label = "Cipher USB",      weight = 1000,  type = "item",     image = "madusb.png",      unique = true,      useable = false,     shouldClose = false,     combinable = nil,    description = "USB containing backdoor: \"://cipher_protocol_ZNCDO/\" " },

-- Heist items
cipherfragment1           = { name = "cipherfragment1",         label = "Cipher Fragment",     weight = 0,     type = "item",   image = "madcipher1.png",     unique = true,    useable = false,     shouldClose = false,   combinable = nil,   description = "Captured samples of wireless signals, essential for unlocking encrypted data",   created = nil,  decay = 0.04166666667 }, -- 1 hour
cipherfragment2           = { name = "cipherfragment2",         label = "Cipher Fragment",     weight = 0,     type = "item",   image = "madcipher2.png",     unique = true,    useable = false,     shouldClose = false,   combinable = nil,   description = "Captured samples of wireless signals, essential for unlocking encrypted data",   created = nil,  decay = 0.04166666667 }, -- 1 hour
cipherfragment3           = { name = "cipherfragment3",         label = "Cipher Fragment",     weight = 0,     type = "item",   image = "madcipher3.png",     unique = true,    useable = false,     shouldClose = false,   combinable = nil,   description = "Captured samples of wireless signals, essential for unlocking encrypted data",   created = nil,  decay = 0.04166666667 }, -- 1 hour
cipherfragment4           = { name = "cipherfragment4",         label = "Cipher Fragment",     weight = 0,     type = "item",   image = "madcipher4.png",     unique = true,    useable = false,     shouldClose = false,   combinable = nil,   description = "Captured samples of wireless signals, essential for unlocking encrypted data",   created = nil,  decay = 0.04166666667 }, -- 1 hour
decryptedtransmissions    = { name = "decryptedtransmissions",  label = "Decrypted Transmissions", weight = 0, type = "item",   image = "maddata.png",        unique = true,    useable = false,     shouldClose = false,   combinable = nil,   description = "Deciphered wireless transmissions containing valuable data.",                    created = nil, decay = 0.12500000001 }, -- 3 hours

-- Loot items
trackedloot           = { name = "trackedloot",         label = "Signal-Emitting Military Case",     weight = 50000,     type = "item",     image = "madtrackedloot.png",     unique = true,    useable = true,     shouldClose = true, combinable = nil,   description = "A military-style case emitting a signal, requiring decryption to remain undetected", created = nil, decay = 0.12500000001 }, -- 3 hours
untrackedloot         = { name = "untrackedloot",       label = "Military Case",                     weight = 50000,     type = "item",     image = "maduntrackedloot.png",     unique = true,    useable = true,     shouldClose = true, combinable = nil,   description = "A secured military case, now free of any tracking signals after successful decryption" },
```

* Copy and paste the weapon below into your shared weapons, example: ``qb-core/shared/weapons.lua``

```lua
[`weapon_digiscanner`]              = { name = 'weapon_digiscanner', label = 'Digiscanner', weapontype = 'Melee', ammotype = nil, damagereason = 'Melee killed / Whacked / Executed / Beat down / Murdered / Battered' },
```

* Copy and paste all images the ``INSTALL/InventoryImages`` into your inventory ``...html/images`` folder
* Copy and paste the ``INSTALL/qb-doorlock/mad-cipherheist.lua`` file into your ``qb-doorlock/configs`` folder
* Copy and paste the ``INSTALL/interact-sound/casebeep.ogg`` file into your ``interact-sound/client/html`` folder

* Add this to your ``ps-dispatch/client/alerts.lua``

```lua
-- MadCap CipherHeist
local function MadCapCipherHeist()
  local coords = GetEntityCoords(cache.ped)
  local dispatchData = {
      message = 'Beacon Signal Activated',
      codeName = 'madcapcipherheist',
      code = '10-90',
      icon = 'fa-solid fa-tower-broadcast',
      priority = 2,
      coords = coords,
      street = GetStreetAndZone(coords),
      heading = GetPlayerHeading(),
      jobs = { 'leo' }
  }
  TriggerServerEvent('ps-dispatch:server:notify', dispatchData)
end
exports('MadCapCipherHeist', MadCapCipherHeist)
```

* Add this to your ``ps-dispatch/shared/config.lua``

```lua
-- MadCap CipherHeist
['madcapcipherheist'] = {
    radius = 0,
    sprite = 767,
    color = 1,
    scale = 1.5,
    length = 2,
    sound = 'Lose_1st',
    sound2 = 'GTAO_FM_Events_Soundset',
    offset = false,
    flash = false
},
```

* *Optional* Add this to your backitems resource (example: devyn-backitems/BackItems.lua)

```lua
-- MadCap CipherHeist TrackedLoot
['trackedloot'] = {
    model='hei_prop_heist_thermite_case',
    back_bone = 24818,
    x = -0.14635964953322,
    y = -0.20835228853177,
    z = -0.030527457423312,
    x_rotation = -95.531095095841,
    y_rotation = 87.419314981763,
    z_rotation = 4.5446930554476,
},
-- MadCap CipherHeist UntrackedLoot
['untrackedloot'] = {
    model='hei_prop_heist_thermite_case',
    back_bone = 24818,
    x = -0.14635964953322,
    y = -0.20835228853177,
    z = -0.030527457423312,
    x_rotation = -95.531095095841,
    y_rotation = 87.419314981763,
    z_rotation = 4.5446930554476,
},
```

* *Optional* Edit ``glow_minigames/html/js/main.js`` startEndScreens:

line 16
```lua
start: 'Network encrypted, user bypass required..',
```

line 18
```lua
success: 'Network successfully decrypted.',
```

* *Optional* If you want to make it even harder for your players to enter Fort Zancudo to begin the heist itself, run this somewhere on the client. I personally put mine in a client resource in small resources, but it doesn't matter what you choose.

```lua
local QBCore = exports['qb-core']:GetCoreObject()

-- ZANCUDO GUARDS SHOOT AT PLAYERS WHEN INSIDE ZONE

function onEnter(self)
    PlayerData = QBCore.Functions.GetPlayerData() -- remove PlayerData = QBCore.Functions.GetPlayerData() if you want this to be standalone or change for your framework
    if (PlayerData.job.name ~= 'police') and (PlayerData.job.name ~= 'ambulance') then -- remove (PlayerData.job ~= 'police' or 'ambulance') if you want this to be standalone or change for your framework
    SetMaxWantedLevel(5)
    SetPlayerWantedLevel(PlayerId(), 3, false)
    SetPlayerWantedLevelNow(PlayerId(), false)
    print(GetPlayerWantedLevel(PlayerId()))
    end
end

function onInside(self)
    PlayerData = QBCore.Functions.GetPlayerData() -- remove PlayerData = QBCore.Functions.GetPlayerData() if you want this to be standalone or change for your framework
    if (PlayerData.job.name ~= 'police') and (PlayerData.job.name ~= 'ambulance') then -- remove (PlayerData.job ~= 'police' or 'ambulance') if you want this to be standalone or change for your framework
    SetMaxWantedLevel(5)
    SetPlayerWantedLevel(PlayerId(), 3, false)
    SetPlayerWantedLevelNow(PlayerId(), false)
    end
end
 
function onExit(self)
    ClearPlayerWantedLevel(PlayerId())
end


local poly = lib.zones.poly({
    points = {
        vec3(-2206.0, 3632.0, 62.81),
		vec3(-2134.0, 3577.0, 62.81),
		vec3(-2049.0, 3510.0, 62.81),
		vec3(-1895.0, 3422.0, 62.81),
		vec3(-1551.0, 3195.0, 62.81),
		vec3(-1557.0, 2987.0, 62.81),
		vec3(-1551.0, 2879.0, 62.81),
		vec3(-1592.0, 2788.0, 62.81),
		vec3(-1788.0, 2748.0, 62.81),
		vec3(-1876.0, 2744.0, 62.81), 
		vec3(-2017.0, 2764.0, 62.81),
		vec3(-2089.0, 2766.0, 62.81),
		vec3(-2159.0, 2790.0, 62.81),
		vec3(-2159.0, 2790.0, 62.81),
		vec3(-2205.0, 2846.0, 62.81),
		vec3(-2258.0, 2879.0, 62.81),
		vec3(-2327.0, 2892.0, 62.81),
		vec3(-2397.0, 2884.0, 62.81),
		vec3(-2470.0, 2895.0, 62.81),
		vec3(-2529.0, 2937.0, 62.81),
		vec3(-2554.0, 3018.0, 62.81),
		vec3(-2598.0, 3086.0, 62.81),
		vec3(-2675.0, 3129.0, 62.81),
		vec3(-2675.0, 3129.0, 62.81),
		vec3(-2748.0, 3170.0, 62.81),
		vec3(-2819.0, 3234.0, 62.81),
		vec3(-2819.0, 3235.0, 62.81),
		vec3(-2900.0, 3325.0, 62.81),
		vec3(-2846.0, 3419.0, 62.81), 
		vec3(-2574.0, 3328.0, 62.81),
		vec3(-2384.0, 3443.0, 62.81),
    },
    thickness = 75,
    debug = false,
    inside = onInside,
    onEnter = onEnter,
    onExit = onExit
})
```

* You can remove the ``INSTALL`` folder once you've completed these steps if you wish.

##### Note
This resource was originally created for my own FiveM Server, and originally I had no plans on releasing it. It has been fully tested and the heist works properly. The code could use improving, and there are certainly better ways to do things than I have chosen. The main section that could use more work is the blips. The idea was always to have a blip displayed on the location of the tracked item, but I never got around to making it work properly.

#### Heist Overview:

This heist involves collecting cipher fragments, merging them, and using the result to locate and retrieve a valuable item guarded by a tracker. Players must evade police and disable the tracker through sequential hacks.

##### Preparation:

* Items: Acquire a Cipher USB, Scanner Antenna, Scanner Screen, Trojan USB, Electronic Kit, and Scuba Tank with Oxygen Refills.

##### Steps:

* Combine Scanner: Combine Antenna and Screen to create a Digiscanner.
* Hack Electric Panel: Use Trojan USB and Electronic Kit at Fort Zancudo Military Base to access the tower.
* Hack Terminal: Use the Cipher USB (consumed) at the top of the tower to receive an email with instructions and a map blip leading to the Merryweather facility.
* Find Signals: Use the Digiscanner at each location to pinpoint and hack exposed signals (4 required). Each successful hack grants a Cipher Fragment (limited to 1 hour duration).
* Merge Fragments: Go to the anonymous hacking group's den and use their computer to merge fragments. Another hack consumes the fragments and gives you "Decrypted Transmissions".
* Activate Beacon: Use Decrypted Transmissions to trigger a temporary radius blip indicating the prize location underwater.
* Retrieve Prize: Dive deep underwater to find the sunken narco submarine and its nearby crate. Interact with the Beacon to obtain the "Signal-Emitting Military Case".
* Escape and Disable Tracker: Evade police while the case emits a signal visible to them. Interact with the case to start 3 sequential hacks with a configurable cooldown in between. Successfully complete all 3 to disable the tracker.
* Enjoy the Loot: Open the case for various rewards including blueprints, weapons, and other valuable items.

###### Resmon:
* 0ms when heist isn't active.
* 0ms while doing heist setup.
* 0.1ms when loops are running (trackedloot blips and beep loops are active) - Tested locally 1 player
