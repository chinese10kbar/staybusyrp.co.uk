fx_version 'bodacious' 
games { 'gta5' }

author 'Isigar <info@rcore.cz>'
description 'rcore_reports'
version '1.3.10'

ui_page 'client/ui/index.html'

lua54 'yes'

dependencies {
    '/server:4752',
    'oxmysql',
    'yarn',
    'screenshot-basic'
}

files {
    'client/ui/*.js',
    'client/ui/*.html',
    'client/ui/*.css',
    'client/ui/*.png',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    -- '@mysql-async/lib/MySQL.lua',
    'permissions.lua',
    'sconfig.lua',
    'server/init/*.lua',
    'server/model/*.lua',
    'server/api/*.js',
    'server/api/*.lua',
    'server/service/*.lua',
    'server/lib/deployFile/*.lua',
    'server/lib/deployFile/*.js',
    'server/lib/*.lua',
    'server/*.lua',
}

client_scripts {
    'client/init/*.lua',
    'client/api/*.lua',
    'client/util/*.lua',
    'client/lib/*.lua',
    'client/*.lua',
}

shared_scripts {
    'shared/const/*.lua',
    'shared/const.lua',
    'config.lua',
    'shared/*.lua',
    'locales/*.lua',
}

escrow_ignore {
    'client/api/*.lua',
    'server/api/**/*.lua',
    'client/util/**/*.lua',
    'config.lua',
    'sconfig.lua',
    'permissions.lua',
    'locales/**/*.lua',
    'shared/**/*.lua',
    'assets/**/*.lua',
}

dependency '/assetpacks'