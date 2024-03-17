fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 't3mpu5'
description 'Deliveroo Delivery Job'
version '1.0.4'

client_scripts {
	'client/main.lua',
}

server_scripts {
	'server/main.lua',
}

shared_scripts {
	'@t3_lib/init.lua',
	'lang.lua',
    'config.lua',
	'customers.lua',
}

escrow_ignore {
	'lang.lua',
	'config.lua',
	'stream/*.ydr',
}

data_file 'DLC_ITYP_REQUEST' 'stream/mouchie_t3mpus_deliveroo.ytyp'
dependency '/assetpacks'