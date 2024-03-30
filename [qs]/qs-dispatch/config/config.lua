Config = {}

Config.Framework = GetResourceState('sb-core') == 'started' and 'qb' or GetResourceState('es_extended') == 'started' and 'esx' or 'esx'                                                                                                                       -- Place here the framework either esx or qb
Config.Language = 'en'                                                                                                                        -- Set the language in which you want to have the script [en, en].
Config.Debug = false                                                                                                         -- Enable debug mode by setting this to true (Multiple console prints showing debug information and enabling color shapes for zones). -- true make the script very slow
Config.AllowImages = true                                                                                                   -- this option can delay the alert
Config.DiscordWebHook = 'https://discord.com/api/webhooks/1220577122368884736/VgbhVoc1Wdo3VeLqr426ajRvk7Hw9ooQ_hC4CB66PuHbn623fXX2P1L2J-DohC2YlTW4' -- Discord webhook to upload new images
Config.vehiclesTable = Config.Framework == "esx" and 'owned_vehicles' or 'player_vehicles'                                                                                                       -- Table name for vehicles
Config.useLogo = false                                                                                                       -- Use logo in the Dispatch
Config.plateImage = 'https://www.quasar-store.com/static/5012-AT_6_x_12.png'
Config.logoURL = 'https://www.quasar-store.com/static/media/logo192.png'                                                                     -- or false if you dont want use logo
Config.useVehicleIconsInDispatchLargueMap = false                                                                           -- if you set it to true the Dispatch icons for the people will be the vehicle icons instead of the player icons (Common blip map)



Config.InventorySystem = "qs-inventory" -- sb-inventory or qs-inventory or esx-default you can select ox-inventory but this is not fully tested

local function getHouses()
    local qsHousesHas = GetResourceState('qs-housing') == 'started'
    local qbHousesHas = GetResourceState('sb-houses') == 'started'
    if qsHousesHas then
        return 'qs-housing'
    elseif qbHousesHas then
        return 'sb-houses'
    else
        return 'default'
    end
end

Config.Housing = getHouses() -- qs-housing
Config.voice = 'pma-voice' -- pma-voice or saltychat

