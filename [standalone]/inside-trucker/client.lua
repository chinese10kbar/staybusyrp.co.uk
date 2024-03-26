cfg.Prefix = exports[cfg.ExportPrefix]:GetCoreObject()
local PlayerData = {}

PlayersCargo = {
	[1] = {TypeOfWork = "none", CargoWeight = "none", TrailerOwner = "none", OwnerID = nil, VehicleEntityID = nil, TrailerEntityID = nil}
}

RegisterNetEvent(cfg.TriggerPrefix..':Client:OnPlayerLoaded')
AddEventHandler(cfg.TriggerPrefix..':Client:OnPlayerLoaded', function()
    PlayerData = cfg.Prefix.Functions.GetPlayerData()

    TriggerServerEvent("inside-trucker:SendCargos")
end)

RegisterNetEvent(cfg.TriggerPrefix..':Client:OnJobUpdate')
AddEventHandler(cfg.TriggerPrefix..':Client:OnJobUpdate', function()
	PlayerData.job = cfg.Prefix.Functions.GetPlayerData().job
end)

AddEventHandler('onResourceStop', function()
    if objectspawned then ObjectsTrailer("delete") end if onDuty then cfg.Prefix.Functions.DeleteVehicle(CompanyVeh) cfg.Prefix.Functions.DeleteVehicle(CompanyTrailer)  TriggerServerEvent("inside-trucker:ReturnDeposit", onDuty) end
    for i = 1, #cfg.Coords.PlatformScale, 1 do
        DeleteEntity(cfg.Coords.PlatformScale[i].Platform)
        DeleteEntity(cfg.Coords.PlatformScale[i].ToolChest)
        DeleteEntity(cfg.Coords.PlatformScale[i].Laptop)
    end
end)

RegisterCommand('truckercoords', function() --- USE IT IN GAME TO GET COORDINATES OF LOADINGS/UNLOADINGS/PLATFORMSCALE TRUCK OR TRAILER POSITION ETC.
    local TrailerCoords = GetEntityCoords(CompanyTrailer)
    local TrailerHeading = GetEntityHeading(CompanyTrailer)
    local VehicleCoords = GetEntityCoords(CompanyVeh)
    local VehicleHeading = GetEntityHeading(CompanyVeh)

    print("Vehicle: x = "..VehicleCoords.x..", y = "..VehicleCoords.y..", z = "..VehicleCoords.z)
    print("Trailer: x = "..TrailerCoords.x..", y = "..TrailerCoords.y..", z = "..VehicleCoords.z)
    if IsEntityAttachedToEntity(CompanyTrailer, CompanyVeh) then
        print("Trailer is attached to your Truck")
    else
        print("Trailer is not attached to your Truck")
    end
end)

