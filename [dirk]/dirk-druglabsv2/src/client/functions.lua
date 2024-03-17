
local curBlips = {}
local Job      = {}

PLAYER_GROUP = GetHashKey('PLAYER')


RegisterNetEvent("Dirk-Core:JobChange", function(job)
  Job = job
end)

Init = function()
  _,guardGroup = AddRelationshipGroup('GUARDS')
  while not Core do Wait(500); end 
  while not Core.Player.Ready() do Wait(500); end
  Core.Callback("DrugLabs:GetConfig", function(cfg)
    Config = cfg
    cb = true
  end)
  while not cb do Wait(0); end
  Core.Player.GetJob()
  while not Config.Labs do Wait(0); end
  for k,v in pairs(Config.Labs) do 
    AddLabDoorTarget(k)
  end
  -- Blips
  for k,v in pairs(Config.Labs) do
    if v.Blip then 
      curBlips[k] = Core.Game.AddBlip(v.Door,{
        Text       =  k,
        Sprite     =  v.Blip.Sprite,
        Display    =  v.Blip.Display,
        Scale      =  v.Blip.Scale,
        Color      =  v.Blip.Color, 
        ShortRange =  v.Blip.Close,
      })
    end
  end
  -- Relationships
  SetRelationshipBetweenGroups(5, PLAYER_GROUP, guardGroup)
  SetRelationshipBetweenGroups(5, guardGroup, PLAYER_GROUP)
end


Citizen.CreateThread(Init)
Citizen.CreateThread(function()
  while not Settings do Wait(0); end
  if Settings.Inventory == "ox_inventory" then 
    exports.ox_inventory:displayMetadata({
      Lab = "Lab",
      LockID = 'Lock ID'
    })
  end
end)

local DoorTargets = {}
AddLabDoorTarget = function(l)
  local lData = Config.Labs[l]
  local buyText = string.format(Targets.BuyLab.Label, lData.Access.Ownable)
  local buyIcon = Targets.BuyLab.Icon
  if lData.TebexPackage then 
    buyText = Targets.TebexLab.Label
    buyIcon = Targets.TebexLab.Icon
  end

  local options = {
    {
      canInteract = function(entity,distance,data)
        if not Config.Labs[l].Access.Owner and Config.Labs[l].Access.Ownable and not Config.Labs[l].Access.Shutdown then return true; end
        return false
      end,

      action = function(entity)
        if not lData.TebexPackage then TriggerServerEvent("DrugLabs:TryBuyLab", l) return true; end 
        Core.UI.OpenLink(lData.TebexPackage)
      end,

      icon  = buyIcon,
      label = buyText,
    },
    {

      canInteract = function(entity, distance, data)
        -- and not Core.Player.Job().IsCop 
        if Config.Labs[l].Access.ShutDown  and not Job.isCop then return false; end
        return true
      end, 

      action = function(entity)
        if CanAccess(l) then 
          AccessShell(l)
        else
          Core.UI.Notify(Labels[Settings.Language].NoAccess)
        end
      end, 
      icon  = Targets.EnterLab.Icon,
      label = Targets.EnterLab.Label,
    },
    {

      canInteract = function(entity, distance, data)
        if Config.Labs[l].Access.ShutDown or not Job.isCop then return false; end
        return true
      end, 

      action = function(entity)
        Core.Callback("Dirk-Core:HasItem", function(has)
          if has then
            -- Raid Animation 
            TriggerServerEvent("DrugLabs:LabRaided", l)
          else
            Core.UI.Notify(Labels[Settings.Language].NeedRaidTool)
          end
        end,Config.Police.RaidTool, 1)
      end, 
      icon  = Targets.RaidLab.Icon,
      label = Targets.RaidLab.Label,
    },
  }

  if Config.TargetBased then 
    Core.Target.AddBoxZone(string.format("%s:Door", l), {
      Position = lData.Door,
      Distance = 2.5, 
      Height   = 2.0, 
      Width    = 2.0, 
      Length   = 1.0, 
      Options = options,  
    })
  else
    Core.Menus.Register(string.format("%s:Door", l), {
      Pos = lData.Door,
      Distance = 1.5,
      Options = options,
    })
  end
end


RegisterNetEvent("DrugLabs:LabState", function(l,s)
  Config.Labs[l].Access.ShutDown = s
end)