--[[
    Billing configuration, choose between the options that we bring by default
    or configure more in client/custom/billing/*.lua.

    By default choose:
        'qs-billing' Buy Now in https://www.quasar-store.com
        'esx_billing' - https://github.com/esx-framework/esx_billing
        'okokBilling' - https://okok.tebex.io/package/5246431
        'jim-payments' - https://github.com/jimathy/jim-payments (Not fully compatible, prefer use other billing systems or disable billing in this script (Config.showBillsInMDT = false))
        'jaksam-billing-ui' - JAKSAM IN TEBEX
        'codeM-billing' - codeM IN TEBEX
]]

Config.Billing = 'okokBilling'
Config.showBillsInMDT = true -- configure your billing system in server/custom/misc/players.lua (Edit getBills function) prefer turn false if you using jim-payments

--[[
    vehicles configuration, choose between the options that we bring by default
    or configure more in server/custom/vehicles/*.lua.

    By default choose:
        'esx_garages'
        'jg-advancedgarages'
        'qb_garages'
        'qs-garages'
        'qs-advancedgarages'
]]

Config.VehicleGarages = 'qb_garages'

Config.Keys = {
    --Basic keys
    ["OpenLargue"] = "O",
    ["OpenSmall"] = "K",
    ["MoveSmall"] = "U"
}

Config.MoveRight = 'RIGHT' --Key to scroll right through the notifications on the small UI. (RIGHT ARROW default)
Config.MoveLeft = 'LEFT'   --Key to scroll left through the notifications on the small UI. (LEFT ARROW default)
Config.Respond = 'J'       --Key to respond/unrespond on the small UI. (G default).


Config.Radar = {
    enabled = true,
    needVehicleInWhitelist = true, -- need vehicle in whitelist to use radar
    jobsAllowedToUseRadar = {       -- Jobs allowed to use the radar
        "police"
    },
    vehiclesWhitelist = {
        "rpPolice1",
        "rpPolice2",
        "rpPolice3",
        "rpPolice4",
        "rpPolice5",
        "rpPolice6",
        "rppolice7",
        "rpPolice8",
        "rpPolice9",
        "rpPolice10",
        "rpPolice11",
        "rpPolice12",
        "rpPolice13",
        "rpPolice14",
        "rpPolice15",
        "rpPolice16",
        "rpPolice17",
        "rpPoliceB1",
        "rpPoliceB2",
        "rpPoliceR1",
        "rpPoliceR2",
        "rpPoliceUC1",
        "rpPoliceUC2",
        "rpPoliceUC3",
        "rpPoliceUC4",
        "rpPoliceUC5",
        "rpPoliceUC6",
        "rpPoliceUC7",
        "rpPoliceUC8",
        "rpPoliceUC9",
        "rpPoliceUC10",
        "rpPoliceUC11",
        "rpPoliceUC12",
        "sheriff2",
    
        "rpG68",
        "rpG61",
        "rpG64",
    
        "rpRanger1",
        "rpRanger2",
        "rpRanger3",
        "rpRanger4",
    
        "ambulance",
        "rpNHS1",
        "rpNHS2",
        "rpNHS3",
        "rpNHS4",
        "rpNHS5",
        "rpNHS6",
        "rpNHS7",
        "rpNHS8",
        "rpNHS9",
        "rpNHS10",
    
        "rpFire1",
        "rpFire2",
        "rpFire3",
        "firetruk"
    }
}


Config.DefaultSpeedLimit = 100 -- radar freeze if the vehicle > this velocity
Config.TimeToFreeze = 2000

Config.JobsAllowed = { -- Jobs allowed to use the Dispatch
    "police",
    "mechanic",
    "ambulance"
}

Config.PlayerLocationTick = 5 -- The time in seconds it takes to update the player's location (preferable not to touch).

--[[
    WARNING: IF YOU REDUCE THE TIME OF THE PLAYER LOCATION TICK, THE DISPATCH WILL BE MORE SLOW AND WILL BE GENERATE CRASHES TO YOUR PLAYERS
    EVERY RECOMENDED USE THE PATREON FIVEM AND ACTIVATE THE ONESYNC INFINITY
]]

Config.ShowOwnBlip = true         -- Show your own blip on the map
Config.JobsBlips = {              -- Blips for players depending on their job
    ['police'] = {                --JOB
        show = true,              -- Enable or disable
        color = 38,               -- Color
        sprite = {
            ['walking'] = 1,      -- Sprite
            ['automobile'] = 225, -- sprite
            ['bike'] = 559,       -- sprite
            ['boat'] = 404,       -- sprite
            ['heli'] = 422,       -- sprite
            ['plane'] = 307,      -- sprite
        },
        showJobs = {
            'ambulance' -- need Exist Blip config in this section
        },
        scale = 1.0,    -- Scale
        showConeOfView = true,
    },
    ['ambulance'] = {             --JOB
        show = true,              -- Enable or disable
        color = 66,               -- Color
        sprite = {
            ['walking'] = 1,      -- Sprite
            ['automobile'] = 225, -- sprite
            ['bike'] = 559,       -- sprite
            ['boat'] = 404,       -- sprite
            ['heli'] = 422,       -- sprite
            ['plane'] = 307,      -- sprite
        },
        showJobs = {
            'police' -- need Exist Blip config in this section
        },
        scale = 1.0, -- Scale
        showConeOfView = false,
    },
    ['mechanic'] = {              --JOB
        show = true,              -- Enable or disable
        color = 43,               -- Color
        sprite = {
            ['walking'] = 1,      -- Sprite
            ['automobile'] = 225, -- sprite
            ['bike'] = 559,       -- sprite
            ['boat'] = 404,       -- sprite
            ['heli'] = 422,       -- sprite
            ['plane'] = 307,      -- sprite
        },
        showJobs = {
            -- 'police' -- cant view other job blips
        },
        scale = 1.0, -- Scale
        showConeOfView = false,
    },
}

Config.Commands = {
    ["OpenLargue"] = "dispatch",                 -- prefer dont touch this
    ["OpenSmall"] = "smalldispatch",             -- prefer dont touch this
    ["MoveSmall"] = "movedispatchcomps",         -- Command to move small dispatch
    ["DisableSpeedRadar"] = 'disablespeedradar', -- Command to disable speed radar
    ["OpenMdt"] = 'openmdt'                      -- Command to open MDT
}

-- Config.JobsAllowedToMDT = { -- Jobs allowed to use police MDT
--     "police",
--     "mechanic",
--     "ambulance"
-- }

Config.NeedItemForMDT = false -- Use item for open MDT
Config.MDTItemName = 'mdt'    -- Item name for open MDT

Config.MDT = {
    newMdt = true,       -- if you want use the new mdt
    JobsAllowedToMDT = { -- Jobs allowed to use police MDT
        ["police"] = {
            gradesAllowedToEdit = {
                [0] = true,
                [1] = true,
                [2] = true,
                [3] = true,
                [4] = true,
                [5] = true,
                [6] = true,
                [7] = true,
                [8] = true,
            },
            categoryes = {
                ['citizens'] = {
                    enabled = true,
                    CanManageLicences = true,
                    CanManageTags = true,
                    CanViewVehicles = true,
                    CanViewHouses = true
                },
                ['incidents'] = {
                    enabled = true
                },
                ['bolos'] = {
                    enabled = true
                }
            }
        },
        ["mechanic"] = {
            gradesAllowedToEdit = {
                [4] = true,
                ['boss'] = true
            },
            categoryes = {
                ['citizens'] = {
                    enabled = true,
                    CanManageLicences = false,
                    CanManageTags = false,
                    CanViewVehicles = false,
                    CanViewHouses = false
                },
                ['incidents'] = {
                    enabled = true
                },
                ['bolos'] = {
                    enabled = true
                }
            }
        },
        ["ambulance"] = {
            gradesAllowedToEdit = {
                [3] = true,
                [4] = true,
                ['chief_doctor'] = true,
                ['boss'] = true
            },
            categoryes = {
                ['citizens'] = {
                    enabled = true,
                    CanManageLicences = false,
                    CanManageTags = false,
                    CanViewVehicles = false,
                    CanViewHouses = false
                },
                ['incidents'] = {
                    enabled = true
                },
                ['bolos'] = {
                    enabled = true
                }
            }
        }
    }
}

Config.Dispatch = {
    EnabledRadios = true,
    ['police'] = {
        DefaultChannel = 10, -- Default channel for the police
        Groups = {
            {
                id = 1,
                name = "TAC 1",
                description = "TAC 1",
                radiochannel = 11,
            },
            {
                id = 2,
                name = "TAC 2",
                description = "TAC 2",
                radiochannel = 12,
            },
            {
                id = 3,
                name = "TAC 3",
                description = "TAC 3",
                radiochannel = 13,
            },
            {
                id = 4,
                name = "TAC 4",
                description = "TAC 4",
                radiochannel = 14,
            },
            {
                id = 5,
                name = "TAC 5",
                description = "TAC 5",
                radiochannel = 15,
            },
            {
                id = 6,
                name = "Patrol 1",
                description = "Patrol 1",
                radiochannel = 16,
            },
            {
                id = 7,
                name = "Patrol 2",
                description = "Patrol 2",
                radiochannel = 17,
            },
            {
                id = 8,
                name = "Patrol 3",
                description = "Patrol 3",
                radiochannel = 18,
            },
            {
                id = 9,
                name = "Patrol 4",
                description = "Patrol 4",
                radiochannel = 19,
            },
            {
                id = 10,
                name = "Patrol 5",
                description = "Patrol 5",
                radiochannel = 20,
            },
            {
                id = 11,
                name = "Patrol 6",
                description = "Patrol 6",
                radiochannel = 21,
            },
            {
                id = 12,
                name = "Patrol 7",
                description = "Patrol 7",
                radiochannel = 22,
            },
            {
                id = 13,
                name = "Patrol 8",
                description = "Patrol 8",
                radiochannel = 23,
            },
            {
                id = 14,
                name = "Patrol 9",
                description = "Patrol 9",
                radiochannel = 24,
            },
            {
                id = 15,
                name = "Patrol 10",
                description = "Patrol 10",
                radiochannel = 25,
            },
            {
                id = 16,
                name = "Patrol 11",
                description = "Patrol 11",
                radiochannel = 26,
            },
            {
                id = 17,
                name = "Patrol 12",
                description = "Patrol 12",
                radiochannel = 27,
            },
            {
                id = 18,
                name = "Patrol 13",
                description = "Patrol 13",
                radiochannel = 28,
            },
            {
                id = 19,
                name = "Patrol 14",
                description = "Patrol 14",
                radiochannel = 29,
            },
            {
                id = 20,
                name = "Patrol 15",
                description = "Patrol 15",
                radiochannel = 30,
            },
            {
                id = 21,
                name = "Patrol 16",
                description = "Patrol 16",
                radiochannel = 31,
            },
            {
                id = 22,
                name = "Patrol 17",
                description = "Patrol 17",
                radiochannel = 32,
            },
            {
                id = 23,
                name = "Patrol 18",
                description = "Patrol 18",
                radiochannel = 33,
            },
            {
                id = 24,
                name = "Patrol 19",
                description = "Patrol 19",
                radiochannel = 34,
            }
        }
    },
    {
        ['ambulance'] = {
            DefaultChannel = 35,
            Groups = {
                {
                    id = 1,
                    name = "H RNK",
                    description = "H RNK",
                    radiochannel = 36,
                },
                {
                    id = 2,
                    name = "Hospital",
                    description = "Hospital",
                    radiochannel = 37,
                },
                {
                    id = 3,
                    name = "Patroll",
                    description = "Patroll",
                    radiochannel = 38,
                }
            }
        }
    }
}


Config.Penitencial = {
    -- ONLY WORK IF YOU ARE USING THE OLD MDT Config.MDT.newMdt = false
    keyForSendToJail = 'E',
    JobsAllowedToSendToJail = {
        "police",
        -- "fbi"
    },
    TimeToRemoveCodes = {
        [1] = 1,  -- remove is out of camera view past 3 minutes
        [2] = 5,  -- remove is out of camera view past 5 minutes
        [3] = 10, -- remove is out of camera view past 10 minutes
        [4] = 15, -- remove is out of camera view past 15 minutes
        [5] = 20, -- remove is out of camera view past 20 minutes
        [6] = 25, -- remove is out of camera view past 25 minutes
    },
    IlegalItems = {
        'weapon_pistol',
        'pistol_ammo'
    },
    jai = true,
    -- AbleToSelectWhetherToPardonJail = true,
    -- CanSendToJailIfNotInPoint = false,
    SendToJailPoints = {
        {
            title = 'Mission Row PD',
            coords = vector3(460.0216, -1001.5779, 24.9149),
        },
        {
            title = 'Mission Row PD',
            coords = vector3(459.1117, -997.9485, 24.9149),
        },
        {
            title = 'Mission Row PD',
            coords = vector3(460.0694, -994.2761, 24.9149),
        }
    },
    Jail = {
        name = 'Jail of paleto',
        coords = vector3(1691.7264, 2582.1084, 45.5648),
        radius = 150,
        spawnPoints = { -- sure this points is inside the zone
            vector4(1678.5844, 2541.4470, 45.5645, 267.97),
            vector4(1678.5844, 2541.4470, 45.5645, 267.97),
            vector4(1678.5844, 2541.4470, 45.5645, 267.97)
        },
        exitPoints = {
            vector4(1850.7671, 2586.0156, 45.6720, 274.4039)
        },
        ReturnToJailIfScaped = false, -- if this is true the player will return to jail if he escapes or if false the player will be free but the officers receive a notification seted after
        onEscaped = function(playerId)
            exports['qs-dispatch']:GetPlayerInfo(playerId, function(playerData)
                if (not playerData) then
                    ErrorPrint("Error getting player data")
                    return
                end
                exports['qs-dispatch']:GetSSURL(playerId, function(screenshot)
                    TriggerEvent('qs-dispatch:server:CreateDispatchCall', {
                        job = { 'police', 'sheriff', 'traffic', 'patrol' },
                        callLocation = playerData.coords,
                        callCode = { code = 'Escaped prisoner', snippet = 'Prision' },
                        message = "A" ..
                            playerData.sex ..
                            " prisoner has escaped from the " .. Config.Penitencial.Jail.name .. " prison",
                        flashes = true,
                        image = screenshot or nil,
                        blip = {
                            sprite = 137,
                            scale = 1.5,
                            colour = 1,
                            flashes = true,
                            text = 'Escaped Prisoner',
                            time = (20 * 1000), --20 secs
                        }
                    })
                end)
            end)
        end
    },
}

Config.VelocityRadar = { -- Velocity Radar Config
    enabled = true,      -- Enable velocity Radars in the map
    activateFXFlash = true,
    sendDirectTheBill = true, -- Send direct the bill to the infractor No remove the money from the account but the player will receive a bill
    account = "bank",    -- Exceeding the limit will remove the money from this account. if you put bill the player will receive a bill (bill, money, bank) Money and bank Dont send the money to the account of the society
    -- if the player does not have enough money in the account, the player will receive a bill
    amount = 1200,
    useMph = false,
    onDispatchCall = function() -- This function is called when the radar sends the dispatch signal. (you can remove it if you prefer)
        local playerData = exports['qs-dispatch']:GetPlayerInfo()
        DebugPrint('onDispatchCall', playerData)
        exports['qs-dispatch']:getSSURL(function(image)
            DebugPrint('image', image)
            TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', {
                job = { 'police', 'sheriff', 'traffic', 'patrol' },
                callLocation = playerData.coords,
                callCode = { code = 'Hight Speed', snippet = 'Vehicle' },
                message = 'A vehicle model ' ..
                    playerData.vehicle_label ..
                    ' with license plate ' ..
                    playerData.vehicle_plate ..
                    ' of color ' .. playerData.vehicle_colour .. ' is traveling at ' .. playerData.speed .. ' km/h',
                flashes = false,
                image = image or nil,
                blip = {
                    sprite = 488,
                    scale = 1.5,
                    colour = 1,
                    flashes = true,
                    text = 'Hight Speed',
                    time = (20 * 1000), --20 secs
                }
            })
        end)
    end,
    onHistoryToMDT = function(zone, kmh, amount)
        --[[
            Hi dear customer, this fragment use our MDT integrated system, you can place here your Trigger server event or client export to add content to your MDT
        ]]
        exports['qs-dispatch']:getSSURL(function(image)
            local playerData = exports["qs-dispatch"]:GetPlayerInfo()

            TriggerServerCallback("qs-dispatch:server:setVehicleDataRecord", function(resp)
                if resp then
                    DebugPrint("BOLO SUCCESS")
                else
                    DebugPrint("BOLO ERROR")
                end
            end, {
                type = "infraction",
                plate = playerData.vehicle_plate,
                zone = zone.label,
                data = {
                    message = string.format(Lang("SPEED_LIMIT_MESSAGE"), zone.label or "Not concluse",
                        zone.velocity or " --- ", math.floor(math.abs(kmh or 0)), amount),
                    job = 'police',
                    data = {
                        { key = "Model", value = playerData.vehicle_label },
                        { key = "Plate", value = playerData.vehicle_plate },
                        { key = "Color", value = playerData.vehicle_colour },
                        { key = "Speed", value = math.floor(math.abs(kmh or 0)) .. " km/h" },
                        { key = "Zone",  value = zone.label or "Not concluse" },
                        { key = "Limit", value = getFirstLimit(zone.velocityRanges) or kmh },
                        { key = "Fine",  value = amount .. "£" },
                        { key = "Image", value = image or 'No image available' }
                    }
                }
            })
        end)
    end,
    ignoredjobs = { -- Jobs that the radar will ignore
        -- "police",
        -- "ambulance"
    },
    zones = {                 -- Zones
        [1] = {
            label = "Zone 1", -- Zone Label
            velocityRanges = {
                { limitFrom = 105, price = 8500 },
                { limitFrom = 200, price = 11000 }          -- The last one is left in nil to make it clear that this is to infinity, that is, for example, from 80 (km/h | Mph) onwards. IF limitTo is left at nil the following will not be counted (no other value can be nil ONLY limitTo can be)
            },
            coords = vector3(365.8156, 134.4366, 103.0974), -- Radar coordinates
            width = 30,                                     -- Radar width (radius)
            beforeEnterInZoneAlert = true,                  -- Alerting before entering the zone?
            beforeEnterInZoneAlertMargin = 40,              -- Margin before the warning zone
            autoBill = true,                                -- Collect fine?
            notifyInfractor = true,                         -- false = no notify fot the infractor
            sendAlertToPolice = true,                       -- Send dispatch signal to police?
            sendHistoryToMDT = true,                        -- send to MDT data record if vehicle exist
            blip = {                                        -- Blip?
                enabled = true,                             -- Blip?
                color = 3,                                  -- Blip color
                sprite = 184,                               -- Blip sprite
                scale = 0.8,                                -- Blip scale
                text = "Velocity Radar"                     -- Blip title
            }
        },
        [2] = {
            label = "Zone 2",
            velocityRanges = {
                { limitFrom = 105, price = 8500 },
                { limitFrom = 200, price = 11000 }
            },
            coords = vector3(222, 320, 0),
            width = 30,
            beforeEnterInZoneAlert = true,
            beforeEnterInZoneAlertMargin = 40,
            autoBill = true,
            notifyInfractor = true, -- false = no notify fot the infractor
            sendAlertToPolice = true,
            sendHistoryToMDT = true,
            blip = {
                enabled = true,
                color = 3,
                sprite = 184,
                scale = 0.8,
                text = "Velocity Radar"
            }
        },
        [3] = {
            label = "Zone 3",
            velocityRanges = {
                { limitFrom = 105, price = 8500 },
                { limitFrom = 200, price = 11000 }
            },
            coords = vector3(1706.6511, 1497.8977, 84.1166),
            width = 40,
            beforeEnterInZoneAlert = true,
            beforeEnterInZoneAlertMargin = 80,
            autoBill = true,
            notifyInfractor = true, -- false = no notify fot the infractor
            sendAlertToPolice = true,
            sendHistoryToMDT = true,
            blip = {
                enabled = true,
                color = 3,
                sprite = 184,
                scale = 0.8,
                text = "Velocity Radar"
            }
        }
    }
}

--                _____ _    _  ____ _______ _____ _   _  _____            _      ______ _____ _______ _____   __  __  ______      ________ _____    _______ ____        _____  _      _____ 
--               / ____| |  | |/ __ \__   __|_   _| \ | |/ ____|     /\   | |    |  ____|  __ \__   __/ ____| |  \/  |/ __ \ \    / /  ____|  __ \  |__   __/ __ \      |  __ \| |    / ____|
--             | (___ | |__| | |  | | | |    | | |  \| | |  __     /  \  | |    | |__  | |__) | | | | (___   | \  / | |  | \ \  / /| |__  | |  | |    | | | |  | |     | |  | | |   | |     
--             \___ \|  __  | |  | | | |    | | | . ` | | |_ |   / /\ \ | |    |  __| |  _  /  | |  \___ \  | |\/| | |  | |\ \/ / |  __| | |  | |    | | | |  | |     | |  | | |   | |     
--            ____) | |  | | |__| | | |   _| |_| |\  | |__| |  / ____ \| |____| |____| | \ \  | |  ____) | | |  | | |__| | \  /  | |____| |__| |    | | | |__| |     | |__| | |___| |____ 
--          |_____/|_|  |_|\____/  |_|  |_____|_| \_|\_____| /_/    \_\______|______|_|  \_\ |_| |_____/  |_|  |_|\____/   \/   |______|_____/     |_|  \____/      |_____/|______\_____|


-- SHOTING ZONES MOVED AND REMASTERED TO THE NEW DLC


Config.DispatchBodyCamZones = {
    enabled = true,
    jobsAllowed = {
        "police",
        "ambulance"
    },                    -- Jobs allowed to use bodycam
    needIsInZone = false, -- need be in zone to use bodycam
    zones = {
        [1] = {
            label = "Zone 1",
            coords = vector3(456.6222, -985.9254, 30.6832),
            width = 30,
        },
        [2] = {
            label = 'Test zone',
            coords = vector3(339.9770, -1397.2855, 32.5092),
            width = 30
        }
    }
}

Config.CCTV = {
    enabled = true,
    jobsAllowed = {
        "police",
    }
}

Config.CameraModels = { -- this models will be used in the shoting zones and the convict detection on the map...
    -- if you need more detects you can use all type of props showed in this web https://gta-objects.xyz/objects
    GetHashKey('prop_cctv_cam_01a'),
    GetHashKey('prop_cctv_cam_01b'),
    GetHashKey('prop_cctv_cam_02a'),
    GetHashKey('prop_cctv_cam_03a'),
    GetHashKey('prop_cctv_cam_04a'),
    GetHashKey('prop_cctv_cam_04b'),
    GetHashKey('prop_cctv_cam_04c'),
    GetHashKey('prop_cctv_cam_05a'),
    GetHashKey('prop_cctv_cam_06a'),
    GetHashKey('prop_cctv_cam_07a'),
    GetHashKey('prop_snow_cam_03a'),
    GetHashKey('prop_snow_cam_03'),
    GetHashKey('police3'), -- its an vehicle, when the player is near to this model of vehicle the auto detect of cameras can detect a suspicius player
    GetHashKey('polmav'),  -- its an vehicle, when the player is near to this model of vehicle the auto detect of cameras can detect a suspicius player
}
