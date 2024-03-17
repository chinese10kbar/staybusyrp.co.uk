fx_version 'adamant'
games { 'rdr3', 'gta5' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
lua54 'yes'
author 'DirkScripts'
description 'Dirk-Script'
version '1.0.0'

shared_script '@ox_lib/init.lua'

client_script {
  'usersettings/config.lua',
  'usersettings/strains.lua',
  'usersettings/growprops.lua',
  'usersettings/labels.lua',
  'src/client/functions.lua'
}


server_script {
  'usersettings/config.lua',
  'usersettings/strains.lua',
  'usersettings/growprops.lua',
  'usersettings/labels.lua',
  'src/server/functions.lua'
}

dependencies{
  'dirk-core',
}

escrow_ignore{

  --## OPEN SOURCE VERSION
  -- 'src/client/functions.lua',
  -- 'src/server/functions.lua',

  --## INSTALLATION
  'items.sql',
  'shared.lua',
  'usersettings/*.lua',
  'INSTALLATION/*.*',
}

  

dependency '/assetpacks'