fx_version 'cerulean'
game 'gta5'

-- Github: https://github.com/ThatMadCap
-- Discord: '.madcap'

author 'MadCap'
description 'Cipher Heist'
version '1.0.0'

dependencies {
    'qb-core',
    'qb-target',
    'qb-doorlock',
    'ps-ui',
    'ps-dispatch',
    'pengu_digiscanner',
    'glow_minigames',
    'hacking',
    'utk_fingerprint',
    'keep-crafting', -- comment out if you don't use
}

shared_scripts {
    '/shared/*.lua'
}

client_scripts {
    '/client/*.lua'
}

server_scripts {
    '/server/*.lua'
}

lua54 'yes'