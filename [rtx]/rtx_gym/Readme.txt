Thank you for purchasing rtx_gym we're grateful for your support. If you'd ever have a question and / or need our help, please reach out to us by sending an email or go ahead and create a ticket on our discord: https://discord.gg/P6KdaDpgAk


Install instructions (Standalone):
1. Put rtx_gym folder to your resources
2. Open config.lua file
3. Configure your config.lua to your preferences
4. Upload sql sql_STANDALONE-QBCORE.sql file to your mysql database.
5. Open fxmanifest.lua and edit it same like on this screenshot (https://i.imgur.com/LWaYxz7.png) remove -- from line 11, or replace line 11 with '@oxmysql/lib/MySQL.lua',
6. Put rtx_gym to the server.cfg

Install instructions (QBCore):
1. Put rtx_gym folder to your resources
2. Open config.lua file
3. Replace Config.Framework = "standalone" with Config.Framework = "qbcore"
4. Configure your config.lua to your preferences
5. Upload sql sql_STANDALONE-QBCORE.sql file to your mysql database.
6. Open fxmanifest.lua and edit it same like on this screenshot (https://i.imgur.com/LWaYxz7.png) remove -- from line 11, or replace line 11 with '@oxmysql/lib/MySQL.lua',
7. Put rtx_gym to the server.cfg
6. Add new items to qb-core/shared/items.lua - items name: protein, creatine, preworkout, testosterone 
Example items line for items.lua:
['protein'] = {['name'] = 'protein', ['label'] = 'Protein', ['weight'] = 1000, ['type'] = 'item', ['image'] = 'protein.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Protein'},
['creatine'] = {['name'] = 'creatine', ['label'] = 'Creatine', ['weight'] = 1000, ['type'] = 'item', ['image'] = 'creatine.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Creatine'},
['preworkout'] = {['name'] = 'preworkout', ['label'] = 'Preworkout', ['weight'] = 1000, ['type'] = 'item', ['image'] = 'preworkout.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Preworkout'},
['testosterone'] = {['name'] = 'testosterone', ['label'] = 'Testosterone', ['weight'] = 1000, ['type'] = 'item', ['image'] = 'testosterone.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Testosterone'},

Install instructions (ESX):
1. Put rtx_gym folder to your resources
2. Open config.lua file
3. Replace Config.Framework = "standalone" with Config.Framework = "esx"
4. Configure your config.lua to your preferences
5. Upload sql sql_ESX.sql file to your mysql database.
6. Open fxmanifest.lua and edit it same like on this screenshot (https://i.imgur.com/yoULcX4.png) remove -- from line 10, or replace line 10 with '@mysql-async/lib/MySQL.lua',
7. Put rtx_gym to the server.cfg

Maps:
Los Santos GYM
https://forum.cfx.re/t/release-mlo-los-santos-gym/1051705
Pump & Run GYM
https://www.gta5-mods.com/maps/mlo-pump-run-gym-add-on-sp-fivem-ragemp
La Fitness
https://www.youtube.com/watch?v=LXm9ix0fF4Y'

Commands for admins:

/addgymstats
/removegymstats
/statsgymclear

-----------------------------
Object names for whitelist to anticheat:

prop_barbell_10kg
prop_barbell_100kg
prop_barbell_80kg
prop_barbell_60kg
prop_barbell_50kg
prop_barbell_40kg
prop_barbell_30kg
prop_barbell_20kg
prop_curl_bar_01
prop_barbell_01
prop_ld_flow_bottle
prop_cs_pills
p_syringe_01_s

License agreement / Terms of Service
1. Any purchase is non-refundable.
2. Each product is to be used on a singular server, with the exception of a test server.
3. Any form of redistribution of our content is considered copyright infringement.
4. If any of these rules are broken, legal actions can be taken.
© 2023 RTX Development, all rights reserved.