--[[
    Hi dear customer or developer, here you can fully configure your server's
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version
    of the framework that you use in its latest version and it will work perfectly.
]]

if Config.Framework ~= "qb" then
    return
end

Citizen.CreateThread(function()
    QBCore = exports['sb-core']:GetCoreObject()

    while QBCore.Functions.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = QBCore.Functions.GetPlayerData()
end)

qbcoreMenu = 'sb-menu'         -- Only if use a custom name of sb-menu
qbcoreInput = 'sb-input'       -- Only if use a custom name of sb-input
qbcoreRadial = 'sb-radialmenu' -- Only if use a custom name of sb-radialmenu

RegisterNetEvent('QBCore:Client:OnJobUptade')
AddEventHandler('QBCore:Client:OnJobUptade', function(playerData)
    DebugPrint('PlayerData Updated')
    DebugPrint('PlayerData', playerData)
    PlayerData = playerData
    ReloadPlayer()
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    exports['qs-dispatch']:ToggleDuty(duty)
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    ReloadPlayer()
    TriggerEvent('qs-dispatch:client:cameras:load')
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    ReloadPlayer()
end)

RegisterNetEvent('QBCore:Player:SetPlayerData')
AddEventHandler('QBCore:Player:SetPlayerData', function(val)
    Wait(1000)

    local OldPlayerData = PlayerData
    PlayerData = QBCore.Functions.GetPlayerData()

    if PlayerData?.job?.name ~= OldPlayerData?.job?.name then
        ReloadPlayer()
        DebugPrint('PlayerData Updated')
        DebugPrint('PlayerData', PlayerData)
    end
end)

function GetPlayerIdentifier()
    return QBCore.Functions.GetPlayerData().citizenid
end

function GetPlayers()
    return QBCore.Functions.GetPlayers()
end

function SendTextMessage(msg, type)
    if type == 'inform' then
        QBCore.Functions.Notify(msg, 'primary', 5000)
    end
    if type == 'error' then
        QBCore.Functions.Notify(msg, 'error', 5000)
    end
    if type == 'success' then
        QBCore.Functions.Notify(msg, 'success', 5000)
    end
end
