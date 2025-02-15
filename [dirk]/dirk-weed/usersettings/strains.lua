Config.Strains = {
  ['Star Dawg'] = {
    -- GENERATION OF ITEMS
    GeneratedAffix     = 'stardawg', --## When the items get auto generated they will be autogenerated as -- accupulcogold_seed, accupulcogold_weed etc etc
    --[[
      This will generate GeneratedAffix_seed, GeneratedAffix_untrimmed_bud, GeneratedAffix_trimmed_bud, GeneratedAffix_leaf
    ]]
    StateUpdatePerTick = 25, --Under Ideal conditions the plants state will increase by this every PlantUpdateTime. Formula: (100/StateUpdatePerTick) * Config.PlantUpdateTime
    --## DISEASES
    DiseaseChance    = 10, --## Chance this plant will get a disease and potentially lose health
    DiseaseAmount    = 0.1, --## Percentage of health the disease will take 0.1 = 10%
    --## WATER SETTINGS
    WaterDrain       = 0.1, -- Every tick how much will the water drain 0.1 = 10%
    MinWater         = 10, -- Wont grow if you have less water than this
    --## LIGHT AND TEMP
    LightMin         = 30, --- Minimum amount of light before plant begins to  decrease in health. Increase this to make them use loads of lights I guess.
    TempMin          = 20, --- If the temperature goes below this the plant will stop growing and begin to decrease in health.
    TempMax          = 30, --- If the temperature goes above this the plant will stop growing and begin to  decrease in health.
    --## SOIL SETTINGS
    SoilDrainHarvest = 0.4, -- Upon harvesting the soil quality will reduce by 20%
    MinSoilQuality   = 20, -- Anything below this and the plant will not grow.
    --## TRIM SETTINGS
    TimeToTrim       = 5, --## Time to trim a bud of this strain.
    --## STRAIN INFO
    Info             = 'Made in the UK original Staw Dawg.It needs high temps between 20-30 and light spectum higher than 30%. Soil quality minimum should be 20%',
    --## REWARD ITEMS UPON HARVEST
    RewardItems      = {
      ['stardawg_untrimmed_bud'] = {
        Chance      = 100, --## Chance out of 100 you will get this item.
        HealthBased = false, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 286,
        Max = 600,
      },
      ['stardawg_leaf'] = {
        Chance      = 100,
        HealthBased = 300, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 5,
        Max = 10,
      },
      ['stardawg_seed'] = {
        Chance      = 5,
        HealthBased = 1, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 15,
        Max = 60,
      },
    },

     --## THERE ARE 3 STAGES TO A PLANT YOU CAN CHANGE THE MODEL FOR THESE STAGES
     Stages = {
      [1] = 'bkr_prop_weed_01_small_01a', -- Pot with little sprouter
      [2] = 'bkr_prop_weed_med_01a',    -- Pot with medium plant
      [3] = 'bkr_prop_weed_lrg_01b',    -- Pot wiht large plant
    },
  },

  ['Acapulco Gold'] = {
    -- GENERATION OF ITEMS
    GeneratedAffix     = 'acapulcogold', --## When the items get auto generated they will be autogenerated as -- accupulcogold_seed, accupulcogold_weed etc etc
    --[[
      This will generate GeneratedAffix_seed, GeneratedAffix_untrimmed_bud, GeneratedAffix_trimmed_bud, GeneratedAffix_leaf
    ]]
    StateUpdatePerTick = 10, --Under Ideal conditions the plants state will increase by this every PlantUpdateTime. Formula: (100/StateUpdatePerTick) * Config.PlantUpdateTime
    --## DISEASES
    DiseaseChance    = 10, --## Chance this plant will get a disease and potentially lose health
    DiseaseAmount    = 0.1, --## Percentage of health the disease will take 0.1 = 10%
    --## WATER SETTINGS
    WaterDrain       = 0.3, -- Every tick how much will the water drain 0.1 = 10%
    MinWater         = 35, -- Wont grow if you have less water than this
    --## LIGHT AND TEMP
    LightMin         = 40, --- Minimum amount of light before plant begins to  decrease in health. Increase this to make them use loads of lights I guess.
    TempMin          = 20, --- If the temperature goes below this the plant will stop growing and begin to decrease in health.
    TempMax          = 40, --- If the temperature goes above this the plant will stop growing and begin to  decrease in health.
    --## SOIL SETTINGS
    SoilDrainHarvest = 0.4, -- Upon harvesting the soil quality will reduce by 20%
    MinSoilQuality   = 20, -- Anything below this and the plant will not grow.
    --## TRIM SETTINGS
    TimeToTrim       = 9, --## Time to trim a bud of this strain.
    --## STRAIN INFO
    Info             = 'Straight from the Guerrero Mountains of Mexico Acapulco Gold is a legendary strain with high great terpine profile and a distinct golden hue.It needs high temps between 28-35 and light spectum higher than 40%. Soil quality minimum should be 20%',
    --## REWARD ITEMS UPON HARVEST
    RewardItems      = {
      ['acapulcogold_untrimmed_bud'] = {
        Chance      = 100, --## Chance out of 100 you will get this item.
        HealthBased = 1300, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 110,
        Max = 650,
      },
      ['acapulcogold_leaf'] = {
        Chance      = 100,
        HealthBased = 2000, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 5,
        Max = 10,
      },
      ['acapulcogold_seed'] = {
        Chance      = 30,
        HealthBased = 60, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 15,
        Max = 60,
      },
    },

    --## THERE ARE 3 STAGES TO A PLANT YOU CAN CHANGE THE MODEL FOR THESE STAGES
    Stages = {
      [1] = 'bkr_prop_weed_01_small_01a', -- Pot with little sprouter
      [2] = 'bkr_prop_weed_med_01a',    -- Pot with medium plant
      [3] = 'bkr_prop_weed_lrg_01b',    -- Pot wiht large plant
    },
  },
  ['Colombian Gold'] = {
    -- GENERATION OF ITEMS
    GeneratedAffix     = 'colombiangold', --## When the items get auto generated they will be autogenerated as -- accupulcogold_seed, accupulcogold_weed etc etc
    --[[
      This will generate GeneratedAffix_seed, GeneratedAffix_untrimmed_bud, GeneratedAffix_trimmed_bud, GeneratedAffix_leaf
    ]]
    StateUpdatePerTick = 10, --Under Ideal conditions the plants state will increase by this every PlantUpdateTime. Formula: (100/StateUpdatePerTick) * Config.PlantUpdateTime
    --## DISEASES
    DiseaseChance    = 10, --## Chance this plant will get a disease and potentially lose health
    DiseaseAmount    = 0.1, --## Percentage of health the disease will take 0.1 = 10%
    --## WATER SETTINGS
    WaterDrain       = 0.4, -- Every tick how much will the water drain 0.1 = 10%
    MinWater         = 25, -- Wont grow if you have less water than this
    --## LIGHT AND TEMP
    LightMin         = 35, --- Minimum amount of light before plant begins to  decrease in health. Increase this to make them use loads of lights I guess.
    TempMin          = 20, --- If the temperature goes below this the plant will stop growing and begin to decrease in health.
    TempMax          = 40, --- If the temperature goes above this the plant will stop growing and begin to  decrease in health.
    --## SOIL SETTINGS
    SoilDrainHarvest = 0.2, -- Upon harvesting the soil quality will reduce by 20%
    MinSoilQuality   = 35, -- Anything below this and the plant will not grow.
    --## TRIM SETTINGS
    TimeToTrim       = 8, --## Time to trim a bud of this strain.
    --## STRAIN INFO
    Info             = 'Colombian Gold AKA Santa Marta is a landrace strain from the Santa Marta mountains of Colombia.Growing in warm climate,it needs temps between 25-35 and a light spectrum higher than 35%. Soil quality minimum should be 30%',
    --## REWARD ITEMS UPON HARVEST
    RewardItems      = {
      ['colombiangold_untrimmed_bud'] = {
        Chance      = 100, --## Chance out of 100 you will get this item.
        HealthBased = 1200, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 97,
        Max = 700,
      },
      ['colombiangold_leaf'] = {
        Chance      = 100,
        HealthBased = 2000, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 5,
        Max = 10,
      },
      ['colombiangold_seed'] = {
        Chance      = 40,
        HealthBased = 45, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 5,
        Max = 45,
      },
    },

    --## THERE ARE 3 STAGES TO A PLANT YOU CAN CHANGE THE MODEL FOR THESE STAGES
    Stages = {
      [1] = 'bkr_prop_weed_01_small_01a', -- Pot with little sprouter
      [2] = 'bkr_prop_weed_med_01a',    -- Pot with medium plant
      [3] = 'bkr_prop_weed_lrg_01b',    -- Pot wiht large plant
    },
  },
  ['Pure Afghani'] = {
    -- GENERATION OF ITEMS
    GeneratedAffix     = 'pureafghani', --## When the items get auto generated they will be autogenerated as -- accupulcogold_seed, accupulcogold_weed etc etc
    --[[
      This will generate GeneratedAffix_seed, GeneratedAffix_untrimmed_bud, GeneratedAffix_trimmed_bud, GeneratedAffix_leaf
    ]]
    StateUpdatePerTick = 10, --Under Ideal conditions the plants state will increase by this every PlantUpdateTime. Formula: (100/StateUpdatePerTick) * Config.PlantUpdateTime
    --## DISEASES
    DiseaseChance    = 5, --## Chance this plant will get a disease and potentially lose health
    DiseaseAmount    = 0.1, --## Percentage of health the disease will take 0.1 = 10%
    --## WATER SETTINGS
    WaterDrain       = 0.2, -- Every tick how much will the water drain 0.1 = 10%
    MinWater         = 25, -- Wont grow if you have less water than this
    --## LIGHT AND TEMP
    LightMin         = 40, --- Minimum amount of light before plant begins to  decrease in health. Increase this to make them use loads of lights I guess.
    TempMin          = 15, --- If the temperature goes below this the plant will stop growing and begin to decrease in health.
    TempMax          = 32, --- If the temperature goes above this the plant will stop growing and begin to  decrease in health.
    --## SOIL SETTINGS
    SoilDrainHarvest = 0.2, -- Upon harvesting the soil quality will reduce by 20%
    MinSoilQuality   = 20, -- Anything below this and the plant will not grow.
    --## TRIM SETTINGS
    TimeToTrim       = 7, --## Time to trim a bud of this strain.
    --## STRAIN INFO
    Info             = 'Pure Afghani hails from the Hindu Kush mountain region on the border between Afghanistan and Pakistan.Heavy body effect and great earthy terpene profile. Temperatures should be kept 15-30 with a light spectrum of around 40%',
    --## REWARD ITEMS UPON HARVEST
    RewardItems      = {
      ['pureafghani_untrimmed_bud'] = {
        Chance      = 100, --## Chance out of 100 you will get this item.
        HealthBased = 1000, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 95,
        Max = 700,
      },
      ['pureafghani_leaf'] = {
        Chance      = 100,
        HealthBased = 1500, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 5,
        Max = 10,
      },
      ['pureafghani_seed'] = {
        Chance      = 5,
        HealthBased = 30, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 10,
        Max = 30,
      },
    },

    --## THERE ARE 3 STAGES TO A PLANT YOU CAN CHANGE THE MODEL FOR THESE STAGES
    Stages = {
      [1] = 'bkr_prop_weed_01_small_01a', -- Pot with little sprouter
      [2] = 'bkr_prop_weed_med_01a',    -- Pot with medium plant
      [3] = 'bkr_prop_weed_lrg_01b',    -- Pot wiht large plant
    },
  },
  ['Skunk 1'] = {
    -- GENERATION OF ITEMS
    GeneratedAffix     = 'skunk1', --## When the items get auto generated they will be autogenerated as -- accupulcogold_seed, accupulcogold_weed etc etc
    --[[
      This will generate GeneratedAffix_seed, GeneratedAffix_untrimmed_bud, GeneratedAffix_trimmed_bud, GeneratedAffix_leaf
    ]]
    StateUpdatePerTick = 10, --Under Ideal conditions the plants state will increase by this every PlantUpdateTime. Formula: (100/StateUpdatePerTick) * Config.PlantUpdateTime
    --## DISEASES
    DiseaseChance    = 10, --## Chance this plant will get a disease and potentially lose health
    DiseaseAmount    = 0.1, --## Percentage of health the disease will take 0.1 = 10%
    --## WATER SETTINGS
    WaterDrain       = 0.4, -- Every tick how much will the water drain 0.1 = 10%
    MinWater         = 35, -- Wont grow if you have less water than this
    --## LIGHT AND TEMP
    LightMin         = 35, --- Minimum amount of light before plant begins to  decrease in health. Increase this to make them use loads of lights I guess.
    TempMin          = 22, --- If the temperature goes below this the plant will stop growing and begin to decrease in health.
    TempMax          = 30, --- If the temperature goes above this the plant will stop growing and begin to  decrease in health.
    --## SOIL SETTINGS
    SoilDrainHarvest = 0.4, -- Upon harvesting the soil quality will reduce by 20%
    MinSoilQuality   = 35, -- Anything below this and the plant will not grow.
    --## TRIM SETTINGS
    TimeToTrim       = 5, --## Time to trim a bud of this strain.
    --## STRAIN INFO
    Info             = 'An Indica Dominant IBL Strain with great potency and amazing yields! One of the most stabilised strains and beginner friendly. Temps of 25-30 are ideal and light spectum higher than 35%. Soil quality minimum should be 35%',
    --## REWARD ITEMS UPON HARVEST
    RewardItems      = {
      ['skunk1_untrimmed_bud'] = {
        Chance      = 100, --## Chance out of 100 you will get this item.
        HealthBased = 500, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 45,
        Max = 300,
      },
      ['skunk1_leaf'] = {
        Chance      = 100,
        HealthBased = 750, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 200,
        Max = 750,
      },
      ['skunk1_seed'] = {
        Chance      = 5,
        HealthBased = 15, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 5,
        Max = 10,
      },
    },

    --## THERE ARE 3 STAGES TO A PLANT YOU CAN CHANGE THE MODEL FOR THESE STAGES
    Stages = {
      [1] = 'bkr_prop_weed_01_small_01a', -- Pot with little sprouter
      [2] = 'bkr_prop_weed_med_01a',    -- Pot with medium plant
      [3] = 'bkr_prop_weed_lrg_01b',    -- Pot wiht large plant
    },
  },
  ['Northern Lights'] = {
    -- GENERATION OF ITEMS
    GeneratedAffix     = 'northernlights', --## When the items get auto generated they will be autogenerated as -- accupulcogold_seed, accupulcogold_weed etc etc
    --[[
      This will generate GeneratedAffix_seed, GeneratedAffix_untrimmed_bud, GeneratedAffix_trimmed_bud, GeneratedAffix_leaf
    ]]
    StateUpdatePerTick = 10, --Under Ideal conditions the plants state will increase by this every PlantUpdateTime. Formula: (100/StateUpdatePerTick) * Config.PlantUpdateTime
    --## DISEASES
    DiseaseChance    = 10, --## Chance this plant will get a disease and potentially lose health
    DiseaseAmount    = 0.1, --## Percentage of health the disease will take 0.1 = 10%
    --## WATER SETTINGS
    WaterDrain       = 0.4, -- Every tick how much will the water drain 0.1 = 10%
    MinWater         = 37, -- Wont grow if you have less water than this
    --## LIGHT AND TEMP
    LightMin         = 10, --- Minimum amount of light before plant begins to  decrease in health. Increase this to make them use loads of lights I guess.
    TempMin          = 20, --- If the temperature goes below this the plant will stop growing and begin to decrease in health.
    TempMax          = 29, --- If the temperature goes above this the plant will stop growing and begin to  decrease in health.
    --## SOIL SETTINGS
    SoilDrainHarvest = 0.6, -- Upon harvesting the soil quality will reduce by 20%
    MinSoilQuality   = 50, -- Anything below this and the plant will not grow.
    --## TRIM SETTINGS
    TimeToTrim       = 5, --## Time to trim a bud of this strain.
    --## STRAIN INFO
    Info             = 'Northern Lights is an amazing combination of genetics that is extremely pleasurable to smoke, with a high that is not as heavy and has a really tropical scent. Temps should be kept around 20-28 and light spectrum higher than 30%. Soil quality minimum should be 50%',
    --## REWARD ITEMS UPON HARVEST
    RewardItems      = {
      ['northernlights_untrimmed_bud'] = {
        Chance      = 100, --## Chance out of 100 you will get this item.
        HealthBased = 500, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 30,
        Max = 200,
      },
      ['northernlights_leaf'] = {
        Chance      = 100,
        HealthBased = 420, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 200,
        Max = 450,
      },
      ['northernlights_seed'] = {
        Chance      = 10,
        HealthBased = 10, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 5,
        Max = 10,
      },
    },

    --## THERE ARE 3 STAGES TO A PLANT YOU CAN CHANGE THE MODEL FOR THESE STAGES
    Stages = {
      [1] = 'bkr_prop_weed_01_small_01a', -- Pot with little sprouter
      [2] = 'bkr_prop_weed_med_01a',    -- Pot with medium plant
      [3] = 'bkr_prop_weed_lrg_01b',    -- Pot wiht large plant
    },
  },
  ['OG Kush'] = {
    -- GENERATION OF ITEMS
    GeneratedAffix     = 'ogkush', --## When the items get auto generated they will be autogenerated as -- accupulcogold_seed, accupulcogold_weed etc etc
    --[[
      This will generate GeneratedAffix_seed, GeneratedAffix_untrimmed_bud, GeneratedAffix_trimmed_bud, GeneratedAffix_leaf
    ]]
    StateUpdatePerTick = 10, --Under Ideal conditions the plants state will increase by this every PlantUpdateTime. Formula: (100/StateUpdatePerTick) * Config.PlantUpdateTime
    --## DISEASES
    DiseaseChance    = 10, --## Chance this plant will get a disease and potentially lose health
    DiseaseAmount    = 0.1, --## Percentage of health the disease will take 0.1 = 10%
    --## WATER SETTINGS
    WaterDrain       = 0.4, -- Every tick how much will the water drain 0.1 = 10%
    MinWater         = 35, -- Wont grow if you have less water than this
    --## LIGHT AND TEMP
    LightMin         = 10, --- Minimum amount of light before plant begins to  decrease in health. Increase this to make them use loads of lights I guess.
    TempMin          = 20, --- If the temperature goes below this the plant will stop growing and begin to decrease in health.
    TempMax          = 30, --- If the temperature goes above this the plant will stop growing and begin to  decrease in health.
    --## SOIL SETTINGS
    SoilDrainHarvest = 0.4, -- Upon harvesting the soil quality will reduce by 20%
    MinSoilQuality   = 40, -- Anything below this and the plant will not grow.
    --## TRIM SETTINGS
    TimeToTrim       = 5, --## Time to trim a bud of this strain.
    --## STRAIN INFO
    Info             = 'One of the most famous and best strains to ever be created.OG Kush still stands strong with crazy gas terps and potency that can make u think twice before taking another hit.Keep temps around 20-30 and light spectrum higher than 40%. Soil quality minimum should be 50%',
    --## REWARD ITEMS UPON HARVEST
    RewardItems      = {
      ['ogkush_untrimmed_bud'] = {
        Chance      = 100, --## Chance out of 100 you will get this item.
        HealthBased = 700, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 120,
        Max = 700,
      },
      ['ogkush_leaf'] = {
        Chance      = 100,
        HealthBased = 800, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 5,
        Max = 10,
      },
      ['ogkush_seed'] = {
        Chance      = 3,
        HealthBased = 15, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 5,
        Max = 10,
      },
    },

    --## THERE ARE 3 STAGES TO A PLANT YOU CAN CHANGE THE MODEL FOR THESE STAGES
    Stages = {
      [1] = 'bkr_prop_weed_01_small_01a', -- Pot with little sprouter
      [2] = 'bkr_prop_weed_med_01a',    -- Pot with medium plant
      [3] = 'bkr_prop_weed_lrg_01b',    -- Pot wiht large plant
    },
  },
  ['Lemon Skunk'] = {
    -- GENERATION OF ITEMS
    GeneratedAffix     = 'lemonskunk', --## When the items get auto generated they will be autogenerated as -- accupulcogold_seed, accupulcogold_weed etc etc
    --[[
      This will generate GeneratedAffix_seed, GeneratedAffix_untrimmed_bud, GeneratedAffix_trimmed_bud, GeneratedAffix_leaf
    ]]
    StateUpdatePerTick = 10, --Under Ideal conditions the plants state will increase by this every PlantUpdateTime. Formula: (100/StateUpdatePerTick) * Config.PlantUpdateTime
    --## DISEASES
    DiseaseChance    = 10, --## Chance this plant will get a disease and potentially lose health
    DiseaseAmount    = 0.1, --## Percentage of health the disease will take 0.1 = 10%
    --## WATER SETTINGS
    WaterDrain       = 0.4, -- Every tick how much will the water drain 0.1 = 10%
    MinWater         = 35, -- Wont grow if you have less water than this
    --## LIGHT AND TEMP
    LightMin         = 40, --- Minimum amount of light before plant begins to  decrease in health. Increase this to make them use loads of lights I guess.
    TempMin          = 19, --- If the temperature goes below this the plant will stop growing and begin to decrease in health.
    TempMax          = 33, --- If the temperature goes above this the plant will stop growing and begin to  decrease in health.
    --## SOIL SETTINGS
    SoilDrainHarvest = 0.2, -- Upon harvesting the soil quality will reduce by 20%
    MinSoilQuality   = 20, -- Anything below this and the plant will not grow.
    --## TRIM SETTINGS
    TimeToTrim       = 5, --## Time to trim a bud of this strain.
    --## STRAIN INFO
    Info             = 'This classic strain is known to produce energizing effects with a mellow high.In terms of flavor, Lemon Skunk is skunky with a pungent aroma and exceptionally zesty lemon undertones. Keep temps around 20-32 and light spectrum higher than 20%. Soil quality minimum should be 30%',
    --## REWARD ITEMS UPON HARVEST
    RewardItems      = {
      ['lemonskunk_untrimmed_bud'] = {
        Chance      = 100, --## Chance out of 100 you will get this item.
        HealthBased = 600, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 100,
        Max = 300,
      },
      ['lemonskunk_leaf'] = {
        Chance      = 100,
        HealthBased = 3000, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 200,
        Max = 600,
      },
      ['lemonskunk_seed'] = {
        Chance      = 5,
        HealthBased = 15, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 2,
        Max = 5,
      },
    },

    --## THERE ARE 3 STAGES TO A PLANT YOU CAN CHANGE THE MODEL FOR THESE STAGES
    Stages = {
      [1] = 'bkr_prop_weed_01_small_01a', -- Pot with little sprouter
      [2] = 'bkr_prop_weed_med_01a',    -- Pot with medium plant
      [3] = 'bkr_prop_weed_lrg_01b',    -- Pot wiht large plant
    },
  },
  ['Gelato 41'] = {
    -- GENERATION OF ITEMS
    GeneratedAffix     = 'gelato41', --## When the items get auto generated they will be autogenerated as -- accupulcogold_seed, accupulcogold_weed etc etc
    --[[
      This will generate GeneratedAffix_seed, GeneratedAffix_untrimmed_bud, GeneratedAffix_trimmed_bud, GeneratedAffix_leaf
    ]]
    StateUpdatePerTick = 5, --Under Ideal conditions the plants state will increase by this every PlantUpdateTime. Formula: (100/StateUpdatePerTick) * Config.PlantUpdateTime
    --## DISEASES
    DiseaseChance    = 10, --## Chance this plant will get a disease and potentially lose health
    DiseaseAmount    = 0.1, --## Percentage of health the disease will take 0.1 = 10%
    --## WATER SETTINGS
    WaterDrain       = 0.4, -- Every tick how much will the water drain 0.1 = 10%
    MinWater         = 35, -- Wont grow if you have less water than this
    --## LIGHT AND TEMP
    LightMin         = 50, --- Minimum amount of light before plant begins to  decrease in health. Increase this to make them use loads of lights I guess.
    TempMin          = 18, --- If the temperature goes below this the plant will stop growing and begin to decrease in health.
    TempMax          = 31, --- If the temperature goes above this the plant will stop growing and begin to  decrease in health.
    --## SOIL SETTINGS
    SoilDrainHarvest = 0.2, -- Upon harvesting the soil quality will reduce by 20%
    MinSoilQuality   = 65, -- Anything below this and the plant will not grow.
    --## TRIM SETTINGS
    TimeToTrim       = 8, --## Time to trim a bud of this strain.
    --## STRAIN INFO
    Info             = 'Gelato 41 is made by crossing Sunset Sherbert and Thin Mint Cookies.This strain has buds that grow in an array of colors, from light green to purple, with trichomes that put out a sweet and earthy aroma alongside hints of lavender and pine.Not easy to grow so make sure to keep temps at 19-28 and light spectrum higher than 50%. Soil quality minimum should be 70%',
    --## REWARD ITEMS UPON HARVEST
    RewardItems      = {
      ['gelato41_untrimmed_bud'] = {
        Chance      = 100, --## Chance out of 100 you will get this item.
        HealthBased = 420, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 5,
        Max = 10,
      },
      ['gelato41_leaf'] = {
        Chance      = 100,
        HealthBased = 10, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 5,
        Max = 10,
      },
      ['gelato41_seed'] = {
        Chance      = 2,
        HealthBased = 5, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 1,
        Max = 2,
      },
    },

    --## THERE ARE 3 STAGES TO A PLANT YOU CAN CHANGE THE MODEL FOR THESE STAGES
    Stages = {
      [1] = 'bkr_prop_weed_01_small_01a', -- Pot with little sprouter
      [2] = 'bkr_prop_weed_med_01a',    -- Pot with medium plant
      [3] = 'bkr_prop_weed_lrg_01b',    -- Pot wiht large plant
    },
  },
  ['DosiDos'] = {
    -- GENERATION OF ITEMS
    GeneratedAffix     = 'dosidos', --## When the items get auto generated they will be autogenerated as -- accupulcogold_seed, accupulcogold_weed etc etc
    --[[
      This will generate GeneratedAffix_seed, GeneratedAffix_untrimmed_bud, GeneratedAffix_trimmed_bud, GeneratedAffix_leaf
    ]]
    StateUpdatePerTick = 10, --Under Ideal conditions the plants state will increase by this every PlantUpdateTime. Formula: (100/StateUpdatePerTick) * Config.PlantUpdateTime
    --## DISEASES
    DiseaseChance    = 35, --## Chance this plant will get a disease and potentially lose health
    DiseaseAmount    = 0.3, --## Percentage of health the disease will take 0.1 = 10%
    --## WATER SETTINGS
    WaterDrain       = 0.3, -- Every tick how much will the water drain 0.1 = 10%
    MinWater         = 35, -- Wont grow if you have less water than this
    --## LIGHT AND TEMP
    LightMin         = 40, --- Minimum amount of light before plant begins to  decrease in health. Increase this to make them use loads of lights I guess.
    TempMin          = 19, --- If the temperature goes below this the plant will stop growing and begin to decrease in health.
    TempMax          = 31, --- If the temperature goes above this the plant will stop growing and begin to  decrease in health.
    --## SOIL SETTINGS
    SoilDrainHarvest = 0.5, -- Upon harvesting the soil quality will reduce by 20%
    MinSoilQuality   = 50, -- Anything below this and the plant will not grow.
    --## TRIM SETTINGS
    TimeToTrim       = 5, --## Time to trim a bud of this strain.
    --## STRAIN INFO
    Info             = 'With glittering trichomes, bright pistils, and lime green and lavender leaves, Dosidos weed is a feast for the eyes. Its aroma is pungent, sweet, and earthy with slight floral funkiness. Temps should be kept at 20-30 and light spectrum higher than 40%. Soil quality minimum should be 50%',
    --## REWARD ITEMS UPON HARVEST
    RewardItems      = {
      ['dosidos_untrimmed_bud'] = {
        Chance      = 100, --## Chance out of 100 you will get this item.
        HealthBased = 400, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 70,
        Max = 400,
      },
      ['dosidos_leaf'] = {
        Chance      = 100,
        HealthBased = 900, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 290,
        Max = 700,
      },
      ['dosidos_seed'] = {
        Chance      = 1,
        HealthBased = 5, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 1,
        Max = 2,
      },
    },

    --## THERE ARE 3 STAGES TO A PLANT YOU CAN CHANGE THE MODEL FOR THESE STAGES
    Stages = {
      [1] = 'bkr_prop_weed_01_small_01a', -- Pot with little sprouter
      [2] = 'bkr_prop_weed_med_01a',    -- Pot with medium plant
      [3] = 'bkr_prop_weed_lrg_01b',    -- Pot wiht large plant
    },
  },
  ['Rainbow Belts'] = {
    -- GENERATION OF ITEMS
    GeneratedAffix     = 'rainbowbelts', --## When the items get auto generated they will be autogenerated as -- accupulcogold_seed, accupulcogold_weed etc etc
    --[[
      This will generate GeneratedAffix_seed, GeneratedAffix_untrimmed_bud, GeneratedAffix_trimmed_bud, GeneratedAffix_leaf
    ]]
    StateUpdatePerTick = 10, --Under Ideal conditions the plants state will increase by this every PlantUpdateTime. Formula: (100/StateUpdatePerTick) * Config.PlantUpdateTime
    --## DISEASES
    DiseaseChance    = 20, --## Chance this plant will get a disease and potentially lose health
    DiseaseAmount    = 0.2, --## Percentage of health the disease will take 0.1 = 10%
    --## WATER SETTINGS
    WaterDrain       = 0.4, -- Every tick how much will the water drain 0.1 = 10%
    MinWater         = 35, -- Wont grow if you have less water than this
    --## LIGHT AND TEMP
    LightMin         = 50, --- Minimum amount of light before plant begins to  decrease in health. Increase this to make them use loads of lights I guess.
    TempMin          = 17, --- If the temperature goes below this the plant will stop growing and begin to decrease in health.
    TempMax          = 35, --- If the temperature goes above this the plant will stop growing and begin to  decrease in health.
    --## SOIL SETTINGS
    SoilDrainHarvest = 0.2, -- Upon harvesting the soil quality will reduce by 20%
    MinSoilQuality   = 60, -- Anything below this and the plant will not grow.
    --## TRIM SETTINGS
    TimeToTrim       = 5, --## Time to trim a bud of this strain.
    --## STRAIN INFO
    Info             = 'The flavor and aroma of this strain may remind you of sweet and fruity candy.A real exotic plant with great potency and amazing entourage effect.Temperatures should be kept between 18-26 and light spectrum higher than 45%. Soil quality minimum should be 65%',
    --## REWARD ITEMS UPON HARVEST
    RewardItems      = {
      ['rainbowbelts_untrimmed_bud'] = {
        Chance      = 100, --## Chance out of 100 you will get this item.
        HealthBased = 444, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 55,
        Max = 500,
      },
      ['rainbowbelts_leaf'] = {
        Chance      = 100,
        HealthBased = 450, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 90,
        Max = 300,
      },
      ['rainbowbelts_seed'] = {
        Chance      = 1,
        HealthBased = 5, -- This can be false or a number if false then will just be random amount based on Min/Max if its a number then the amount they get will be the percentage health times the amount here
        -- Min/Max only used if HealthBased = false
        Min = 1,
        Max = 2,
      },
    },

    --## THERE ARE 3 STAGES TO A PLANT YOU CAN CHANGE THE MODEL FOR THESE STAGES
    Stages = {
      [1] = 'bkr_prop_weed_01_small_01a', -- Pot with little sprouter
      [2] = 'bkr_prop_weed_med_01a',    -- Pot with medium plant
      [3] = 'bkr_prop_weed_lrg_01b',    -- Pot wiht large plant
    },
  },
}