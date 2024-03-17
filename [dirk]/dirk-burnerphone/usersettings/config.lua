--[[
  --## CHARGING ##--
  These events could be used for you to set all phones on a player to charge, currently they will charge if someone is in a vehicle it will check if they have a charging_cable too
  TriggerServerEvent("DirkBurner:ChargingState", true) --## Set the charging state of the phone to true
  TriggerServerEvent("DirkBurner:ChargingState", false) --## Set the charging state of the phone to false
]]--
Config = {
  Debug                 = false,   --## Enable/Disable Debugging (DISABLE THIS OR PEOPLE WILL BE ABLE TO SPAWN PHONES WITH /testPhone) 
  PoliceCount           = 0,      --## How many police need to be online for missions to happen? ( set jobs in dirk-core)
  AutoSave              = 5,      --## How often in minutes should the script save the data to the json within dirk-core (REMEMBER TO BACK UP THE FOLDER: dirk-core/saveddata if you ever update dirk-core)
  DealingAccount        = "cash", --## The account that the money will be taken from when a deal is completed (cash, bank, black_money)
  DealingAccountItem    = false,   --## If you want to use an item instead of money set this to true and set the item name above as the account (DONT USE UNLESS SMARTER THAN THE AVERGAE PEANUT)
  DeleteOldPhones       = 14,     --## In days how long before we should delete a phone that hasn't been used
  IgnoreZoneItemChances = false,  --## If set to true this will ignore the chances when deciding what drug to ask for and just check the players inventory for any drug that zone allows sale of
  notifyText            = true,  --## Notification aswell as sound when receving a message
  Items = {                 --## Define your item names here you can also add new entries here to use within your ContactZones
    --## Drugs 
   -- ['Cocaine']      = {PhysicalObject = "prop_meth_bag_01",     ItemName = 'cocainepackage',  Alias = {"cocaine", "coke", "blow", "booger sugar", "yayo"}}, --## Physical Object: This is an actual in-game prop/object that will be shown in either the buyer/sellers hands upon the deal 
    ['StardawgPack']      = {PhysicalObject = "prop_weed_bottle",     ItemName = 'stardawg_pack',  Alias = {"3.5"}}, --## Physical Object: This is an actual in-game prop/object that will be shown in either the buyer/sellers hands upon the deal 
   -- ['Weed']         = {PhysicalObject = "prop_weed_bottle",     ItemName = 'trimmed_weed',    Alias = {"weed", "dank", "loud", "kush"}},
  --  ['Meth']         = {PhysicalObject = "p_meth_bag_01_s",      ItemName = 'boxmeth',         Alias = {"meth", "ice", "crystal", "chunk"}},
 --   ['Crack']        = {PhysicalObject = "prop_meth_bag_01",     ItemName = 'cocainebaggy',    Alias = {"crack", "rock", "hard", "candy"}},
  --  ['Heroin']       = {PhysicalObject = "prop_meth_bag_01",     ItemName = 'cocainebaggy',    Alias = {"heroin", "junk", "dope", "chiva"}},
  --  ['Lean']         = {PhysicalObject = "prop_drug_bottle",     ItemName = 'cocainebaggy',    Alias = {"lean", "tussionex", "purple drank", "mississippi mud", "drank"}},
  --  ['Mushrooms']    = {PhysicalObject = "prop_meth_bag_01",     ItemName = 'cocainebaggy',    Alias = {"mushrooms", "shrooms", "brain melters", "gooms", "doomies"}},
  --  ['Oxy']          = {PhysicalObject = "prop_cs_pills",        ItemName = 'cocainebaggy',    Alias = {"oxy", "o.c.", "billy mays", "hilbilly heroin"}},
  --  ['Molly']        = {PhysicalObject = "hei_prop_pill_bag_01", ItemName = 'cocainebaggy',    Alias = {"molly", "moonrocks", "turn up", "sass"}},

    --## Weapons
    --['Pistol']       = {PhysicalObject = "w_pi_appistol",        ItemName = 'weapon_pistol',          Alias = {"shooters", "piece", "blicky"}},
  --  ['Rifle']        = {PhysicalObject = "w_ar_advancedrifle",   ItemName = 'weapon_assaultrifle',    Alias = {"boomer", "long boi", "broomstick"}},
 --   ['Knive']        = {PhysicalObject = "prop_cs_bowie_knife",  ItemName = 'weapon_knife',           Alias = {"pokey sticks", "slasher", "shanks"}},
  },

  Phone = {
    ItemName           = "burnerphone",    --## The item name of the phone if you wanted to change it
    MaxContactMessages = 30,               --## How many messages can a contact have before it starts deleting the oldest messages
    MaxNotifications   = 30,               --## How many notifications can a player have before it starts deleting the oldest notifications
    PricePerText       = 1,                --## How much should it cost per text message sent
    MaxContacts        = 30,               --## How many contacts can a player have in one phone?
    ChargeRate         = 0.5,              --## The loop runs every 30 seconds so if the phones plugged in for 30 seconds it'll recieve 5% of charge
    ChargeItem         = "charging_cable", --## The item name of the item that is required to charge the phone can also be false if you don't need an item and want to always allow charging in cars
    DischargeRate      = 0.1,              --## The loop runs every 30 seconds so if the phones unplugged for 30 seconds it'll lose 3% of charge
    WaterDamage        = true,             --## Set to false if you don't want the phone to take water damage
  },

  PoliceTablet  = {
    ItemName        = "descramble_tablet",
    DistFromMessage = 5000,                                 --## At the moment I've set it so you will be able to view messages from all over the city but if you wanted you could make it so they need to be closer to either the sender or reciever
    MessageTime     = 30,                                   --## In minutes how long should the messages be able to be interceptable for? After this time this message won't be interceptable
    JobLock         = {police = {1, 2, 3}, bcso = 0}, --## JobName, Rank or table of ranks
  },

  PhoneShops = {
    ['Downtown Phoneshop'] = {  --## Index will be the name of the shop on the map keep it unique
      Location = vector4(65.88, -1467.44, 28.3, 229.67),                              --## Location of the ped
      Ped      = 's_m_m_linecook',                                                    --## Ped model  
      Account  = "bank",                                                              --## Account you will use for purchasing phones/repairs/chargers
      Options  = {NewPhone = 500, Repair = 250, Charger = 100, Credit = 50},          --## What you can do at this shop, if you wanted to stop repairs simply just remove Repair = 250, or just set it to Repair = false, the amount you set as price for Credit will also be how many credits they get
      Blip     = {Scale = 0.75, Sprite = 817, Color = 52, Display = 4, Close = true}, --## Remove thise entire line should you want to hide blips
    }
  },
  
  HandOver = { 
    MoneyObject = "prop_cash_pile_02",                                                 --## This is the prop that will be seen in either the purchaser/sellers hand
    Blip        = {Scale = 0.75, Sprite = 366, Color = 52, Display = 4, Close = true}, --## This is the blip on the map for the handover
  },

  NoSignalZones = { --## While inside this zone the user will have no signal? https://skyrossm.github.io/PolyZoneCreator/
    { --## CHILLIAD
      vector2(-350.00, 5716.67),
      vector2(-1125.76, 5189.39),
      vector2(-1731.82, 4674.24),
      vector2(-1483.33, 4383.33),
      vector2(-986.36, 4389.39),
      vector2(-125.76, 4413.64),
      vector2(383.33, 4219.70),
      vector2(746.97, 4134.85),
      vector2(1395.45, 4201.52),
      vector2(1625.76, 4431.82),
      vector2(1516.67, 4940.91),
      vector2(2050.00, 5310.61),
      vector2(2207.58, 5316.67),
      vector2(2480.30, 5419.70),
      vector2(2201.52, 6019.70),
      vector2(1613.64, 6346.97),
      vector2(686.36, 6413.64)
    },
    { --## CHILLIAD SOUTH
      vector2(-2428.79, 3462.12),
      vector2(-2289.39, 4104.55),
      vector2(-1950.00, 4510.61),
      vector2(-1816.67, 4559.09),
      vector2(-1483.33, 4237.88),
      vector2(-531.82, 4340.91),
      vector2(-216.67, 4231.82),
      vector2(-174.24, 3734.85),
      vector2(-119.70, 3583.33),
      vector2(50.00, 3353.03),
      vector2(-53.03, 3104.55),
      vector2(110.61, 2322.73),
      vector2(-2646.97, 2274.24)
    },
    { --## CHILLIAD NORTH EAST
      vector2(1607.58, 6619.70),
      vector2(1692.42, 6407.58),
      vector2(2122.73, 6316.67),
      vector2(2801.52, 5583.33),
      vector2(2856.06, 5104.55),
      vector2(3128.79, 3946.97),
      vector2(3813.64, 3916.67),
      vector2(3880.30, 4165.15),
      vector2(3401.52, 6043.94),
      vector2(2850.00, 6510.61),
      vector2(2110.61, 6753.03)
    }
  },

  ContactZones = { 
    ['paleto'] = {
      Polyzone = {                                                 --## Area where these contacts are found use this tool to create zones: https://skyrossm.github.io/PolyZoneCreator/
        vector2(-622.73, 6250.00),
        vector2(-89.39, 6765.15),
        vector2(159.09, 7059.09),
        vector2(668.18, 6443.94),
        vector2(-389.39, 5753.03)
      },
      ContactIcon      = "fas fa-message",                         --## Font Awesome Icon
      MessageFrequency = 10,                                       --## How often in minutes can a user get a message from a contact from this area
      MessageChance    = 50,                                      --## What is the chance of a contact from this area sending a message to the player
      TimeToAccept     = 10,                                       --## In minutes how long do you have to accept before the contact will call the deal off
      TimeToMeet       = 10,                                       --## In minutes how long do you have to meet the contact before the contact will call the deal off
      ExchangeChance   = {Success = 80, Fight = 30,  Snitch = 20}, --## Chance of a contact from this area refusing to exchange details with the player
      DealChance       = {Success = 70, Snitch = 20, Steal  = 30}, --## Chance of this type of contacts deal going sour or being successful
      Items            = {
      ---  {Item = "Cocaine",   Type = "SALE", Chance = 60, Price = {70,90},  Amount = {7,14}},
      ---  {Item = "Heroin",    Type = "SALE", Chance = 10, Price = {60,100}, Amount = {3,10}},
      ---  {Item = "Weed",      Type = "SALE", Chance = 80, Price = {30,30},  Amount = {7,28}},

        {Item = "StardawgPack",      Type = "SALE", Chance = 80, Price = {30,30},  Amount = {7,28}},
    ---    {Item = "Oxy",       Type = "SALE", Chance = 40, Price = {40,70},  Amount = {15,20}},
    ---    {Item = "Molly",     Type = "SALE", Chance = 50, Price = {20,50},  Amount = {3,10}},
    ---    {Item = "Lean",      Type = "SALE", Chance = 30, Price = {30,30},  Amount = {2,6}},
       --- {Item = "Mushrooms", Type = "SALE", Chance = 45, Price = {15,25},  Amount = {6,14}},   
      },
    },
    ['grapeseed'] = {
      Polyzone = { ---## Area where these contacts are found use this tool to create zones: https://skyrossm.github.io/PolyZoneCreator/
        vector2(1643.94, 4950.00),
        vector2(2159.09, 5253.03),
        vector2(2656.06, 5068.18),
        vector2(2792.42, 4386.36),
        vector2(2492.42, 4086.36),
        vector2(1653.03, 4574.24)
      },
      ContactIcon      = "fas fa-message",                         --## Font Awesome Icon
      MessageFrequency = 10,                                       --## How often in minutes can a user get a message from a contact from this area
      MessageChance    = 50,                                      --## What is the chance of a contact from this area sending a message to the player
      TimeToAccept     = 10,                                       --## In minutes how long do you have to accept before the contact will call the deal off
      TimeToMeet       = 10,                                       --## In minutes how long do you have to meet the contact before the contact will call the deal off
      ExchangeChance   = {Success = 80, Fight = 30,  Snitch = 20}, --## Chance of a contact from this area refusing to exchange details with the player
      DealChance       = {Success = 70, Snitch = 20, Steal  = 30}, --## Chance of this type of contacts deal going sour or being successful
      Items            = {
        {Item = "StardawgPack",      Type = "SALE", Chance = 80, Price = {30,30},  Amount = {7,28}},

      --  {Item = "Cocaine",   Type = "SALE", Chance = 60, Price = {70,90},  Amount = {7,14}},
      --  {Item = "Heroin",    Type = "SALE", Chance = 10, Price = {60,100}, Amount = {3,10}},
      --  {Item = "Weed",      Type = "SALE", Chance = 80, Price = {30,30},  Amount = {7,28}},
     --   {Item = "Oxy",       Type = "SALE", Chance = 40, Price = {40,70},  Amount = {15,20}},
     --   {Item = "Molly",     Type = "SALE", Chance = 50, Price = {20,50},  Amount = {3,10}},
      --  {Item = "Lean",      Type = "SALE", Chance = 30, Price = {30,30},  Amount = {2,6}},
      --  {Item = "Mushrooms", Type = "SALE", Chance = 45, Price = {15,25},  Amount = {6,14}},  
      },
    },
    ['sandyshores'] = {
      Polyzone = { ---## Area where these contacts are found use this tool to create zones: https://skyrossm.github.io/PolyZoneCreator/
        vector2(353.03, 3589.39),
        vector2(104.55, 3334.85),
        vector2(131.82, 2516.67),
        vector2(1525.76, 2665.15),
        vector2(2277.27, 2989.39),
        vector2(2204.55, 3880.30),
        vector2(1910.61, 4037.88)
      },
      ContactIcon      = "fas fa-message",                         --## Font Awesome Icon
      MessageFrequency = 10,                                       --## How often in minutes can a user get a message from a contact from this area
      MessageChance    = 90,                                       --## What is the chance of a contact from this area sending a message to the player
      TimeToAccept     = 3,                                        --## In minutes how long do you have to accept before the contact will call the deal off
      TimeToMeet       = 8,                                        --## In minutes how long do you have to meet the contact before the contact will call the deal off
      ExchangeChance   = {Success = 90, Fight = 50,  Snitch = 10}, --## Chance of a contact from this area refusing to exchange details with the player
      DealChance       = {Success = 60, Snitch = 20, Steal = 50}, --## Chance of this type of contacts deal going sour or being successful
      Items            = {
        {Item = "StardawgPack",      Type = "SALE", Chance = 80, Price = {30,30},  Amount = {7,28}},

      --  {Item = "Cocaine",   Type = "SALE", Chance = 60, Price = {70,90},  Amount = {7,14}},
      --  {Item = "Heroin",    Type = "SALE", Chance = 10, Price = {60,100}, Amount = {3,10}},
      --  {Item = "Weed",      Type = "SALE", Chance = 80, Price = {30,30},  Amount = {7,28}},
     --   {Item = "Oxy",       Type = "SALE", Chance = 40, Price = {40,70},  Amount = {15,20}},
     --   {Item = "Molly",     Type = "SALE", Chance = 50, Price = {20,50},  Amount = {3,10}},
      --  {Item = "Lean",      Type = "SALE", Chance = 30, Price = {30,30},  Amount = {2,6}},
      --  {Item = "Mushrooms", Type = "SALE", Chance = 45, Price = {15,25},  Amount = {6,14}},  
      },
    },
    --## CITY ZONES
    ['chumash'] = {
      Polyzone = { ---## Area where these contacts are found use this tool to create zones: https://skyrossm.github.io/PolyZoneCreator/
        vector2(-2919.70, 298.48),
        vector2(-3119.70, 189.39),
        vector2(-3198.48, 262.12),
        vector2(-3095.45, 559.09),
        vector2(-3307.58, 898.48),
        vector2(-3453.03, 946.97),
        vector2(-3422.73, 1025.76),
        vector2(-3289.39, 1050.00),
        vector2(-3277.27, 1340.91),
        vector2(-3034.85, 1328.79),
        vector2(-2877.27, 589.39)
      },
      ContactIcon      = "fas fa-message",                         --## Font Awesome Icon
      MessageFrequency = 20,                                       --## How often in minutes can a user get a message from a contact from this area
      MessageChance    = 75,                                       --## What is the chance of a contact from this area sending a message to the player
      TimeToAccept     = 5,                                       --## In minutes how long do you have to accept before the contact will call the deal off
      TimeToMeet       = 10,                                       --## In minutes how long do you have to meet the contact before the contact will call the deal off
      ExchangeChance   = {Success = 60, Fight  = 20, Snitch = 40}, --## Chance of a contact from this area refusing to exchange details with the player
      DealChance       = {Success = 70, Snitch = 25, Steal  = 15}, --## Chance of this type of contacts deal going sour or being successful
      Items            = {
        {Item = "StardawgPack",      Type = "SALE", Chance = 80, Price = {30,30},  Amount = {7,28}},

      --  {Item = "Cocaine",   Type = "SALE", Chance = 60, Price = {70,90},  Amount = {7,14}},
      --  {Item = "Heroin",    Type = "SALE", Chance = 10, Price = {60,100}, Amount = {3,10}},
      --  {Item = "Weed",      Type = "SALE", Chance = 80, Price = {30,30},  Amount = {7,28}},
     --   {Item = "Oxy",       Type = "SALE", Chance = 40, Price = {40,70},  Amount = {15,20}},
     --   {Item = "Molly",     Type = "SALE", Chance = 50, Price = {20,50},  Amount = {3,10}},
      --  {Item = "Lean",      Type = "SALE", Chance = 30, Price = {30,30},  Amount = {2,6}},
      --  {Item = "Mushrooms", Type = "SALE", Chance = 45, Price = {15,25},  Amount = {6,14}},  
      },
    },
    ['vinewoodhills'] = {
      Polyzone = { ---## Area where these contacts are found use this tool to create zones: https://skyrossm.github.io/PolyZoneCreator/
        vector2(-2065.15, 698.48),
        vector2(-1922.73, 28.79),
        vector2(-1562.12, -216.67),
        vector2(-1383.33, -65.15),
        vector2(-1013.64, -153.03),
        vector2(-656.06, -40.91),
        vector2(-771.21, 222.73),
        vector2(-828.79, 365.15),
        vector2(-559.09, 356.06),
        vector2(-295.45, 301.52),
        vector2(22.73, 280.30),
        vector2(231.82, 428.79),
        vector2(413.64, 425.76),
        vector2(259.09, 974.24),
        vector2(-213.64, 1062.12),
        vector2(-450.00, 886.36),
        vector2(-713.64, 913.64),
        vector2(-1250.00, 843.94),
        vector2(-1659.09, 771.21)
      },
      ContactIcon      = "fas fa-message",                         --## Font Awesome Icon
      MessageFrequency = 15,                                       --## How often in minutes can a user get a message from a contact from this area
      MessageChance    = 50,                                       --## What is the chance of a contact from this area sending a message to the player
      TimeToAccept     = 5,                                        --## In minutes how long do you have to accept before the contact will call the deal off
      TimeToMeet       = 5,                                        --## In minutes how long do you have to meet the contact before the contact will call the deal off
      ExchangeChance   = {Success = 50, Fight  = 10, Snitch = 60}, --## Chance of a contact from this area refusing to exchange details with the player
      DealChance       = {Success = 70, Snitch = 30, Steal  = 10}, --## Chance of this type of contacts deal going sour or being successful
      Items            = {
        {Item = "StardawgPack",      Type = "SALE", Chance = 80, Price = {30,30},  Amount = {7,28}},

      --  {Item = "Cocaine",   Type = "SALE", Chance = 60, Price = {70,90},  Amount = {7,14}},
      --  {Item = "Heroin",    Type = "SALE", Chance = 10, Price = {60,100}, Amount = {3,10}},
      --  {Item = "Weed",      Type = "SALE", Chance = 80, Price = {30,30},  Amount = {7,28}},
     --   {Item = "Oxy",       Type = "SALE", Chance = 40, Price = {40,70},  Amount = {15,20}},
     --   {Item = "Molly",     Type = "SALE", Chance = 50, Price = {20,50},  Amount = {3,10}},
      --  {Item = "Lean",      Type = "SALE", Chance = 30, Price = {30,30},  Amount = {2,6}},
      --  {Item = "Mushrooms", Type = "SALE", Chance = 45, Price = {15,25},  Amount = {6,14}},  
      },
    },
    ['southlossantos'] = {
      Polyzone = { ---## Area where these contacts are found use this tool to create zones: https://skyrossm.github.io/PolyZoneCreator/
        vector2(89.39, -2004.55),
        vector2(242.42, -2092.42),
        vector2(375.76, -2186.36),
        vector2(606.06, -1996.97),
        vector2(637.88, -1528.79),
        vector2(533.33, -1245.45),
        vector2(-400.00, -1236.36),
        vector2(-363.64, -1590.91),
        vector2(-121.21, -1819.70)
      },
      ContactIcon      = "fas fa-message",                         --## Font Awesome Icon
      MessageFrequency = 0.5,                                        --## How often in minutes can a user get a message from a contact from this area
      MessageChance    = 100,                                      --## What is the chance of a contact from this area sending a message to the player
      TimeToAccept     = 8,                                        --## In minutes how long do you have to accept before the contact will call the deal off
      TimeToMeet       = 10,                                        --## In minutes how long do you have to meet the contact before the contact will call the deal off
      ExchangeChance   = {Success = 80,  Fight  = 50,  Snitch = 20},   --## Chance of a contact from this area refusing to exchange details with the player
      DealChance       = {Success = 75,  Snitch = 10,  Steal  = 60}, --## Chance of this type of contacts deal going sour or being successful
      Items            = {
        {Item = "StardawgPack",      Type = "SALE", Chance = 80, Price = {30,30},  Amount = {7,28}},

      --  {Item = "Cocaine",   Type = "SALE", Chance = 60, Price = {70,90},  Amount = {7,14}},
      --  {Item = "Heroin",    Type = "SALE", Chance = 10, Price = {60,100}, Amount = {3,10}},
      --  {Item = "Weed",      Type = "SALE", Chance = 80, Price = {30,30},  Amount = {7,28}},
     --   {Item = "Oxy",       Type = "SALE", Chance = 40, Price = {40,70},  Amount = {15,20}},
     --   {Item = "Molly",     Type = "SALE", Chance = 50, Price = {20,50},  Amount = {3,10}},
      --  {Item = "Lean",      Type = "SALE", Chance = 30, Price = {30,30},  Amount = {2,6}},
      --  {Item = "Mushrooms", Type = "SALE", Chance = 45, Price = {15,25},  Amount = {6,14}},  
      },
    },
    ['eastlossantos'] = {
      Polyzone = { ---## Area where these contacts are found use this tool to create zones: https://skyrossm.github.io/PolyZoneCreator/
        vector2(1172.73, -1834.85),
        vector2(1112.88, -1643.18),
        vector2(1267.42, -1500.76),
        vector2(1458.33, -1453.79),
        vector2(1497.73, -1503.79),
        vector2(1493.18, -1755.30)
      },
      ContactIcon      = "fas fa-message",                         --## Font Awesome Icon
      MessageFrequency = 10,                                       --## How often in minutes can a user get a message from a contact from this area
      MessageChance    = 90,                                       --## What is the chance of a contact from this area sending a message to the player
      TimeToAccept     = 3,                                        --## In minutes how long do you have to accept before the contact will call the deal off
      TimeToMeet       = 8,                                        --## In minutes how long do you have to meet the contact before the contact will call the deal off
      ExchangeChance   = {Success = 90, Fight = 50,  Snitch = 10}, --## Chance of a contact from this area refusing to exchange details with the player
      DealChance       = {Success = 60, Snitch = 20, Steal = 50}, --## Chance of this type of contacts deal going sour or being successful
      Items            = {
        {Item = "StardawgPack",      Type = "SALE", Chance = 80, Price = {30,30},  Amount = {7,28}},

      --  {Item = "Cocaine",   Type = "SALE", Chance = 60, Price = {70,90},  Amount = {7,14}},
      --  {Item = "Heroin",    Type = "SALE", Chance = 10, Price = {60,100}, Amount = {3,10}},
      --  {Item = "Weed",      Type = "SALE", Chance = 80, Price = {30,30},  Amount = {7,28}},
     --   {Item = "Oxy",       Type = "SALE", Chance = 40, Price = {40,70},  Amount = {15,20}},
     --   {Item = "Molly",     Type = "SALE", Chance = 50, Price = {20,50},  Amount = {3,10}},
      --  {Item = "Lean",      Type = "SALE", Chance = 30, Price = {30,30},  Amount = {2,6}},
      --  {Item = "Mushrooms", Type = "SALE", Chance = 45, Price = {15,25},  Amount = {6,14}},  
      },
    },
    ['vespucci'] = { --## TOURIST AREA THAT BUYS RECRETIONAL DRUGS FOR A HIGH PRICE IN SMALL QUANTITIES WITH MEDIUM RISK MORE FREQUENTLY 
      Polyzone = { ---## Area where these contacts are found use this tool to create zones: https://skyrossm.github.io/PolyZoneCreator/
        vector2(-2180.30, -486.36),
        vector2(-2077.27, -401.52),
        vector2(-1562.12, -798.48),
        vector2(-1286.36, -907.58),
        vector2(-1001.52, -789.39),
        vector2(-719.70, -1168.18),
        vector2(-671.21, -1516.67),
        vector2(-1192.42, -1995.45)
      },
      ContactIcon      = "fas fa-message",                         --## Font Awesome Icon
      MessageFrequency = 30,                                       --## How often in minutes can a user get a message from a contact from this area
      MessageChance    = 70,                                       --## What is the chance of a contact from this area sending a message to the player
      TimeToAccept     = 5,                                       --## In minutes how long do you have to accept before the contact will call the deal off
      TimeToMeet       = 10,                                       --## In minutes how long do you have to meet the contact before the contact will call the deal off
      ExchangeChance   = {Success = 60, Fight  = 50, Snitch = 30}, --## Chance of a contact from this area refusing to exchange details with the player
      DealChance       = {Success = 60, Snitch = 30, Steal  = 20}, --## Chance of this type of contacts deal going sour or being successful
      Items            = {
        {Item = "StardawgPack",      Type = "SALE", Chance = 80, Price = {30,30},  Amount = {7,28}},

      --  {Item = "Cocaine",   Type = "SALE", Chance = 60, Price = {70,90},  Amount = {7,14}},
      --  {Item = "Heroin",    Type = "SALE", Chance = 10, Price = {60,100}, Amount = {3,10}},
      --  {Item = "Weed",      Type = "SALE", Chance = 80, Price = {30,30},  Amount = {7,28}},
     --   {Item = "Oxy",       Type = "SALE", Chance = 40, Price = {40,70},  Amount = {15,20}},
     --   {Item = "Molly",     Type = "SALE", Chance = 50, Price = {20,50},  Amount = {3,10}},
      --  {Item = "Lean",      Type = "SALE", Chance = 30, Price = {30,30},  Amount = {2,6}},
      --  {Item = "Mushrooms", Type = "SALE", Chance = 45, Price = {15,25},  Amount = {6,14}},  
      },
    },
    ['nicolaave'] = { --## POSH AREA THAT BUYS RECRETIONAL DRUGS FOR A HIGH PRICE IN SMALL QUANTITIES WITH LITTLE RISK LESS FREQUENTLY 
      Polyzone = { ---## Area where these contacts are found use this tool to create zones: https://skyrossm.github.io/PolyZoneCreator/
        vector2(813.64, -600.00),
        vector2(815.15, -474.24),
        vector2(1057.58, -348.48),
        vector2(1178.79, -289.39),
        vector2(1319.70, -366.67),
        vector2(1450.00, -589.39),
        vector2(1383.33, -692.42),
        vector2(1192.42, -831.82),
        vector2(1022.73, -818.18),
        vector2(860.61, -675.76)
      },
      ContactIcon      = "fas fa-message",                         --## Font Awesome Icon
      MessageFrequency = 20,                                       --## How often in minutes can a user get a message from a contact from this area
      MessageChance    = 75,                                       --## What is the chance of a contact from this area sending a message to the player
      TimeToAccept     = 5,                                       --## In minutes how long do you have to accept before the contact will call the deal off
      TimeToMeet       = 10,                                       --## In minutes how long do you have to meet the contact before the contact will call the deal off
      ExchangeChance   = {Success = 60, Fight  = 20, Snitch = 40}, --## Chance of a contact from this area refusing to exchange details with the player
      DealChance       = {Success = 70, Snitch = 25, Steal  = 15}, --## Chance of this type of contacts deal going sour or being successful
      Items            = {
        {Item = "StardawgPack",      Type = "SALE", Chance = 80, Price = {30,30},  Amount = {7,28}},

      --  {Item = "Cocaine",   Type = "SALE", Chance = 60, Price = {70,90},  Amount = {7,14}},
      --  {Item = "Heroin",    Type = "SALE", Chance = 10, Price = {60,100}, Amount = {3,10}},
      --  {Item = "Weed",      Type = "SALE", Chance = 80, Price = {30,30},  Amount = {7,28}},
     --   {Item = "Oxy",       Type = "SALE", Chance = 40, Price = {40,70},  Amount = {15,20}},
     --   {Item = "Molly",     Type = "SALE", Chance = 50, Price = {20,50},  Amount = {3,10}},
      --  {Item = "Lean",      Type = "SALE", Chance = 30, Price = {30,30},  Amount = {2,6}},
      --  {Item = "Mushrooms", Type = "SALE", Chance = 45, Price = {15,25},  Amount = {6,14}},  
      },
    },
    ['docks'] = {
      Polyzone = { ---## Area where these contacts are found use this tool to create zones: https://skyrossm.github.io/PolyZoneCreator/
        vector2(1277.27, -3425.76),
        vector2(95.45, -3383.33),
        vector2(-625.76, -2874.24),
        vector2(-471.21, -2371.21),
        vector2(-59.09, -2319.70),
        vector2(522.73, -2346.97),
        vector2(1001.52, -2783.33),
        vector2(1319.70, -2883.33),
        vector2(1395.45, -3292.42)
      },
      ContactIcon      = "fas fa-message",                         --## Font Awesome Icon
      MessageFrequency = 60 * 72,                                  --## How often in minutes can a user get a message from a contact from this area 
      MessageChance    = 75,                                       --## What is the chance of a contact from this area sending a message to the player
      TimeToAccept     = 10,                                       --## In minutes how long do you have to accept before the contact will call the deal off
      TimeToMeet       = 15,                                       --## In minutes how long do you have to meet the contact before the contact will call the deal off
      ExchangeChance   = {Success = 80, Fight = 30,Snitch = 20},   --## Chance of a contact from this area refusing to exchange details with the player
      DealChance       = {Success = 10, Snitch = 10, Steal = 100}, --## Chance of this type of contacts deal going sour or being successful
      Items            = {
        {Item = "StardawgPack",      Type = "SALE", Chance = 80, Price = {30,30},  Amount = {7,28}},

      --  {Item = "Cocaine",   Type = "SALE", Chance = 60, Price = {70,90},  Amount = {7,14}},
      --  {Item = "Heroin",    Type = "SALE", Chance = 10, Price = {60,100}, Amount = {3,10}},
      --  {Item = "Weed",      Type = "SALE", Chance = 80, Price = {30,30},  Amount = {7,28}},
     --   {Item = "Oxy",       Type = "SALE", Chance = 40, Price = {40,70},  Amount = {15,20}},
     --   {Item = "Molly",     Type = "SALE", Chance = 50, Price = {20,50},  Amount = {3,10}},
      --  {Item = "Lean",      Type = "SALE", Chance = 30, Price = {30,30},  Amount = {2,6}},
      --  {Item = "Mushrooms", Type = "SALE", Chance = 45, Price = {15,25},  Amount = {6,14}},  
      },
    },
    ['airport'] = {
      Polyzone = { ---## Area where these contacts are found use this tool to create zones: https://skyrossm.github.io/PolyZoneCreator/
        vector2(-1513.64, -2004.55),
        vector2(-2271.21, -3174.24),
        vector2(-846.97, -3750.00),
        vector2(-604.55, -3137.88),
        vector2(-756.06, -2731.82),
        vector2(-574.24, -2459.09)
      },
      ContactIcon      = "fas fa-message",                         --## Font Awesome Icon
      MessageFrequency = 60 * 72,                                  --## How often in minutes can a user get a message from a contact from this area 
      MessageChance    = 75,                                       --## What is the chance of a contact from this area sending a message to the player
      TimeToAccept     = 10,                                       --## In minutes how long do you have to accept before the contact will call the deal off
      TimeToMeet       = 15,                                       --## In minutes how long do you have to meet the contact before the contact will call the deal off
      ExchangeChance   = {Success = 80, Fight = 30,Snitch = 20},   --## Chance of a contact from this area refusing to exchange details with the player
      DealChance       = {Success = 10, Snitch = 10, Steal = 100}, --## Chance of this type of contacts deal going sour or being successful
      Items            = {
        {Item = "StardawgPack",      Type = "SALE", Chance = 80, Price = {30,30},  Amount = {7,28}},

      --  {Item = "Cocaine",   Type = "SALE", Chance = 60, Price = {70,90},  Amount = {7,14}},
      --  {Item = "Heroin",    Type = "SALE", Chance = 10, Price = {60,100}, Amount = {3,10}},
      --  {Item = "Weed",      Type = "SALE", Chance = 80, Price = {30,30},  Amount = {7,28}},
     --   {Item = "Oxy",       Type = "SALE", Chance = 40, Price = {40,70},  Amount = {15,20}},
     --   {Item = "Molly",     Type = "SALE", Chance = 50, Price = {20,50},  Amount = {3,10}},
      --  {Item = "Lean",      Type = "SALE", Chance = 30, Price = {30,30},  Amount = {2,6}},
      --  {Item = "Mushrooms", Type = "SALE", Chance = 45, Price = {15,25},  Amount = {6,14}},  
      },
    }
  },

  ReqItems = {
    ['burnerphone'] = {
      ['name']        = 'burnerphone',               
      ['label']       = 'Burner Phone',          
      ['weight']      = 100,   
      ['type']        = 'item',    
      ['image']       = 'burnerphone.png',       
      ['unique']      = true,   
      ['useable']     = true,  
      ['shouldClose'] = true,   
      ['combinable']  = nil,   
      ['description'] = 'Cheap throwaway phone'
    },
    ['charging_cable'] = {
      ['name']        = 'charging_cable',               
      ['label']       = 'Charging Cable',          
      ['weight']      = 100,   
      ['type']        = 'item',    
      ['image']       = 'charging_cable.png',       
      ['unique']      = false,   
      ['useable']     = false,  
      ['shouldClose'] = false,   
      ['combinable']  = nil,   
      ['description'] = 'Cheap phone charger'
    },
    ['descramble_tablet'] = {
      ['name']        = 'descramble_tablet',               
      ['label']       = 'Police Tablet',          
      ['weight']      = 100,   
      ['type']        = 'item',    
      ['image']       = 'descramble_tablet.png',       
      ['unique']      = false,   
      ['useable']     = true,  
      ['shouldClose'] = false,   
      ['combinable']  = nil,   
      ['description'] = 'Police tablet used to descramble burner phone messages',
    },
  },
}

debugPrint = function(msg)
  if Config.Debug then 
    print('^8DIRK-BURNERPHONE^7 : '..msg)
  end
end

Core, Settings = exports['dirk-core']:getCore()