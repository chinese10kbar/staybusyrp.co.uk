Config = {}
Locales = {}

--[[
    The first thing will be to choose our main language, here you can choose
    between the default languages that you will find within locales/*,
    if yours is not there, feel free to create it!
]]

local esxHas = GetResourceState('es_extended') == 'started'
local qbHas = GetResourceState('qb-core') == 'started'

Config.Framework = esxHas and 'esx' or qbHas and 'qb' or 'esx'

Config.Language = 'en'

--[[
    Shop system based on qb-shops!
    Here you have a small configuration for the details of your stores,
    remember that UseTrucketJob is exclusive for qb-core!

    For the firearms license, you must use the item weaponlicense.
]]

Config.UseTruckerJob = false                            -- true = The shops stock is based on when truckers refill it | false = shop inventory never runs out (ONLY FOR QB)
Config.FirearmsLicenseCheck = false                     -- Whether a arms dealer checks for a firearms license (ONLY FOR QB)
Config.ShopsInvJsonFile = './json/shops-inventory.json' -- json file location (ONLY FOR QB)

--[[
    Part of esx_licenses, in this case, we can make the licenses
    functional through esx_licenses in case of using true, if you
    use false, then the conventional form of items will be used.

    Remember to put the license name in Config.Locations:
    ['requiredLicense'] = nil -- or example 'itemname' or 'license name in esx_license case)'
]]

Config.ESXLicense = false                                   -- Do you want to use esx_license? if this is the case use true/false (only for ESX)
Config.esx_licensecheckLicense = 'esx_license:checkLicense' -- esx_license event name, edit it if you modify it in your script

--[[
    You can use the following targets by default:
        'qb-target'
        'ox_target'

        'none'
]]

Config.UseTarget = 'qb-target' -- Choose between 'qb-target', 'ox_target' or 'none'

--[[
    Stashing system!
    Here you can add your stashes, their blips or even add a license to them!

    Remember that the licenses are an item, so you must put the name of said item!
    Example:
        ['requiredLicense'] = 'weapon_license' -- item or nil
]]

Config.Stashes = {
    [1] = {
        ['coords'] = vector3(456.672516, -983.195618, 30.678345),
        ['targetLabel'] = 'Open Stash',
        ['size'] = {
            weight = 50000,
            slots = 15
        },
        ['blip'] = {
            name = 'Police Stash',
            coords = vector3(456.672516, -983.195618, 30.678345),
            sprite = 1,
            color = 38,
            size = 0.5
        },
        ['label'] = 'police_stash',
        ['requiredJobs'] = { 'police' }, -- nil or example { 'police', 'ambulance' }
        ['requiredJobsGrades'] = { 2, 3, 4 },
        ['requiredLicense'] = nil,       -- nil or example 'itemname',
        ['personal'] = false
    },
    [2] = {
        ['coords'] = vector3(306.303284, -1457.709839, 29.953857),
        ['targetLabel'] = 'Open Stash',
        ['size'] = {
            weight = 9500,
            slots = 15
        },
        ['blip'] = nil,
        ['label'] = 'doctor_stash',
        ['requiredJobs'] = { 'ambulance' }, -- nil or example { 'police', 'ambulance' }
        ['requiredJobsGrades'] = nil,       -- nil or grade tables example { 2, 3, 4},
        ['requiredLicense'] = nil,          -- nil or example 'itemname',
        ['personal'] = false
    },
    [3] = {
        ['coords'] = vector3(237.481323, -1354.747192, 31.032227),
        ['targetLabel'] = 'Open Stash',
        ['size'] = {
            weight = 10000,
            slots = 50
        },
        ['blip'] = nil,
        ['label'] = 'mysterious_shed',
        ['requiredJobs'] = nil,       -- nil or example { 'police', 'ambulance' }
        ['requiredJobsGrades'] = nil, -- nil or grade tables example { 2, 3, 4},
        ['requiredLicense'] = nil,    -- nil or example 'itemname',
        ['personal'] = true
    }
}

--[[
    Store setup!
    Remember to add the items correctly, checking that they exist
    within your qb-core or your qs-inventory/shared/*.

    Below you can add these items to the desired stores.

    Remember that the licenses are an item, so you must put the name of said item!
    Example:
        ['requiredLicense'] = 'weapon_license' -- item or nil
]]

Config.Products = {
    ['normal'] = {
        [1] = {
            name = 'micard_psa',
            price = 2,
            amount = 50,
            info = {},
            type = 'item',
            slot = 1,
        },
        [2] = {
            name = 'water_bottle',
            price = 2,
            amount = 50,
            info = {},
            type = 'item',
            slot = 2,
        },
        [3] = {
            name = 'kurkakola',
            price = 2,
            amount = 50,
            info = {},
            type = 'item',
            slot = 3,
        },
        [4] = {
            name = 'twerks_candy',
            price = 2,
            amount = 50,
            info = {},
            type = 'item',
            slot = 4,
        },
        [5] = {
            name = 'snikkel_candy',
            price = 2,
            amount = 50,
            info = {},
            type = 'item',
            slot = 5,
        },
        [6] = {
            name = 'sandwich',
            price = 2,
            amount = 50,
            info = {},
            type = 'item',
            slot = 6,
        },
        [7] = {
            name = 'beer',
            price = 7,
            amount = 50,
            info = {},
            type = 'item',
            slot = 7,
        },
        [8] = {
            name = 'whiskey',
            price = 10,
            amount = 50,
            info = {},
            type = 'item',
            slot = 8,
        },
        [9] = {
            name = 'vodka',
            price = 12,
            amount = 50,
            info = {},
            type = 'item',
            slot = 9,
        },
        [10] = {
            name = 'bandage',
            price = 100,
            amount = 50,
            info = {},
            type = 'item',
            slot = 10,
        },
        [11] = {
            name = 'clipper',
            price = 2,
            amount = 50,
            info = {},
            type = 'item',
            slot = 11,
        },
        [12] = {
            name = 'rolling_paper',
            price = 2,
            amount = 5000,
            info = {},
            type = 'item',
            slot = 12,
        },
        [13] = {
            name = 'vape',
            price = 250,
            amount = 50,
            info = {},
            type = 'item',
            slot = 13,
        },
        [14] = {
            name = 'blueberry_jam_cookie',
            price = 50,
            amount = 100,
            info = {},
            type = 'item',
            slot = 14,
        },
        [15] = {
            name = 'butter_cookie',
            price = 50,
            amount = 100,
            info = {},
            type = 'item',
            slot = 15,
        },
        [16] = {
            name = 'cookie_dough',
            price = 50,
            amount = 100,
            info = {},
            type = 'item',
            slot = 16,
        },
        [17] = {
            name = 'icey_gummy_bear',
            price = 50,
            amount = 100,
            info = {},
            type = 'item',
            slot = 17,
        },
        [18] = {
            name = 'key_lime_cookie',
            price = 2,
            amount = 100,
            info = {},
            type = 'item',
            slot = 18,
        },
        [19] = {
            name = 'marshmallow_crisp',
            price = 50,
            amount = 100,
            info = {},
            type = 'item',
            slot = 19,
        },
        [20] = {
            name = 'tutti_fruiti',
            price = 50,
            amount = 100,
            info = {},
            type = 'item',
            slot = 20,
        },
        [21] = {
            name = 'strawberry_jam_cookie',
            price = 50,
            amount = 100,
            info = {},
            type = 'item',
            slot = 21,
        },
        [22] = {
            name = 'corn_seed',
            price = 30,
            amount = 100,
            info = {},
            type = 'item',
            slot = 22,
        },
        [23] = {
            name = 'tomato_seed',
            price = 20,
            amount = 100,
            info = {},
            type = 'item',
            slot = 23,
        },
        [24] = {
            name = 'wheat_seed',
            price = 15,
            amount = 100,
            info = {},
            type = 'item',
            slot = 24,
        },
        [25] = {
            name = 'wheat_seed',
            price = 10,
            amount = 100,
            info = {},
            type = 'item',
            slot = 25,
        },
        [26] = {
            name = 'broccoli_seed',
            price = 20,
            amount = 100,
            info = {},
            type = 'item',
            slot = 26,
        },
        [27] = {
            name = 'carrot_seed',
            price = 20,
            amount = 100,
            info = {},
            type = 'item',
            slot = 27,
        },
        [28] = {
            name = 'potato_seed',
            price = 40,
            amount = 100,
            info = {},
            type = 'item',
            slot = 28,
        },
        [29] = {
            name = 'pickle_seed',
            price = 40,
            amount = 100,
            info = {},
            type = 'item',
            slot = 29,
        },
        [30] = {
            name = 'garden_shovel',
            price = 120,
            amount = 100,
            info = {},
            type = 'item',
            slot = 30,
        },
        [31] = {
            name = 'garden_pitcher',
            price = 100,
            amount = 100,
            info = {},
            type = 'item',
            slot = 31,
        },

        
    },
    ['liquor'] = {
        [1] = {
            name = 'beer',
            price = 7,
            amount = 50,
            info = {},
            type = 'item',
            slot = 1,
        },
        [2] = {
            name = 'whiskey',
            price = 10,
            amount = 50,
            info = {},
            type = 'item',
            slot = 2,
        },
        [3] = {
            name = 'vodka',
            price = 12,
            amount = 50,
            info = {},
            type = 'item',
            slot = 3,
        },
    },
    ['hardware'] = {
        [1] = {
            name = 'lockpick',
            price = 200,
            amount = 50,
            info = {},
            type = 'item',
            slot = 1,
        },
        [2] = {
            name = 'weapon_wrench',
            price = 250,
            amount = 250,
            info = {},
            type = 'item',
            slot = 2,
        },
        [3] = {
            name = 'weapon_hammer',
            price = 250,
            amount = 250,
            info = {},
            type = 'item',
            slot = 3,
        },
        [4] = {
            name = 'repairkit',
            price = 250,
            amount = 50,
            info = {},
            type = 'item',
            slot = 4,
            requiredJob = { 'mechanic', 'police' }
        },
        [5] = {
            name = 'screwdriverset',
            price = 350,
            amount = 50,
            info = {},
            type = 'item',
            slot = 5,
        },
        [6] = {
            name = 'rubber',
            price = 850,
            amount = 50,
            info = {},
            type = 'item',
            slot = 6,
        },
        [7] = {
            name = 'radio',
            price = 250,
            amount = 50,
            info = {},
            type = 'item',
            slot = 7,
        },
        [8] = {
            name = 'binoculars',
            price = 50,
            amount = 50,
            info = {},
            type = 'item',
            slot = 8,
        },
        [9] = {
            name = 'firework1',
            price = 50,
            amount = 50,
            info = {},
            type = 'item',
            slot = 9,
        },
        [10] = {
            name = 'firework2',
            price = 50,
            amount = 50,
            info = {},
            type = 'item',
            slot = 10,
        },
        [11] = {
            name = 'firework3',
            price = 50,
            amount = 50,
            info = {},
            type = 'item',
            slot = 11,
        },
        [12] = {
            name = 'firework4',
            price = 50,
            amount = 50,
            info = {},
            type = 'item',
            slot = 12,
        },
        [13] = {
            name = 'fitbit',
            price = 400,
            amount = 150,
            info = {},
            type = 'item',
            slot = 13,
        },
        [14] = {
            name = 'cleaningkit',
            price = 150,
            amount = 150,
            info = {},
            type = 'item',
            slot = 14,
        },
        [15] = {
            name = 'advancedrepairkit',
            price = 500,
            amount = 50,
            info = {},
            type = 'item',
            slot = 15,
            requiredJob = { 'mechanic' }
        },
        [16] = {
            name = 'scissors',
            price = 200,
            amount = 150,
            info = {},
            type = 'item',
            slot = 16,
        },
        [17] = {
            name = 'generator',
            price = 800,
            amount = 150,
            info = {},
            type = 'item',
            slot = 17,
        },
        [18] = {
            name = 'head_bag',
            price = 1000,
            amount = 150,
            info = {},
            type = 'item',
            slot = 18,
        },
    },
    ['apple'] = {
        [1] = {
            name = 'phone',
            price = 1000,
            amount = 100,
            info = {},
            type = 'item',
            slot = 1,
        },
        [2] = {
            name = 'laptop2',
            price = 50000,
            amount = 100,
            info = {},
            type = 'item',
            slot = 2,
        },
        [3] = {
            name = 'printer',
            price = 50000,
            amount = 100,
            info = {},
            type = 'item',
            slot = 3,
        },
        [4] = {
            name = 'infousb',
            price = 50000,
            amount = 100,
            info = {},
            type = 'item',
            slot = 4,
        },
    },
        ['weedshop'] = {
        [1] = {
            name = 'empty_weed_bag',
            price = 30,
            amount = 1000,
            info = {},
            type = 'item',
            slot = 1,
        },
        [2] = {
            name = 'backwoods_grape',
            price = 80,
            amount = 1000,
            info = {},
            type = 'item',
            slot = 2,
        },
        [3] = {
            name = 'backwoods_honey',
            price = 80,
            amount = 1000,
            info = {},
            type = 'item',
            slot = 3,
        },
        [4] = {
            name = 'backwoods_russian_cream',
            price = 80,
            amount = 1000,
            info = {},
            type = 'item',
            slot = 4,
        },
        [5] = {
            name = 'banana_backwoods',
            price = 80,
            amount = 1000,
            info = {},
            type = 'item',
            slot = 5,
        },
        [6] = {
            name = 'grabba_leaf',
            price = 80,
            amount = 1000,
            info = {},
            type = 'item',
            slot = 6,
        },
        [7] = {
            name = 'paxton_pearl_cigars',
            price = 80,
            amount = 1000,
            info = {},
            type = 'item',
            slot = 7,
        },
        [8] = {
            name = 'raw_cone_king',
            price = 80,
            amount = 1000,
            info = {},
            type = 'item',
            slot = 8,
        },
        [9] = {
            name = 'rolling_paper',
            price = 80,
            amount = 1000,
            info = {},
            type = 'item',
            slot = 9,
        },
        [10] = {
            name = 'clipper',
            price = 80,
            amount = 1000,
            info = {},
            type = 'item',
            slot = 10,
        },

    },
    ['weedshopblack'] = {
        [1] = {
            name = 'empty_weed_bag',
            price = 30,
            amount = 1000,
            info = {},
            type = 'item',
            slot = 1,
        },
        [2] = {
            name = 'rolling_paper',
            price = 4,
            amount = 1000,
            info = {},
            type = 'item',
            slot = 2,
        },
        [3] = {
            name = 'plantpot',
            price = 100,
            amount = 1000,
            info = {},
            type = 'item',
            slot = 3,
        },
        [4] = {
            name = 'lowqualitysoil',
            price = 200,
            amount = 1000,
            info = {},
            type = 'item',
            slot = 4,
        },
        [5] = {
            name = 'hiqualitysoil',
            price = 400,
            amount = 1000,
            info = {},
            type = 'item',
            slot = 5,
        },
        [6] = {
            name = 'lowqualnutrients',
            price = 100,
            amount = 1000,
            info = {},
            type = 'item',
            slot = 6,
        },
        [7] = {
            name = 'medqualnutrients',
            price = 150,
            amount = 1000,
            info = {},
            type = 'item',
            slot = 7,
        },
        [8] = {
            name = 'hiqualnutrients',
            price = 200,
            amount = 1000,
            info = {},
            type = 'item',
            slot = 8,
        },
        [9] = {
            name = 'wateringcan',
            price = 50,
            amount = 1000,
            info = {},
            type = 'item',
            slot = 9,
        },
        [10] = {
            name = 'weed_grow_fan1',
            price = 50,
            amount = 1000,
            info = {},
            type = 'item',
            slot = 10,
        },
        [11] = {
            name = 'weed_grow_light1',
            price = 50,
            amount = 1000,
            info = {},
            type = 'item',
            slot = 11,
        },
    },
    ['gearshop'] = {
        [1] = {
            name = 'diving_gear',
            price = 2500,
            amount = 10,
            info = {},
            type = 'item',
            slot = 1,
        },
        [2] = {
            name = 'jerry_can',
            price = 200,
            amount = 50,
            info = {},
            type = 'item',
            slot = 2,
        },
    },
    ['leisureshop'] = {
        [1] = {
            name = 'parachute',
            price = 2500,
            amount = 10,
            info = {},
            type = 'item',
            slot = 1,
        },
        [2] = {
            name = 'binoculars',
            price = 50,
            amount = 50,
            info = {},
            type = 'item',
            slot = 2,
        },
        [3] = {
            name = 'diving_gear',
            price = 2500,
            amount = 10,
            info = {},
            type = 'item',
            slot = 3,
        },
        [4] = {
            name = 'diving_fill',
            price = 500,
            amount = 10,
            info = {},
            type = 'item',
            slot = 4,
        },
    },
    ['weapons'] = {
        [1] = {
            name = 'weapon_knife',
            price = 30,
            amount = 250,
            info = {},
            type = 'item',
            slot = 1,
        },
        [2] = {
            name = 'weapon_katana',
            price = 100,
            amount = 250,
            info = {},
            type = 'item',
            slot = 2,
        },
        [3] = {
            name = 'weapon_huntsmanknife',
            price = 120,
            amount = 250,
            info = {},
            type = 'item',
            slot = 3,
        },
        [4] = {
            name = 'weapon_gutknife',
            price = 120,
            amount = 250,
            info = {},
            type = 'item',
            slot = 4,
        },
        [5] = {
            name = 'weapon_karambit',
            price = 75,
            amount = 250,
            info = {},
            type = 'item',
            slot = 5,
        },
        [6] = {
            name = 'weapon_bfknife',
            price = 50,
            amount = 250,
            info = {},
            type = 'item',
            slot = 6,
        },
        [7] = {
            name = 'weapon_urbanrbfknife',
            price = 50,
            amount = 250,
            info = {},
            type = 'item',
            slot = 7,
        },
        [8] = {
            name = 'weapon_stainedrbfknife',
            price = 50,
            amount = 250,
            info = {},
            type = 'item',
            slot = 8,
        },
        [9] = {
            name = 'weapon_slaughterbfknife',
            price = 50,
            amount = 250,
            info = {},
            type = 'item',
            slot = 9,
        },
        [10] = {
            name = 'weapon_scorchedbfknife',
            price = 50,
            amount = 250,
            info = {},
            type = 'item',
            slot = 10,
        },
    },

['gym'] = {
    [1] = {
        name = 'protein',
        price = 200,
        amount = 200,
        info = {},
        type = 'item',
        slot = 1,
    },
    [2] = {
        name = 'preworkout',
        price = 400,
        amount = 250,
        info = {},
        type = 'item',
        slot = 2,
    },
    [3] = {
        name = 'creatine',
        price = 500,
        amount = 250,
        info = {},
        type = 'item',
        slot = 3,
    },
}
}

Config.Locations = {
    -- 24/7 Locations
    ['247supermarket'] = {
        ['label'] = '24/7 Supermarket',
        ['coords'] = vector4(24.47, -1346.62, 29.5, 271.66),
        ['ped'] = 'mp_m_shopkeep_01', -- or false
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ['products'] = Config.Products['normal'],
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.6,
        ['blipcolor'] = 2,
        ['delivery'] = vector4(26.45, -1315.51, 29.62, 0.07),
        ['distance'] = 2.0,
        ['account'] = 'bank',
        ['requiredJobs'] = nil,       -- nil or example { 'police', 'ambulance' }
        ['requiredJobsGrades'] = nil, -- nil or grade tables example { 2, 3, 4},
        ['requiredLicense'] = nil     -- or example 'itemname'
    },
    ['247supermarket2'] = {
        ['label'] = '24/7 Supermarket',
        ['coords'] = vector4(-3039.54, 584.38, 7.91, 17.27),
        ['ped'] = 'mp_m_shopkeep_01', -- or false
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ['products'] = Config.Products['normal'],
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.6,
        ['blipcolor'] = 2,
        ['delivery'] = vector4(-3047.95, 590.71, 7.62, 19.53),
        ['distance'] = 2.0,
        ['account'] = 'money',
        ['requiredJobs'] = nil,       -- nil or example { 'police', 'ambulance' }
        ['requiredJobsGrades'] = nil, -- nil or grade tables example { 2, 3, 4},
        ['requiredLicense'] = nil     -- or example 'itemname'
    },
    ['247supermarket3'] = {
        ['label'] = '24/7 Supermarket',
        ['coords'] = vector4(-3242.97, 1000.01, 12.83, 357.57),
        ['ped'] = 'mp_m_shopkeep_01', -- or false
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ['products'] = Config.Products['normal'],
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.6,
        ['blipcolor'] = 2,
        ['delivery'] = vector4(-3245.76, 1005.25, 12.83, 269.45),
        ['distance'] = 2.0,
        ['account'] = 'money',
        ['requiredJobs'] = nil,       -- nil or example { 'police', 'ambulance' }
        ['requiredJobsGrades'] = nil, -- nil or grade tables example { 2, 3, 4},
        ['requiredLicense'] = nil     -- or example 'itemname'
    },
    ['247supermarket4'] = {
        ['label'] = '24/7 Supermarket',
        ['coords'] = vector4(1728.07, 6415.63, 35.04, 242.95),
        ['ped'] = 'mp_m_shopkeep_01', -- or false
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ['products'] = Config.Products['normal'],
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.6,
        ['blipcolor'] = 2,
        ['delivery'] = vector4(1741.76, 6419.61, 35.04, 6.83),
        ['distance'] = 2.0,
        ['account'] = 'money',
        ['requiredJobs'] = nil,       -- nil or example { 'police', 'ambulance' }
        ['requiredJobsGrades'] = nil, -- nil or grade tables example { 2, 3, 4},
        ['requiredLicense'] = nil     -- or example 'itemname'
    },
    ['247supermarket5'] = {
        ['label'] = '24/7 Supermarket',
        ['coords'] = vector4(1959.82, 3740.48, 32.34, 301.57),
        ['ped'] = 'mp_m_shopkeep_01', -- or false
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ['products'] = Config.Products['normal'],
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.6,
        ['blipcolor'] = 2,
        ['delivery'] = vector4(1963.81, 3750.09, 32.26, 302.46),
        ['distance'] = 2.0,
        ['account'] = 'money',
        ['requiredJobs'] = nil,       -- nil or example { 'police', 'ambulance' }
        ['requiredJobsGrades'] = nil, -- nil or grade tables example { 2, 3, 4},
        ['requiredLicense'] = nil     -- or example 'itemname'
    },
    ['247supermarket6'] = {
        ['label'] = '24/7 Supermarket',
        ['coords'] = vector4(549.13, 2670.85, 42.16, 99.39),
        ['ped'] = 'mp_m_shopkeep_01', -- or false
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ['products'] = Config.Products['normal'],
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.6,
        ['blipcolor'] = 2,
        ['delivery'] = vector4(541.54, 2663.53, 42.17, 120.51),
        ['distance'] = 2.0,
        ['account'] = 'money',
        ['requiredJobs'] = nil,       -- nil or example { 'police', 'ambulance' }
        ['requiredJobsGrades'] = nil, -- nil or grade tables example { 2, 3, 4},
        ['requiredLicense'] = nil     -- or example 'itemname'
    },
    ['247supermarket7'] = {
        ['label'] = '24/7 Supermarket',
        ['coords'] = vector4(2677.47, 3279.76, 55.24, 335.08),
        ['ped'] = 'mp_m_shopkeep_01', -- or false
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ['products'] = Config.Products['normal'],
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.6,
        ['blipcolor'] = 2,
        ['delivery'] = vector4(2662.19, 3264.95, 55.24, 168.55),
        ['distance'] = 2.0,
        ['account'] = 'money',
        ['requiredJobs'] = nil,       -- nil or example { 'police', 'ambulance' }
        ['requiredJobsGrades'] = nil, -- nil or grade tables example { 2, 3, 4},
        ['requiredLicense'] = nil     -- or example 'itemname'
    },
    ['247supermarket8'] = {
        ['label'] = '24/7 Supermarket',
        ['coords'] = vector4(2556.66, 380.84, 108.62, 356.67),
        ['ped'] = 'mp_m_shopkeep_01', -- or false
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ['products'] = Config.Products['normal'],
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.6,
        ['blipcolor'] = 2,
        ['delivery'] = vector4(2553.24, 399.73, 108.56, 344.86),
        ['distance'] = 2.0,
        ['account'] = 'money',
        ['requiredJobs'] = nil,       -- nil or example { 'police', 'ambulance' }
        ['requiredJobsGrades'] = nil, -- nil or grade tables example { 2, 3, 4},
        ['requiredLicense'] = nil     -- or example 'itemname'
    },
    ['247supermarket9'] = {
        ['label'] = '24/7 Supermarket',
        ['coords'] = vector4(372.66, 326.98, 103.57, 253.73),
        ['ped'] = 'mp_m_shopkeep_01', -- or false
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ['products'] = Config.Products['normal'],
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.6,
        ['blipcolor'] = 2,
        ['delivery'] = vector4(379.97, 357.3, 102.56, 26.42),
        ['distance'] = 2.0,
        ['account'] = 'money',
        ['requiredJobs'] = nil,       -- nil or example { 'police', 'ambulance' }
        ['requiredJobsGrades'] = nil, -- nil or grade tables example { 2, 3, 4},
        ['requiredLicense'] = nil     -- or example 'itemname'
    },
    -- LTD Gasoline Locations
    ['ltdgasoline'] = {
        ['label'] = 'LTD Gasoline',
        ['coords'] = vector4(-47.02, -1758.23, 29.42, 45.05),
        ['ped'] = 'mp_m_shopkeep_01', -- or false
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ['products'] = Config.Products['normal'],
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.6,
        ['blipcolor'] = 2,
        ['delivery'] = vector4(-40.51, -1747.45, 29.29, 326.39),
        ['distance'] = 2.0,
        ['account'] = 'money',
        ['requiredJobs'] = nil,       -- nil or example { 'police', 'ambulance' }
        ['requiredJobsGrades'] = nil, -- nil or grade tables example { 2, 3, 4},
        ['requiredLicense'] = nil     -- or example 'itemname'
    },
        -- Gym
        ['gym'] = {
            ['label'] = 'La Fitness',
            ['coords'] = vector4(258.3827, -271.5872, 53.9635, 336.7877),
            ['ped'] = 'u_m_y_babyd', -- or false
            ['scenario'] = 'WORLD_HUMAN_JOG_STANDING',
            ['radius'] = 1.5,
            ['targetIcon'] = 'fas fa-shopping-basket',
            ['targetLabel'] = 'Open Shop',
            ['products'] = Config.Products['gym'],
            ['showblip'] = true,
            ['blipsprite'] = nil,
            ['blipscale'] = 0.6,
            ['blipcolor'] = 2,
            ['delivery'] = vector4(-40.51, -1747.45, 29.29, 326.39),
            ['distance'] = 2.0,
            ['account'] = 'money',
            ['requiredJobs'] = nil,       -- nil or example { 'police', 'ambulance' }
            ['requiredJobsGrades'] = nil, -- nil or grade tables example { 2, 3, 4},
            ['requiredLicense'] = nil     -- or example 'itemname'
        },
    ['ltdgasoline2'] = {
        ['label'] = 'LTD Gasoline',
        ['coords'] = vector4(-706.06, -913.97, 19.22, 88.04),
        ['ped'] = 'mp_m_shopkeep_01', -- or false
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ['products'] = Config.Products['normal'],
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.6,
        ['blipcolor'] = 2,
        ['delivery'] = vector4(-702.89, -917.44, 19.21, 181.96),
        ['distance'] = 2.0,
        ['account'] = 'money',
        ['requiredJobs'] = nil,       -- nil or example { 'police', 'ambulance' }
        ['requiredJobsGrades'] = nil, -- nil or grade tables example { 2, 3, 4},
        ['requiredLicense'] = nil     -- or example 'itemname'
    },
    ['ltdgasoline3'] = {
        ['label'] = 'LTD Gasoline',
        ['coords'] = vector4(-1820.02, 794.03, 138.09, 135.45),
        ['ped'] = 'mp_m_shopkeep_01', -- or false
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ['products'] = Config.Products['normal'],
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.6,
        ['blipcolor'] = 2,
        ['delivery'] = vector4(-1829.29, 801.49, 138.41, 41.39),
        ['distance'] = 2.0,
        ['account'] = 'money',
        ['requiredJobs'] = nil,       -- nil or example { 'police', 'ambulance' }
        ['requiredJobsGrades'] = nil, -- nil or grade tables example { 2, 3, 4},
        ['requiredLicense'] = nil     -- or example 'itemname'
    },
    ['ltdgasoline4'] = {
        ['label'] = 'LTD Gasoline',
        ['coords'] = vector4(1164.71, -322.94, 69.21, 101.72),
        ['ped'] = 'mp_m_shopkeep_01', -- or false
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Open Shop',
        ['products'] = Config.Products['normal'],
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.6,
        ['blipcolor'] = 2,
        ['delivery'] = vector4(1160.62, -312.06, 69.28, 3.77),
        ['distance'] = 2.0,
        ['account'] = 'money',
        ['requiredJobs'] = nil,       -- nil or example { 'police', 'ambulance' }
        ['requiredJobsGrades'] = nil, -- nil or grade tables example { 2, 3, 4},
        ['requiredLicense'] = nil     -- or example 'itemname'
    },
    ['ltdgasoline5'] = {
        ['label'] = 'LTD Gasoline',
        ['coords'] = vector4(1697.87, 4922.96, 42.06, 324.71),
        ['ped'] = 'mp_m_shopkeep_01', -- or false
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ['products'] = Config.Products['normal'],
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.6,
        ['blipcolor'] = 2,
        ['delivery'] = vector4(1702.68, 4917.28, 42.22, 139.27),
        ['distance'] = 2.0,
        ['account'] = 'money',
        ['requiredJobs'] = nil,       -- nil or example { 'police', 'ambulance' }
        ['requiredJobsGrades'] = nil, -- nil or grade tables example { 2, 3, 4},
        ['requiredLicense'] = nil     -- or example 'itemname'
    },
    -- Rob's Liquor Locations
    ['robsliquor'] = {
        ['label'] = "Rob's Liqour",
        ['coords'] = vector4(-1221.58, -908.15, 12.33, 35.49),
        ['ped'] = 'mp_m_shopkeep_01', -- or false
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ['products'] = Config.Products['liquor'],
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.6,
        ['blipcolor'] = 2,
        ['delivery'] = vector4(-1226.92, -901.82, 12.28, 213.26),
        ['distance'] = 2.0,
        ['account'] = 'money',
        ['requiredJobs'] = nil,       -- nil or example { 'police', 'ambulance' }
        ['requiredJobsGrades'] = nil, -- nil or grade tables example { 2, 3, 4},
        ['requiredLicense'] = nil     -- or example 'itemname'
    },
    ['robsliquor2'] = {
        ['label'] = "Rob's Liqour",
        ['coords'] = vector4(-1486.59, -377.68, 40.16, 139.51),
        ['ped'] = 'mp_m_shopkeep_01', -- or false
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ['products'] = Config.Products['liquor'],
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.6,
        ['blipcolor'] = 2,
        ['delivery'] = vector4(-1468.29, -387.61, 38.79, 220.13),
        ['distance'] = 2.0,
        ['account'] = 'money',
        ['requiredJobs'] = nil,       -- nil or example { 'police', 'ambulance' }
        ['requiredJobsGrades'] = nil, -- nil or grade tables example { 2, 3, 4},
        ['requiredLicense'] = nil     -- or example 'itemname'
    },
    ['robsliquor3'] = {
        ['label'] = "Rob's Liqour",
        ['coords'] = vector4(-2966.39, 391.42, 15.04, 87.48),
        ['ped'] = 'mp_m_shopkeep_01', -- or false
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ['products'] = Config.Products['liquor'],
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.6,
        ['blipcolor'] = 2,
        ['delivery'] = vector4(-2961.49, 376.25, 15.02, 111.41),
        ['distance'] = 2.0,
        ['account'] = 'money',
        ['requiredJobs'] = nil,       -- nil or example { 'police', 'ambulance' }
        ['requiredJobsGrades'] = nil, -- nil or grade tables example { 2, 3, 4},
        ['requiredLicense'] = nil     -- or example 'itemname'
    },
    ['robsliquor4'] = {
        ['label'] = "Rob's Liqour",
        ['coords'] = vector4(1165.17, 2710.88, 38.16, 179.43),
        ['ped'] = 'mp_m_shopkeep_01', -- or false
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ['products'] = Config.Products['liquor'],
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.6,
        ['blipcolor'] = 2,
        ['delivery'] = vector4(1194.52, 2722.21, 38.62, 9.37),
        ['distance'] = 2.0,
        ['account'] = 'money',
        ['requiredJobs'] = nil,       -- nil or example { 'police', 'ambulance' }
        ['requiredJobsGrades'] = nil, -- nil or grade tables example { 2, 3, 4},
        ['requiredLicense'] = nil     -- or example 'itemname'
    },
    ['robsliquor5'] = {
        ['label'] = "Rob's Liqour",
        ['coords'] = vector4(1134.2, -982.91, 46.42, 277.24),
        ['ped'] = 'mp_m_shopkeep_01', -- or false
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ['products'] = Config.Products['liquor'],
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.6,
        ['blipcolor'] = 2,
        ['delivery'] = vector4(1129.73, -989.27, 45.97, 280.98),
        ['distance'] = 2.0,
        ['account'] = 'money',
        ['requiredJobs'] = nil,       -- nil or example { 'police', 'ambulance' }
        ['requiredJobsGrades'] = nil, -- nil or grade tables example { 2, 3, 4},
        ['requiredLicense'] = nil     -- or example 'itemname'
    },
    -- Hardware Store Locations
    ['hardware'] = {
        ['label'] = 'Hardware Store',
        ['coords'] = vector4(45.68, -1749.04, 29.61, 53.13),
        ['ped'] = 'mp_m_waremech_01', -- or false
        ['scenario'] = 'WORLD_HUMAN_CLIPBOARD',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-wrench',
        ['targetLabel'] = 'Open Hardware Store',
        ['products'] = Config.Products['hardware'],
        ['showblip'] = true,
        ['blipsprite'] = 402,
        ['blipscale'] = 0.8,
        ['blipcolor'] = 0,
        ['delivery'] = vector4(89.15, -1745.29, 30.09, 315.25),
        ['distance'] = 2.0,
        ['account'] = 'money',
        ['requiredJobs'] = nil,       -- nil or example { 'police', 'ambulance' }
        ['requiredJobsGrades'] = nil, -- nil or grade tables example { 2, 3, 4},
        ['requiredLicense'] = nil     -- or example 'itemname'
    },
    ['hardware2'] = {
        ['label'] = 'Hardware Store',
        ['coords'] = vector4(2747.71, 3472.85, 55.67, 255.08),
        ['ped'] = 'mp_m_waremech_01', -- or false
        ['scenario'] = 'WORLD_HUMAN_CLIPBOARD',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-wrench',
        ['targetLabel'] = 'Open Hardware Store',
        ['products'] = Config.Products['hardware'],
        ['showblip'] = true,
        ['blipsprite'] = 402,
        ['blipscale'] = 0.8,
        ['blipcolor'] = 0,
        ['delivery'] = vector4(2704.68, 3457.21, 55.54, 176.28),
        ['distance'] = 2.0,
        ['account'] = 'money',
        ['requiredJobs'] = nil,       -- nil or example { 'police', 'ambulance' }
        ['requiredJobsGrades'] = nil, -- nil or grade tables example { 2, 3, 4},
        ['requiredLicense'] = nil     -- or example 'itemname'
    },
    ['hardware3'] = {
        ['label'] = 'Hardware Store',
        ['coords'] = vector4(-421.83, 6136.13, 31.88, 228.2),
        ['ped'] = 'mp_m_waremech_01', -- or false
        ['scenario'] = 'WORLD_HUMAN_CLIPBOARD',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-wrench',
        ['targetLabel'] = 'Hardware Store',
        ['products'] = Config.Products['hardware'],
        ['showblip'] = true,
        ['blipsprite'] = 402,
        ['blipscale'] = 0.8,
        ['blipcolor'] = 0,
        ['delivery'] = vector4(-438.25, 6146.9, 31.48, 136.99),
        ['distance'] = 2.0,
        ['account'] = 'money',
        ['requiredJobs'] = nil,       -- nil or example { 'police', 'ambulance' }
        ['requiredJobsGrades'] = nil, -- nil or grade tables example { 2, 3, 4},
        ['requiredLicense'] = nil     -- or example 'itemname'
    },
    -- Apple Store
    ['apple'] = {
        ['label'] = 'Apple Store',
        ['coords'] = vector4(148.7205, -234.4918, 54.4240, 340.2929),
        ['ped'] = 'a_m_y_smartcaspat_01', -- or false
        ['scenario'] = 'WORLD_HUMAN_AA_COFFEE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-wrench',
        ['targetLabel'] = 'Apple Store',
        ['products'] = Config.Products['apple'],
        ['showblip'] = true,
        ['blipsprite'] = 76,
        ['blipscale'] = 0.8,
        ['blipcolor'] = 2,
        ['delivery'] = vector4(-438.25, 6146.9, 31.48, 136.99),
        ['distance'] = 2.0,
        ['account'] = 'money',
        ['requiredJobs'] = nil,       -- nil or example { 'police', 'ambulance' }
        ['requiredJobsGrades'] = nil, -- nil or grade tables example { 2, 3, 4},
        ['requiredLicense'] = nil     -- or example 'itemname'
    },
        -- Black market
        ['weedshop1'] = {
            ['label'] = 'Weed Shop',
            ['coords'] = vector4(281.6931, 6789.1904, 15.6951, 249.7313),
            ['ped'] = 'g_m_y_ballaorig_01', -- or false
            ['scenario'] = 'WORLD_HUMAN_COP_IDLES',
            ['radius'] = 1.5,
            ['targetIcon'] = 'fas fa-wrench',
            ['targetLabel'] = 'Weed Shop',
            ['products'] = Config.Products['weedshopblack'],
            ['showblip'] = false,
            ['blipsprite'] = 76,
            ['blipscale'] = 0.8,
            ['blipcolor'] = 2,
            ['delivery'] = vector4(-438.25, 6146.9, 31.48, 136.99),
            ['distance'] = 2.0,
            ['account'] = 'money',
            ['requiredJobs'] = nil,       -- nil or example { 'police', 'ambulance' }
            ['requiredJobsGrades'] = nil, -- nil or grade tables example { 2, 3, 4},
            ['requiredLicense'] = nil     -- or example 'itemname'
        },
    -- Ammunation Locations

    -- Weedshop Locations
    ['weedshop'] = {
        ['label'] = 'Smoke On The Water',
        ['coords'] = vector4(-527.5812, 49.7370, 44.6261, 174.8936),
        ['ped'] = 'a_m_y_hippy_01', -- or false
        ['scenario'] = 'WORLD_HUMAN_AA_SMOKE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-cannabis',
        ['targetLabel'] = 'Open Weed Shop',
        ['products'] = Config.Products['weedshop'],
        ['showblip'] = true,
        ['blipsprite'] = 140,
        ['blipscale'] = 0.6,
        ['blipcolor'] = 2,
        ['delivery'] = vector4(-1162.13, -1568.57, 4.39, 328.52),
        ['distance'] = 2.0,
        ['account'] = 'money',
        ['requiredJobs'] = nil,       -- nil or example { 'police', 'ambulance' }
        ['requiredJobsGrades'] = nil, -- nil or grade tables example { 2, 3, 4},
        ['requiredLicense'] = nil     -- or example 'itemname'
    },
    -- Sea Word Locations
    ['seaword'] = {
        ['label'] = 'Sea Word',
        ['coords'] = vector4(-1687.03, -1072.18, 13.15, 52.93),
        ['ped'] = 'a_m_y_beach_01', -- or false
        ['scenario'] = 'WORLD_HUMAN_STAND_IMPATIENT',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-fish',
        ['targetLabel'] = 'Sea Word',
        ['products'] = Config.Products['gearshop'],
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.6,
        ['blipcolor'] = 2,
        ['delivery'] = vector4(-1674.18, -1073.7, 13.15, 333.56),
        ['distance'] = 2.0,
        ['account'] = 'money',
        ['requiredJobs'] = nil,       -- nil or example { 'police', 'ambulance' }
        ['requiredJobsGrades'] = nil, -- nil or grade tables example { 2, 3, 4},
        ['requiredLicense'] = nil     -- or example 'itemname'
    },
    -- Leisure Shop Locations
    ['leisureshop'] = {
        ['label'] = 'Leisure Shop',
        ['coords'] = vector4(-1505.91, 1511.95, 115.29, 257.13),
        ['ped'] = 'a_m_y_beach_01', -- or false
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE_CLUBHOUSE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-leaf',
        ['targetLabel'] = 'Open Leisure Shop',
        ['products'] = Config.Products['leisureshop'],
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.8,
        ['blipcolor'] = 2,
        ['delivery'] = vector4(-1507.64, 1505.52, 115.29, 262.2),
        ['distance'] = 2.0,
        ['account'] = 'money',
        ['requiredJobs'] = nil,       -- nil or example { 'police', 'ambulance' }
        ['requiredJobsGrades'] = nil, -- nil or grade tables example { 2, 3, 4},
        ['requiredLicense'] = nil     -- or example 'itemname' -- or example 'itemname'
    },
}
