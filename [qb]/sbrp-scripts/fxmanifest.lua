fx_version 'cerulean'
games {  'gta5' }
minify "yes"
lua54 'yes'
use_experimental_fxv2_oal 'yes'
this_is_a_map 'yes'


shared_scripts {
  '@qb-core/shared/locale.lua',
  'locales/*.lua',
  'config.lua'
}

files {
  'addons/carcols.meta',
  'addons/events.meta',
  'addons/popgroups.ymt',
  'addons/relationships.dat'
}
-- client scripts
client_scripts{
  "client_prod/*.lua",
  "client_prod/Policehandbook.net.dll",
  '@PolyZone/client.lua',
  '@PolyZone/BoxZone.lua',
  '@PolyZone/ComboZone.lua',
  'addons/vehicle_names.lua',
  'scripts/twoislands.lua', -- Both Islands Visible At One Time
  'scripts/cayo_perico_entitysets.lua', -- Responsible for spawning in heist props in El Rubio's Mansion safe. You can use this file to change the prop that appears.
  'scripts/blips.lua', -- Map Blips
  'scripts/zones.lua', -- Displays all map zones, fixing the 'bug' of showing North Yankton, and instead, showing Cayo Perico
  'scripts/static_emitters.lua' -- Disables annoying 'cheering' SFXs from Arena Wars location near North Yankton / Cayo Perico
}
-- server scripts
server_scripts{ 
  "modules/*.lua",
}

files {
  'audioconfig/*.dat151.rel',
  'audioconfig/*.dat54.rel',
  'audioconfig/*.dat10.rel',
  'sfx/**/*.awc',
  'addons/*.rel',
  'addons/audio/sfx/resident/explosions.awc',
  'addons/audio/sfx/resident/vehicles.awc',
  'addons/audio/sfx/resident/collision.awc',
  'addons/audio/sfx/resident/melee.awc',
  'addons/audio/sfx/resident/weapons.awc',
  'addons/audio/sfx/resident/collisions.awc',
  'addons/audio/sfx/dlc_weapons/ptl_revolver.awc',
  'addons/audio/sfx/dlc_weapons/ptl_navy_revolver.awc',
  'addons/audio/sfx/dlc_weapons/ptl_doubleaction_revolver.awc',
  'addons/audio/sfx/dlc_weapons/db_shotgun.awc',

  'addons/audio/sfx/weapons_player/lmg_combat.awc',
  'addons/audio/sfx/weapons_player/lmg_mg_player.awc',
  'addons/audio/sfx/weapons_player/mgn_sml_am83_vera.awc',
  'addons/audio/sfx/weapons_player/mgn_sml_am83_verb.awc',
  'addons/audio/sfx/weapons_player/mgn_sml_sc__l.awc',
  'addons/audio/sfx/weapons_player/ptl_50cal.awc',
  'addons/audio/sfx/weapons_player/ptl_combat.awc',
  'addons/audio/sfx/weapons_player/ptl_pistol.awc',
  'addons/audio/sfx/weapons_player/ptl_px4.awc',
  'addons/audio/sfx/weapons_player/ptl_rubber.awc',
  'addons/audio/sfx/weapons_player/sht_bullpup.awc',
  'addons/audio/sfx/weapons_player/sht_pump.awc',
  'addons/audio/sfx/weapons_player/smg_micro.awc',
  'addons/audio/sfx/weapons_player/smg_smg.awc',
  'addons/audio/sfx/weapons_player/snp_heavy.awc',
  'addons/audio/sfx/weapons_player/snp_rifle.awc',
  'addons/audio/sfx/weapons_player/spl_grenade_player.awc',
  'addons/audio/sfx/weapons_player/spl_minigun_player.awc',
  'addons/audio/sfx/weapons_player/spl_prog_ar_player.awc',
  'addons/audio/sfx/weapons_player/spl_railgun.awc',
  'addons/audio/sfx/weapons_player/spl_rpg_player.awc',
  'addons/audio/sfx/weapons_player/spl_tank_player.awc',

  'addons/weather/timecycle_mods_1.xml',
  'addons/weather/timecycle_mods_2.xml',
  'addons/weather/timecycle_mods_3.xml',
  'addons/weather/timecycle_mods_4.xml',
  'addons/weather/w_blizzard.xml',
  'addons/weather/w_clear.xml',
  'addons/weather/w_clearing.xml',
  'addons/weather/w_clouds.xml',
  'addons/weather/w_extrasunny.xml',
  'addons/weather/w_foggy.xml',
  'addons/weather/w_neutral.xml',
  'addons/weather/w_overcast.xml',
  'addons/weather/w_rain.xml',
  'addons/weather/w_smog.xml',
  'addons/weather/w_snow.xml',
  'addons/weather/w_snowlight.xml',
  'addons/weather/w_thunder.xml',
  'addons/weather/w_xmas.xml',
  'addons/weather/w_halloween.xml',
  'addons/weather/underwater_deep.xml',

  'addons/visual/cloudkeyframes.xml',
  'addons/visual/clouds.xml',
  'addons/visual/cpqsmix_ssaosettings.xml',
  'addons/visual/hbaosettings.xml',
  'addons/visual/lensflare_m.xml',
  'addons/visual/lensflare_t.xml',
  'addons/visual/lensflare_t.xml',
  'addons/visual/vfxlightningsettings.xml',
  'addons/visual/watertune.xml',
  'addons/visual/watertune_heistisland.xml',

  'addons/clipSets/*.clip_sets.xml'
}

