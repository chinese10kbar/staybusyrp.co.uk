Config = Config or {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true' -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget true` to use this and just that from true to false or the other way around)

Config.AvailableJobs = {                                     -- Only used when not using qb-jobs.
    ['trucker'] = { ['label'] = 'Trucker', ['isManaged'] = false },
    ['taxi'] = { ['label'] = 'Taxi', ['isManaged'] = false },
  --  ['tow'] = { ['label'] = 'Tow Truck', ['isManaged'] = false },
  --  ['reporter'] = { ['label'] = 'News Reporter', ['isManaged'] = false },
  --  ['garbage'] = { ['label'] = 'Garbage Collector', ['isManaged'] = false },
    ['bus'] = { ['label'] = 'Bus Driver', ['isManaged'] = false },
    ['builder'] = { ['label'] = 'Construction', ['isManaged'] = false },
    ['electrician'] = { ['label'] = 'Electrician', ['isManaged'] = false },
 --   ['hotdog'] = { ['label'] = 'Hot Dog Stand', ['isManaged'] = false },
    ['deliveroo'] = { ['label'] = 'Deliveroo', ['isManaged'] = false },
    ['uber'] = { ['label'] = 'Uber Driver', ['isManaged'] = false },
    ['unemployed'] = { ['label'] = 'Unemployed', ['isManaged'] = false },
    ['lumber'] = { ['label'] = 'lumber', ['isManaged'] = false },

}

Config.Cityhalls = {
    { -- Cityhall 1
        coords = vec3(-363.75, -248.95, 36.08),
        showBlip = true,
        blipData = {
            sprite = 487,
            display = 4,
            scale = 0.65,
            colour = 0,
            title = 'City Services'
        },
        licenses = {
            ['id_card'] = {
                label = 'ID Card',
                cost = 80,
            },
            ['driver_license'] = {
                label = 'Driver License',
                cost = 150,
                metadata = 'driver'
            },
           -- ['weaponlicense'] = {
          --      label = 'Weapon License',
          --      cost = 50,
          --      metadata = 'weapon'
          --  },
        }
    },
}

Config.DrivingSchools = {
    { -- Driving School 1
        coords = vec3(240.3, -1379.89, 33.74),
        showBlip = true,
        blipData = {
            sprite = 225,
            display = 4,
            scale = 0.65,
            colour = 3,
            title = 'Driving School'
        },
        instructors = {
            'DJD56142',
            'DXT09752',
            'SRI85140',
        }
    },
}

Config.Peds = {
    -- Cityhall Ped
    {
        model = 'a_m_m_hasjew_01',
        coords = vector4(-364.43041992188, -249.2684173584, 35.13516998291, 60.740333557129),
        scenario = 'WORLD_HUMAN_STAND_MOBILE',
        cityhall = true,
        zoneOptions = { -- Used for when UseTarget is false
            length = 3.0,
            width = 3.0,
            debugPoly = false
        }
    },
    -- Driving School Ped
    {
        model = 'a_m_m_eastsa_02',
        coords = vec4(240.91, -1379.2, 32.74, 138.96),
        scenario = 'WORLD_HUMAN_STAND_MOBILE',
        drivingschool = true,
        zoneOptions = { -- Used for when UseTarget is false
            length = 3.0,
            width = 3.0
        }
    }
}
