Config = {}

Config.Language = "en"

Config.Debug = true

Config.RenderDistance = 100.0

Config.IgnoreGroups = false -- Doesn't scan people who can see scan results.

Config.ScannerLocations = {
    {
        location = vec3(365.58471679688,-1609.8415527344,28.292036056519),
        heading = 140.2734527587891,
        hideObject = false, -- Don't show the scanner prop (Useful for scanners already on the map).
    },
    {
        location = vec3(356.2782, -1588.7589, 22.8036),
        heading = 228.8944274902344,
        hideObject = false, -- Don't show the scanner prop (Useful for scanners already on the map).
    },
    {
        location = vec3(371.89437866211,-1591.4560546875,28.292030334473),
        heading = 139.63796997070312,
        hideObject = false, -- Don't show the scanner prop (Useful for scanners already on the map).
    },
    {
        location = vec3(351.07470703125,-1606.8995361328,22.803632736206),
        heading = 139.759033203125,
        hideObject = false, -- Don't show the scanner prop (Useful for scanners already on the map).
    },
    {
        location = vec3(1855.4650, 3683.4009, 33.3261),
        heading = 300.0000,
        hideObject = false, -- Don't show the scanner prop (Useful for scanners already on the map).
    },
    {
        location = vec3(1833.2311, 3678.5261, 33.3261),
        heading = 118.0000,
        hideObject = false, -- Don't show the scanner prop (Useful for scanners already on the map).
    }    
}

Config.MetalItems = { -- List of Detected Items
'WEAPON_KNIFE',
'weapon_katana',
'WEAPON_FLASHLIGHT',
'WEAPON_HAMMER',
'weapon_shiv',
'weapon_sledgehammer',
'weapon_karambit',
'weapon_keyboard',
'weapon_bfknife',
'weapon_urbanrbfknife',
'weapon_stainedrbfknife',
'weapon_slaughterbfknife',
'weapon_scorchedbfknife',
'weapon_safaribfknife',
'weapon_perforator',
'weapon_huntsmanknife',
'weapon_gutknife',
'weapon_goldenknife',
'weapon_forestbfknife',
'weapon_flipknife',
'weapon_fadebfknife',
'weapon_crimsonbfknife',
'weapon_chbfknife',
'weapon_bluebfknife',
'weapon_bayonetknife',
'weapon_awerp',
'weapon_glock18c',
'weapon_glock22',
'weapon_deagle',
'weapon_fnx45',
'weapon_m1911',
'weapon_glock20',
'weapon_glock19gen4',
'weapon_g17',
'weapon_pmxfm',
'weapon_mac10',
'weapon_miniuzi',
'weapon_mp5temp',
'weapon_m870',
'weapon_mk47fm',
'weapon_m6ic',
'weapon_scarsc',
'weapon_m4',
'weapon_ak47',
'weapon_ak74',
'weapon_aks74',
'weapon_groza',
'weapon_scarh',
'weapon_akm',
'weapon_ak47handmade',
}

Config.Scanner = {
    model = `ch_prop_ch_metal_detector_01a`,
    displayItems = true, -- Display all detected items found on the person, or just detect metal.
    failBeepCount = 8, -- Beeps for finding metal
    successBeepCount = 1, -- Beeps for not finding metal
    notifyDistance = 3.0, -- Display Text Distance
    flashDistance = 20.0, -- Object Flash Distance
    groups = { -- Groups that see the display text
        ["police"] = 0,
    },
    items = Config.MetalItems -- Items the scanner can detect
}

Config.Wand = {
    item = "metal_wand",
    model = `bv_scannerhand`,
    displayItems = false, -- Display all detected items found on the person, or just detect metal.
    failBeepCount = 8, -- Beeps for finding metal
    successBeepCount = 1, -- Beeps for not finding metal
    searchTime = 10000, -- Time for scanning
    boneID = 60309,
    offset = {
        pos = vec3(0.0, 0.0, 0.0),
        rot = vec3(0.0, -60.0, 180.0000),
    },
    animation = {"amb@world_human_security_shine_torch@male@idle_b", "idle_e"},
    --animation = {"missheist_agency2aig_4", "look_plan_a_worker2"},
    items = Config.MetalItems -- Items the scanner can detect
}
