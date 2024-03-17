--## Translate the script here.
Labels = {
  ['ENG'] = {
    InvSeize           = "This inventory has been seized everything has been destroyed",
    WrongJob           = "You do not have the correct job or rank for this aciton",
    CantAccess         = "You cannot access this right now",
    ChangedLocks       = "You have changed the locks",
    YouPurchased       = "You have just purchased %s", 
    RedeemedLab        = "You just redeemed your lab: %s thank you for supporting our server",
    NewKey             = "You have recieved a key for: %s", 
    NotEnoughMoney     = "You do not have enough money",
    OrderTooSoon       = "You can't order again this soon",
    NoAccess           = "You do not have access to this lab.",
    DeliveryMission    = "Ingredients Pickup", --## Blip Text
    HeadToPickup       = "Head to the pickup point marked on your map",
    HeadToLab          = "Head to back to the lab and deliver the goods",
    ParkInMarker       = "Park in the indicated spot", 
    PressToDeliver     = "Deliver Goods",
    returnBlip         = "Drop Point",
    MissionComplete    = "You have completed the mission the goods are in the labs stockpile",
    ItemsAddedStock    = "The reward items have been added to the labs stockpile",
    TransferOwnership  = "You have transferred ownership of this labratory",
    GainedOwnership    = "You have gained ownership of this labratory",
    RaidedLab          = "You have raided this lab and it's now offline for %s hours",
    NeedRaidTool       = "You need a raid tool in order to do this",
    NothingToRedeem    = "You have no labs to redeem",
    NoMissionAvailable = "There are no missions available right now",
    AppearsRaided      = "This lab appears to have been raided",
  },
}



Targets = {

  -- Lab Entrance
  TebexLab = {
    Label = "Purchase from Tebex",
    Icon  = "fa-solid fa-money-bill-1",
  },

  BuyLab = {
    Label = "Buy Lab for $%s",
    Icon  = "fa-solid fa-money-bill-1",
  },
  EnterLab = {
    Label = "Enter Lab",
    Icon  = "fa-solid fa-door-open",
  },
  RaidLab = {
    Label = "Raid Lab",
    Icon  = "fa-solid fa-hammer",
  },

  -- Lab Exit
  ExitLab = {
    Label = "Exit Lab",
    Icon  = "fa-solid fa-door-open",
  },
  GenerateKey = {
    Label = "Generate Key",
    Icon  = "fa-solid fa-key",    
  },
  ChangeLocks = {
    Label = "Change Locks",
    Icon  = "fa-solid fa-lock",    
  },
  Transfer = {
    Label = "Transfer Ownership",
    Icon  = "fa-solid fa-right-left",    
  },
  OrderIngredients = {
    Label = "Order Ingredients",
    Icon  = "fa-solid fa-truck",    
  },


  -- StockPile 
  OpenStockPile = {
    Label = "Open Stockpile",
    Icon  = "fa-solid fa-box-open",    
  },
  SeizeDrugs = {
    Label = "Seize Drugs",
    Icon  = "fa-solid fa-dumpster",    
  },
}