CreateThread(function()

    BaseBlip = AddBlipForCoord(cfg.Coords.Base.x, cfg.Coords.Base.y, cfg.Coords.Base.z)
    SetBlipSprite(BaseBlip, cfg.Blip.Base.Sprite)
    SetBlipDisplay(BaseBlip, 4)
    SetBlipScale(BaseBlip, cfg.Blip.Base.Scale)
    SetBlipAsShortRange(BaseBlip, cfg.Blip.Base.ShortRange)
    SetBlipColour(BaseBlip, cfg.Blip.Base.Color)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(cfg.Blip.Base.Label)
    EndTextCommandSetBlipName(BaseBlip)
    
    ID = 1
    Work = cfg.Works[ID]
    PlatformScale()

    while true do

        local refresh = 1000
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

            if not cfg.JobRequirement then
                if (#(coords - vector3(cfg.Coords.Base.x, cfg.Coords.Base.y, cfg.Coords.Base.z)) < 0.5) then
                    refresh = 4
                    DrawMarker(6, cfg.Coords.Base.x, cfg.Coords.Base.y, cfg.Coords.Base.z - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                    if not onDuty then
                        DrawText3D(cfg.Coords.Base.x, cfg.Coords.Base.y, cfg.Coords.Base.z + 1.2, "[LEFTARROW] - ~w~Choose your Work~s~ - [RIGHTARROW]")
                        DrawText3D(cfg.Coords.Base.x, cfg.Coords.Base.y, cfg.Coords.Base.z + 1.0, "~w~"..Work.Label.."~s~")
                        DrawText3D(coords.x, coords.y, coords.z + 0.9, "[E] - ~w~Start Work")
                        if IsControlJustReleased(0, Keys["LEFT"]) and not block or IsDisabledControlJustReleased(0, Keys["LEFT"]) and not block then
                            block = true
                            if ID > 1 then
                                ID = ID - 1
                                Work = cfg.Works[ID]
                            end
                            block = false
                        elseif IsControlJustReleased(0, Keys["RIGHT"]) and not block or IsDisabledControlJustReleased(0, Keys["RIGHT"]) and not block then
                            block = true
                            if ID < #cfg.Works then
                                ID = ID + 1
                                Work = cfg.Works[ID]
                            end
                            block = false
                        elseif IsControlJustReleased(0, Keys["E"]) and not block or IsDisabledControlJustReleased(0, Keys["E"]) and not block then
                            block = true
                            cfg.Prefix.Functions.TriggerCallback('inside-trucker:CheckDeposit', function(hasMoney)
                                if hasMoney then
                                    local availableParkingSpace = false
                                    for i = 1, #cfg.Coords.Spawn.Vehicle, 1 do
                                        if IsSpawnPointClear(vector3(cfg.Coords.Spawn.Vehicle[i].x, cfg.Coords.Spawn.Vehicle[i].y, cfg.Coords.Spawn.Vehicle[i].z), 5.0) then
                                            StartJob(i)
                                            TriggerServerEvent("inside-trucker:GetDeposit")
                                            availableParkingSpace = true

                                            exports.bulletin:SendAdvanced({
                                                message = "You started working as a Trucker. You paid a deposit of ~g~£"..cfg.DepositPrice.."~s~.",
                                                title = "<font color=#4effaf>"..Work.Label.."</font>",
                                                subject = "<font color=#4effaf>Trucker</font>",
                                                icon = 'CHAR_PLANESITE',
                                                timeout = 2500,
                                                position = 'bottom',
                                                theme = 'default',
                                                exitAnim = 'zoomOut',
                                                progress = true,
                                            })

                                            break
                                        end
                                    end
                                    if not availableParkingSpace then

                                        exports.bulletin:SendAdvanced({
                                            message = "Currently, there is no free space in the Car Park.",
                                            title = "<font color=#4effaf>"..Work.Label.."</font>",
                                            subject = "<font color=#4effaf>Trucker</font>",
                                            icon = 'CHAR_PLANESITE',
                                            timeout = 5000,
                                            position = 'bottom',
                                            theme = 'default',
                                            exitAnim = 'zoomOut',
                                            progress = true,
                                        })

                                    end
                                else

                                    exports.bulletin:SendAdvanced({
                                        message = "You don't have Enough Money to pay for the deposit. The deposit is ~r~£"..cfg.DepositPrice.."~s~.",
                                        title = "<font color=#4effaf>"..Work.Label.."</font>",
                                        subject = "<font color=#4effaf>Trucker</font>",
                                        icon = 'CHAR_PLANESITE',
                                        timeout = 5000,
                                        position = 'bottom',
                                        theme = 'default',
                                        exitAnim = 'zoomOut',
                                        progress = true,
                                    })

                                end
                            end)
                            block = false
                        end
                    else
                        DrawText3D(cfg.Coords.Base.x, cfg.Coords.Base.y, cfg.Coords.Base.z + 1.0, "~w~You're currently Responsible for~s~ "..Work.Label)
                        DrawText3D(coords.x, coords.y, coords.z + 0.9, "[E] - ~w~Finish Work")
                        if IsControlJustReleased(0, Keys["E"]) and not block or IsDisabledControlJustReleased(0, Keys["E"]) and not block then
                            Wait(100)
                            local VehicleGetNetworkID = NetworkGetNetworkIdFromEntity(CompanyVeh)
                            local TrailerGetNetworkID = NetworkGetNetworkIdFromEntity(CompanyTrailer)
                            TriggerServerEvent("inside-trucker:RemoveCargo", VehicleGetNetworkID, TrailerGetNetworkID)
                            TriggerServerEvent("inside-trucker:ReturnDeposit", onDuty)
                            cfg.Prefix.Functions.DeleteVehicle(CompanyVeh) 
                            cfg.Prefix.Functions.DeleteVehicle(CompanyTrailer)
                            CompanyVeh = nil
                            CompanyTrailer = nil
                            onDuty = false

                            exports.bulletin:SendAdvanced({
                                message = "You finished working as a Trucker. Your deposit has been returned to your Bank Account.",
                                title = "<font color=#4effaf>"..Work.Label.."</font>",
                                subject = "<font color=#4effaf>Trucker</font>",
                                icon = 'CHAR_PLANESITE',
                                timeout = 2500,
                                position = 'bottom',
                                theme = 'default',
                                exitAnim = 'zoomOut',
                                progress = true,
                            })

                        end
                    end
                elseif (#(coords - vector3(cfg.Coords.Base.x, cfg.Coords.Base.y, cfg.Coords.Base.z)) < 30.0) then
                    refresh = 4
                    DrawMarker(6, cfg.Coords.Base.x, cfg.Coords.Base.y, cfg.Coords.Base.z - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                    DrawMarker(2, cfg.Coords.Base.x, cfg.Coords.Base.y, cfg.Coords.Base.z + 1.0, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.3, 0.3, 0.3, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, true, true, 2, false, false, false, false)
                end
            elseif cfg.JobRequirement then
                if PlayerData.job ~= nil and PlayerData.job.name == "trucker" then
                    SetBlipAlpha(BaseBlip, 1000)
                    if (#(coords - vector3(cfg.Coords.Base.x, cfg.Coords.Base.y, cfg.Coords.Base.z)) < 0.5) then
                        refresh = 4
                        DrawMarker(6, cfg.Coords.Base.x, cfg.Coords.Base.y, cfg.Coords.Base.z - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                        if not onDuty then
                            DrawText3D(cfg.Coords.Base.x, cfg.Coords.Base.y, cfg.Coords.Base.z + 1.2, "[LEFTARROW] - ~w~Choose your Work~s~ - [RIGHTARROW]")
                            DrawText3D(cfg.Coords.Base.x, cfg.Coords.Base.y, cfg.Coords.Base.z + 1.0, "~w~"..Work.Label.."~s~")
                            DrawText3D(coords.x, coords.y, coords.z + 0.9, "[E] - ~w~Start Work")
                            if IsControlJustReleased(0, Keys["LEFT"]) and not block or IsDisabledControlJustReleased(0, Keys["LEFT"]) and not block then
                                block = true
                                if ID > 1 then
                                    ID = ID - 1
                                    Work = cfg.Works[ID]
                                end
                                block = false
                            elseif IsControlJustReleased(0, Keys["RIGHT"]) and not block or IsDisabledControlJustReleased(0, Keys["RIGHT"]) and not block then
                                block = true
                                if ID < #cfg.Works then
                                    ID = ID + 1
                                    Work = cfg.Works[ID]
                                end
                                block = false
                            elseif IsControlJustReleased(0, Keys["E"]) and not block or IsDisabledControlJustReleased(0, Keys["E"]) and not block then
                                block = true
                                cfg.Prefix.Functions.TriggerCallback('inside-trucker:CheckDeposit', function(hasMoney)
                                    if hasMoney then
                                        local availableParkingSpace = false
                                        for i = 1, #cfg.Coords.Spawn.Vehicle, 1 do
                                            if IsSpawnPointClear(vector3(cfg.Coords.Spawn.Vehicle[i].x, cfg.Coords.Spawn.Vehicle[i].y, cfg.Coords.Spawn.Vehicle[i].z), 5.0) then
                                                StartJob(i)
                                                TriggerServerEvent("inside-trucker:GetDeposit")
                                                availableParkingSpace = true

                                                exports.bulletin:SendAdvanced({
                                                    message = "You started working as a Trucker. You paid a deposit of ~g~£"..cfg.DepositPrice.."~s~.",
                                                    title = "<font color=#4effaf>"..Work.Label.."</font>",
                                                    subject = "<font color=#4effaf>Trucker</font>",
                                                    icon = 'CHAR_PLANESITE',
                                                    timeout = 2500,
                                                    position = 'bottom',
                                                    theme = 'default',
                                                    exitAnim = 'zoomOut',
                                                    progress = true,
                                                })

                                                break
                                            end
                                        end
                                        if not availableParkingSpace then

                                            exports.bulletin:SendAdvanced({
                                                message = "Currently, there is no free space in the Car Park.",
                                                title = "<font color=#4effaf>"..Work.Label.."</font>",
                                                subject = "<font color=#4effaf>Trucker</font>",
                                                icon = 'CHAR_PLANESITE',
                                                timeout = 5000,
                                                position = 'bottom',
                                                theme = 'default',
                                                exitAnim = 'zoomOut',
                                                progress = true,
                                            })

                                        end
                                    else

                                        exports.bulletin:SendAdvanced({
                                            message = "You don't have Enough Money to pay for the deposit. The deposit is ~r~£"..cfg.DepositPrice.."~s~.",
                                            title = "<font color=#4effaf>"..Work.Label.."</font>",
                                            subject = "<font color=#4effaf>Trucker</font>",
                                            icon = 'CHAR_PLANESITE',
                                            timeout = 5000,
                                            position = 'bottom',
                                            theme = 'default',
                                            exitAnim = 'zoomOut',
                                            progress = true,
                                        })

                                    end
                                end)
                                block = false
                            end
                        else
                            DrawText3D(cfg.Coords.Base.x, cfg.Coords.Base.y, cfg.Coords.Base.z + 1.0, "~w~You're currently Responsible for~s~ "..Work.Label)
                            DrawText3D(coords.x, coords.y, coords.z + 0.9, "[E] - ~w~Finish Work")
                            if IsControlJustReleased(0, Keys["E"]) and not block or IsDisabledControlJustReleased(0, Keys["E"]) and not block then
                                Wait(100)
                                local VehicleGetNetworkID = NetworkGetNetworkIdFromEntity(CompanyVeh)
                                local TrailerGetNetworkID = NetworkGetNetworkIdFromEntity(CompanyTrailer)
                                TriggerServerEvent("inside-trucker:RemoveCargo", VehicleGetNetworkID, TrailerGetNetworkID)
                                TriggerServerEvent("inside-trucker:ReturnDeposit", onDuty)
                                cfg.Prefix.Functions.DeleteVehicle(CompanyVeh) 
                                cfg.Prefix.Functions.DeleteVehicle(CompanyTrailer)
                                CompanyVeh = nil
                                CompanyTrailer = nil
                                onDuty = false

                                exports.bulletin:SendAdvanced({
                                    message = "You finished working as a Trucker. Your deposit has been returned to your Bank Account.",
                                    title = "<font color=#4effaf>"..Work.Label.."</font>",
                                    subject = "<font color=#4effaf>Trucker</font>",
                                    icon = 'CHAR_PLANESITE',
                                    timeout = 2500,
                                    position = 'bottom',
                                    theme = 'default',
                                    exitAnim = 'zoomOut',
                                    progress = true,
                                })

                            end
                        end
                    elseif (#(coords - vector3(cfg.Coords.Base.x, cfg.Coords.Base.y, cfg.Coords.Base.z)) < 30.0) then
                        refresh = 4
                        DrawMarker(6, cfg.Coords.Base.x, cfg.Coords.Base.y, cfg.Coords.Base.z - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                        DrawMarker(2, cfg.Coords.Base.x, cfg.Coords.Base.y, cfg.Coords.Base.z + 1.0, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.3, 0.3, 0.3, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, true, true, 2, false, false, false, false)
                    end
                else
                    SetBlipAlpha(BaseBlip, 0)
                end
            end
        Wait(refresh)
    end
end)

function StartJob(ParkingSpace)
    onDuty = true
    SpawnCar(Work.Veh, cfg.Coords.Spawn.Vehicle[ParkingSpace], cfg.Coords.Spawn.Vehicle[ParkingSpace].h, "Car")
    SpawnCar(Work.Trailer, cfg.Coords.Spawn.Trailer[ParkingSpace], cfg.Coords.Spawn.Trailer[ParkingSpace].h, "Trailer")
    Wait(100)
    TriggerEvent("vehiclekeys:client:SetOwner", cfg.Prefix.Functions.GetPlate(CompanyVeh))
    exports['cdn-fuel']:SetFuel(CompanyVeh, 100.0)
    local VehicleGetNetworkID = NetworkGetNetworkIdFromEntity(CompanyVeh)
    local TrailerGetNetworkID = NetworkGetNetworkIdFromEntity(CompanyTrailer)
    TriggerServerEvent("inside-trucker:AddCargo", Work.Name, 0, VehicleGetNetworkID, TrailerGetNetworkID)
    ComingToVehicle()

    exports.bulletin:SendAdvanced({
        message = "Your Vehicle is waiting for you at the Parking Space, get in it.",
        title = "<font color=#4effaf>"..Work.Label.."</font>",
        subject = "<font color=#4effaf>Trucker</font>",
        icon = 'CHAR_PLANESITE',
        timeout = 5000,
        position = 'bottom',
        theme = 'default',
        exitAnim = 'zoomOut',
        progress = true,
    })

end

function ComingToVehicle()
    CreateThread(function()

        local PlusZ = 4.0
        
        while true do
            local refresh = 4
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local vehcoords = GetEntityCoords(CompanyVeh)

            if not onDuty then break end
            if IsPedInVehicle(ped, CompanyVeh) then 
                ComingToAttachTrailer() 
                
                exports.bulletin:SendAdvanced({
                    message = "Okay, now you can attach the Trailer to your Vehicle.",
                    title = "<font color=#4effaf>"..Work.Label.."</font>",
                    subject = "<font color=#4effaf>Trucker</font>",
                    icon = 'CHAR_PLANESITE',
                    timeout = 2500,
                    position = 'bottom',
                    theme = 'default',
                    exitAnim = 'zoomOut',
                    progress = true,
                })

                break 
            end
            DrawMarker(2, vehcoords.x, vehcoords.y, vehcoords.z + PlusZ, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, true, true, 2, false, false, false, false)
            Wait(refresh)
        end
    end)
end

function ComingToAttachTrailer()
    CreateThread(function()

        local PlusZ = 4.0

        while true do
            local refresh = 4
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local trailercoords = GetEntityCoords(CompanyTrailer)

            if not onDuty then break end
            if IsVehicleAttachedToTrailer(CompanyVeh) then 
                Wait(1000) 
                FreezeEntityPosition(CompanyVeh, true)
                FreezeEntityPosition(CompanyTrailer, true)
                TaskLeaveVehicle(ped, CompanyVeh, 0) 
                CheckTirePressure() 
                
                exports.bulletin:SendAdvanced({
                    message = "Check the Tire Pressure in the Vehicle and Trailer.",
                    title = "<font color=#4effaf>"..Work.Label.."</font>",
                    subject = "<font color=#4effaf>Trucker</font>",
                    icon = 'CHAR_PLANESITE',
                    timeout = 5000,
                    position = 'bottom',
                    theme = 'default',
                    exitAnim = 'zoomOut',
                    progress = true,
                })

                break
            end
            DrawMarker(2, trailercoords.x, trailercoords.y, trailercoords.z + PlusZ, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, true, true, 2, false, false, false, false)
            Wait(refresh)
        end
    end)
end

function CheckTirePressure()
    CreateThread(function()

        local CheckTable = nil
        local AmountToPump = 0
        local WheelChecked = 0

        Normal = {
            [1] = {x = 2.00, y = 2.30, z = -0.20, Checked = false, Entity = CompanyVeh, ActBar = 0, SuggestedBar = 8.0, MinRandomBar = 60, MaxRandomBar = 75},
            [2] = {x = 2.00, y = -1.05, z = -0.20, Checked = false, Entity = CompanyVeh, ActBar = 0, SuggestedBar = 7.8, MinRandomBar = 58, MaxRandomBar = 73},
            [3] = {x = 2.00, y = -2.55, z = -0.20, Checked = false, Entity = CompanyVeh, ActBar = 0, SuggestedBar = 7.8, MinRandomBar = 58, MaxRandomBar = 73},
            [4] = {x = -2.00, y = 2.30, z = -0.20, Checked = false, Entity = CompanyVeh, ActBar = 0, SuggestedBar = 8.0, MinRandomBar = 60, MaxRandomBar = 75},
            [5] = {x = -2.00, y = -1.05, z = -0.20, Checked = false, Entity = CompanyVeh, ActBar = 0, SuggestedBar = 7.8, MinRandomBar = 58, MaxRandomBar = 73},
            [6] = {x = -2.00, y = -2.55, z = -0.20, Checked = false, Entity = CompanyVeh, ActBar = 0, SuggestedBar = 7.8, MinRandomBar = 58, MaxRandomBar = 73},
            [7] = {x = 2.00, y = -3.45, z = -1.80, Checked = false, Entity = CompanyTrailer, ActBar = 0, SuggestedBar = 8.5, MinRandomBar = 65, MaxRandomBar = 80},
            [8] = {x = 2.00, y = -4.80, z = -1.80, Checked = false, Entity = CompanyTrailer, ActBar = 0, SuggestedBar = 8.5, MinRandomBar = 65, MaxRandomBar = 80},
            [9] = {x = -2.00, y = -3.45, z = -1.80, Checked = false, Entity = CompanyTrailer, ActBar = 0, SuggestedBar = 8.5, MinRandomBar = 65, MaxRandomBar = 80},
            [10] = {x = -2.00, y = -4.80, z = -1.80, Checked = false, Entity = CompanyTrailer, ActBar = 0, SuggestedBar = 8.5, MinRandomBar = 65, MaxRandomBar = 80},
        }

        Wood = {
            [1] = {x = 2.10, y = 3.15, z = -0.05, Checked = false, Entity = CompanyVeh, ActBar = 0, SuggestedBar = 8.0, MinRandomBar = 60, MaxRandomBar = 75},
            [2] = {x = 2.10, y = -2.17, z = -0.05, Checked = false, Entity = CompanyVeh, ActBar = 0, SuggestedBar = 7.8, MinRandomBar = 58, MaxRandomBar = 73},
            [3] = {x = 2.10, y = -3.55, z = -0.05, Checked = false, Entity = CompanyVeh, ActBar = 0, SuggestedBar = 7.8, MinRandomBar = 58, MaxRandomBar = 73},
            [4] = {x = -2.10, y = 3.15, z = -0.05, Checked = false, Entity = CompanyVeh, ActBar = 0, SuggestedBar = 8.0, MinRandomBar = 60, MaxRandomBar = 75},
            [5] = {x = -2.10, y = -2.17, z = -0.05, Checked = false, Entity = CompanyVeh, ActBar = 0, SuggestedBar = 7.8, MinRandomBar = 58, MaxRandomBar = 73},
            [6] = {x = -2.10, y = -3.55, z = -0.05, Checked = false, Entity = CompanyVeh, ActBar = 0, SuggestedBar = 7.8, MinRandomBar = 58, MaxRandomBar = 73},
            [7] = {x = 2.10, y = -3.55, z = -0.20, Checked = false, Entity = CompanyTrailer, ActBar = 0, SuggestedBar = 8.5, MinRandomBar = 65, MaxRandomBar = 80},
            [8] = {x = 2.10, y = -4.76, z = -0.20, Checked = false, Entity = CompanyTrailer, ActBar = 0, SuggestedBar = 8.5, MinRandomBar = 65, MaxRandomBar = 80},
            [9] = {x = -2.10, y = -3.55, z = -0.20, Checked = false, Entity = CompanyTrailer, ActBar = 0, SuggestedBar = 8.5, MinRandomBar = 65, MaxRandomBar = 80},
            [10] = {x = -2.10, y = -4.76, z = -0.20, Checked = false, Entity = CompanyTrailer, ActBar = 0, SuggestedBar = 8.5, MinRandomBar = 65, MaxRandomBar = 80},
        }

        if Work.Name == "normal" then CheckTable = Normal elseif Work.Name == "wood" then CheckTable = Wood end

        for i = 1, #CheckTable, 1 do
            if CheckTable[i].ActBar >= 0 then
                local NeedToPump = math.random(0, 2)
                if NeedToPump == 0 or NeedToPump == 1 then
                    CheckTable[i].ActBar = CheckTable[i].SuggestedBar
                elseif NeedToPump == 2 then
                    AmountToPump = AmountToPump + 1
                    local BarMath = (math.random(CheckTable[i].MinRandomBar, CheckTable[i].MaxRandomBar)) / 10
                    CheckTable[i].ActBar = BarMath
                end
            end
        end

        while true do
            local refresh = 1000
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)

            if not onDuty then break end
            for i = 1, #CheckTable, 1 do
                if not CheckTable[i].Checked then
                    local Entity = GetOffsetFromEntityInWorldCoords(CheckTable[i].Entity, CheckTable[i].x, CheckTable[i].y, CheckTable[i].z)
                    if (#(coords - vector3(Entity.x, Entity.y, Entity.z)) < 0.5) then
                        refresh = 4
                        DrawMarker(6, Entity.x, Entity.y, Entity.z - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                        DrawText3D(coords.x, coords.y, coords.z + 0.9, "[E] - ~w~Check Pressure in a Tire")
                        if IsControlJustReleased(0, Keys["E"]) and not block or IsDisabledControlJustReleased(0, Keys["E"]) and not block then
                            block = true
                            TaskStartScenarioInPlace(ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                            Wait(2500)
                            ClearPedTasks(ped)
                            CheckTable[i].Checked = true
                            WheelChecked = WheelChecked + 1
                            block = false
                            if WheelChecked == #CheckTable and AmountToPump == 0 then
                                FreezeEntityPosition(CompanyVeh, false)
                                FreezeEntityPosition(CompanyTrailer, false)
                                TruckerJob()
                                break
                            elseif WheelChecked == #CheckTable and AmountToPump > 0 then
                                PumpWheels(CheckTable, AmountToPump)

                                exports.bulletin:SendAdvanced({
                                    message = "You need to inflate the "..AmountToPump.." tires.",
                                    title = "<font color=#4effaf>"..Work.Label.."</font>",
                                    subject = "<font color=#4effaf>Trucker</font>",
                                    icon = 'CHAR_PLANESITE',
                                    timeout = 2500,
                                    position = 'bottom',
                                    theme = 'default',
                                    exitAnim = 'zoomOut',
                                    progress = true,
                                })

                                break
                            end
                        end
                    elseif (#(coords - vector3(Entity.x, Entity.y, Entity.z)) < 30.0) then
                        refresh = 4
                        DrawMarker(6, Entity.x, Entity.y, Entity.z - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                        DrawMarker(2, Entity.x, Entity.y, Entity.z + 1.0, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.3, 0.3, 0.3, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, true, true, 2, false, false, false, false)
                    end
                end
            end
            Wait(refresh)
        end
    end)
end

function PumpWheels(WheelTable, AmountToPump)
    CreateThread(function()

        local DrawTextZpos = 0.4

        while true do
            local refresh = 1000
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)

            if not onDuty then break end
            for i = 1, #WheelTable, 1 do
                local Entity = GetOffsetFromEntityInWorldCoords(WheelTable[i].Entity, WheelTable[i].x, WheelTable[i].y, WheelTable[i].z)
                if WheelTable[i].ActBar ~= WheelTable[i].SuggestedBar then
                    if (#(coords - vector3(Entity.x, Entity.y, Entity.z)) < 0.5) then
                        refresh = 4
                        DrawMarker(6, Entity.x, Entity.y, Entity.z - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                        DrawText3D(Entity.x, Entity.y, Entity.z - DrawTextZpos, "~w~Suggested ~s~Tire Pressure: "..WheelTable[i].SuggestedBar)
                        DrawText3D(Entity.x, Entity.y, Entity.z - DrawTextZpos - 0.2, "~w~Currently ~s~Tire Pressure: "..WheelTable[i].ActBar)
                        DrawText3D(coords.x, coords.y, coords.z + 0.9, "[E] - ~w~Inflate the Tire")
                        if IsControlJustReleased(0, Keys["E"]) and not block or IsDisabledControlJustReleased(0, Keys["E"]) and not block then
                            block = true
                            Pump = CreateObject(GetHashKey('prop_compressor_03'), Entity.x, Entity.y + 0.5, Entity.z - 1.04, false)
                            FreezeEntityPosition(Pump, true)
                            TaskStartScenarioInPlace(ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                            Wait(5500)
                            ClearPedTasks(ped)
                            Wait(1500)
                            DeleteEntity(Pump)
                            local AirPressureToPump = WheelTable[i].SuggestedBar - WheelTable[i].ActBar

                            exports.bulletin:SendAdvanced({
                                message = "You increased the Air Pressure by "..AirPressureToPump..".",
                                title = "<font color=#4effaf>"..Work.Label.."</font>",
                                subject = "<font color=#4effaf>Trucker</font>",
                                icon = 'CHAR_PLANESITE',
                                timeout = 1000,
                                position = 'bottom',
                                theme = 'default',
                                exitAnim = 'zoomOut',
                                progress = true,
                            })

                            WheelTable[i].ActBar = WheelTable[i].SuggestedBar
                            AmountToPump = AmountToPump - 1
                            block = false
                            if AmountToPump == 0 then
                                FreezeEntityPosition(CompanyVeh, false)
                                FreezeEntityPosition(CompanyTrailer, false)
                                TruckerJob()
                                break
                            end
                        end
                    elseif (#(coords - vector3(Entity.x, Entity.y, Entity.z)) < 30.0) then
                        refresh = 4
                        DrawMarker(6, Entity.x, Entity.y, Entity.z - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                        DrawMarker(2, Entity.x, Entity.y, Entity.z + 1.0, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.3, 0.3, 0.3, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, true, true, 2, false, false, false, false)
                    end
                end
            end
            Wait(refresh)
        end
    end)
end

function TruckerJob()
    CreateThread(function()

        Status = nil
        LoadPlace = nil
        UnloadPlace = nil

        exports.bulletin:SendAdvanced({
            message = "You are now ready to get the order. The locations where you can pick up the order have been marked on the map.",
            title = "<font color=#4effaf>"..Work.Label.."</font>",
            subject = "<font color=#4effaf>Trucker</font>",
            icon = 'CHAR_PLANESITE',
            timeout = 10000,
            position = 'bottom',
            theme = 'default',
            exitAnim = 'zoomOut',
            progress = true,
        })

        if Work.Name == "normal" then

            Loading = cfg.Coords.Loading.Normal
            Unloading = cfg.Coords.Unloading.Normal
            for i = 1, #Loading, 1 do
                Loading[i].LoadingBlip = AddBlipForCoord(Loading[i].vehicleX, Loading[i].vehicleY, Loading[i].vehicleZ)
                SetBlipSprite(Loading[i].LoadingBlip, cfg.Blip.NormalLoading.Sprite)
                SetBlipDisplay(Loading[i].LoadingBlip, 4)
                SetBlipScale(Loading[i].LoadingBlip, cfg.Blip.NormalLoading.Scale)
                SetBlipAsShortRange(Loading[i].LoadingBlip, cfg.Blip.NormalLoading.ShortRange)
                SetBlipColour(Loading[i].LoadingBlip, cfg.Blip.NormalLoading.Color)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentSubstringPlayerName(cfg.Blip.NormalLoading.Label)
                EndTextCommandSetBlipName(Loading[i].LoadingBlip)
            end

        elseif Work.Name == "wood" then

            Loading = cfg.Coords.Loading.Wood
            Unloading = cfg.Coords.Unloading.Wood
            for i = 1, #Loading, 1 do
                Loading[i].LoadingBlip = AddBlipForCoord(Loading[i].vehicleX, Loading[i].vehicleY, Loading[i].vehicleZ)
                SetBlipSprite(Loading[i].LoadingBlip, cfg.Blip.WoodLoading.Sprite)
                SetBlipDisplay(Loading[i].LoadingBlip, 4)
                SetBlipScale(Loading[i].LoadingBlip, cfg.Blip.WoodLoading.Scale)
                SetBlipAsShortRange(Loading[i].LoadingBlip, cfg.Blip.WoodLoading.ShortRange)
                SetBlipColour(Loading[i].LoadingBlip, cfg.Blip.WoodLoading.Color)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentSubstringPlayerName(cfg.Blip.WoodLoading.Label)
                EndTextCommandSetBlipName(Loading[i].LoadingBlip)
            end
            
        end

        while true do

            local refresh = 1000
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local vehcoords = GetEntityCoords(CompanyVeh)
            local trailercoords = GetEntityCoords(CompanyTrailer)

                if not onDuty then if Status == "UnloadingComingToPlace" then RemoveBlip(UnloadPlace.UnloadingBlip) end if Status == nil then for i = 1, #Loading, 1 do RemoveBlip(Loading[i].LoadingBlip) end end if objectspawned then ObjectsTrailer("delete") end break end
                if Work.Name == "normal" then

                    if Status == nil then
                        if IsPedInVehicle(ped, CompanyVeh) and IsEntityAttachedToEntity(CompanyTrailer, CompanyVeh) then
                            for i = 1, #Loading, 1 do
                                if (#(vehcoords - vector3(Loading[i].vehicleX, Loading[i].vehicleY, Loading[i].vehicleZ)) < 2.0) and (#(trailercoords - vector3(Loading[i].trailerX, Loading[i].trailerY, Loading[i].trailerZ)) < 2.0) then
                                    refresh = 4
                                    DrawMarker(6, Loading[i].vehicleX, Loading[i].vehicleY, Loading[i].vehicleZ - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 4.0, 4.0, 4.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                                    DrawMarker(6, Loading[i].trailerX, Loading[i].trailerY, Loading[i].trailerZ - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 4.0, 4.0, 4.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                                    DrawText3D(Loading[i].vehicleX, Loading[i].vehicleY, Loading[i].vehicleZ + 1.0, "~w~Legal = 10-24 tons, Illegal = 25-30 tons")
                                    DrawText3D(Loading[i].vehicleX, Loading[i].vehicleY, Loading[i].vehicleZ, "[E] - ~w~Load Legal~s~ | [H] - ~w~Load Illegal~s~")
                                    if IsControlJustReleased(0, Keys["E"]) and not block or IsDisabledControlJustReleased(0, Keys["E"]) and not block then
                                        block = true
                                        Weight = math.random(10, 24)
                                        Wait(100)
                                        local VehicleGetNetworkID = NetworkGetNetworkIdFromEntity(CompanyVeh)
                                        local TrailerGetNetworkID = NetworkGetNetworkIdFromEntity(CompanyTrailer)
                                        TriggerServerEvent("inside-trucker:AddCargo", Work.Name, Weight, VehicleGetNetworkID, TrailerGetNetworkID)
                                        TaskLeaveVehicle(ped, CompanyVeh, 0)
                                        FreezeEntityPosition(CompanyVeh, true)
                                        FreezeEntityPosition(CompanyTrailer, true)
                                        
                                        exports.bulletin:SendAdvanced({
                                            message = "You took the Contract. Open the Trailer for workers to load the cargo.",
                                            title = "<font color=#4effaf>"..Work.Label.."</font>",
                                            subject = "<font color=#4effaf>Trucker</font>",
                                            icon = 'CHAR_PLANESITE',
                                            timeout = 2500,
                                            position = 'bottom',
                                            theme = 'default',
                                            exitAnim = 'zoomOut',
                                            progress = true,
                                        })

                                        LoadPlace = Loading[i]
                                        Status = "LoadingOpenTrailer"
                                        block = false
                                    elseif IsControlJustReleased(0, Keys["H"]) and not block or IsDisabledControlJustReleased(0, Keys["H"]) and not block then
                                        block = true
                                        Weight = math.random(25, 30)
                                        Wait(100)
                                        local VehicleGetNetworkID = NetworkGetNetworkIdFromEntity(CompanyVeh)
                                        local TrailerGetNetworkID = NetworkGetNetworkIdFromEntity(CompanyTrailer)
                                        TriggerServerEvent("inside-trucker:AddCargo", Work.Name, Weight, VehicleGetNetworkID, TrailerGetNetworkID)
                                        TaskLeaveVehicle(ped, CompanyVeh, 0)
                                        FreezeEntityPosition(CompanyVeh, true)
                                        FreezeEntityPosition(CompanyTrailer, true)

                                        exports.bulletin:SendAdvanced({
                                            message = "You took the Contract. Open the Trailer for workers to load the cargo.",
                                            title = "<font color=#4effaf>"..Work.Label.."</font>",
                                            subject = "<font color=#4effaf>Trucker</font>",
                                            icon = 'CHAR_PLANESITE',
                                            timeout = 2500,
                                            position = 'bottom',
                                            theme = 'default',
                                            exitAnim = 'zoomOut',
                                            progress = true,
                                        })

                                        LoadPlace = Loading[i]
                                        Status = "LoadingOpenTrailer"
                                        block = false
                                    end
                                elseif (#(vehcoords - vector3(Loading[i].vehicleX, Loading[i].vehicleY, Loading[i].vehicleZ)) < 50.0) and (#(trailercoords - vector3(Loading[i].trailerX, Loading[i].trailerY, Loading[i].trailerZ)) < 50.0) then
                                    refresh = 4
                                    DrawMarker(6, Loading[i].vehicleX, Loading[i].vehicleY, Loading[i].vehicleZ - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 4.0, 4.0, 4.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 50, false, true, 2, false, false, false, false)
                                    DrawMarker(6, Loading[i].trailerX, Loading[i].trailerY, Loading[i].trailerZ - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 4.0, 4.0, 4.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 50, false, true, 2, false, false, false, false)
                                end
                            end
                        end

                    elseif Status == "LoadingOpenTrailer" then
                        local Entity = GetOffsetFromEntityInWorldCoords(CompanyTrailer, 0.0, -7.0, -1.8)
                        if (#(coords - vector3(Entity.x, Entity.y, Entity.z)) < 0.5) then
                            refresh = 4
                            DrawMarker(6, Entity.x, Entity.y, Entity.z - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                            DrawText3D(coords.x, coords.y, coords.z + 0.9, "[E] - ~w~Open the Trailer")
                            if IsControlJustReleased(0, Keys["E"]) and not block or IsDisabledControlJustReleased(0, Keys["E"]) and not block then
                                block = true
                                for v = 0, 7 do
                                    SetVehicleDoorOpen(CompanyTrailer, v, false, false)
                                end
                                FreezeEntityPosition(ped, true)
                                DoScreenFadeOut(500)
                                Wait(2000)
                                ObjectsTrailer("spawn")
                                DoScreenFadeIn(500)
                                FreezeEntityPosition(ped, false)
                                
                                exports.bulletin:SendAdvanced({
                                    message = Weight.." tons have been loaded. You can now close the Trailer and get ready to drive.",
                                    title = "<font color=#4effaf>"..Work.Label.."</font>",
                                    subject = "<font color=#4effaf>Trucker</font>",
                                    icon = 'CHAR_PLANESITE',
                                    timeout = 2500,
                                    position = 'bottom',
                                    theme = 'default',
                                    exitAnim = 'zoomOut',
                                    progress = true,
                                })

                                Status = "LoadingCloseTrailer"
                                block = false
                            end
                        elseif (#(coords - vector3(Entity.x, Entity.y, Entity.z)) < 30.0) then
                            refresh = 4
                            DrawMarker(6, Entity.x, Entity.y, Entity.z - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                            DrawMarker(2, Entity.x, Entity.y, Entity.z + 1.0, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.3, 0.3, 0.3, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, true, true, 2, false, false, false, false)
                        end

                    elseif Status == "LoadingCloseTrailer" then
                        local Entity = GetOffsetFromEntityInWorldCoords(CompanyTrailer, 0.0, -7.0, -1.8)
                        if (#(coords - vector3(Entity.x, Entity.y, Entity.z)) < 0.5) then
                            refresh = 4
                            DrawMarker(6, Entity.x, Entity.y, Entity.z - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                            DrawText3D(coords.x, coords.y, coords.z + 0.9, "[E] - ~w~Close the Trailer")
                            if IsControlJustReleased(0, Keys["E"]) and not block or IsDisabledControlJustReleased(0, Keys["E"]) and not block then
                                block = true
                                for v = 0, 7 do
                                    SetVehicleDoorShut(CompanyTrailer, v, true)
                                end
                                
                                exports.bulletin:SendAdvanced({
                                    message = "Go back to the Vehicle. The forwarder will send you the Transport Documents in a moment.",
                                    title = "<font color=#4effaf>"..Work.Label.."</font>",
                                    subject = "<font color=#4effaf>Trucker</font>",
                                    icon = 'CHAR_PLANESITE',
                                    timeout = 2500,
                                    position = 'bottom',
                                    theme = 'default',
                                    exitAnim = 'zoomOut',
                                    progress = true,
                                })

                                Status = "LoadingEnterToVehicle"
                                block = false
                            end
                        elseif (#(coords - vector3(Entity.x, Entity.y, Entity.z)) < 30.0) then
                            refresh = 4
                            DrawMarker(6, Entity.x, Entity.y, Entity.z - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                            DrawMarker(2, Entity.x, Entity.y, Entity.z + 1.0, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.3, 0.3, 0.3, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, true, true, 2, false, false, false, false)
                        end

                    elseif Status == "LoadingEnterToVehicle" then
                        if (#(coords - vector3(vehcoords.x, vehcoords.y, vehcoords.z)) < 30.0) then
                            refresh = 4
                            DrawMarker(2, vehcoords.x, vehcoords.y, vehcoords.z + 4.0, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, true, true, 2, false, false, false, false)
                            if IsPedInVehicle(ped, CompanyVeh) then
                                FreezeEntityPosition(CompanyVeh, false)
                                FreezeEntityPosition(CompanyTrailer, false)
                                UnloadPlace = Unloading[math.random(1, #Unloading)]
                                UnloadPlace.UnloadingBlip = AddBlipForCoord(UnloadPlace.vehicleX, UnloadPlace.vehicleY, UnloadPlace.vehicleZ)
                                SetBlipSprite(UnloadPlace.UnloadingBlip, cfg.Blip.NormalUnloading.Sprite)
                                SetBlipDisplay(UnloadPlace.UnloadingBlip, 4)
                                SetBlipScale(UnloadPlace.UnloadingBlip, cfg.Blip.NormalUnloading.Scale)
                                SetBlipAsShortRange(UnloadPlace.UnloadingBlip, cfg.Blip.NormalUnloading.ShortRange)
                                SetBlipColour(UnloadPlace.UnloadingBlip, cfg.Blip.NormalUnloading.Color)
                                BeginTextCommandSetBlipName("STRING")
                                AddTextComponentSubstringPlayerName(cfg.Blip.NormalUnloading.Label)
                                EndTextCommandSetBlipName(UnloadPlace.UnloadingBlip)
                                street = GetStreetNameAtCoord(UnloadPlace.vehicleX, UnloadPlace.vehicleY, UnloadPlace.vehicleZ)
                                street2 = GetStreetNameFromHashKey(street)
                                if cfg.ShowTransportInfo then
                                    ShowTransportInfo()
                                end

                                exports.bulletin:SendAdvanced({
                                    message = "Your unloading is in ~g~"..street2.."~s~.",
                                    title = "<font color=#4effaf>"..Work.Label.."</font>",
                                    subject = "<font color=#4effaf>Trucker</font>",
                                    icon = 'CHAR_PLANESITE',
                                    timeout = 5000,
                                    position = 'bottom',
                                    theme = 'default',
                                    exitAnim = 'zoomOut',
                                    progress = true,
                                })

                                Status = "UnloadingComingToPlace"
                            end
                        end

                    elseif Status == "UnloadingComingToPlace" then
                        if (#(vehcoords - vector3(UnloadPlace.vehicleX, UnloadPlace.vehicleY, UnloadPlace.vehicleZ)) < 2.0) and (#(trailercoords - vector3(UnloadPlace.trailerX, UnloadPlace.trailerY, UnloadPlace.trailerZ)) < 2.0) then
                            refresh = 4
                            DrawMarker(6, UnloadPlace.vehicleX, UnloadPlace.vehicleY, UnloadPlace.vehicleZ - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 4.0, 4.0, 4.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                            DrawMarker(6, UnloadPlace.trailerX, UnloadPlace.trailerY, UnloadPlace.trailerZ - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 4.0, 4.0, 4.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                            DrawText3D(UnloadPlace.vehicleX, UnloadPlace.vehicleY, UnloadPlace.vehicleZ + 1.0, "[E] - ~w~Park Truck")
                            if IsControlJustReleased(0, Keys["E"]) and not block or IsDisabledControlJustReleased(0, Keys["E"]) and not block then
                                block = true
                                RemoveBlip(UnloadPlace.UnloadingBlip)
                                TaskLeaveVehicle(ped, CompanyVeh, 0)
                                FreezeEntityPosition(CompanyVeh, true)
                                FreezeEntityPosition(CompanyTrailer, true)

                                exports.bulletin:SendAdvanced({
                                    message = "Open the Trailer for workers to unload the cargo.",
                                    title = "<font color=#4effaf>"..Work.Label.."</font>",
                                    subject = "<font color=#4effaf>Trucker</font>",
                                    icon = 'CHAR_PLANESITE',
                                    timeout = 2500,
                                    position = 'bottom',
                                    theme = 'default',
                                    exitAnim = 'zoomOut',
                                    progress = true,
                                })

                                Status = "UnloadingOpenTrailer"
                                block = false
                            end
                        elseif (#(vehcoords - vector3(UnloadPlace.vehicleX, UnloadPlace.vehicleY, UnloadPlace.vehicleZ)) < 50.0) and (#(trailercoords - vector3(UnloadPlace.trailerX, UnloadPlace.trailerY, UnloadPlace.trailerZ)) < 50.0) then
                            refresh = 4
                            DrawMarker(6, UnloadPlace.vehicleX, UnloadPlace.vehicleY, UnloadPlace.vehicleZ - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 4.0, 4.0, 4.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 50, false, true, 2, false, false, false, false)
                            DrawMarker(6, UnloadPlace.trailerX, UnloadPlace.trailerY, UnloadPlace.trailerZ - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 4.0, 4.0, 4.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 50, false, true, 2, false, false, false, false)
                        end

                    elseif Status == "UnloadingOpenTrailer" then
                        local Entity = GetOffsetFromEntityInWorldCoords(CompanyTrailer, 0.0, -7.0, -1.8)
                        if (#(coords - vector3(Entity.x, Entity.y, Entity.z)) < 0.5) then
                            refresh = 4
                            DrawMarker(6, Entity.x, Entity.y, Entity.z - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                            DrawText3D(coords.x, coords.y, coords.z + 0.9, "[E] - ~w~Open the Trailer")
                            if IsControlJustReleased(0, Keys["E"]) and not block or IsDisabledControlJustReleased(0, Keys["E"]) and not block then
                                block = true
                                for v = 0, 7 do
                                    SetVehicleDoorOpen(CompanyTrailer, v, false, false)
                                end
                                FreezeEntityPosition(ped, true)
                                DoScreenFadeOut(500)
                                Wait(2000)
                                ObjectsTrailer("delete")
                                DoScreenFadeIn(500)
                                Wait(100)
                                FreezeEntityPosition(ped, false)

                                exports.bulletin:SendAdvanced({
                                    message = "Your Trailer is empty, you can close it now.",
                                    title = "<font color=#4effaf>"..Work.Label.."</font>",
                                    subject = "<font color=#4effaf>Trucker</font>",
                                    icon = 'CHAR_PLANESITE',
                                    timeout = 2500,
                                    position = 'bottom',
                                    theme = 'default',
                                    exitAnim = 'zoomOut',
                                    progress = true,
                                })

                                Status = "UnloadingCloseTrailer"
                                block = false
                            end
                        elseif (#(coords - vector3(Entity.x, Entity.y, Entity.z)) < 30.0) then
                            refresh = 4
                            DrawMarker(6, Entity.x, Entity.y, Entity.z - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                            DrawMarker(2, Entity.x, Entity.y, Entity.z + 1.0, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.3, 0.3, 0.3, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, true, true, 2, false, false, false, false)
                        end

                    elseif Status == "UnloadingCloseTrailer" then
                        local Entity = GetOffsetFromEntityInWorldCoords(CompanyTrailer, 0.0, -7.0, -1.8)
                        if (#(coords - vector3(Entity.x, Entity.y, Entity.z)) < 0.5) then
                            refresh = 4
                            DrawMarker(6, Entity.x, Entity.y, Entity.z - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                            DrawText3D(coords.x, coords.y, coords.z + 0.9, "[E] - ~w~Close the Trailer")
                            if IsControlJustReleased(0, Keys["E"]) and not block or IsDisabledControlJustReleased(0, Keys["E"]) and not block then
                                block = true
                                for v = 0, 7 do
                                    SetVehicleDoorShut(CompanyTrailer, v, false)
                                end

                                exports.bulletin:SendAdvanced({
                                    message = "Order completed, return to the Truck and notify the freight forwarder.",
                                    title = "<font color=#4effaf>"..Work.Label.."</font>",
                                    subject = "<font color=#4effaf>Trucker</font>",
                                    icon = 'CHAR_PLANESITE',
                                    timeout = 2500,
                                    position = 'bottom',
                                    theme = 'default',
                                    exitAnim = 'zoomOut',
                                    progress = true,
                                })

                                Status = "UnloadingEnterToVehicle"
                                block = false
                            end
                        elseif (#(coords - vector3(Entity.x, Entity.y, Entity.z)) < 30.0) then
                            refresh = 4
                            DrawMarker(6, Entity.x, Entity.y, Entity.z - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                            DrawMarker(2, Entity.x, Entity.y, Entity.z + 1.0, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.3, 0.3, 0.3, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, true, true, 2, false, false, false, false)
                        end

                    elseif Status == "UnloadingEnterToVehicle" then
                        if (#(coords - vector3(vehcoords.x, vehcoords.y, vehcoords.z)) < 30.0) then
                            refresh = 4
                            DrawMarker(2, vehcoords.x, vehcoords.y, vehcoords.z + 4.0, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, true, true, 2, false, false, false, false)
                            if IsPedInVehicle(ped, CompanyVeh) then
                                FreezeEntityPosition(CompanyVeh, false)
                                FreezeEntityPosition(CompanyTrailer, false)
                                cfg.Prefix.Functions.TriggerCallback('inside-trucker:GetSalary', function(Salary)

                                    exports.bulletin:SendAdvanced({
                                        message = "You received a salary of ~g~£"..Salary.."~s~. You can pick up orders again or Finish Work.",
                                        title = "<font color=#4effaf>"..Work.Label.."</font>",
                                        subject = "<font color=#4effaf>Trucker</font>",
                                        icon = 'CHAR_PLANESITE',
                                        timeout = 5000,
                                        position = 'bottom',
                                        theme = 'default',
                                        exitAnim = 'zoomOut',
                                        progress = true,
                                    })

                                end, Weight, Work)
                                Wait(100)
                                local VehicleGetNetworkID = NetworkGetNetworkIdFromEntity(CompanyVeh)
                                local TrailerGetNetworkID = NetworkGetNetworkIdFromEntity(CompanyTrailer)
                                TriggerServerEvent("inside-trucker:AddCargo", Work.Name, 0, VehicleGetNetworkID, TrailerGetNetworkID)
                                LoadPlace = nil
                                UnloadPlace = nil
                                Status = nil
                            end
                        end
                    end

                elseif Work.Name == "wood" then

                    if Status == nil then
                        if IsPedInVehicle(ped, CompanyVeh) and IsEntityAttachedToEntity(CompanyTrailer, CompanyVeh) then
                            for i = 1, #Loading, 1 do
                                if (#(vehcoords - vector3(Loading[i].vehicleX, Loading[i].vehicleY, Loading[i].vehicleZ)) < 2.0) and (#(trailercoords - vector3(Loading[i].trailerX, Loading[i].trailerY, Loading[i].trailerZ)) < 2.0) then
                                    refresh = 4
                                    DrawMarker(6, Loading[i].vehicleX, Loading[i].vehicleY, Loading[i].vehicleZ - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 4.0, 4.0, 4.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                                    DrawMarker(6, Loading[i].trailerX, Loading[i].trailerY, Loading[i].trailerZ - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 4.0, 4.0, 4.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                                    DrawText3D(Loading[i].vehicleX, Loading[i].vehicleY, Loading[i].vehicleZ + 1.0, "~w~Legal = 10-20 tons, Illegal = 21-28 tons")
                                    DrawText3D(Loading[i].vehicleX, Loading[i].vehicleY, Loading[i].vehicleZ, "[E] - ~w~Load Legal~s~ | [H] - ~w~Load Illegal~s~")
                                    if IsControlJustReleased(0, Keys["E"]) and not block or IsDisabledControlJustReleased(0, Keys["E"]) and not block then
                                        block = true
                                        Weight = math.random(10, 20)
                                        Wait(100)
                                        local VehicleGetNetworkID = NetworkGetNetworkIdFromEntity(CompanyVeh)
                                        local TrailerGetNetworkID = NetworkGetNetworkIdFromEntity(CompanyTrailer)
                                        TriggerServerEvent("inside-trucker:AddCargo", Work.Name, Weight, VehicleGetNetworkID, TrailerGetNetworkID)
                                        TaskLeaveVehicle(ped, CompanyVeh, 0)
                                        FreezeEntityPosition(CompanyVeh, true)
                                        FreezeEntityPosition(CompanyTrailer, true)
                                        
                                        exports.bulletin:SendAdvanced({
                                            message = "You took the Contract. Pull the lashing straps out of the storage compartment in the Trailer.. During this time, the Workers will load the Boards for you.",
                                            title = "<font color=#4effaf>"..Work.Label.."</font>",
                                            subject = "<font color=#4effaf>Trucker</font>",
                                            icon = 'CHAR_PLANESITE',
                                            timeout = 5000,
                                            position = 'bottom',
                                            theme = 'default',
                                            exitAnim = 'zoomOut',
                                            progress = true,
                                        })

                                        WoodBeltSecured = 0
                                        WoodBelt = {
                                            [1] = {x = 2.10, y = -4.23, z = -0.17, Secured = false, Entity = CompanyTrailer},
                                            [2] = {x = -2.10, y = -4.23, z = -0.17, Secured = false, Entity = CompanyTrailer},
                                            [3] = {x = 2.10, y = -1.2, z = -0.17, Secured = false, Entity = CompanyTrailer},
                                            [4] = {x = -2.10, y = -1.2, z = -0.17, Secured = false, Entity = CompanyTrailer},
                                            [5] = {x = 2.10, y = 1.38, z = -0.17, Secured = false, Entity = CompanyTrailer},
                                            [6] = {x = -2.10, y = 1.38, z = -0.17, Secured = false, Entity = CompanyTrailer},
                                            [7] = {x = 2.10, y = 4.41, z = -0.17, Secured = false, Entity = CompanyTrailer},
                                            [8] = {x = -2.10, y = 4.41, z = -0.17, Secured = false, Entity = CompanyTrailer},
                                        }

                                        LoadPlace = Loading[i]
                                        Status = "LoadingGetStraps"
                                        block = false
                                    elseif IsControlJustReleased(0, Keys["H"]) and not block or IsDisabledControlJustReleased(0, Keys["H"]) and not block then
                                        block = true
                                        Weight = math.random(21, 28)
                                        Wait(100)
                                        local VehicleGetNetworkID = NetworkGetNetworkIdFromEntity(CompanyVeh)
                                        local TrailerGetNetworkID = NetworkGetNetworkIdFromEntity(CompanyTrailer)
                                        TriggerServerEvent("inside-trucker:AddCargo", Work.Name, Weight, VehicleGetNetworkID, TrailerGetNetworkID)
                                        TaskLeaveVehicle(ped, CompanyVeh, 0)
                                        FreezeEntityPosition(CompanyVeh, true)
                                        FreezeEntityPosition(CompanyTrailer, true)

                                        exports.bulletin:SendAdvanced({
                                            message = "You took the Contract. Pull the lashing straps out of the storage compartment in the Trailer.. During this time, the Workers will load the Boards for you.",
                                            title = "<font color=#4effaf>"..Work.Label.."</font>",
                                            subject = "<font color=#4effaf>Trucker</font>",
                                            icon = 'CHAR_PLANESITE',
                                            timeout = 5000,
                                            position = 'bottom',
                                            theme = 'default',
                                            exitAnim = 'zoomOut',
                                            progress = true,
                                        })

                                        WoodBeltSecured = 0
                                        WoodBelt = {
                                            [1] = {x = 2.10, y = -4.23, z = -0.17, Secured = false, Entity = CompanyTrailer},
                                            [2] = {x = -2.10, y = -4.23, z = -0.17, Secured = false, Entity = CompanyTrailer},
                                            [3] = {x = 2.10, y = -1.2, z = -0.17, Secured = false, Entity = CompanyTrailer},
                                            [4] = {x = -2.10, y = -1.2, z = -0.17, Secured = false, Entity = CompanyTrailer},
                                            [5] = {x = 2.10, y = 1.38, z = -0.17, Secured = false, Entity = CompanyTrailer},
                                            [6] = {x = -2.10, y = 1.38, z = -0.17, Secured = false, Entity = CompanyTrailer},
                                            [7] = {x = 2.10, y = 4.41, z = -0.17, Secured = false, Entity = CompanyTrailer},
                                            [8] = {x = -2.10, y = 4.41, z = -0.17, Secured = false, Entity = CompanyTrailer},
                                        }

                                        LoadPlace = Loading[i]
                                        Status = "LoadingGetStraps"
                                        block = false
                                    end
                                elseif (#(vehcoords - vector3(Loading[i].vehicleX, Loading[i].vehicleY, Loading[i].vehicleZ)) < 50.0) and (#(trailercoords - vector3(Loading[i].trailerX, Loading[i].trailerY, Loading[i].trailerZ)) < 50.0) then
                                    refresh = 4
                                    DrawMarker(6, Loading[i].vehicleX, Loading[i].vehicleY, Loading[i].vehicleZ - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 4.0, 4.0, 4.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 50, false, true, 2, false, false, false, false)
                                    DrawMarker(6, Loading[i].trailerX, Loading[i].trailerY, Loading[i].trailerZ - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 4.0, 4.0, 4.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 50, false, true, 2, false, false, false, false)
                                end
                            end
                        end

                    elseif Status == "LoadingGetStraps" then
                        local Entity = GetOffsetFromEntityInWorldCoords(CompanyTrailer, 2.1, -1.7, -0.17)
                        if (#(coords - vector3(Entity.x, Entity.y, Entity.z)) < 0.5) then
                            refresh = 4
                            DrawMarker(6, Entity.x, Entity.y, Entity.z - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                            DrawText3D(coords.x, coords.y, coords.z + 0.9, "[E] - ~w~Take the transport belt")
                            if IsControlJustReleased(0, Keys["E"]) and not block or IsDisabledControlJustReleased(0, Keys["E"]) and not block then
                                block = true
                                FreezeEntityPosition(ped, true)
                                DoScreenFadeOut(500)
                                TaskStartScenarioInPlace(ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                                Wait(2500)
                                ObjectsTrailer("spawn")
                                ClearPedTasks(ped)
                                DoScreenFadeIn(500)
                                FreezeEntityPosition(ped, false)

                                exports.bulletin:SendAdvanced({
                                    message = Weight.." tons have been loaded. Now you can secure the Load with lashing straps.",
                                    title = "<font color=#4effaf>"..Work.Label.."</font>",
                                    subject = "<font color=#4effaf>Trucker</font>",
                                    icon = 'CHAR_PLANESITE',
                                    timeout = 2500,
                                    position = 'bottom',
                                    theme = 'default',
                                    exitAnim = 'zoomOut',
                                    progress = true,
                                })

                                Status = "LoadingSecureCargo"
                                block = false
                            end
                        elseif (#(coords - vector3(Entity.x, Entity.y, Entity.z)) < 30.0) then
                            refresh = 4
                            DrawMarker(6, Entity.x, Entity.y, Entity.z - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                            DrawMarker(2, Entity.x, Entity.y, Entity.z + 1.0, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.3, 0.3, 0.3, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, true, true, 2, false, false, false, false)
                        end

                    elseif Status == "LoadingSecureCargo" then
                        for i = 1, #WoodBelt, 1 do
                            local Entity = GetOffsetFromEntityInWorldCoords(WoodBelt[i].Entity, WoodBelt[i].x, WoodBelt[i].y, WoodBelt[i].z)
                            if WoodBelt[i].Secured == false then
                                if (#(coords - vector3(Entity.x, Entity.y, Entity.z)) < 0.5) then
                                    refresh = 4
                                    DrawMarker(6, Entity.x, Entity.y, Entity.z - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                                    DrawText3D(coords.x, coords.y, coords.z + 0.9, "[E] - ~w~Secure the load")
                                    if IsControlJustReleased(0, Keys["E"]) and not block or IsDisabledControlJustReleased(0, Keys["E"]) and not block then
                                        block = true
                                        TaskStartScenarioInPlace(ped, 'PROP_HUMAN_BUM_BIN', 0, true)
                                        Wait(5000)
                                        ClearPedTasks(ped)
                                        WoodBelt[i].Secured = true
                                        WoodBeltSecured = WoodBeltSecured + 1
                                        if WoodBeltSecured == #WoodBelt then

                                            exports.bulletin:SendAdvanced({
                                                message = "Go back to the Vehicle. The forwarder will send you the Transport Documents in a moment.",
                                                title = "<font color=#4effaf>"..Work.Label.."</font>",
                                                subject = "<font color=#4effaf>Trucker</font>",
                                                icon = 'CHAR_PLANESITE',
                                                timeout = 2500,
                                                position = 'bottom',
                                                theme = 'default',
                                                exitAnim = 'zoomOut',
                                                progress = true,
                                            })

                                            Status = "LoadingEnterVehicle"
                                        end
                                        block = false
                                    end
                                elseif (#(coords - vector3(Entity.x, Entity.y, Entity.z)) < 30.0) then
                                    refresh = 4
                                    DrawMarker(6, Entity.x, Entity.y, Entity.z - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                                    DrawMarker(2, Entity.x, Entity.y, Entity.z + 1.0, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.3, 0.3, 0.3, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, true, true, 2, false, false, false, false)
                                end
                            end
                        end

                    elseif Status == "LoadingEnterVehicle" then
                        if (#(coords - vector3(vehcoords.x, vehcoords.y, vehcoords.z)) < 30.0) then
                            refresh = 4
                            DrawMarker(2, vehcoords.x, vehcoords.y, vehcoords.z + 4.0, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, true, true, 2, false, false, false, false)
                            if IsPedInVehicle(ped, CompanyVeh) then
                                FreezeEntityPosition(CompanyVeh, false)
                                FreezeEntityPosition(CompanyTrailer, false)
                                UnloadPlace = Unloading[math.random(1, #Unloading)]
                                UnloadPlace.UnloadingBlip = AddBlipForCoord(UnloadPlace.vehicleX, UnloadPlace.vehicleY, UnloadPlace.vehicleZ)
                                SetBlipSprite(UnloadPlace.UnloadingBlip, cfg.Blip.WoodUnloading.Sprite)
                                SetBlipDisplay(UnloadPlace.UnloadingBlip, 4)
                                SetBlipScale(UnloadPlace.UnloadingBlip, cfg.Blip.WoodUnloading.Scale)
                                SetBlipAsShortRange(UnloadPlace.UnloadingBlip, cfg.Blip.WoodUnloading.ShortRange)
                                SetBlipColour(UnloadPlace.UnloadingBlip, cfg.Blip.WoodUnloading.Color)
                                BeginTextCommandSetBlipName("STRING")
                                AddTextComponentSubstringPlayerName(cfg.Blip.WoodUnloading.Label)
                                EndTextCommandSetBlipName(UnloadPlace.UnloadingBlip)
                                street = GetStreetNameAtCoord(UnloadPlace.vehicleX, UnloadPlace.vehicleY, UnloadPlace.vehicleZ)
                                street2 = GetStreetNameFromHashKey(street)
                                if cfg.ShowTransportInfo then
                                    ShowTransportInfo()
                                end

                                exports.bulletin:SendAdvanced({
                                    message = "Your unloading is in ~g~"..street2.."~s~.",
                                    title = "<font color=#4effaf>"..Work.Label.."</font>",
                                    subject = "<font color=#4effaf>Trucker</font>",
                                    icon = 'CHAR_PLANESITE',
                                    timeout = 5000,
                                    position = 'bottom',
                                    theme = 'default',
                                    exitAnim = 'zoomOut',
                                    progress = true,
                                })

                                Status = "UnloadingComingToPlace"
                            end
                        end

                    elseif Status == "UnloadingComingToPlace" then
                        if (#(vehcoords - vector3(UnloadPlace.vehicleX, UnloadPlace.vehicleY, UnloadPlace.vehicleZ)) < 2.0) and (#(trailercoords - vector3(UnloadPlace.trailerX, UnloadPlace.trailerY, UnloadPlace.trailerZ)) < 2.0) then
                            refresh = 4
                            DrawMarker(6, UnloadPlace.vehicleX, UnloadPlace.vehicleY, UnloadPlace.vehicleZ - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 4.0, 4.0, 4.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                            DrawMarker(6, UnloadPlace.trailerX, UnloadPlace.trailerY, UnloadPlace.trailerZ - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 4.0, 4.0, 4.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                            DrawText3D(UnloadPlace.vehicleX, UnloadPlace.vehicleY, UnloadPlace.vehicleZ + 1.0, "[E] - ~w~Park Truck")
                            if IsControlJustReleased(0, Keys["E"]) and not block or IsDisabledControlJustReleased(0, Keys["E"]) and not block then
                                block = true
                                RemoveBlip(UnloadPlace.UnloadingBlip)
                                TaskLeaveVehicle(ped, CompanyVeh, 0)
                                FreezeEntityPosition(CompanyVeh, true)
                                FreezeEntityPosition(CompanyTrailer, true)

                                exports.bulletin:SendAdvanced({
                                    message = "Remove the lashing straps so workers can unload the boards.",
                                    title = "<font color=#4effaf>"..Work.Label.."</font>",
                                    subject = "<font color=#4effaf>Trucker</font>",
                                    icon = 'CHAR_PLANESITE',
                                    timeout = 2500,
                                    position = 'bottom',
                                    theme = 'default',
                                    exitAnim = 'zoomOut',
                                    progress = true,
                                })

                                Status = "UnloadingUnsecureCargo"
                                block = false
                            end
                        elseif (#(vehcoords - vector3(UnloadPlace.vehicleX, UnloadPlace.vehicleY, UnloadPlace.vehicleZ)) < 50.0) and (#(trailercoords - vector3(UnloadPlace.trailerX, UnloadPlace.trailerY, UnloadPlace.trailerZ)) < 50.0) then
                            refresh = 4
                            DrawMarker(6, UnloadPlace.vehicleX, UnloadPlace.vehicleY, UnloadPlace.vehicleZ - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 4.0, 4.0, 4.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 50, false, true, 2, false, false, false, false)
                            DrawMarker(6, UnloadPlace.trailerX, UnloadPlace.trailerY, UnloadPlace.trailerZ - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 4.0, 4.0, 4.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 50, false, true, 2, false, false, false, false)
                        end

                    elseif Status == "UnloadingUnsecureCargo" then
                        for i = 1, #WoodBelt, 1 do
                            local Entity = GetOffsetFromEntityInWorldCoords(WoodBelt[i].Entity, WoodBelt[i].x, WoodBelt[i].y, WoodBelt[i].z)
                            if WoodBelt[i].Secured == true then
                                if (#(coords - vector3(Entity.x, Entity.y, Entity.z)) < 0.5) then
                                    refresh = 4
                                    DrawMarker(6, Entity.x, Entity.y, Entity.z - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                                    DrawText3D(coords.x, coords.y, coords.z + 0.9, "[E] - ~w~Unsecure the load")
                                    if IsControlJustReleased(0, Keys["E"]) and not block or IsDisabledControlJustReleased(0, Keys["E"]) and not block then
                                        block = true
                                        TaskStartScenarioInPlace(ped, 'PROP_HUMAN_BUM_BIN', 0, true)
                                        Wait(5000)
                                        ClearPedTasks(ped)
                                        WoodBelt[i].Secured = false
                                        WoodBeltSecured = WoodBeltSecured - 1
                                        if WoodBeltSecured == 0 then

                                            exports.bulletin:SendAdvanced({
                                                message = "Now you can stow the lashing straps in the storage compartment in the Trailer, while the workers unload the Boards.",
                                                title = "<font color=#4effaf>"..Work.Label.."</font>",
                                                subject = "<font color=#4effaf>Trucker</font>",
                                                icon = 'CHAR_PLANESITE',
                                                timeout = 2500,
                                                position = 'bottom',
                                                theme = 'default',
                                                exitAnim = 'zoomOut',
                                                progress = true,
                                            })

                                            Status = "UnloadingPutStraps"
                                        end
                                        block = false
                                    end
                                elseif (#(coords - vector3(Entity.x, Entity.y, Entity.z)) < 30.0) then
                                    refresh = 4
                                    DrawMarker(6, Entity.x, Entity.y, Entity.z - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                                    DrawMarker(2, Entity.x, Entity.y, Entity.z + 1.0, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.3, 0.3, 0.3, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, true, true, 2, false, false, false, false)
                                end
                            end
                        end

                    elseif Status == "UnloadingPutStraps" then
                        local Entity = GetOffsetFromEntityInWorldCoords(CompanyTrailer, 2.1, -1.7, -0.17)
                        if (#(coords - vector3(Entity.x, Entity.y, Entity.z)) < 0.5) then
                            refresh = 4
                            DrawMarker(6, Entity.x, Entity.y, Entity.z - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                            DrawText3D(coords.x, coords.y, coords.z + 0.9, "[E] - ~w~Put the transport belt")
                            if IsControlJustReleased(0, Keys["E"]) and not block or IsDisabledControlJustReleased(0, Keys["E"]) and not block then
                                block = true
                                FreezeEntityPosition(ped, true)
                                DoScreenFadeOut(500)
                                TaskStartScenarioInPlace(ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                                Wait(2500)
                                ObjectsTrailer("delete")
                                ClearPedTasks(ped)
                                DoScreenFadeIn(500)
                                FreezeEntityPosition(ped, false)

                                exports.bulletin:SendAdvanced({
                                    message = "Order completed, return to the Truck and notify the freight forwarder.",
                                    title = "<font color=#4effaf>"..Work.Label.."</font>",
                                    subject = "<font color=#4effaf>Trucker</font>",
                                    icon = 'CHAR_PLANESITE',
                                    timeout = 2500,
                                    position = 'bottom',
                                    theme = 'default',
                                    exitAnim = 'zoomOut',
                                    progress = true,
                                })

                                Status = "UnloadingEnterToVehicle"
                                block = false
                            end
                        elseif (#(coords - vector3(Entity.x, Entity.y, Entity.z)) < 30.0) then
                            refresh = 4
                            DrawMarker(6, Entity.x, Entity.y, Entity.z - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                            DrawMarker(2, Entity.x, Entity.y, Entity.z + 1.0, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.3, 0.3, 0.3, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, true, true, 2, false, false, false, false)
                        end

                    elseif Status == "UnloadingEnterToVehicle" then
                        if (#(coords - vector3(vehcoords.x, vehcoords.y, vehcoords.z)) < 30.0) then
                            refresh = 4
                            DrawMarker(2, vehcoords.x, vehcoords.y, vehcoords.z + 4.0, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, true, true, 2, false, false, false, false)
                            if IsPedInVehicle(ped, CompanyVeh) then
                                FreezeEntityPosition(CompanyVeh, false)
                                FreezeEntityPosition(CompanyTrailer, false)
                                cfg.Prefix.Functions.TriggerCallback('inside-trucker:GetSalary', function(Salary)

                                    exports.bulletin:SendAdvanced({
                                        message = "You received a salary of ~g~£"..Salary.."~s~. You can pick up orders again or Finish Work.",
                                        title = "<font color=#4effaf>"..Work.Label.."</font>",
                                        subject = "<font color=#4effaf>Trucker</font>",
                                        icon = 'CHAR_PLANESITE',
                                        timeout = 5000,
                                        position = 'bottom',
                                        theme = 'default',
                                        exitAnim = 'zoomOut',
                                        progress = true,
                                    })

                                end, Weight, Work)
                                Wait(100)
                                local VehicleGetNetworkID = NetworkGetNetworkIdFromEntity(CompanyVeh)
                                local TrailerGetNetworkID = NetworkGetNetworkIdFromEntity(CompanyTrailer)
                                TriggerServerEvent("inside-trucker:AddCargo", Work.Name, 0, VehicleGetNetworkID, TrailerGetNetworkID)
                                LoadPlace = nil
                                UnloadPlace = nil
                                Status = nil
                            end
                        end
                    end
                end
            Wait(refresh)
        end
    end)
end

function PlatformScale()
    CreateThread(function()

        PlatformScale = cfg.Coords.PlatformScale

        for i = 1, #PlatformScale, 1 do
            PlatformScale[i].Platform = CreateObject(GetHashKey('prop_spray_jackframe'), PlatformScale[i].x, PlatformScale[i].y, PlatformScale[i].z, false)
            SetEntityHeading(PlatformScale[i].Platform, PlatformScale[i].h)
            FreezeEntityPosition(PlatformScale[i].Platform, true)
    
            local ToolChestPos = GetOffsetFromEntityInWorldCoords(PlatformScale[i].Platform, 3.0, 0.0, -0.1)
            PlatformScale[i].ToolChest = CreateObject(GetHashKey('prop_toolchest_03'), ToolChestPos.x, ToolChestPos.y, ToolChestPos.z, false)
            FreezeEntityPosition(PlatformScale[i].ToolChest, true)
    
            local LaptopPos = GetOffsetFromEntityInWorldCoords(PlatformScale[i].Platform, 3.0, 0.0, 0.87)
            PlatformScale[i].Laptop = CreateObject(GetHashKey('prop_laptop_jimmy'), LaptopPos.x, LaptopPos.y, LaptopPos.z, false)
            FreezeEntityPosition(PlatformScale[i].Laptop, true)


            PlatformScale[i].PlatformScaleBlip = AddBlipForCoord(PlatformScale[i].x, PlatformScale[i].y, PlatformScale[i].z)
            SetBlipSprite(PlatformScale[i].PlatformScaleBlip, cfg.Blip.PlatformScale.Sprite)
            SetBlipDisplay(PlatformScale[i].PlatformScaleBlip, 4)
            SetBlipScale(PlatformScale[i].PlatformScaleBlip, cfg.Blip.PlatformScale.Scale)
            SetBlipAsShortRange(PlatformScale[i].PlatformScaleBlip, cfg.Blip.PlatformScale.ShortRange)
            SetBlipColour(PlatformScale[i].PlatformScaleBlip, cfg.Blip.PlatformScale.Color)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(cfg.Blip.PlatformScale.Label)
            EndTextCommandSetBlipName(PlatformScale[i].PlatformScaleBlip)
        end

        while true do

            local refresh = 1000
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)

                if ActPlatformScale == nil then
                    for i = 1, #PlatformScale, 1 do
                        if (#(coords - vector3(PlatformScale[i].vehicleX, PlatformScale[i].vehicleY, PlatformScale[i].vehicleZ)) < 50.0) then
                            ActPlatformScale = PlatformScale[i]
                        end
                    end
                elseif ActPlatformScale ~= nil then
                    if (#(coords - vector3(ActPlatformScale.vehicleX, ActPlatformScale.vehicleY, ActPlatformScale.vehicleZ)) < 50.0) then
                        refresh = 4
                        DrawMarker(6, ActPlatformScale.vehicleX, ActPlatformScale.vehicleY, ActPlatformScale.vehicleZ - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 4.0, 4.0, 4.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, ActPlatformScale.MarkerAlpha, false, true, 2, false, false, false, false)
                        DrawMarker(6, ActPlatformScale.trailerX, ActPlatformScale.trailerY, ActPlatformScale.trailerZ - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 4.0, 4.0, 4.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, ActPlatformScale.MarkerAlpha, false, true, 2, false, false, false, false)
                        for i = 1, #PlayersCargo, 1 do
                            local vehcoords = GetEntityCoords(PlayersCargo[i].VehicleEntityID)
                            local trailercoords = GetEntityCoords(PlayersCargo[i].TrailerEntityID)
                            if (#(vehcoords - vector3(ActPlatformScale.vehicleX, ActPlatformScale.vehicleY, ActPlatformScale.vehicleZ)) < 2.0) and (#(trailercoords - vector3(ActPlatformScale.trailerX, ActPlatformScale.trailerY, ActPlatformScale.trailerZ)) < 2.0) then
                                ActPlatformScale.MarkerAlpha = 175
                                ActPlatformScale.PlatformScaleInfoPos = GetOffsetFromEntityInWorldCoords(ActPlatformScale.Platform, 2.4, 0.6, 0.0)
                                if (#(coords - vector3(ActPlatformScale.PlatformScaleInfoPos.x, ActPlatformScale.PlatformScaleInfoPos.y, ActPlatformScale.PlatformScaleInfoPos.z)) < 1.0) then
                                    DrawMarker(6, ActPlatformScale.PlatformScaleInfoPos.x, ActPlatformScale.PlatformScaleInfoPos.y, ActPlatformScale.PlatformScaleInfoPos.z - 0.05, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                                    if PlayersCargo[i].TypeOfWork == "normal" then
                                        DrawText3D(ActPlatformScale.PlatformScaleInfoPos.x, ActPlatformScale.PlatformScaleInfoPos.y, ActPlatformScale.PlatformScaleInfoPos.z + 1.4, "Normal Transport")
                                    elseif PlayersCargo[i].TypeOfWork == "wood" then
                                        DrawText3D(ActPlatformScale.PlatformScaleInfoPos.x, ActPlatformScale.PlatformScaleInfoPos.y, ActPlatformScale.PlatformScaleInfoPos.z + 1.4, "Wood Transport")
                                    end
                                    DrawText3D(ActPlatformScale.PlatformScaleInfoPos.x, ActPlatformScale.PlatformScaleInfoPos.y, ActPlatformScale.PlatformScaleInfoPos.z + 1.2, "Driver: ~w~"..PlayersCargo[i].TrailerOwner.." ("..PlayersCargo[i].OwnerID..")")
                                    DrawText3D(ActPlatformScale.PlatformScaleInfoPos.x, ActPlatformScale.PlatformScaleInfoPos.y, ActPlatformScale.PlatformScaleInfoPos.z + 1.0, "Load Weight: ~w~"..tostring(PlayersCargo[i].CargoWeight).." tons")
                                    if PlayersCargo[i].CargoWeight > 0 then
                                        if PlayerData.job ~= nil and PlayerData.job.name == cfg.PoliceJobName then
                                            DrawText3D(coords.x, coords.y, coords.z + 0.9, "[G] - ~w~Confiscate the Cargo")
                                            if IsControlJustReleased(0, Keys["G"]) and not block or IsDisabledControlJustReleased(0, Keys["G"]) and not block then
                                                block = true
                                                TriggerServerEvent("inside-trucker:ConfiscateCargo", PlayersCargo[i].TrailerOwner, PlayersCargo[i].OwnerID)
                                                block = false
                                            end
                                        end
                                    end
                                elseif (#(coords - vector3(ActPlatformScale.PlatformScaleInfoPos.x, ActPlatformScale.PlatformScaleInfoPos.y, ActPlatformScale.PlatformScaleInfoPos.z)) < 50.0) then
                                    DrawMarker(2, ActPlatformScale.PlatformScaleInfoPos.x, ActPlatformScale.PlatformScaleInfoPos.y, ActPlatformScale.PlatformScaleInfoPos.z + 1.9, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.3, 0.3, 0.3, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, true, true, 2, false, false, false, false)
                                    DrawMarker(6, ActPlatformScale.PlatformScaleInfoPos.x, ActPlatformScale.PlatformScaleInfoPos.y, ActPlatformScale.PlatformScaleInfoPos.z - 0.05, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 175, false, true, 2, false, false, false, false)
                                end
                            else
                                ActPlatformScale.MarkerAlpha = 50
                            end
                        end
                    else
                        ActPlatformScale = nil
                    end
                end
            Wait(refresh)
        end
    end)
end

function ShowTransportInfo()
    CreateThread(function()

        LoadStreet = GetStreetNameAtCoord(LoadPlace.vehicleX, LoadPlace.vehicleY, LoadPlace.vehicleZ)
        LoadStreetName = GetStreetNameFromHashKey(LoadStreet)

        UnloadStreet = GetStreetNameAtCoord(UnloadPlace.vehicleX, UnloadPlace.vehicleY, UnloadPlace.vehicleZ)
        UnloadStreetName = GetStreetNameFromHashKey(UnloadStreet)

        while true do
            local refresh = 4
            if LoadPlace ~= nil and UnloadPlace ~= nil then
                DrawText2D(0.5, 0.88, "~g~Loading:~s~ "..LoadStreetName.."\n~g~Unloading:~s~ "..UnloadStreetName.."\n~g~Weight:~s~ "..Weight.." tons", 0.35)
            else
                break
            end
            Wait(refresh)
        end
    end)
end

Boards = {
    [1] = {BoardEntity, xPos = 0.0, yPos = 2.8, zPos = 0.4, xRot = 0.0, yRot = 0.0, zRot = 0.0},
    [2] = {BoardEntity, xPos = 0.0, yPos = -2.8, zPos = 0.4, xRot = 0.0, yRot = 0.0, zRot = 0.0},
    [3] = {BoardEntity, xPos = 0.0, yPos = 2.8, zPos = 1.47, xRot = 0.0, yRot = 0.0, zRot = 0.0},
    [4] = {BoardEntity, xPos = 0.0, yPos = -2.8, zPos = 1.47, xRot = 0.0, yRot = 0.0, zRot = 0.0},
}

Box = {
    [1] = {BoxEntity, BoxEntityz1, BoxEntityz2, BoxEntityz3, BoxEntityz4, BoxEntityz5, BoxEntityz6, xPos = -1.02, yPos = -4.5, zPos = -1.1, xRot = 0.0, yRot = 0.0, zRot = 0.0},
    [2] = {BoxEntity, BoxEntityz1, BoxEntityz2, BoxEntityz3, BoxEntityz4, BoxEntityz5, BoxEntityz6, xPos = 1.02, yPos = -4.5, zPos = -1.1, xRot = 0.0, yRot = 0.0, zRot = 0.0},
    [3] = {BoxEntity, BoxEntityz1, BoxEntityz2, BoxEntityz3, BoxEntityz4, BoxEntityz5, BoxEntityz6, xPos = -0.58, yPos = -4.5, zPos = -1.1, xRot = 0.0, yRot = 0.0, zRot = 0.0},
    [4] = {BoxEntity, BoxEntityz1, BoxEntityz2, BoxEntityz3, BoxEntityz4, BoxEntityz5, BoxEntityz6, xPos = 0.58, yPos = -4.5, zPos = -1.1, xRot = 0.0, yRot = 0.0, zRot = 0.0},
    [5] = {BoxEntity, BoxEntityz1, BoxEntityz2, BoxEntityz3, BoxEntityz4, BoxEntityz5, BoxEntityz6, xPos = 0.18, yPos = -4.46, zPos = -1.1, xRot = 0.0, yRot = 0.0, zRot = 90.0},
    [6] = {BoxEntity, BoxEntityz1, BoxEntityz2, BoxEntityz3, BoxEntityz4, BoxEntityz5, BoxEntityz6, xPos = -0.18, yPos = -4.46, zPos = -1.1, xRot = 0.0, yRot = 0.0, zRot = 90.0},
    [7] = {BoxEntity, BoxEntityz1, BoxEntityz2, BoxEntityz3, BoxEntityz4, BoxEntityz5, BoxEntityz6, xPos = -1.02, yPos = -4.98, zPos = -1.1, xRot = 0.0, yRot = 0.0, zRot = 0.0},
    [8] = {BoxEntity, BoxEntityz1, BoxEntityz2, BoxEntityz3, BoxEntityz4, BoxEntityz5, BoxEntityz6, xPos = 1.02, yPos = -4.98, zPos = -1.1, xRot = 0.0, yRot = 0.0, zRot = 0.0},
    [9] = {BoxEntity, BoxEntityz1, BoxEntityz2, BoxEntityz3, BoxEntityz4, BoxEntityz5, BoxEntityz6, xPos = -0.58, yPos = -4.98, zPos = -1.1, xRot = 0.0, yRot = 0.0, zRot = 0.0},
    [10] = {BoxEntity, BoxEntityz1, BoxEntityz2, BoxEntityz3, BoxEntityz4, BoxEntityz5, BoxEntityz6, xPos = 0.58, yPos = -4.98, zPos = -1.1, xRot = 0.0, yRot = 0.0, zRot = 0.0},
    [11] = {BoxEntity, BoxEntityz1, BoxEntityz2, BoxEntityz3, BoxEntityz4, BoxEntityz5, BoxEntityz6, xPos = 0.18, yPos = -4.94, zPos = -1.1, xRot = 0.0, yRot = 0.0, zRot = 90.0},
    [12] = {BoxEntity, BoxEntityz1, BoxEntityz2, BoxEntityz3, BoxEntityz4, BoxEntityz5, BoxEntityz6, xPos = -0.18, yPos = -4.94, zPos = -1.1, xRot = 0.0, yRot = 0.0, zRot = 90.0},
    [13] = {BoxEntity, BoxEntityz1, BoxEntityz2, BoxEntityz3, BoxEntityz4, BoxEntityz5, BoxEntityz6, xPos = -1.02, yPos = -5.46, zPos = -1.1, xRot = 0.0, yRot = 0.0, zRot = 0.0},
    [14] = {BoxEntity, BoxEntityz1, BoxEntityz2, BoxEntityz3, BoxEntityz4, BoxEntityz5, BoxEntityz6, xPos = 1.02, yPos = -5.46, zPos = -1.1, xRot = 0.0, yRot = 0.0, zRot = 0.0},
    [15] = {BoxEntity, BoxEntityz1, BoxEntityz2, BoxEntityz3, BoxEntityz4, BoxEntityz5, BoxEntityz6, xPos = -0.58, yPos = -5.46, zPos = -1.1, xRot = 0.0, yRot = 0.0, zRot = 0.0},
    [16] = {BoxEntity, BoxEntityz1, BoxEntityz2, BoxEntityz3, BoxEntityz4, BoxEntityz5, BoxEntityz6, xPos = 0.58, yPos = -5.46, zPos = -1.1, xRot = 0.0, yRot = 0.0, zRot = 0.0},
    [17] = {BoxEntity, BoxEntityz1, BoxEntityz2, BoxEntityz3, BoxEntityz4, BoxEntityz5, BoxEntityz6, xPos = 0.18, yPos = -5.42, zPos = -1.1, xRot = 0.0, yRot = 0.0, zRot = 90.0},
    [18] = {BoxEntity, BoxEntityz1, BoxEntityz2, BoxEntityz3, BoxEntityz4, BoxEntityz5, BoxEntityz6, xPos = -0.18, yPos = -5.42, zPos = -1.1, xRot = 0.0, yRot = 0.0, zRot = 90.0},
}

function ObjectsTrailer(Type)

    if Type == "spawn" then
        if Work.Name == "normal" then
            for i = 1, #Box, 1 do
                Box[i].BoxEntity = CreateObject(GetHashKey('prop_cs_cardbox_01'), 0, 0, 0, true)
                AttachEntityToEntity(Box[i].BoxEntity, CompanyTrailer, GetEntityBoneIndexByName(CompanyTrailer, 'boot'), Box[i].xPos, Box[i].yPos, Box[i].zPos, Box[i].xRot, Box[i].yRot, Box[i].zRot, true, true, false, true, 1, true)
        
                Box[i].BoxEntityz1 = CreateObject(GetHashKey('prop_cs_cardbox_01'), 0, 0, 0, true)
                AttachEntityToEntity(Box[i].BoxEntityz1, CompanyTrailer, GetEntityBoneIndexByName(CompanyTrailer, 'boot'), Box[i].xPos, Box[i].yPos, Box[i].zPos + 0.35, Box[i].xRot, Box[i].yRot, Box[i].zRot, true, true, false, true, 1, true)
        
                Box[i].BoxEntityz2 = CreateObject(GetHashKey('prop_cs_cardbox_01'), 0, 0, 0, true)
                AttachEntityToEntity(Box[i].BoxEntityz2, CompanyTrailer, GetEntityBoneIndexByName(CompanyTrailer, 'boot'), Box[i].xPos, Box[i].yPos, Box[i].zPos + 0.70, Box[i].xRot, Box[i].yRot, Box[i].zRot, true, true, false, true, 1, true)
        
                Box[i].BoxEntityz3 = CreateObject(GetHashKey('prop_cs_cardbox_01'), 0, 0, 0, true)
                AttachEntityToEntity(Box[i].BoxEntityz3, CompanyTrailer, GetEntityBoneIndexByName(CompanyTrailer, 'boot'), Box[i].xPos, Box[i].yPos, Box[i].zPos + 1.05, Box[i].xRot, Box[i].yRot, Box[i].zRot, true, true, false, true, 1, true)
        
                Box[i].BoxEntityz4 = CreateObject(GetHashKey('prop_cs_cardbox_01'), 0, 0, 0, true)
                AttachEntityToEntity(Box[i].BoxEntityz4, CompanyTrailer, GetEntityBoneIndexByName(CompanyTrailer, 'boot'), Box[i].xPos, Box[i].yPos, Box[i].zPos + 1.40, Box[i].xRot, Box[i].yRot, Box[i].zRot, true, true, false, true, 1, true)
        
                Box[i].BoxEntityz5 = CreateObject(GetHashKey('prop_cs_cardbox_01'), 0, 0, 0, true)
                AttachEntityToEntity(Box[i].BoxEntityz5, CompanyTrailer, GetEntityBoneIndexByName(CompanyTrailer, 'boot'), Box[i].xPos, Box[i].yPos, Box[i].zPos + 1.75, Box[i].xRot, Box[i].yRot, Box[i].zRot, true, true, false, true, 1, true)
        
                Box[i].BoxEntityz6 = CreateObject(GetHashKey('prop_cs_cardbox_01'), 0, 0, 0, true)
                AttachEntityToEntity(Box[i].BoxEntityz6, CompanyTrailer, GetEntityBoneIndexByName(CompanyTrailer, 'boot'), Box[i].xPos, Box[i].yPos, Box[i].zPos + 2.10, Box[i].xRot, Box[i].yRot, Box[i].zRot, true, true, false, true, 1, true)
            end
        elseif Work.Name == "wood" then
            for i = 1, #Boards, 1 do
                Boards[i].BoardEntity = CreateObject(GetHashKey('prop_woodpile_02a'), 0, 0, 0, true)
                AttachEntityToEntity(Boards[i].BoardEntity, CompanyTrailer, GetEntityBoneIndexByName(CompanyTrailer, 'boot'), Boards[i].xPos, Boards[i].yPos, Boards[i].zPos, Boards[i].xRot, Boards[i].yRot, Boards[i].zRot, true, true, false, true, 1, true)
            end
        end
        objectspawned = true
    elseif Type == "delete" then
        if Work.Name == "normal" then
            for i = 1, #Box, 1 do
                DeleteEntity(Box[i].BoxEntity)

                DeleteEntity(Box[i].BoxEntityz1)

                DeleteEntity(Box[i].BoxEntityz2)

                DeleteEntity(Box[i].BoxEntityz3)

                DeleteEntity(Box[i].BoxEntityz4)

                DeleteEntity(Box[i].BoxEntityz5)

                DeleteEntity(Box[i].BoxEntityz6)
            end
        elseif Work.Name == "wood" then
            for i = 1, #Boards, 1 do
                DeleteEntity(Boards[i].BoardEntity)
            end
        end
        objectspawned = false
    end
end

function SpawnCar(model, coords, h, type)

    if type == "Car" then
        cfg.Prefix.Functions.SpawnVehicle(model, function(vehicle)
            SetEntityHeading(vehicle, h)
            SetVehicleDirtLevel(vehicle, 0.0)
            SetVehicleCustomPrimaryColour(vehicle, 255, 255, 255)
            SetVehicleCustomSecondaryColour(vehicle, 255, 255, 255)
            SetVehicleExtraColours(vehicle, 131, 131)
            SetVehicleNumberPlateText(vehicle, "TRC"..tostring(math.random(1000, 9999)))
            SetVehicleEngineOn(vehicle, true, false)
            CompanyVeh = vehicle
        end, coords)
    elseif type == "Trailer" then
        cfg.Prefix.Functions.SpawnVehicle(model, function(vehicle)
            SetEntityHeading(vehicle, h)
            SetVehicleDirtLevel(vehicle, 0.0)
            SetVehicleLivery(vehicle, 1)
            SetVehicleCustomPrimaryColour(vehicle, 255, 255, 255)
            SetVehicleCustomSecondaryColour(vehicle, 255, 255, 255)
            SetVehicleExtraColours(vehicle, 131, 131)
            SetVehicleNumberPlateText(vehicle, "TRC"..tostring(math.random(1000, 9999)))
            SetVehicleEngineOn(vehicle, true, false)
            CompanyTrailer = vehicle
        end, coords)
    end

end

RegisterNetEvent('inside-trucker:ConfiscateCargoByPolice')
AddEventHandler('inside-trucker:ConfiscateCargoByPolice', function()	
    RemoveBlip(UnloadPlace.UnloadingBlip)
    Status = nil
    LoadPlace = nil
    UnloadPlace = nil
    if objectspawned then ObjectsTrailer("delete") end

    exports.bulletin:SendAdvanced({
        message = "Your Cargo has been confiscated by the Police.",
        title = "<font color=#4effaf>"..Work.Label.."</font>",
        subject = "<font color=#4effaf>Trucker</font>",
        icon = 'CHAR_PLANESITE',
        timeout = 2500,
        position = 'bottom',
        theme = 'default',
        exitAnim = 'zoomOut',
        progress = true,
    })
end)


RegisterNetEvent('inside-trucker:SynchronizeCargo')
AddEventHandler('inside-trucker:SynchronizeCargo', function(CargosTable)	
    PlayersCargo = CargosTable

    Wait(100)

    for i = 1, #PlayersCargo, 1 do
        local vehicle = NetworkGetEntityFromNetworkId(PlayersCargo[i].VehicleEntityID)
        local trailer = NetworkGetEntityFromNetworkId(PlayersCargo[i].TrailerEntityID)

        PlayersCargo[i].VehicleEntityID = vehicle
        PlayersCargo[i].TrailerEntityID = trailer
    end
end)
------ ISSPAWNPOINTCLEAR ESX
function GetVehiclesInArea(coords, maxDistance)
	return EnumerateEntitiesWithinDistance(GetVehicles(), false, coords, maxDistance)
end

function IsSpawnPointClear(coords, maxDistance)
	return #GetVehiclesInArea(coords, maxDistance) == 0
end

function GetVehicles()
	return GetGamePool('CVehicle')
end

function EnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
	local nearbyEntities = {}

	if coords then
		coords = vector3(coords.x, coords.y, coords.z)
	end

	for k,entity in pairs(entities) do
		local distance = #(coords - GetEntityCoords(entity))

		if distance <= maxDistance then
			nearbyEntities[#nearbyEntities + 1] = isPlayerEntities and k or entity
		end
	end

	return nearbyEntities
end
------ ISSPAWNPOINTCLEAR ESX

function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(cfg.Colors.r, cfg.Colors.g, cfg.Colors.b, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.025+ factor, 0.03, 19, 19, 51, 155)
    ClearDrawOrigin()
end

function DrawText2D(x, y, text, scale)
    SetTextFont(4)
    SetTextProportional(7)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0.0, 0.0, 0.0, 0.0, 255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
	SetTextCentre(true)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end