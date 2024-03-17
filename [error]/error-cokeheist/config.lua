Config = {}

Config.NumberOfCircles = math.random(2,3)
Config.MSMinigame = math.random(8,20)

Config.MinimumCokeJobPolice = 0 -- This Is Under Maintainance Dont Use

Config.Cooldown = 10 --- Mission Cooldown To Start Again
Config.RunCost = 2500 --- Amount Of Money Need To Start

Config.Payout = math.random(3000, 4000) -- How Much Will You Rechived After Mission
Config.Item = "coke_brick" -- The item you receive from the job
Config.CokeChance = 1000 -- Percentage chance to get Coke
Config.CokeAmount = 5 -- Amount of Coke you recieve

Config.SpecialRewardChance = 300 -- Rare Item Percentage
Config.SpecialItem = "weapon_de" -- Put a rare item here which will have 0.1% chance of being given on the run.

Config.NPCLOCATION = vector4(2570.78, 4668.08, 34.08, 137.29) -- NPC Location For Start
Config.Itemtime = 1000 * 5 -- 5 minutes (time for the case to open after you collect it)
Config.Carspawn = vector3(1447.98, 6554.66, 14.95) -- Spawn location for vehicle (Vehicle For Map Blips...)

--Processing
Config.CokeProcessing = vector3(1086.27, -3194.69, -38.99) -- Coke Processing Location
Config.Heading = 180 --Processing Heading
Config.Minz = -43.19
Config.Maxz = -39.19
Config.RequiredItem = "coke_brick" -- Required Item To Process
Config.AfterProcess = "cokebaggy" -- You Rechived After Process

Config['cokeguards'] = {
    ['npcguards'] = {
        { coords = vector3(1462.94, 6564.58, 13.46), heading = 118.97, model = 'csb_mweather'},
        { coords = vector3(1455.43, 6578.44, 12.5), heading = 178.95, model = 'csb_mweather'},
        { coords = vector3(1427.85, 6572.6, 18.05), heading = 178.95, model = 'csb_mweather'},
        { coords = vector3(1471.9, 6551.88, 14.0), heading = 188.3, model = 'csb_mweather'},
        { coords = vector3(1465.58, 6551.21, 14.03), heading = 188.3, model = 'csb_mweather'},
        { coords = vector3(1470.36, 6548.63, 19.92), heading = 162.82, model = 'csb_mweather'},
        { coords = vector3(1456.54, 6525.57, 17.84), heading = 189.59, model = 'csb_mweather'},
        { coords = vector3(1400.14, 6577.69, 15.16), heading = 226.68, model = 'csb_mweather'},
        { coords = vector3(1399.73, 6562.53, 17.1), heading = 236.85, model = 'csb_mweather'},
        { coords = vector3(1500.57, 6522.83, 20.05), heading = 113.63, model = 'csb_mweather'},
        { coords = vector3(1486.8, 6567.71, 8.84), heading = 122.11, model = 'csb_mweather'},
        { coords = vector3(1459.21, 6561.69, 13.87), heading = 78.9, model = 'csb_mweather'},
    },
}