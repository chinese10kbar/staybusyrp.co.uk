if GetResourceState('sb-core') ~= 'started' then return end

local QBCore = exports['sb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    OnPlayerLogout()
end)

function handleVehicleKeys(veh)
    local plate = GetVehicleNumberPlateText(veh)
    TriggerServerEvent('sb-vehiclekeys:server:AcquireVehicleKeys', plate)
end

function hasPlyLoaded()
    return LocalPlayer.state.isLoggedIn
end

function DoNotification(text, nType)
    QBCore.Functions.Notify(text, nType)
end

function AlertPolice(vehicle)
    local callData = {
        job = { 'police'},
        callLocation = GetEntityCoords(vehicle),
        callCode = { code = 'Theft', snippet = 'Vehicle Theft' },
        message = "Vehicle theft in progress!",
        flashes = false,
        image = "", -- No image for vehicle theft
        blip = {
            sprite = 227,
            scale = 1.5,
            colour = 1,
            flashes = true,
            text = 'Vehicle Theft',
            time = (20 * 1000)
        },
        otherData = {
            {
                text = 'Red Obscure',
                icon = 'fas fa-user-secret'
            }
        }
    }
    
    TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', callData)
end
