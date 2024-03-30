local QBCore = exports['sb-core']:GetCoreObject()


QBCore.Functions.CreateCallback('sb-scooterrentals:server:RentCheck',function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveMoney('cash', Config.ScooterPrice, "pay-rental") then
        cb(true)
    elseif Player.Functions.RemoveMoney('bank', Config.ScooterPrice, "pay-rental") then
        cb(true)
    else
        cb(false)
    end
end)