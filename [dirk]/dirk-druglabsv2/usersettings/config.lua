Config = {
  Debug       = true, 
  TargetBased   = true, --\ if false will use my menu system
  --## Lab Generic Settings
  ShellHeight     = 2000.0, --\\ Shells spawn in the sky
  OwnerNeedsKeys  = true, --## Does the owner of a lab need keys or will he always have access?
  PurchaseAccount = "bank", --## Where will lab purchase money come from?
  DefaultKeyItem  = "lab-key",

  ProgressBars  = true, --## Do you want progress bars during stages?

  TebexCommand  = 'drug_lab_purchase', --## drug_lab_purchase {"steamId":"{hexid}", "lab":{packageName}} -- This is what you will use as the command for this package. --## Lock this
  TestBuy       = 'testBuy', --## /testBuy Cocaine Lab --## use this to test if you wished
  RedeemCommand = 'ClaimLab',

  GiveLab       = "GiveLab", --## Use this command to give labs to people by ID if you wished --## /GiveLab playerId Heroin Lab
  RemoveLab     = "RemoveLab", --## Use this command to remove a labs current owner --## /RemoveLab Heroin Lab

  InShellTime = { --## Time will be set when entering a shell and will sync to sever time when 
    Hour    = 12, 
    Min     = 0 
  },

  Police = {
    RaidTool     = "raidtool",
    RaidCooldown = 12, --## For how many hours will this lab be disabled if police raid it?
    Jobs = {
    --jobname = minimumraidgrade
      police = 1, 
    },
  },

  IngredientsOrders = { --## Make it so there are armed players driving the car and you have to stop it without damaging it
    Timeout          = 15, --## After x minutes the mission will become available again regardless if complete
    TimeBetween      = 1, --## Minutes betweeen orders
    OrderAccount     = "bank", 
    TruckModel       = "rumpo",
    ToInventory      = true,  --## If true then ingredients will go into the players inventory upon completion rather than the labs

    Blip = {
      Scale   = 0.75,
      Sprite  = 51,
      Color   = 1,
      Display = 4,
    },

    Missions    = { --## Locations players will need to go to collect orders

      ['Downtown Vinewood'] = {
        Van = {
          Position = vector4(41.59, 6449.78, 31.42, 227.99),
          Model    = "blista",
          Driver   = "a_m_m_hillbilly_01", --## If there is a driver the van will drive off when attempt of theft is made
        },
        Guards      = {
          {
            Model    = "a_m_m_hillbilly_01",
            Position = vector4(31.25, 6445.05, 31.43, 223.57),
            Accuracy = 60, 
            Weapon   = "WEAPON_PISTOL",
          },
          {
            Model    = "a_m_m_hillbilly_01",
            Position = vector4(43.0, 6457.49, 31.43, 199.26), 
            Accuracy = 60,
            Weapon   = "WEAPON_PISTOL",
          }
        },
      },
      
      ['Downtown Vinewood'] = {
        Van = {
          Position = vector4(41.59, 6449.78, 31.42, 227.99),
          Model    = "blista",
          Driver   = "a_m_m_hillbilly_01", --## If there is a driver the van will drive off when attempt of theft is made
        },
        Guards      = {
          {
            Model    = "a_m_m_hillbilly_01",
            Position = vector4(31.25, 6445.05, 31.43, 223.57),
            Accuracy = 60, 
            Weapon   = "WEAPON_PISTOL",
          },
          {
            Model    = "a_m_m_hillbilly_01",
            Position = vector4(43.0, 6457.49, 31.43, 199.26), 
            Accuracy = 60,
            Weapon   = "WEAPON_PISTOL",
          }
        },
      },

    },
  },

  Shells = {
    --## K4MBI's High-End Drug Lab Shells - Requires (https://www.k4mb1maps.com/package/4698329)
    ['Cocaine High End Shell'] = {
      Model        = 'k4coke_shell', 
      Entrance     = vector4(-11.007922,-2.427085,-0.003029,270.557159),
      StockPile    = vector4(-5.737,-2.42,-2.67,176.0),
      Stash        = {
        Slots  = 50, 
        Weight = 50000,  
      },
    },
    ['Weed High End Shell'] = {
      Model        = 'k4weed_shell',
      Entrance     =  vector4(-11.007922,-2.427085,-0.003029,270.557159),
      StockPile    =  vector4(9.5747222900391,-1.7655029296875,-2.674015045166,268.38430786133),
      Stash        = {
        Slots  = 50, 
        Weight = 50000,  
      },
    },
    ['Meth High End Shell'] = {
      Model        = 'k4meth_shell',
      Entrance     =  vector4(-11.007922,-2.427085,-0.003029,270.557159),
      StockPile    =  vector4(9.5688934326172,-0.6209716796875,-2.6740751266479,268.92538452148),
      Stash        = {
        Slots  = 50, 
        Weight = 50000,  
      },   
    },

    --## K4MBI's Drug Lab Shells - Requires (https://www.k4mb1maps.com/package/4672285)
    ['Cocaine Shell'] = {
      Model        = 'shell_coke2',
      Entrance     = vector4(-6.3437366485596,8.683349609375,-0.95851707458496,169.14138793945),
      StockPile    = vector4(7.2056217193604,2.2894287109375,-0.95817756652832,315.4264831543),
      Stash        = {
        Slots  = 50, 
        Weight = 50000,  
      },  
    },
    ['Weed Shell'] = {
      Model        = 'shell_weed2',
      Entrance     = vector4(17.875198364258,11.770874023438,-2.0969161987305,103.38287353516),
      StockPile    = vector4(-14.316024780273,-12.219848632813,-1.1084651947021,89.742568969727),
      Stash        = {
        Slots  = 50, 
        Weight = 50000,  
      },   
    },
    ['Meth Shell'] = {
      Model        = 'shell_meth', 
      Entrance     = vector4(-6.2149963378906,8.6058349609375,-0.95850372314453,182.97537231445),
      StockPile    = vector4(1.9841766357422,2.953125,-0.9585018157959,359.47616577148),
      Stash        = {
        Slots  = 50, 
        Weight = 50000,  
      },  
    },
  },


  --[[
    Optional Vars for Labs
    TebexPackage = "link to my tebex package", -- This will be a link to your tebex package players will be able to open at the door of any unclaimed tebex labs. 
    TeamworkMode = true,  --## Will prevent players doing processes unless the lab storage has the items. Reward items will also go here.

    IngredientsOrders = { -- Will allow users of the lab to place ingredients orders at the door and do missions to get ingredients
      Price        = 15000, -- Cost of the ingredients run 
      DropPoint    = vector4(-16.90599822998,6276.65234375,31.22873878479,298.28988647461), -- Where outside the labt the ingredients will be dropped too
      Items = { -- Items and amount player will recieve from runs.
        sodiumbenzoate   = 50, 
        propelyeneglycol   = 50,   
      },
    },

    Blip = { --## Delete this blip table from a lab if you don't want a blip
      Scale   = 0.75, 
      Sprite  = 499, 
      Color   = 45,
      Display = 2,
      Close  = true, --## Will only show this on the minimap when you are close to the lab forcing players to drive around and try find it. 
    },

  ]]

  Labs = { --## The name of hte lab is the index warning if you change this name then you will need to also change the inventory name in dirk-core/inventories.json - Just dont change if items are stored...
    
  --## K4MBI PAID HIGHEND SHELLS
    ['Paleto Cocaine Lab'] = { --## Tebex Package Example
      Door  = vector4(-212.60719299316,6358.0473632813,31.492290496826,221.96774291992),
      Shell = "Cocaine High End Shell", -- Can be false or can be model name of a shell
      TebexPackage = 'https://www.google.com', --## This will not be useable until claimed. Please read the documentation provided on how to setup tebex packages. --- Access.Ownable must be a number but it doesnt matter which number it is 

      TeamWorkMode = false, --## If this is true required items will come from the shared stockpile and reward items will also go here

      Access = {
        Ownable = 50000, --## Will make this buyable and have key access -- Probably leave Gangs, Jobs and Public as false. Can be false also -- If this is a tebex package please make rthis a random number -- MUST BE A NUMBER VALUE (THIS WILL BE TRHE BUY PRICE)
        KeyCode = false, --## Do you want a keycode to access this? -- This will overwrite everything else except public. 
        Public  = false,  -- If this is true anyone can access this regardless of other settings.
        Gangs   = false, --## Gangs can access this lab
        Jobs    = false, --## Jobs can access this lab
        ItemKey = false, --## If this is an itemname then the player will need a an item to access this lab (NOT THE SAME AS PLAYER OWNED WITH UNIQUE KEYS)
      },


      IngOrders = {
        Price        = 5000, -- How much will it cost to order ingredients?
        DropPoint    = vector4(-215.32147216797,6351.30859375,31.528518676758,319.28759765625), --## This is the point where the van will have to be dropped outside the lab in order to deliver ingredietns
        Items = { -- What will the player get for this ingredients run
          rawcocaine   = 50, 
          bakingsoda   = 50, 
          actionfigure = 25,  
        },
      },

      Blip = { --## Delete this blip table if you don't want a blip
        Scale   = 0.75, 
        Sprite  = 497, 
        Color   = 45,
        Display = 2,
        Close  = true, --## Will only show this on the minimap when you are close to the lab forcing players to drive around and try find it. 
      },

      Stages = {
        [1] = {
          Position      = vector4(4.825562, -3.003174, -2.673802, 179.7306060791), 
          Label         = "Cut Cocaine",
          Icon          = "fa-solid fa-scissors",
          
          FancyScene    = "Cut Cocaine", --# This can be one of the scenes from Config.Scenes or it can be false and you can use a regular animation
          NormalAnim    = false, --## Can be false or can be a table like so {anim = "anim_b", dict = "dict_a", time = 15000}
          RequiredItems = {
            rawcocaine = 3, 
            bakingsoda = 2, 
          },
          RewardItems   = {
            cutcocaine = 2, 
          },
        },
        [2] = {
          Position      = vector4(3.890869, -0.5727539, -2.673793,359.83615112305),
          Label         = "Cut Cocaine",
          Icon          = "fa-solid fa-scissors",
          
          FancyScene    = "Cut Cocaine", --# This can be one of the scenes from Config.Scenes or it can be false and you can use a regular animation
          NormalAnim    = false, --## Can be false or can be a table like so {anim = "anim_b", dict = "dict_a", time = 15000}
          RequiredItems = {
            rawcocaine = 3, 
            bakingsoda = 2, 
          },
          RewardItems   = {
            cutcocaine = 2, 
          },
        },
        [3] = {
          Position      = vector4(4.125854, 3.231079, -2.673817,0.0),
          Label         = "Package Cocaine",
          Icon          = "fa-solid fa-box-archive",
          
          FancyScene    = "Package Cocaine", --# This can be one of the scenes from Config.Scenes or it can be false and you can use a regular animation
          NormalAnim    = false, --## Can be false or can be a table like so {anim = "anim_b", dict = "dict_a", time = 15000}
          RequiredItems = {
            cutcocaine   = 1, 
            actionfigure = 1, 
          },
          RewardItems   = {
            cocainepackage = 1, 
          },
        },
      },
    },
    ['Paleto Meth Lab'] = { --## KeyCode Example - Code - 1234
      Door  = vector4(-11.633558273315,6279.953125,31.376426696777,290.68182373047),
      Shell = "Meth High End Shell", -- Can be false or can be model name of a shell

      TeamWorkMode = false, --## If this is true required items will come from the shared stockpile and reward items will also go here
      KeyItem      = nil, --## This could be a name of an item if you wanted a different item to be the key for this lab :thinking: It'll still need metadata attached via the script

      Access = {
        Ownable = false, --## Will make this buyable and have key access -- Probably leave Gangs, Jobs and Public as false. Can be false also
        KeyCode = 1234, --## Do you want a keycode to access this? -- This will overwrite everything else
        Public  = false, 
        Gangs   = false, --## Gangs can access this lab
        Jobs    = false, --## Gangs can access this lab
      },


      IngOrders = {
        Price        = 15000, 
        DropPoint    = vector4(-16.90599822998,6276.65234375,31.22873878479,298.28988647461), 
        Items = {
          sodiumbenzoate   = 50, 
          propelyeneglycol   = 50,   
        },
      },

      Blip = { --## Delete this blip table if you don't want a blip
        Scale   = 0.75, 
        Sprite  = 499, 
        Color   = 45,
        Display = 2,
        Close  = true, --## Will only show this on the minimap when you are close to the lab forcing players to drive around and try find it. 
      },

      Stages = {
        [1] = {
          Position      = vector4(-2.1496429443359,-2.3616943359375,-2.2236909866333,186.49963378906),
          Label         = "Cook Meth",
          Icon          = "fa-solid fa-fire-burner",
          ProgText      = "Cooking Meth",
          FancyScene    = "Cook Meth", --# This can be one of the scenes from Config.Scenes or it can be false and you can use a regular animation
          NormalAnim    = false, --## Can be false or can be a table like so {anim = "anim_b", dict = "dict_a", time = 15000}
          RequiredItems = {
            sodiumbenzoate   = 10, 
            propelyeneglycol = 10,   
          },
          RewardItems   = {
            boxmeth = 10, 
          },
        },
        [2] = {
          Position      = vector4(6.41650390625,3.1162109375,-2.673828125,4.8522024154663),
          Label         = "Package Meth",
          Icon          = "fa-solid fa-box",
          ProgText      = "Packaging Meth",
          FancyScene    = "Package Meth", --# This can be one of the scenes from Config.Scenes or it can be false and you can use a regular animation
          NormalAnim    = false, --## Can be false or can be a table like so {anim = "anim_b", dict = "dict_a", time = 15000}
          RequiredItems = {
            boxmeth = 10, 
          },
          RewardItems   = {
            bagmeth = 20,  --## With Current time settings you will get 29 times this in an hour if grinding 
          },
        },
      },
    },
    ['Paleto Weed Grow']      = { --## Private Owned $25000
      Door  = vector4(-146.28691101074,6303.5537109375,31.558603286743,132.73893737793),
      Shell = "Weed High End Shell", -- Can be false or can be model name of a shell

      TeamWorkMode = false, --## If this is true required items will come from the shared stockpile and reward items will also go here
      KeyItem      = nil, --## This could be a name of an item if you wanted a different item to be the key for this lab :thinking: It'll still need metadata attached via the script
    
      Access = {
        Ownable = 25000, --## Will make this buyable and have key access -- Probably leave Gangs, Jobs and Public as false. Can be false also
        KeyCode = false, --## Do you want a keycode to access this? -- This will overwrite everything else
        Public  = false, 
        Gangs   = false, --## Gangs can access this lab
        Jobs    = false, --## Gangs can access this lab
      },

      Blip = { --## Delete this blip table if you don't want a blip
        Scale   = 0.75, 
        Sprite  = 496, 
        Color   = 45,
        Display = 2,
        Close  = true, --## Will only show this on the minimap when you are close to the lab forcing players to drive around and try find it. 
      },


      Stages = {
        [1] = {
          Position      = vector4(4.3036499023438,3.2998046875,-2.6737945079803,358.98886108398),
          Label         = "Trim Weed",
          Icon          = "fa-solid fa-scissors",
          ProgText      = "Harvesting",
          FancyScene    = "Trim Weed", --# This can be one of the scenes from Config.Scenes or it can be false and you can use a regular animation
          NormalAnim    = false, --## Can be false or can be a table like so {anim = "anim_b", dict = "dict_a", time = 15000}
          RequiredItems = {
            untrimmed_weed = 5, 
          },
          RewardItems   = {
            trimmed_weed = 5, 
          },
        },

        [2] = {
          Position      = vector4(-4.6531829833984,-2.24658203125,-2.5402765274048,264.90560913086),
          Label         = "Gather Weed",
          Icon          = "fa-solid fa-scissors",
          ProgText      = "Harvesting",
          FancyScene    = "Gather Weed", --# This can be one of the scenes from Config.Scenes or it can be false and you can use a regular animation
          NormalAnim    = false, --## Can be false or can be a table like so {anim = "anim_b", dict = "dict_a", time = 15000}
          RequiredItems = {
            
          },
          RewardItems   = {
            untrimmed_weed = 5, 
          },
        },


        [3] = {
          Position      = vector4(-3.8286743164063,1.44482421875,-2.6737940311432,177.63793945313),
          Label         = "Gather Weed",
          Icon          = "fa-solid fa-scissors",
          ProgText      = "Harvesting",
          FancyScene    = "Gather Weed", --# This can be one of the scenes from Config.Scenes or it can be false and you can use a regular animation
          NormalAnim    = false, --## Can be false or can be a table like so {anim = "anim_b", dict = "dict_a", time = 15000}
          RequiredItems = {
            
          },
          RewardItems   = {
            untrimmed_weed = 5, 
          },
        },
        [4] = {
          Position      = vector4(-1.9292755126953,1.2735595703125,-2.6737957000732,183.86921691895),
          Label         = "Gather Weed",
          Icon          = "fa-solid fa-scissors",
          ProgText      = "Harvesting",
          FancyScene    = "Gather Weed", --# This can be one of the scenes from Config.Scenes or it can be false and you can use a regular animation
          NormalAnim    = false, --## Can be false or can be a table like so {anim = "anim_b", dict = "dict_a", time = 15000}
          RequiredItems = {
            
          },
          RewardItems   = {
            untrimmed_weed = 5, 
          },
        },
        [5] = {
          Position      = vector4(-0.0038604736328125,1.177001953125,-2.6737945079803,174.0167388916),
          Label         = "Gather Weed",
          Icon          = "fa-solid fa-scissors",
          ProgText      = "Harvesting",
          FancyScene    = "Gather Weed", --# This can be one of the scenes from Config.Scenes or it can be false and you can use a regular animation
          NormalAnim    = false, --## Can be false or can be a table like so {anim = "anim_b", dict = "dict_a", time = 15000}
          RequiredItems = {
            
          },
          RewardItems   = {
            untrimmed_weed = 5, 
          },
        },
        [6] = {
          Position      = vector4(2.3000183105469,1.1473388671875,-2.673796415329,178.97296142578),
          Label         = "Gather Weed",
          Icon          = "fa-solid fa-scissors",
          ProgText      = "Harvesting",
          FancyScene    = "Gather Weed", --# This can be one of the scenes from Config.Scenes or it can be false and you can use a regular animation
          NormalAnim    = false, --## Can be false or can be a table like so {anim = "anim_b", dict = "dict_a", time = 15000}
          RequiredItems = {
            
          },
          RewardItems   = {
            untrimmed_weed = 5, 
          },
        },
        [7] = {
          Position      = vector4(4.3461151123047,1.1641845703125,-2.6737947463989,176.18046569824),
          Label         = "Gather Weed",
          Icon          = "fa-solid fa-scissors",
          ProgText      = "Harvesting",
          FancyScene    = "Gather Weed", --# This can be one of the scenes from Config.Scenes or it can be false and you can use a regular animation
          NormalAnim    = false, --## Can be false or can be a table like so {anim = "anim_b", dict = "dict_a", time = 15000}
          RequiredItems = {
            
          },
          RewardItems   = {
            untrimmed_weed = 5, 
          },
        },
        [8] = {
          Position      = vector4(7.2486419677734,1.0867919921875,-2.6739161014557,131.86152648926),
          Label         = "Gather Weed",
          Icon          = "fa-solid fa-scissors",
          ProgText      = "Harvesting",
          FancyScene    = "Gather Weed", --# This can be one of the scenes from Config.Scenes or it can be false and you can use a regular animation
          NormalAnim    = false, --## Can be false or can be a table like so {anim = "anim_b", dict = "dict_a", time = 15000}
          RequiredItems = {
            
          },
          RewardItems   = {
            untrimmed_weed = 5,
          },
        },
        [9] = {
          Position      = vector4(7.6144561767578,-2.3123779296875,-2.6738851070404,88.717674255371),
          Label         = "Gather Weed",
          Icon          = "fa-solid fa-scissors",
          ProgText      = "Harvesting",
          FancyScene    = "Gather Weed", --# This can be one of the scenes from Config.Scenes or it can be false and you can use a regular animation
          NormalAnim    = false, --## Can be false or can be a table like so {anim = "anim_b", dict = "dict_a", time = 15000}
          RequiredItems = {
            
          },
          RewardItems   = {
            untrimmed_weed = 5, 
          },
        },
      },
    },

    --## K4MBI LOW END DRUG SHELLS
    ['Public Cocaine Lab'] = { --## Public
      Door  = vector4(-773.0400390625,-187.76544189453,37.28369140625,303.32772827148),
      Shell = "Cocaine Shell", -- Can be false or can be model name of a shell

      TeamWorkMode = false, --## If this is true required items will come from the shared stockpile and reward items will also go here
      KeyItem      = nil, --## This could be a name of an item if you wanted a different item to be the key for this lab :thinking: It'll still need metadata attached via the script

      Access = {
        Ownable = false, --## Will make this buyable and have key access -- Probably leave Gangs, Jobs and Public as false. Can be false also
        KeyCode = false, --## Do you want a keycode to access this? -- This will overwrite everything else
        Public  = true, 
        Gangs   = false, --## Gangs can access this lab
        Jobs    = false, --## Gangs can access this lab
      },


      IngOrders = {
        Price        = 5000, 
        DropPoint    = vector4(-775.93023681641,-193.7191619873,37.28369140625,120.91262054443), 
        Items = {
          rawcocaine   = 50, 
          bakingsoda   = 50, 
          actionfigure = 25,  
        },
      },

      Blip = { --## Delete this blip table if you don't want a blip
        Scale   = 0.75, 
        Sprite  = 497, 
        Color   = 45,
        Display = 4,
        Close  = true, --## Will only show this on the minimap when you are close to the lab forcing players to drive around and try find it. 
      },

      Stages = {
        [1] = {
          Position      = vector4(-4.6897039413452,-0.55615234375,-0.95853424072266,359.3857421875),
          Label         = "Cut Cocaine",
          Icon          = "fa-solid fa-scissors",
          ProgText      = "Cutting Cocaine",
          FancyScene    = "Cut Cocaine", --# This can be one of the scenes from Config.Scenes or it can be false and you can use a regular animation
          NormalAnim    = false, --## Can be false or can be a table like so {anim = "anim_b", dict = "dict_a", time = 15000}
          RequiredItems = {
            rawcocaine = 3, 
            bakingsoda = 2, 
          },
          RewardItems   = {
            cutcocaine = 2, 
          },
        },
        [2] = {
          Position      = vector4(0.51191282272339,-0.4735107421875,-0.95852851867676,1.1724637746811),
          Label         = "Cut Cocaine",
          Icon          = "fa-solid fa-scissors",
          ProgText      = "Cutting Cocaine",
          FancyScene    = "Cut Cocaine", --# This can be one of the scenes from Config.Scenes or it can be false and you can use a regular animation
          NormalAnim    = false, --## Can be false or can be a table like so {anim = "anim_b", dict = "dict_a", time = 15000}
          RequiredItems = {
            rawcocaine = 3, 
            bakingsoda = 2, 
          },
          RewardItems   = {
            cutcocaine = 2, 
          },
        },
        [3] = {
          Position      = vector4(6.2549304962158,-2.6531982421875,-0.95852851867676,180.15774536133),
          Label         = "Package Cocaine",
          Icon          = "fa-solid fa-box-archive",
          ProgText      = "Packing Cocaine",
          FancyScene    = "Package Cocaine", --# This can be one of the scenes from Config.Scenes or it can be false and you can use a regular animation
          NormalAnim    = false, --## Can be false or can be a table like so {anim = "anim_b", dict = "dict_a", time = 15000}
          RequiredItems = {
            cutcocaine   = 1, 
            actionfigure = 1, 
          },
          RewardItems   = {
            cocainepackage = 1, 
          },
        },
      },
    },
    ['Keycoded Meth Lab'] = { --## Keycoded to 1234
      Door  = vector4(1261.6147460938,-1616.744140625,54.742881774902,214.38056945801),
      Shell = "Meth Shell", -- Can be false or can be model name of a shell

      TeamWorkMode = false, --## If this is true required items will come from the shared stockpile and reward items will also go here
      KeyItem      = nil, --## This could be a name of an item if you wanted a different item to be the key for this lab :thinking: It'll still need metadata attached via the script

      Access = {
        Ownable = false, --## Will make this buyable and have key access -- Probably leave Gangs, Jobs and Public as false. Can be false also
        KeyCode = 1234, --## Do you want a keycode to access this? -- This will overwrite everything else
        Public  = false, 
        Gangs   = false, --## Gangs can access this lab
        Jobs    = false, --## Gangs can access this lab
      },


      IngOrders = {
        Price        = 5000, 
        DropPoint    = vector4(1252.2244873047,-1605.4554443359,53.107166290283,314.43713378906), 
        Items = {
          rawcocaine   = 50, 
          bakingsoda   = 50, 
          actionfigure = 25,  
        },
      },

      Blip = { --## Delete this blip table if you don't want a blip
        Scale   = 0.75, 
        Sprite  = 499, 
        Color   = 45,
        Display = 4,
        Close  = true, --## Will only show this on the minimap when you are close to the lab forcing players to drive around and try find it. 
      },

      Stages = {
        [1] = {
          Position      = vector4(-2.2980346679688,-1.635498046875,-0.47295570373535,174.29225158691),
          Label         = "Cook Meth",
          Icon          = "fa-solid fa-fire-burner",
          ProgText      = "Cooking Meth",
          FancyScene    = "Cook Meth", --# This can be one of the scenes from Config.Scenes or it can be false and you can use a regular animation
          NormalAnim    = false, --## Can be false or can be a table like so {anim = "anim_b", dict = "dict_a", time = 15000}
          RequiredItems = {
            sodiumbenzoate   = 10, 
            propelyeneglycol = 10,   
          },
          RewardItems   = {
            boxmeth = 10, 
          },
        },
        [2] = {
          Position      = vector4(6.2822265625,2.942626953125,-0.95849323272705,0.30201748013496),
          Label         = "Package Meth",
          Icon          = "fa-solid fa-box",
          ProgText      = "Packaing Meth",
          FancyScene    = "Package Meth", --# This can be one of the scenes from Config.Scenes or it can be false and you can use a regular animation
          NormalAnim    = false, --## Can be false or can be a table like so {anim = "anim_b", dict = "dict_a", time = 15000}
          RequiredItems = {
            boxmeth = 10, 
          },
          RewardItems   = {
            bagmeth = 20,  --## With Current time settings you will get 29 times this in an hour if grinding 
          },
        },
      },
    },
    ['Public Weed Grow'] = { -- ## Public
      Door  = vector4(154.16979980469,-1548.412109375,29.143009185791,231.43171691895),
      Shell = "Weed Shell", -- Can be false or can be model name of a shell

      TeamWorkMode = false, --## If this is true required items will come from the shared stockpile and reward items will also go here
      KeyItem      = nil, --## This could be a name of an item if you wanted a different item to be the key for this lab :thinking: It'll still need metadata attached via the script

      Access = {
        Ownable = false, --## Will make this buyable and have key access -- Probably leave Gangs, Jobs and Public as false. Can be false also
        KeyCode = false, --## Do you want a keycode to access this? -- This will overwrite everything else
        Public  = true, 
        Gangs   = false, --## Gangs can access this lab
        Jobs    = false, --## Gangs can access this lab
      },

      Blip = { --## Delete this blip table if you don't want a blip
        Scale   = 0.75, 
        Sprite  = 496, 
        Color   = 45,
        Display = 4,
        Close  = true, --## Will only show this on the minimap when you are close to the lab forcing players to drive around and try find it. 
      },

      Stages = {
        [1] = {
          Position      = vector4(6.3436584472656,-9.7176513671875,-2.0926952362061,268.46987915039),
          Label         = "Trim Weed",
          Icon          = "fa-solid fa-scissors",
          ProgText      = "Harvesting",
          FancyScene    = "Trim Weed", --# This can be one of the scenes from Config.Scenes or it can be false and you can use a regular animation
          NormalAnim    = false, --## Can be false or can be a table like so {anim = "anim_b", dict = "dict_a", time = 15000}
          RequiredItems = {
            untrimmed_weed = 5, 
          },
          RewardItems   = {
            trimmed_weed = 5, 
          },
        },

        [2] = {
          Position      = vector4(7.5216064453125,-3.8681640625,-2.0929279327393,267.34216308594),
          Label         = "Gather Weed",
          Icon          = "fa-solid fa-scissors",
          ProgText      = "Harvesting",
          FancyScene    = "Gather Weed", --# This can be one of the scenes from Config.Scenes or it can be false and you can use a regular animation
          NormalAnim    = false, --## Can be false or can be a table like so {anim = "anim_b", dict = "dict_a", time = 15000}
          RequiredItems = {
            
          },
          RewardItems   = {
            untrimmed_weed = 5, 
          },
        },


        [3] = {
          Position      = vector4(7.4476623535156,-5.4110107421875,-2.0929279327393,268.05358886719),
          Label         = "Gather Weed",
          Icon          = "fa-solid fa-scissors",
          ProgText      = "Harvesting",
          FancyScene    = "Gather Weed", --# This can be one of the scenes from Config.Scenes or it can be false and you can use a regular animation
          NormalAnim    = false, --## Can be false or can be a table like so {anim = "anim_b", dict = "dict_a", time = 15000}
          RequiredItems = {
            
          },
          RewardItems   = {
            untrimmed_weed = 5, 
          },
        },
        [4] = {
          Position      = vector4(7.428955078125,-7.0372314453125,-2.0928840637207,263.57763671875),
          Label         = "Gather Weed",
          Icon          = "fa-solid fa-scissors",
          ProgText      = "Harvesting",
          FancyScene    = "Gather Weed", --# This can be one of the scenes from Config.Scenes or it can be false and you can use a regular animation
          NormalAnim    = false, --## Can be false or can be a table like so {anim = "anim_b", dict = "dict_a", time = 15000}
          RequiredItems = {
            
          },
          RewardItems   = {
            untrimmed_weed = 5, 
          },
        },
        [5] = {
          Position      = vector4(6.3436584472656,-9.7176513671875,-2.0926952362061,268.46987915039),
          Label         = "Gather Weed",
          Icon          = "fa-solid fa-scissors",
          ProgText      = "Harvesting",
          FancyScene    = "Gather Weed", --# This can be one of the scenes from Config.Scenes or it can be false and you can use a regular animation
          NormalAnim    = false, --## Can be false or can be a table like so {anim = "anim_b", dict = "dict_a", time = 15000}
          RequiredItems = {
            
          },
          RewardItems   = {
            untrimmed_weed = 5, 
          },
        },
        [6] = {
          Position      = vector4(11.679122924805,-7.263427734375,-2.092866897583,82.601036071777),
          Label         = "Trim Weed",
          Icon          = "fa-solid fa-scissors",
          ProgText      = "Harvesting",
          FancyScene    = "Trim Weed", --# This can be one of the scenes from Config.Scenes or it can be false and you can use a regular animation
          NormalAnim    = false, --## Can be false or can be a table like so {anim = "anim_b", dict = "dict_a", time = 15000}
          RequiredItems = {
            untrimmed_weed = 5, 
          },
          RewardItems   = {
            trimmed_weed = 5, 
          },
        },

        [7] = {
          Position      = vector4(11.789215087891,-5.7425537109375,-2.0929298400879,85.139038085938),
          Label         = "Gather Weed",
          Icon          = "fa-solid fa-scissors",
          ProgText      = "Harvesting",
          FancyScene    = "Gather Weed", --# This can be one of the scenes from Config.Scenes or it can be false and you can use a regular animation
          NormalAnim    = false, --## Can be false or can be a table like so {anim = "anim_b", dict = "dict_a", time = 15000}
          RequiredItems = {
            
          },
          RewardItems   = {
            untrimmed_weed = 5, 
          },
        },


        [8] = {
          Position      = vector4(11.895095825195,-4.1693115234375,-2.0929298400879,86.093078613281),
          Label         = "Gather Weed",
          Icon          = "fa-solid fa-scissors",
          ProgText      = "Harvesting",
          FancyScene    = "Gather Weed", --# This can be one of the scenes from Config.Scenes or it can be false and you can use a regular animation
          NormalAnim    = false, --## Can be false or can be a table like so {anim = "anim_b", dict = "dict_a", time = 15000}
          RequiredItems = {
            
          },
          RewardItems   = {
            untrimmed_weed = 5, 
          },
        },
        [9] = {
          Position      = vector4(11.244354248047,-1.6134033203125,-2.0929298400879,176.37371826172),
          Label         = "Gather Weed",
          Icon          = "fa-solid fa-scissors",
          ProgText      = "Harvesting",
          FancyScene    = "Gather Weed", --# This can be one of the scenes from Config.Scenes or it can be false and you can use a regular animation
          NormalAnim    = false, --## Can be false or can be a table like so {anim = "anim_b", dict = "dict_a", time = 15000}
          RequiredItems = {
            
          },
          RewardItems   = {
            untrimmed_weed = 5, 
          },
        },
        [10] = {
          Position      = vector4(8.4410552978516,-1.3575439453125,-2.0929298400879,177.27713012695),
          Label         = "Gather Weed",
          Icon          = "fa-solid fa-scissors",
          ProgText      = "Harvesting",
          FancyScene    = "Gather Weed", --# This can be one of the scenes from Config.Scenes or it can be false and you can use a regular animation
          NormalAnim    = false, --## Can be false or can be a table like so {anim = "anim_b", dict = "dict_a", time = 15000}
          RequiredItems = {
            
          },
          RewardItems   = {
            untrimmed_weed = 5, 
          },
        },
        [11] = {
          Position      = vector4(-14.352951049805,-9.8824462890625,-1.1094284057617,0.74314200878143),
          Label         = "Trim Weed",
          Icon          = "fa-solid fa-scissors",
          ProgText      = "Trimming Weed",
          FancyScene    = "Trim Weed", --# This can be one of the scenes from Config.Scenes or it can be false and you can use a regular animation
          NormalAnim    = false, --## Can be false or can be a table like so {anim = "anim_b", dict = "dict_a", time = 15000}
          RequiredItems = {
            untrimmed_weed = 5, 
          },
          RewardItems   = {
            trimmed_weed = 4, 
          },
        },
      },
    },    
  }
}

Core, Settings = exports['dirk-core']:getCore()

--## Debug Print Function
dPrint = function(msg)
  if Config.Debug then 
    print(string.format("DIRK-SCRIPTS: %s", msg))
  end
end

