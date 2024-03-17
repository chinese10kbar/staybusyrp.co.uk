fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 't3mpu5'
description 't3_businesscards'
version '1.0.0'

ui_page 'html/index.html'

client_scripts {
	'client/main.lua',
}

server_scripts {
	'server/main.lua',
}

shared_scripts {
	'config.lua',
}

files {
	'html/index.html',
	'html/images/*.png',
    'html/script.js',
    'html/styles.css',
}

escrow_ignore {
	'server/main.lua',
	'client/main.lua',
	'config.lua',
}
dependency '/assetpacks'