fx_version 'adamant'
games { 'rdr3', 'gta5' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
lua54 'yes'
author 'DirkScripts'
description 'DirkScripts DrugLabsV2 - Available only at www.dirkscripts.com anywhere else and you have been scammed :( '
version '1.0.0'

client_script {
  'usersettings/config.lua',
  'usersettings/items.lua',
  'usersettings/labels.lua',
  'src/client/scenes.lua',
  'src/client/functions.lua'
}


server_script {
  'usersettings/config.lua',
  'usersettings/items.lua',
  'usersettings/labels.lua',
  'src/server/functions.lua'
}

escrow_ignore{
  'INSTALLATION/*.lua',
  'usersettings/*.lua',
  'usersettings/*.json',
  'usersettings/*.sql',
  'src/client/functions.lua',
}

dependencies{
  'dirk-core',
} 

dependency '/assetpacks'