client_scripts {
	"client_prod/common.lua",
	"client_prod/observers/interiorIdObserver.lua",
	"client_prod/observers/officeSafeDoorHandler.lua",
	"client_prod/client.lua",


	-- GTA V
	"client_prod/base.lua",   -- Base IPLs to fix holes
	"client_prod/ammunations.lua",
	"client_prod/bahama.lua",
	"client_prod/floyd.lua",
	"client_prod/franklin.lua",
	"client_prod/franklin_aunt.lua",
	"client_prod/graffitis.lua",
	"client_prod/pillbox_hospital.lua",
	"client_prod/lester_factory.lua",
	"client_prod/michael.lua",
	"client_prod/north_yankton.lua",
	"client_prod/red_carpet.lua",
	"client_prod/simeon.lua",
	"client_prod/stripclub.lua",
	"client_prod/trevors_trailer.lua",
	"client_prod/ufo.lua",
	"client_prod/zancudo_gates.lua",

	-- GTA Online
	"dlc/gta_online/apartment_hi_1.lua",
	"dlc/gta_online/apartment_hi_2.lua",
	"dlc/gta_online/house_hi_1.lua",
	"dlc/gta_online/house_hi_2.lua",
	"dlc/gta_online/house_hi_3.lua",
	"dlc/gta_online/house_hi_4.lua",
	"dlc/gta_online/house_hi_5.lua",
	"dlc/gta_online/house_hi_6.lua",
	"dlc/gta_online/house_hi_7.lua",
	"dlc/gta_online/house_hi_8.lua",
	"dlc/gta_online/house_mid_1.lua",
	"dlc/gta_online/house_low_1.lua",

	-- dlc/dlc High Life
	"dlc/dlc_high_life/apartment1.lua",
	"dlc/dlc_high_life/apartment2.lua",
	"dlc/dlc_high_life/apartment3.lua",
	"dlc/dlc_high_life/apartment4.lua",
	"dlc/dlc_high_life/apartment5.lua",
	"dlc/dlc_high_life/apartment6.lua",

	-- dlc/dlc Heists
	"dlc/dlc_heists/carrier.lua",
	"dlc/dlc_heists/yacht.lua",

	-- dlc/dlc Executives & Other Criminals
	"dlc/dlc_executive/apartment1.lua",
	"dlc/dlc_executive/apartment2.lua",
	"dlc/dlc_executive/apartment3.lua",

	-- dlc/dlc Finance & Felony
	"dlc/dlc_finance/office1.lua",
	"dlc/dlc_finance/office2.lua",
	"dlc/dlc_finance/office3.lua",
	"dlc/dlc_finance/office4.lua",
	"dlc/dlc_finance/organization.lua",

	-- dlc/dlc Bikers
	"dlc/dlc_bikers/cocaine.lua",
	"dlc/dlc_bikers/counterfeit_cash.lua",
	"dlc/dlc_bikers/document_forgery.lua",
	"dlc/dlc_bikers/meth.lua",
	"dlc/dlc_bikers/weed.lua",
	"dlc/dlc_bikers/clubhouse1.lua",
	"dlc/dlc_bikers/clubhouse2.lua",
	"dlc/dlc_bikers/gang.lua",

	-- dlc/dlc Import/Export
	"dlc/dlc_import/garage1.lua",
	"dlc/dlc_import/garage2.lua",
	"dlc/dlc_import/garage3.lua",
	"dlc/dlc_import/garage4.lua",
	"dlc/dlc_import/vehicle_warehouse.lua",

	-- dlc/dlc Gunrunning
	"dlc/dlc_gunrunning/bunkers.lua",
	"dlc/dlc_gunrunning/yacht.lua",

	-- dlc/dlc Smuggler's Run
	"dlc/dlc_smuggler/hangar.lua",

	-- dlc/dlc Doomsday Heist
	"dlc/dlc_doomsday/facility.lua",

	-- dlc/dlc After Hours
	"dlc/dlc_afterhours/nightclubs.lua",

	-- dlc/dlc Diamond Casino
	"dlc/dlc_casino/casino.lua",
	"dlc/dlc_casino/penthouse.lua",

	-- dlc/dlc Tuners (Requires forced build 2372 or higher)
	"dlc/dlc_tuner/garage.lua",
	"dlc/dlc_tuner/meetup.lua",
	"dlc/dlc_tuner/methlab.lua",

	-- dlc/dlc The Contract (Requires forced build 2545 or higher)
	"dlc/dlc_security/studio.lua",
	-- "dlc/dlc_security/billboards.lua",
	"dlc/dlc_security/musicrooftop.lua",
	"dlc/dlc_security/garage.lua",
	"dlc/dlc_security/office1.lua",
	"dlc/dlc_security/office2.lua",
	"dlc/dlc_security/office3.lua",
	"dlc/dlc_security/office4.lua"
}