CanAccess = function(l)
  local aData = Config.Labs[l].Access
  if Job.isCop then return true; end -- Cops always get access
  if aData.ShutDown then Core.UI.Notify(Labels[Settings.Language].AppearsRaided) return false; end --## Been raided overrides any other access

  if aData.ItemKey then --## Item Key
    local hasKey = nil
    Core.Callback("Dirk-Core:HasItem", function(has)
      hasKey = has
    end,aData.ItemKey, 1)
    while hasKey == nil do Wait(0); end
    if hasKey then return true; end
  end 

  if aData.KeyCode then 
    local result = Core.UI.Keycode(aData.KeyCode, {multipleTries = false})
    while result == nil do Wait(0); end
    return result
  end --## Key Code Trumps all 

  if aData.Public then return true; end -- Public Lab
  if aData.Ownable and not aData.Owner then return false; end --## Returning False because no owner and ownable
  if aData.Ownable then 
    --## Check if owner or has key
    local cID = Core.Player.Identifier()
    if aData.Owner == cID and not Config.OwnerNeedsKeys then return true; end
    local canAccess = nil
    Core.Callback("DrugLabs:HasKeys", function(hasKeys)
      canAccess = hasKeys
    end,l)
    while canAccess == nil do Wait(0); end
    if canAccess then return true; end
  else
    local myJob = Core.Player.Job().name
    local myGang =  Core.Player.Gang()
    if aData.Gangs and aData.Gangs[myGang] then return true; end
    if aData.Jobs and aData.Jobs[myJob] then return true; end
  end


  return false
end


CurrentShell = false
local CurrentLab = false
currentTargs = {}

if Config.Debug then 
  RegisterCommand('DrugLabs:labOffset', function(source,args)
    if not CurrentShell then return false; end
    local c = GetEntityCoords(PlayerPedId())
    local offset = GetOffsetFromEntityGivenWorldCoords(CurrentShell, c.x,c.y,c.z)
    Core.UI.CopyToClipboard(string.format("vector4(%s,%s,%s,%s)", offset.x,offset.y,offset.z, GetEntityHeading(PlayerPedId())))
  end)
end

