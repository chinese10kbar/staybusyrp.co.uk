fx_version 'cerulean'
lua54 'yes'
games { 'rdr3', 'gta5' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
author 'DirkScripts'
description 'Dirk-Script'
version '1.0.0'

client_script {
  'usersettings/config.lua',
  'usersettings/labels.lua',
  'usersettings/hooks.lua',
  'src/client/functions.lua'
}

server_script {
  'usersettings/config.lua',
  'usersettings/labels.lua',
  'src/server/functions.lua'
}

ui_page 'src/nui/index.html'

dependencies {
  'dirk-core',
}

escrow_ignore{
  'usersettings/*.*',
  'items.*',
}

files{
  'src/nui/index.html',  
  'src/nui/*.css',  
  'src/nui/*.js',  
  'src/nui/*.otf',  
  'src/nui/*.ttf',  
  'src/nui/*.png',  
  'src/nui/phones/*.png',  
  'src/nui/ringtones/*.mp3',  
}

dependency '/assetpacks'