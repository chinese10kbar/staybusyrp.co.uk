fx_version 'cerulean'

author 'errorgaming4044'
description 'Coke Heist Script For Qbcore'
game 'gta5'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'config.lua',
}

dependencies {'ps-ui', 'boostinghack' }


client_scripts{
    'client/*.lua',
}

server_scripts{
    'server/*.lua',
}

lua54 'yes'

escrow_ignore {
    'config.lua',
    'locales/en.lua'
}
dependency '/assetpacks'