AccessShell = function(l)
  local lData = Config.Labs[l]

  Wait(10)
  DoScreenFadeOut(500)
  Wait(500)
  Core.Game.SyncTime(false)
  NetworkOverrideClockTime(Config.InShellTime.Hour, Config.InShellTime.Min, 0)
  CurrentShell, entrance,stockpile = LoadShell(Config.Shells[Config.Labs[l].Shell], Config.Labs[l].Door)
  if not CurrentShell then 
    Wait(10)
    DoScreenFadeIn(500)
    Wait(500)
    Core.Game.SyncTime(true)
    return false; 
  end
  for k,v in pairs(lData.Stages) do 
    local worldCoords = GetOffsetFromEntityInWorldCoords(CurrentShell, v.Position.x, v.Position.y, v.Position.z)
    local options = {
      {
        canInteract = function(entity,distance,data)
          if not Config.Labs[l].Stages[k].inUse then return true; end
          return false
        end,

        action = function(entity)
          TriggerEvent("DrugLabs:UseSpot", l, k)
        end,

        icon  = v.Icon,
        label = v.Label,
      },
    }

    if Config.TargetBased then 
      local zone = Core.Target.AddBoxZone(string.format("%s:%s", l, k), {
        Position = worldCoords,
        Distance = 2.5, 
        Height   = 2.0, 
        Width    = 2.0, 
        Length   = 1.8, 
        Options = options
      })   
    else
      Core.Menus.Register(string.format("%s:%s", l, k), {
        Pos = worldCoords,
        Distance = 1.0,
        Options = options,
      })
    end
    currentTargs[string.format("%s:%s", l, k)] = true 
  end


  ------ SHELL STOCKPILE ------ -- Options for opening, Option for cops to clear inventory. 
  
  local stockPileOpts = {
    {
      canInteract = function(entity,distance,data)
        return true
      end,

      action = function(entity)
        OpenInventory(l)
      end,

      icon  = Targets.OpenStockPile.Icon,
      label = Targets.OpenStockPile.Label,
    },
    {
      canInteract = function(entity,distance,data)
        if Job.isCop then return true; end
        return false
      end,

      action = function(entity)
        TriggerServerEvent("DrugLabs:SeizeDrugs", l)
      end,

      icon  = Targets.SeizeDrugs.Icon,
      label = Targets.SeizeDrugs.Label,
    },
  }
  if Config.TargetBased then 
    local newZone = Core.Target.AddBoxZone(string.format("%s:StockPile", l), {
      Position = stockpile,
      Distance = 2.5, 
      Height   = 2.0, 
      Width    = 2.0, 
      Length   = 1.0, 
      Options = stockPileOpts
    })   
  else
    Core.Menus.Register(string.format("%s:StockPile", l), {
      Pos = stockpile,
      Distance = 1.0,
      Options = stockPileOpts,
    })
  end
  currentTargs[string.format("%s:StockPile", l)] = true

  ------ SHELL EXIT ------- -- Options for leaving shell, Management Options - Generate New Key, Change Locks, Transfer Ownership -- FUTURE VIEW CAMERAS?

  local exitOptions = {
    {
      canInteract = function(entity,distance,data)
        return true
      end,

      action = function(entity)
        ExitShell()
      end,

      icon  = Targets.ExitLab.Icon,
      label = Targets.ExitLab.Label,
    },
    {
      canInteract = function(entity,distance,data)
        if not Config.Labs[l].Access.Owner or (Core.Player.Identifier() ~= Config.Labs[l].Access.Owner) then return false; end 
        return true
      end,

      action = function(entity)
        TriggerServerEvent("DrugLabs:GenerateKey", l)
      end,

      icon  = Targets.GenerateKey.Icon,
      label = Targets.GenerateKey.Label,
    },
    {
      canInteract = function(entity,distance,data)
        if not Config.Labs[l].Access.Owner or (Core.Player.Identifier() ~= Config.Labs[l].Access.Owner) then return false; end 
        return true
      end,

      action = function(entity)
        TriggerServerEvent("DrugLabs:ChangeLocks", l)
      end,

      icon  = Targets.ChangeLocks.Icon,
      label = Targets.ChangeLocks.Label,
    },
    {
      canInteract = function(entity,distance,data)
        if not Config.Labs[l].IngOrders then return false; end
        if Config.Labs[l].Access.Ownable and (not Config.Labs[l].Access.Owner or (Core.Player.Identifier() ~= Config.Labs[l].Access.Owner)) then return false; end 
        return true
      end,

      action = function(entity)
        OrderIngredients(l)
      end,

      icon  = Targets.OrderIngredients.Icon,
      label = Targets.OrderIngredients.Label,
    },
    {
      canInteract = function(entity,distance,data)
        if not Config.Labs[l].Access.Owner or (Core.Player.Identifier() ~= Config.Labs[l].Access.Owner) then return false; end 
        return true
      end,

      action = function(entity)
        ChooseNearbyPlayers(l)
      end,

      icon  = Targets.Transfer.Icon,
      label = Targets.Transfer.Label,
    },
  }
  if Config.TargetBased then
    local newZone1 = Core.Target.AddBoxZone(string.format("%s:ShellExit", l), {
      Position = entrance,
      Distance = 2.5, 
      Height   = 2.0, 
      Width    = 2.0, 
      Length   = 1.0, 
      Options = exitOptions
    })   
  else
    Core.Menus.Register(string.format("%s:ShellExit", l), {
      Pos = entrance,
      Distance = 1.0,
      Options = exitOptions,
    })
  end
  currentTargs[string.format("%s:ShellExit", l)] = true
  --- Teleport Into Shell
  SetEntityCoords(PlayerPedId(), entrance.x,entrance.y,entrance.z - 1.0)
  SetEntityHeading(PlayerPedId(), entrance.w)
  DoScreenFadeIn(1000)
  CurrentLab = l 
end

ChooseNearbyPlayers = function(l)
  local chosen = Core.Game.ChooseNearbyPlayer()
  if chosen then 
    TriggerServerEvent("DrugLabs:ChangeOwner", l, chosen)
  end
end

CurrentMission = nil

OrderIngredients = function(l)
  local res = nil
  Core.Callback("DrugLabs:CanOrder", function(can, reason, info)
    if can then 
      Core.UI.Notify(Labels[Settings.Language].HeadToPickup)
      CurrentMission = info
      CreateMissionBlip(info.Van.Position)
    else
      Core.UI.Notify(reason)
    end
    res = can 
  end, l)
  while res == nil do Wait(0); end
  if not res then return false; end
  inMission = l
end


CreateMissionBlip = function(pos)
  missionBlip = Core.Game.AddBlip(pos,{
    Text       =  Labels[Settings.Language].DeliveryMission,
    Sprite     =  Config.IngredientsOrders.Blip.Sprite,
    Display    =  Config.IngredientsOrders.Blip.Display,
    Scale      =  Config.IngredientsOrders.Blip.Scale,
    Color      =  Config.IngredientsOrders.Blip.Color,
    Route      = true, 
    ShortRange =  false,
  })
