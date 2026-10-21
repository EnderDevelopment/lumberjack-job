-- Resource Metadata
game 'gta5'
fx_version 'cerulean'

-- Resource Information
name 'lumberjack_job'
description 'A FiveM resource for a lumberjack job with map markers, a minigame, a vehicle to carry logs, and a delivery system.'
author 'EnderDevelopment'
version '1.0.0'

-- What to run
dependencies {
    'essentialmode',
    'es_extended'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}

ui_page 'html/index.html'