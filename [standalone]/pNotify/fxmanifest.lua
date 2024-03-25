fx_version 'cerulean'
game 'gta5'
description 'pNotify'

ui_page "html/index.html"

client_script "cl_notify.lua"


files {
    "html/index.html",
    "html/pNotify.js",
    "html/noty.js",
    "html/noty.css",
    "html/themes.css",
    "html/sound-example.wav"
}

export "SetQueueMax"
export "SendNotification"
