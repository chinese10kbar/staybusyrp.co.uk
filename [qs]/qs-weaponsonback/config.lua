Config = {}

local esxHas = GetResourceState('es_extended') == 'started'
local qbHas = GetResourceState('sb-core') == 'started'

Config.Framework = esxHas and 'esx' or qbHas and 'qb' or 'esx'

Config.WeaponPositions = {
    ['weapon_carbinerifle'] = {
        model = 'w_ar_carbinerifle',
        hash = -2084633992,
        bone = 10706,
        x = 0.0,
        y = 0.17,
        z = -0.25,
        x_rotation = 0.0,
        y_rotation = 75.0,
        z_rotation = 180.0
    },
    ['weapon_sig516'] = {
        model = 'w_ar_sig516',
        hash = GetHashKey('WEAPON_SIG516'),
        bone = 10706,
        x = 0.0,
        y = 0.18,
        z = -0.2,
        x_rotation = 0.0,
        y_rotation = 70.0,
        z_rotation = 180.0
    },
    ['weapon_sr25'] = {
        model = 'w_ar_sr25',
        hash = GetHashKey('WEAPON_SR25'),
        bone = 10706,
        x = 0.0,
        y = 0.18,
        z = -0.2,
        x_rotation = 0.0,
        y_rotation = 70.0,
        z_rotation = 180.0
    },
    ['weapon_g36'] = {
        model = 'w_ar_g36',
        hash = GetHashKey('WEAPON_G36'),
        bone = 10706,
        x = 0.0,
        y = 0.18,
        z = -0.15,
        x_rotation = 0.0,
        y_rotation = 70.0,
        z_rotation = 180.0
    },
    ['weapon_mpx'] = {
        model = 'w_sb_mpx',
        hash = GetHashKey('WEAPON_MPX'),
        bone = 24816,
        x = -0.200,
        y = 0.05,
        z = 0.210,
        x_rotation = 90.0,
        y_rotation = 110.0,
        z_rotation = 50.0
    },
    ['weapon_miniuzi'] = {
        model = 'markomods-uzi',
        hash = GetHashKey('WEAPON_MINIUZI'),
        bone = 24816,
        x = -0.200,
        y = 0.05,
        z = -0.210,
        x_rotation = 90.0,
        y_rotation = 110.0,
        z_rotation = 50.0
    },
    ['weapon_nailgun'] = {
        model = 'w_pi_nailgun',
        hash = GetHashKey('WEAPON_NAILGUN'),
        bone = 24816,
        x = -0.200,
        y = 0.05,
        z = -0.210,
        x_rotation = 90.0,
        y_rotation = 110.0,
        z_rotation = 50.0
    },
    ['weapon_slipper'] = {
        model = 'w_me_slipper',
        hash = GetHashKey('WEAPON_SLIPPER'),
        bone = 24816,
        x = -0.200,
        y = 0.05,
        z = -0.210,
        x_rotation = 90.0,
        y_rotation = -150.0,
        z_rotation = 50.0
    },
    ['weapon_sig716'] = {
        model = 'mdx_sig716',
        hash = GetHashKey('WEAPON_SIG716'),
        bone = 24816,
        x = 0.005,
        y = -0.16,
        z = 0.0,
        x_rotation = 0.0,
        y_rotation = -15.0,
        z_rotation = 2.0
    },
    ['weapon_carbinerifle_mk2'] = {
        model = 'w_ar_carbineriflemk2',
        hash = GetHashKey('WEAPON_CARBINERIFLE_MK2'),
        bone = 24816,
        x = 0.2275,
        y = -0.17,
        z = -0.110,
        x_rotation = 0.0,
        y_rotation = 20.0,
        z_rotation = 1.0
    },
    ['weapon_katana'] = {
        model = 'w_me_katana',
        hash = GetHashKey('WEAPON_KATANA'),
        bone = 24816,
        x = 0.0,
        y = -0.16,
        z = 0.1,
        x_rotation = 0.0,
        y_rotation = 110.0,
        z_rotation = -0.2
    },
    ['weapon_perforator'] = {
        model = 'w_me_perforator',
        hash = GetHashKey('WEAPON_PERFORATOR'),
        bone = 24816,
        x = 0.0,
        y = -0.16,
        z = 0.1,
        x_rotation = 0.0,
        y_rotation = 110.0,
        z_rotation = -0.2
    },
    ['weapon_pigeon'] = {
        model = 'w_me_pigeon',
        hash = GetHashKey('WEAPON_PIGEON'),
        bone = 24816,
        x = 0.46,
        y = -0.33,
        z = 0.11,
        x_rotation = 90.0,
        y_rotation = 130.0,
        z_rotation = -0.0
    },
    ['weapon_assaultrifle'] = {
        model = 'w_ar_assaultrifle',
        hash = -1074790547,
        bone = 24816,
        x = 0.2275,
        y = -0.16,
        z = 0.110,
        x_rotation = 0.0,
        y_rotation = -15.0,
        z_rotation = 2.0
    },
    ['weapon_tacticalrifle'] = {
        model = 'w_ar_tacticalrifle',
        hash = `weapon_tacticalrifle`,
        bone = 24816,
        x = 0.2275,
        y = -0.16,
        z = 0.110,
        x_rotation = 0.0,
        y_rotation = -15.0,
        z_rotation = 2.0
    },
    ['weapon_specialcarbine'] = {
        model = 'w_ar_specialcarbine',
        hash = -1063057011,
        bone = 24816,
        x = 0.2275,
        y = -0.16,
        z = 0.030,
        x_rotation = 0.0,
        y_rotation = 5.0,
        z_rotation = 1.0
    },
    ['weapon_bullpuprifle'] = {
        model = 'w_ar_bullpuprifle',
        hash = 2132975508,
        bone = 24816,
        x = 0.2275,
        y = -0.16,
        z = 0.055,
        x_rotation = 0.0,
        y_rotation = 0.0,
        z_rotation = 1.0
    },
    ['weapon_advancedrifle'] = {
        model = 'w_ar_advancedrifle',
        hash = -1357824103,
        bone = 24816,
        x = 0.2275,
        y = -0.16,
        z = -0.055,
        x_rotation = 0.0,
        y_rotation = 35.0,
        z_rotation = 1.0
    },
    ['weapon_appistol'] = {
        model = 'w_pi_appistol',
        hash = 584646201,
        bone = 24816,
        x = -0.140,
        y = 0.05,
        z = -0.210,
        x_rotation = 90.0,
        y_rotation = 90.0,
        z_rotation = 50.0
    },
    ['weapon_microsmg'] = {
        model = 'w_sb_microsmg',
        hash = 324215364,
        bone = 24816,
        x = -0.200,
        y = 0.05,
        z = -0.210,
        x_rotation = 90.0,
        y_rotation = 110.0,
        z_rotation = 50.0
    },
    ['weapon_assaultsmg'] = {
        model = 'w_sb_assaultsmg',
        hash = -270015777,
        bone = 10706,
        x = 0.0,
        y = 0.17,
        z = -0.35,
        x_rotation = 0.0,
        y_rotation = 55.0,
        z_rotation = 180.0
    },
    ['weapon_smg'] = {
        model = 'w_sb_smg',
        hash = 736523883,
        bone = 24816,
        x = 0.1275,
        y = -0.16,
        z = -0.055,
        x_rotation = 0.0,
        y_rotation = 35.0,
        z_rotation = 1.0
    },
    ['weapon_smg_mk2'] = {
        model = 'w_sb_smgmk2',
        hash = GetHashKey('WEAPON_SMG_MK2'),
        bone = 24816,
        x = -0.140,
        y = 0.05,
        z = 0.210,
        x_rotation = 90.0,
        y_rotation = 120.0,
        z_rotation = 50.0
    },
    ['weapon_sniperrifle'] = {
        model = 'w_sr_sniperrifle',
        hash = 100416529,
        bone = 24816,
        x = 0.005,
        y = -0.16,
        z = 0.0,
        x_rotation = 0.0,
        y_rotation = -15.0,
        z_rotation = 2.0
    },
    ['weapon_assaultshotgun'] = {
        model = 'w_sg_assaultshotgun',
        hash = -494615257,
        bone = 24816,
        x = 0.2275,
        y = -0.16,
        z = 0.015,
        x_rotation = 0.0,
        y_rotation = 160.0,
        z_rotation = 1.0
    },
    ['weapon_pumpshotgun'] = {
        model = 'w_sg_pumpshotgun',
        hash = 487013001,
        bone = 24816,
        x = 0.1275,
        y = -0.16,
        z = 0.030,
        x_rotation = 0.0,
        y_rotation = 25.0,
        z_rotation = 1.0
    },
    ['weapon_musket'] = {
        model = 'w_ar_musket',
        hash = -1466123874,
        bone = 24816,
        x = 0.0,
        y = -0.16,
        z = 0.0,
        x_rotation = 0.0,
        y_rotation = 15.0,
        z_rotation = 2.0
    },
    ['weapon_beanbagshotgun'] = {
        model = 'w_sg_beanbagshotgun',
        hash = GetHashKey('WEAPON_BEANBAGSHOTGUN'),
        bone = 24816,
        x = 0.0,
        y = -0.16,
        z = 0.0,
        x_rotation = 0.0,
        y_rotation = 15.0,
        z_rotation = 2.0
    },
    ['weapon_heavyshotgun'] = {
        model = 'w_sg_heavyshotgun',
        hash = GetHashKey('WEAPON_HEAVYSHOTGUN'),
        bone = 10706,
        x = 0.100,
        y = 0.17,
        z = -0.20,
        x_rotation = 0.0,
        y_rotation = 60.0,
        z_rotation = 190.0
    },
    -- Add more weapons as needed
}
