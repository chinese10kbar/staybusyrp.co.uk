

  -- Config.outsideTemp = {20, 30}
  -- Config.outsideTempNight = {10, 20}
  -- Config.outsideLight = {20, 30}
  -- Config.outsideLightNight = {10, 20}
  -- Config.tempChangeTime = 60 -- Every 60 seconds the temp will change


Config = {
  debug = false, --## Debug mode will print out a lot of information to the console
  interactionType       = "target", --## target or dirk-menu 
  DistanceBetweenPlants = 1.0, -- How far apart do plants have to be? I guess this could stop exploitation
  PlantPotModel         = 'dirkdrugz_2',
  PlantRenderDistance   = 50.0, --## How far away before planits delete/spawn

  PlantModelSwapDistance = 0.05, --## Decrease if bug with multiple plants changing at once and increase if they dont change at all

  KeyInput = {
    Use          = {Key = 47, Label = "g"}, --## G Used for generic interactions
    Alt          = {Key = 49, Label = "f"}, --## F Used for cancelling interactions usually
    DestroyPlant = {Key = 304, Label = "h"}, --## H used for destroying plants
  },

  --## Pickup Options
  Pickup = { --## If a pot is picked up then it will remove all contents and just give you back a plantpot
    Everyone = true, --## Can everyone pickup a plant pot?
    Cops     = true, --## Can cops pick up pots?
    Owner    = true, --## If only the person who placed the pot can pick it up
  },

  PlantUpdateTime = 5, --## Plants will update every 5 minutes



  --## NEW TEMPERATURE SYSTEM 28/01/2024
  outsideTemp       = {20, 30}, --## Outside temp range
  outsideTempNight  = {10, 20}, --## Outside temp range at night
  outsideLight      = {60, 85}, --## Outside light range
  outsideLightNight = {10, 20}, --## Outside light range at night
  tempChangeTime    = 320, --## Seconds
  insideTemp        = {20, 30}, --## Inside temp range
  insideTempNight   = {10, 20}, --## Inside temp range at night
  insideLight       = {20, 30}, --## Inside light range
  insideLightNight  = {10, 20}, --## Inside light range at night



  PoliceJobs = { --## Add all your police jobs or jobs you want to be able to destroy plants
    police = true,
    lspd   = true,
  },


  ----#### TRIMMING ####----
  BudTrimming     = true, --## If you use an untrimmed_bud it wil do an animation and trim the bud.
  BudTrimmingItem = 'scissors', --## The item you need in your inventory for this
  BudTrimAmount   = 1, --## How much bud you need to have before trimming, will return the same amount of trimmed_bud

  GrowingEquipment = {
    ['scissors'] = {
      ['name'] = 'scissors',
      ['label'] = 'Scissors',
      ['weight'] = 0,
      ['type'] = 'item',
      ['image'] = 'scissors.png',
      ['unique'] = false,
      ['useable'] = false,
      ['shouldClose'] = false,
      ['combinable'] = nil,
      ['description'] = 'Used to trim things'
    },


    --- PLANT POT ITEMS
    ['plantpot'] = {
      ['name'] = 'plantpot',
      ['label'] = 'Plant Pot',
      ['weight'] = 0,
      ['type'] = 'item',
      ['image'] = 'plantpot.png',
      ['unique'] = false,
      ['useable'] = true,
      ['shouldClose'] = true,
      ['combinable'] = nil,
      ['isPlantPot'] = true,
      ['description'] = 'Used to Plant Pot'
    },


    --- SOILS
    ['lowqualitysoil'] = {
      ['name'] = 'lowqualitysoil',
      ['label'] = 'Soil (LQ)',
      ['weight'] = 0,
      ['type'] = 'item',
      ['image'] = 'lowqualitysoil.png',
      ['unique'] = false,
      ['useable'] = false,
      ['shouldClose'] = false,
      ['combinable'] = nil,
      ['description'] = 'Soil for your plants',

      --## Use this if this should be able to be used on a plant
      ['uses'] = {
        IsSoil=true,
        Soil=30,
      },
    },

    ['hiqualitysoil'] = {
      ['name'] = 'hiqualitysoil',
      ['label'] = 'Soil (HQ)',
      ['weight'] = 0,
      ['type'] = 'item',
      ['image'] = 'hiqualitysoil.png',
      ['unique'] = false,
      ['useable'] = false,
      ['shouldClose'] = false,
      ['combinable'] = nil,
      ['description'] = 'Soil for your plants',

      --## Use this if this should be able to be used on a plant
      ['uses'] = {
        IsSoil=true,
        Soil=60,
      },
    },

    --- SOIL NUTRIENTS
    ['lowqualnutrients'] = {
      ['name'] = 'lowqualnutrients',
      ['label'] = 'Growing Nutrients (LQ)',
      ['weight'] = 0,
      ['type'] = 'item',
      ['image'] = 'lowqualnutrients.png',
      ['unique'] = false,
      ['useable'] = false,
      ['shouldClose'] = false,
      ['combinable'] = nil,
      ['description'] = 'Used to Boost your crops soil nutrients',

      --## Use this if this should be able to be used on a plant
      ['uses'] = {
        Soil=5,
      },
    },
    ['medqualnutrients'] = {
      ['name'] = 'medqualnutrients',
      ['label'] = 'Growing Nutrients (MQ)',
      ['weight'] = 0,
      ['type'] = 'item',
      ['image'] = 'medqualNutrients.png',
      ['unique'] = false,
      ['useable'] = false,
      ['shouldClose'] = false,
      ['combinable'] = nil,
      ['description'] = 'Used to Boost your crops soil nutrients',

      --## Use this if this should be able to be used on a plant
      ['uses'] = {
        Soil=10,
      },
    },
    ['hiqualnutrients'] = {
      ['name'] = 'hiqualnutrients',
      ['label'] = 'Growing Nutrients (HQ)',
      ['weight'] = 0,
      ['type'] = 'item',
      ['image'] = 'hiqualnutrients.png',
      ['unique'] = false,
      ['useable'] = false,
      ['shouldClose'] = false,
      ['combinable'] = nil,
      ['description'] = 'Used to Boost your crops soil nutrients',

      --## Use this if this should be able to be used on a plant
      ['uses'] = {
        Soil=15,
      },
    },

    -- WATERING CAN
    ['wateringcan'] = {
      ['name'] = 'wateringcan',
      ['label'] = 'Watering Can',
      ['weight'] = 0,
      ['type'] = 'item',
      ['image'] = 'wateringcan.png',
      ['unique'] = false,
      ['useable'] = false,
      ['shouldClose'] = false,
      ['combinable'] = nil,
      ['description'] = 'Used to water plants',
      ['remove'] = false,
      --## Use this if this should be able to be used on a plant
      ['uses'] = {
        Water=25,
      },
    },
  },
  
  -- UI STAT INFO WOULDNT TOUCH UNLESS SEMI SMERT

  StatSettings = {
    Stage = {
      Value   = 20,
      Icon    = 'fa-solid fa-percent',
      IconCol = 'black',
      BarCol  = 'white',
      Click   = false,
      Tip     = 'This will go to 100% when the grow has completed and we are ready to harvest',
    },
    Health = {
      Value   = 20,
      Icon    = 'fa-solid fa-suitcase-medical',
      IconCol = 'white',
      BarCol  = 'red',
      Click   = true,
      Tip     = 'The higher this is the better you can ensure your plant is in optimial conditions to increase/maintain health',
    },
    Water = {
      Value   = 20,
      Icon    = 'fa-solid fa-droplet',
      IconCol = 'white',
      BarCol  = 'blue',
      Click   = true,
      Tip     = 'Plants need to be kept hydrated please keep this as near to 100% as you can',
    },
    Light = {
      Value   = 20,
      Icon    = 'fa-solid fa-sun',
      IconCol = 'orange',
      BarCol  = 'yellow',
      Click   = false,
      Tip     = 'Plants will obviously need light in order to grow. Please provide this via the great sunshine or via artificial lighting.',
    },
    Temp = {
      Value   = 20,
      Icon    = 'fa-solid fa-temperature-three-quarters',
      IconCol = 'white',
      BarCol  = 'orange',
      Click   = false,
      Tip     = 'Certain strains of plant will need different minimum and maximum temperatures.',
    },
    Soil = {
      Value   = 20,
      Icon    = 'fa-solid fa-person-digging',
      IconCol = 'white',
      BarCol  = 'brown',
      Click   = true,
      Tip     = 'Certain strains will need a certain level of nutrients in the soil in order to grow. Please use quality base soil and top up with soil feed',
    },
  },

}

Core, Settings = exports['dirk-core']:getCore()
