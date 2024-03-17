ESX, QBCore = nil, nil
if Config.Framework == 'ESX' then
    ESX = exports["es_extended"]:getSharedObject()
    for k,v in pairs(Config.Cards) do
        ESX.RegisterUsableItem(v, function(source)
            local data = {}
            data.img = v
            TriggerClientEvent("t3_businesscards:showCard",source,data)
        end)
    end
elseif Config.Framework == 'QB' then
    QBCore = exports['qb-core']:GetCoreObject()
    for k,v in pairs(Config.Cards) do
        QBCore.Functions.CreateUseableItem(v, function(source, item)
            local data = {}
            data.img = v
            TriggerClientEvent("t3_businesscards:showCard",source,data)
        end)
    end
end