end


AddReturnRouteBlip = function(pos)
  returnBlip = Core.Game.AddBlip(pos,{
    Text       =  Labels[Settings.Language].ReturnBlip,
    Sprite     =  Config.IngredientsOrders.Blip.Sprite,
    Display    =  Config.IngredientsOrders.Blip.Display,
    Scale      =  Config.IngredientsOrders.Blip.Scale,
    Color      =  Config.IngredientsOrders.Blip.Color,
    Route      = true, 
    ShortRange =  false,
  })
end


RemoveReturnRouteBlip = function()  
  Core.Game.RemoveBlip(returnBlip)
end

RemoveMissionBlip = function()
  Core.Game.RemoveBlip(missionBlip)
  missionBlip = false
end



local spawnedGuards = {}
Citizen.CreateThread(function()
  while true do 
    local wait_time = 1000

    if SceneInProgress then 
      wait_time = 0 
      DisableAllControlActions(0)
      DisableAllControlActions(1)
    end
    if inMission then 
      local ply = PlayerPedId()
      local pos = GetEntityCoords(ply)
      local vehIn = GetVehiclePedIsIn(ply)
      if missionVeh and #(pos - CurrentMission.Van.Position.xyz) <= 10.0 then 
        --## Make Peds Attack

      end

      if vehIn and vehIn == missionVeh then 
        --## In Vehicle
        if missionBlip then 
          RemoveMissionBlip()
          AddReturnRouteBlip(Config.Labs[inMission].IngOrders.DropPoint)
        end

        if #(pos - Config.Labs[inMission].IngOrders.DropPoint.xyz) <= 15.0 then 
          wait_time = 0 
          DrawMarker(2, Config.Labs[inMission].IngOrders.DropPoint.x, Config.Labs[inMission].IngOrders.DropPoint.y, Config.Labs[inMission].IngOrders.DropPoint.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 50, false, true, 2, nil, nil, false)
          Core.UI.ShowHelpNotification(Labels[Settings.Language].ParkInMarker)
          if #(pos - Config.Labs[inMission].IngOrders.DropPoint.xyz) <= 5.0 then
            Core.UI.AdvancedHelpNotif("deliverObject", {
              {
                key   = "e",
                label = Labels[Settings.Language].PressToDeliver,
              }
            })
            if IsControlJustPressed(0,38) then 
              RemoveReturnRouteBlip()
              DeleteEntity(missionVeh)
              TriggerServerEvent("DrugLabs:MissionComplete", inMission, CurrentMission.Mission)
              
              inMission = false
              missionVeh = false
              CurrentMission = {}
              for k,v in pairs(spawnedGuards) do 
                DeleteEntity(v)
              end
            end
          end
        end
      else
        if not missionVeh and #(pos - CurrentMission.Van.Position.xyz) <= 60.0 then 
          --## Spawn Mission Peds 
          for k,v in pairs(CurrentMission.Guards) do 
            local model = GetHashKey(v.Model)
            while not HasModelLoaded(model) do RequestModel(model) Wait(0); end
            local ped = CreatePed(4, model, v.Position.x,v.Position.y,v.Position.z,v.Position.w, true, true)
            table.insert(spawnedGuards, ped)
            SetPedRelationshipGroupHash(ped, guardGroup)
            SetModelAsNoLongerNeeded(model)
            SetPedDropsWeaponsWhenDead(ped, false)
            SetEntityAsMissionEntity(ped,true,true)
            -- SetBlockingOfNonTemporaryEvents(ped , true)
            -- TaskSetBlockingOfNonTemporaryEvents(ped , true)
            SetPedFleeAttributes(ped,0,0)
            if v.Weapon then 
              GiveWeaponToPed(ped,GetHashKey(v.Weapon), 100,true, true)
              SetPedAccuracy(ped, v.Accuracy)
            end
            
            if v.Anim then
              while not HasAnimDictLoaded(v.Anim.Dict) do RequestAnimDict(v.Anim.Dict) Wait(0); end
              TaskPlayAnim(ped,v.Anim.Dict,v.Anim.Anim,1.0, -1.0, -1, 15, 0, 0, 0, 0)
            end
            Wait(1)
          end


          --## Spawn Mission Vehicle
          Core.Vehicle.Create(CurrentMission.Van.Model, CurrentMission.Van.Position, function(veh)
            local plate = GetVehicleNumberPlateText(veh)
            Core.Vehicle.AddKeys(veh,plate)
            missionVeh = veh
          end, true)
        end
      end
    end
    Wait(wait_time)
  end
end)