data_file 'FIVEM_LOVES_YOU_4B38E96CC036038F' 'addons/events.meta'
data_file 'FIVEM_LOVES_YOU_341B23A2F0E0F131' 'addons/popgroups.ymt'
data_file 'AUDIO_GAMEDATA' 'audioconfig/aq36hyutheta2n_game.dat' -- Hyundai Veloster N
data_file 'AUDIO_SOUNDDATA' 'audioconfig/aq36hyutheta2n_sounds.dat' -- Hyundai Veloster N
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_aq36hyutheta2n' -- Hyundai Veloster N
data_file 'AUDIO_GAMEDATA' 'audioconfig/ea888_game.dat' -- Golf GTI Mk7
data_file 'AUDIO_SOUNDDATA' 'audioconfig/ea888_sounds.dat'  -- Golf GTI Mk7
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_ea888'  -- Golf GTI Mk7
data_file 'AUDIO_GAMEDATA' 'audioconfig/ea825_game.dat' -- Audi RS6
data_file 'AUDIO_SOUNDDATA' 'audioconfig/ea825_sounds.dat' -- Audi RS6
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_ea825' -- Audi RS6
data_file 'AUDIO_GAMEDATA' 'audioconfig/npolchar_game.dat' -- Dodge Charger
data_file 'AUDIO_SOUNDDATA' 'audioconfig/npolchar_sounds.dat' -- Dodge Charger
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_npolchar' -- Dodge Charger
data_file 'AUDIO_GAMEDATA' 'audioconfig/asteropers_game.dat' -- Karin Asterope RS
data_file 'AUDIO_SOUNDDATA' 'audioconfig/asteropers_sounds.dat' -- Karin Asterope RS
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_asteropers' -- Karin Asterope RS
data_file "AUDIO_SYNTHDATA" "audioconfig/ml720v8eng_amp.dat" -- Mclaren 720s
data_file "AUDIO_GAMEDATA" "audioconfig/ml720v8eng_game.dat" -- Mclaren 720s
data_file "AUDIO_SOUNDDATA" "audioconfig/ml720v8eng_sounds.dat" -- Mclaren 720s
data_file "AUDIO_WAVEPACK" "sfx/dlc_ml720v8eng" -- Mclaren 720s
data_file "AUDIO_SYNTHDATA" "audioconfig/z33u2_amp.dat" -- Nissan 350z
data_file "AUDIO_GAMEDATA" "audioconfig/z33u2_game.dat" -- Nissan 350z
data_file "AUDIO_SOUNDDATA" "audioconfig/z33u2_sounds.dat" -- Nissan 350z
data_file "AUDIO_WAVEPACK" "sfx/dlc_z33u2" -- Nissan 350z
data_file "AUDIO_GAMEDATA" "audioconfig/cypherct_game.dat" -- Cypher Hatchback
data_file "AUDIO_SOUNDDATA" "audioconfig/cypherct_sounds.dat" -- Cypher Hatchback
data_file "AUDIO_WAVEPACK" "sfx/dlc_cypherct" -- Cypher Hatchback
data_file "AUDIO_GAMEDATA" "audioconfig/mf1c_game.dat" -- Progen MF1 Spyder
data_file "AUDIO_SOUNDDATA" "audioconfig/mf1c_sounds.dat" -- Progen MF1 Spyder
data_file "AUDIO_WAVEPACK" "sfx/dlc_progenmf1" -- Progen MF1 Spyder
data_file 'AUDIO_GAMEDATA' 'audioconfig/ta488f154_game.dat' -- Ferrari 488
data_file 'AUDIO_SOUNDDATA' 'audioconfig/ta488f154_sounds.dat'  -- Ferrari 488
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_ta488f154'  -- Ferrari 488
data_file 'AUDIO_SYNTHDATA' 'audioconfig/f136_amp.dat' -- Ferrari 458
data_file 'AUDIO_GAMEDATA' 'audioconfig/f136_game.dat' -- Ferrari 458
data_file 'AUDIO_SOUNDDATA' 'audioconfig/f136_sounds.dat' -- Ferrari 458
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_f136' -- Ferrari 458
data_file 'AUDIO_GAMEDATA' 'audioconfig/rb26dett_game.dat' -- Nissan Skyline
data_file 'AUDIO_SOUNDDATA' 'audioconfig/rb26dett_sounds.dat' -- Nissan Skyline
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_rb26dett'-- Nissan Skyline
data_file "AUDIO_SYNTHDATA" "audioconfig/lg67koagerars_amp.dat" -- Koenigsegg Regera
data_file "AUDIO_GAMEDATA" "audioconfig/lg67koagerars_game.dat"-- Koenigsegg Regera
data_file "AUDIO_SOUNDDATA" "audioconfig/lg67koagerars_sounds.dat"-- Koenigsegg Regera
data_file "AUDIO_WAVEPACK" "sfx/dlc_lg67koagerars"-- Koenigsegg Regera
data_file 'AUDIO_GAMEDATA' 'audioconfig/ta176m177_game.dat' -- Mercedes-AMG GT S
data_file 'AUDIO_SOUNDDATA' 'audioconfig/ta176m177_sounds.dat' -- Mercedes-AMG GT S
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_ta176m177' -- Mercedes-AMG GT S
data_file 'AUDIO_GAMEDATA' 'audioconfig/aston59v12_game.dat' -- Vulcan
data_file 'AUDIO_SOUNDDATA' 'audioconfig/aston59v12_sounds.dat'-- Vulcan
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_aston59v12'-- Vulcan
data_file 'AUDIO_GAMEDATA' 'audioconfig/lambov10_game.dat' -- Lambo Huracan 
data_file 'AUDIO_SOUNDDATA' 'audioconfig/lambov10_sounds.dat'-- Lambo Huracan 
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_lambov10'-- Lambo Huracan 
data_file 'AUDIO_GAMEDATA' 'audioconfig/chevroletlt4_game.dat' -- Chevrolet Camaro 2021
data_file 'AUDIO_SOUNDDATA' 'audioconfig/chevroletlt4_sounds.dat'  -- Chevrolet Camaro 2021
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_chevroletlt4'  -- Chevrolet Camaro 2021
data_file "AUDIO_SYNTHDATA" "audioconfig/lg81hcredeye_amp.dat" -- trackhawk 
data_file "AUDIO_GAMEDATA" "audioconfig/lg81hcredeye_game.dat"-- trackhawk 
data_file "AUDIO_SOUNDDATA" "audioconfig/lg81hcredeye_sounds.dat"-- trackhawk 
data_file "AUDIO_WAVEPACK" "sfx/dlc_lg81hcredeye"-- trackhawk 
data_file 'AUDIO_GAMEDATA' 'audioconfig/aq40benw12tt_game.dat' -- P1
data_file 'AUDIO_SOUNDDATA' 'audioconfig/aq40benw12tt_sounds.dat'-- P1
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_aq40benw12tt'-- P1
data_file 'AUDIO_GAMEDATA' 'audioconfig/ta183lt1_game.dat' -- [czr1] Chevrolet Corvette ZR1
data_file 'AUDIO_SOUNDDATA' 'audioconfig/ta183lt1_sounds.dat'-- [czr1] Chevrolet Corvette ZR1
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_ta183lt1'-- [czr1] Chevrolet Corvette ZR1
data_file 'AUDIO_SYNTHDATA' 'audioconfig/f113_amp.dat' -- Ferrari 250 GT California Spyder
data_file 'AUDIO_GAMEDATA' 'audioconfig/f113_game.dat' -- Ferrari 250 GT California Spyder
data_file 'AUDIO_SOUNDDATA' 'audioconfig/f113_sounds.dat' -- Ferrari 250 GT California Spyder
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_f113' -- Ferrari 250 GT California Spyder
data_file 'AUDIO_GAMEDATA' 'audioconfig/ta103ninjah2r_game.dat' -- Kawasaki Ninja H2
data_file 'AUDIO_SOUNDDATA' 'audioconfig/ta103ninjah2r_sounds.dat' -- Kawasaki Ninja H2
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_ta103ninjah2r' -- Kawasaki Ninja H2
data_file 'AUDIO_GAMEDATA' 'audioconfig/jmbearcat_game.dat' -- MRAP Sound
data_file 'AUDIO_GAMEDATA' 'audioconfig/aq48roln72v12_game.dat' -- BMW X5 40D xDrive
data_file 'AUDIO_SOUNDDATA' 'audioconfig/aq48roln72v12_sounds.dat' -- BMW X5 40D xDrive
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_aq48roln72v12' -- BMW X5 40D xDrive
data_file 'AUDIO_GAMEDATA' 'audioconfig/ecoboostv6_game.dat' -- Jaguar F-Pace (SUV)
data_file 'AUDIO_SOUNDDATA' 'audioconfig/ecoboostv6_sounds.dat' -- Jaguar F-Pace (SUV)
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_ecoboostv6' -- Jaguar F-Pace (SUV)
data_file 'AUDIO_GAMEDATA' 'audioconfig/b58b30_game.dat' -- G31 
data_file 'AUDIO_SOUNDDATA' 'audioconfig/b58b30_sounds.dat' -- G31
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_b58b30' -- G31
data_file 'AUDIO_GAMEDATA' 'audioconfig/aq02coyotef150_game.dat' -- Ford Ranger
data_file 'AUDIO_SOUNDDATA' 'audioconfig/aq02coyotef150_sounds.dat'-- Ford Ranger
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_aq02coyotef150'-- Ford Ranger
data_file 'AUDIO_GAMEDATA' 'audioconfig/s63b44_game.dat' -- 540I
data_file 'AUDIO_SOUNDDATA' 'audioconfig/s63b44_sounds.dat'-- 540I
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_s63b44'-- 540I
data_file 'AUDIO_GAMEDATA' 'audioconfig/suzukigsxr1k_game.dat' -- R1200Rt
data_file 'AUDIO_SOUNDDATA' 'audioconfig/suzukigsxr1k_sounds.dat'-- R1200Rt
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_suzukigsxr1k'-- R1200Rt
data_file 'AUDIO_GAMEDATA' 'audioconfig/cvpiv8_game.dat' --x5
data_file 'AUDIO_SOUNDDATA' 'audioconfig/cvpiv8_sounds.dat'--x5
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_cvpiv8'--x5#
data_file 'AUDIO_GAMEDATA' 'audioconfig/m113k_game.dat' --Range Rover Sport SVR
data_file 'AUDIO_SOUNDDATA' 'audioconfig/m113k_sounds.dat'--Range Rover Sport SVR
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_m113k'--Range Rover Sport SVR


