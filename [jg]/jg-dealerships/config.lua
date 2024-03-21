-----------------------------------------------------------------------------------
-- WAIT! Before editing this file manually, try our new easy configuration tool! --
--               https://configurator.jgscripts.com/dealerships                  --
-----------------------------------------------------------------------------------
Config = {}

Config.Locale = "en"
Config.NumberAndDateFormat = "en-GB"
Config.Currency = "GBP"
Config.SpeedUnit = "mph"
Config.Logging = false
Config.PlateFormat = "1AA111AA" -- https://docs.jgscripts.com/dealerships/plate-format
Config.DisableServerVehicleSpawning = false -- Set to true to use CreateVehicle instead of CreateVehicleServerSetter (only do this if you know what you're doing, or told to do so by support)

Config.Framework = "QBCore"  -- or "ESX"
Config.FuelSystem = "LegacyFuel" -- or "LegacyFuel", "ps-fuel", "lj-fuel", "ox_fuel", "cdn-fuel", "hyon_gas_station", "okokGasStation", "nd_fuel", "myFuel", "ti_fuel", "none"
Config.VehicleKeys = "qb-vehiclekeys" -- or "qb-vehiclekeys", "jaksam-vehicles-keys", "qs-vehiclekeys", "mk_vehiclekeys", "wasabi_carlock", "cd_garage", "okokGarage", "t1ger_keys", "none"
Config.Notifications = "default" -- or "okokNotify", "ox_lib", "ps-ui"

Config.DrawText = "qb-DrawText" -- or "qb-DrawText", "okokTextUI", "ox_lib", "ps-ui"
Config.OpenShowroomPrompt = "[E] Open Showroom"
Config.OpenShowroomKeyBind = 38
Config.ViewInShowroomPrompt = "[E] View in Showroom"
Config.ViewInShowroomKeyBind = 38
Config.OpenManagementPrompt = "[E] Dealership Management"
Config.OpenManagementKeyBind = 38
Config.SellVehiclePrompt = "[E] Sell Vehicle"
Config.SellVehicleKeyBind = 38

Config.FinancePayments = 12
Config.FinanceDownPayment = 0.1 -- 0.1 means 10%
Config.FinanceInterest = 0.1 -- 0.1 means 10%
Config.FinancePaymentInterval = 12 -- in hours
Config.FinancePaymentFailedHoursUntilRepo = 1 -- in hours
Config.MaxFinancedVehiclesPerPlayer = 5

Config.TestDrivePlate = "TESTER"
Config.TestDriveTimeSeconds = 120
Config.TestDriveNotInBucket = false -- Set to true for everyone to see the test driven vehicle (player is instanced by default)

Config.DisplayVehiclesPlate = "DEALER"
Config.DisplayVehiclesHidePurchasePrompt = false
Config.DisplayVehiclesPurchasePromptDistance = 3.1

Config.DealerPurchasePrice = 0.8 -- 0.8 = Dealers pay 80% of vehicle price
Config.VehicleOrderTime = 1 -- in mins

Config.Categories = {
  planes = "Planes",
  sportsclassics = "Sports Classics",
  sedans = "Sedans",
  compacts = "Compacts",
  motorcycles = "Motorcycles",
  super = "Super",
  offroad = "Offroad",
  helicopters = "Helicopters",
  coupes = "Coupes",
  muscle = "Muscle",
  boats = "Boats",
  vans = "Vans",
  sports = "Sports",
  suvs = "SUVs",
  commercial = "Commercial",
  cycles = "Cycles",
  industrial = "Industrial"
}

Config.DealershipLocations = {
  ["pdm"] = {
    type = "self-service", -- or "owned", "self-service"
    openShowroom = vector3(-55.99, -1096.59, 26.42),
    openManagement = vector3(-30.43, -1106.84, 26.42),
    purchaseSpawn = vector4(-13.68, -1092.31, 26.67, 159.82),
    testDriveSpawn = vector4(-49.77, -1110.83, 26.44, 75.94),
    camera = {
      name = "Car",
      coords = vector4(-146.6166, -596.6301, 166.0000, 120.0),
      positions = {5.0, 8.0, 12.0, 8.0}
    },
    categories = {"sedans", "compacts", "motorcycles", "offroad", "coupes", "muscle", "suvs"},
    enableTestDrive = true,
    hideBlip = false,
    blip = {
      id = 326,
      color = 2,
      scale = 0.6
    },
    enableSellVehicle = true, -- Allow players to sell vehicles back to dealer
    sellVehiclePercent = 0.6,  -- 60% of current sale price
    sellVehicle = vector3(-27.89, -1082.1, 26.64),
    enableFinance = true,
    hideMarkers = false,
    markers = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
    showroomJobWhitelist = {},
    showroomGangWhitelist = {},
    societyPurchaseJobWhitelist = {},
    societyPurchaseGangWhitelist = {},
    disableShowroomPurchase = false,
    job = "cardealer", -- Owned dealerships only
    directSaleDistance = 50,
  },
}

Config.ReturnToPreviousRoutingBucket = false
Config.HideWatermark = false