OpenInventory = function(id)
  local shellInfo = Config.Shells[Config.Labs[id].Shell].Stash
  if not shellInfo then print('There has been a problem finding the shell stash information for this lab so it will default'); end
  local data = {
    Name = id, 
    Slots = shellInfo.Slots or 128,
    Weight = shellInfo.Weight or 250000,
  }
  TriggerEvent("Dirk:Inventory:Open", id, data)
end

LoadShell = function(d, pos)
  local hash = GetHashKey(d.Model)
  local start_time = GetGameTimer()
  while not HasModelLoaded(hash) do
    if GetGameTimer() - start_time > 15000 then
      print('Failed to load model: '..d.Model)
      return false
    end 
    RequestModel(hash) 

    Wait(0); 
  end
  local object = CreateObject(hash, pos.x,pos.y,pos.z + Config.ShellHeight ,false,true,false)
  SetEntityHeading(object, 0.0)
  FreezeEntityPosition(object,true)
  local entrance = GetOffsetFromEntityInWorldCoords(object, d.Entrance.x,d.Entrance.y,d.Entrance.z)
  entrance = vector4(entrance.x,entrance.y,entrance.z,d.Entrance.w)
  local stockpile = GetOffsetFromEntityInWorldCoords(object, d.StockPile.x,d.StockPile.y,d.StockPile.z)
  return object, entrance, stockpile
end




ExitShell = function()

  DoScreenFadeOut(500)
  Wait(500)
  Core.Game.SyncTime(true)
  -- Delete Targets


  for k,v in pairs(currentTargs) do 
    if Config.TargetBased then
      Core.Target.DeleteZone(k)
    else
      Core.Menus.Remove(k)
    end
  end
  
  currentTargs = {}



  -- Delete Shell
  DeleteEntity(CurrentShell)
  CurrentShell = false

  -- Teleport Outside
  local exit = Config.Labs[CurrentLab].Door
  FreezeEntityPosition(PlayerPedId(),true)
  SetEntityCoords(PlayerPedId(), exit.x,exit.y,exit.z - 1.0)
  SetEntityHeading(PlayerPedId(), exit.w - 180.0)
  while not HasCollisionLoadedAroundEntity(PlayerPedId()) do Wait(300); end
  FreezeEntityPosition(PlayerPedId(),false)
  DoScreenFadeIn(1000)
  CurrentLab = false
end


RegisterNetEvent("DrugLabs:UseSpot", function(lab,stage)
  local has = nil
  Core.Callback("DrugLabs:HasRequired", function(res) -- If has then it will set this person as using this spot.
    has = res    
  end,lab,stage)
  while has == nil do Wait(0); end
  if has then 
    local sData = Config.Labs[lab].Stages[stage]
    if sData.FancyScene then 
      local done = FancyScene(lab,stage, sData.FancyScene)
      while not done do Wait(0); end 
    elseif sData.NormalAnim then 
      local ply  = PlayerPedId()
      local anim = sData.NormalAnim.anim
      local dict = sData.NormalAnim.dict
      while not HasAnimDictLoaded(dict) do RequestAnimDict(dict) Wait(0); end
      TaskPlayAnim(ply,dict,anim,-1.0, -1.0, -1, 49, 0, 0, 0, 0)
      if Config.ProgressBars then
        Core.UI.ProgressBar({
          time  = sData.NormalAnim.time, 
          label =  Config.Labs[lab].Stages[stage].ProgText or "...",
          usewhileDead = false, 
          canCancel = false, 
          disableControl = true, 
        })
      else
        Wait(sData.NormalAnim.time)
      end
      ClearPedTasks(ply)
    end

    TriggerServerEvent("DrugLabs:LabTaskComplete", lab,stage) -- Tell the server the spot is clear if someone needs to use it
  else
    Core.UI.Notify("You do not have the required items")    
  end
end)

RegisterNetEvent("DrugLabs:ToggleSpotUse", function(lab,stage,state)
  Config.Labs[lab].Stages[stage].inUse = state
end)



RegisterNetEvent("DrugLabs:NewOwner", function(l,o)
  Config.Labs[l].Access.Owner = o 
end)


AddEventHandler('onResourceStop', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then return false; end
  for k,v in pairs(Config.Labs)do 
    if Config.TargetBased then 
      Core.Target.DeleteZone(string.format("%s:Door", k))
    end
  end
  if CurrentLab and CurrentShell then ExitShell(); end 
end)