provides {
	'qb-smallresources',
}

data_file 'AUDIO_DYNAMIXDATA' 'addons/dynamix.dat'
data_file 'AUDIO_GAMEDATA' 'addons/game.dat'

data_file 'TIMECYCLEMOD_FILE' 'addons/weather/timecycle_mods_1.xml'
data_file 'TIMECYCLEMOD_FILE' 'addons/weather/timecycle_mods_2.xml'
data_file 'TIMECYCLEMOD_FILE' 'addons/weather/timecycle_mods_3.xml'
data_file 'TIMECYCLEMOD_FILE' 'addons/weather/timecycle_mods_4.xml'
data_file 'TIMECYCLEMOD_FILE' 'addons/weather/w_blizzard.xml'
data_file 'TIMECYCLEMOD_FILE' 'addons/weather/w_clear.xml'
data_file 'TIMECYCLEMOD_FILE' 'addons/weather/w_clearing.xml'
data_file 'TIMECYCLEMOD_FILE' 'addons/weather/w_clouds.xml'
data_file 'TIMECYCLEMOD_FILE' 'addons/weather/w_extrasunny.xml'
data_file 'TIMECYCLEMOD_FILE' 'addons/weather/w_foggy.xml'
data_file 'TIMECYCLEMOD_FILE' 'addons/weather/w_neutral.xml'
data_file 'TIMECYCLEMOD_FILE' 'addons/weather/w_overcast.xml'
data_file 'TIMECYCLEMOD_FILE' 'addons/weather/w_rain.xml'
data_file 'TIMECYCLEMOD_FILE' 'addons/weather/w_smog.xml'
data_file 'TIMECYCLEMOD_FILE' 'addons/weather/w_snow.xml'
data_file 'TIMECYCLEMOD_FILE' 'addons/weather/w_snowlight.xml'
data_file 'TIMECYCLEMOD_FILE' 'addons/weather/w_thunder.xml'
data_file 'TIMECYCLEMOD_FILE' 'addons/weather/w_xmas.xml'
data_file 'TIMECYCLEMOD_FILE' 'addons/weather/w_halloween.xml'
data_file 'TIMECYCLEMOD_FILE' 'addons/weather/underwater_deep.xml'

data_file 'AUDIO_WAVEPACK' 'addons/audio/sfx/resident'
data_file 'AUDIO_WAVEPACK' 'addons/audio/sfx/weapons_player'
data_file 'AUDIO_WAVEPACK' 'addons/audio/sfx/dlc_weapons'
data_file 'CLIP_SETS_FILE' 'addons/clipSets/*.clip_sets.xml'

data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_shake_bubblegum.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_shake_cherry.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_shake_chocolate.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_shake_coffee.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_shake_doublechocolate.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_shake_frappe.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_shake_lemon.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_shake_mint.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_shake_raspberry.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_shake_rsaltedcaramel.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_shake_strawberry.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_shake_vanilla.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_cherryshake_vanilla.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_cherryshake_bubblegum.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_cherryshake_cherry.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_cherryshake_chocolate.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_cherryshake_coffee.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_cherryshake_doublechocolate.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_cherryshake_frappe.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_cherryshake_lemon.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_cherryshake_mint.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_cherryshake_raspberry.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_cherryshake_salted.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_cherryshake_strawberry.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_can_awrootbeer.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_can_cherrycoke.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_can_coke.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_can_dietdew.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_can_dppepper.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_can_fantagrape.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_can_fantaorange.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_can_fantapineapple.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_can_mountaindew.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_can_redbull.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_can_redbullsugarfree.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_can_sprite.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_blueberry_elfbar.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_bubblegum_elfbar.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_cheesecake_elfbar.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_cherry_elfbar.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_cola_elfbar.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_doubleapple_elfbar.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_elfbull_elfbar.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_grape_elfbar.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_greenapple_elfbar.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_mango_elfbar.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_strawberryice_elfbar.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_watermelon_elfbar.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_prime_blueraspberrry.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_prime_grape.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_prime_icepop.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_prime_lemonlime.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_prime_metamoon.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_prime_orange.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_prime_tropicalpunch.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_slothbucks.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_starbuckscan_coffeeshot.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_starbuckscan_hazelnut.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_starbuckscan_mocha.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_starbuckscan_vanilla.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_starbuckscan_whitechocolate.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_jetlighter_black.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_jetlighter_blue.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_jetlighter_cream.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_jetlighter_green.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_jetlighter_grey.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_jetlighter_purple.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_jetlighter_purpleweed.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_jetlighter_red.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_jetlighter_white.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/ps_jarrito_grapefruit.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/ps_jarrito_lime.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/ps_jarrito_mandarin.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/ps_jarrito_strawberry.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/ps_jarritos_mango.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_7up.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_al_mimosa.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_arizona_lemon.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_atruly_watermelonkiwi.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_bang_bcv.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_bang_citrustwist.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_canadadry.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_bang_rainbowunicorn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_coke.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_coke_cherry.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_cokezero.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_dppepper.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_drpepper_diet.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_fanta.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_fanta_grape.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_la_grapefruit.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_minutemaid_berrypunch.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_minutemaid_kiwistrawberry.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_minutemaid_watermelonpunch.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_minutemaid_wblueraspberry.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_pepsi_diet.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_pepsiwildcherry.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_sprite.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_truly_blackcherry.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_truly_justmango.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_truly_lemonade.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_truly_mango.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_truly_passionfruit.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_truly_pineapple.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_truly_pomegeanate.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[props]/brum_truly_strawberry.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[cayo]/mads_no_exp_pumps.ytyp'