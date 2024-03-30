local QBCore = exports['sb-core']:GetCoreObject()
local trunkBusy = {}

function IsCloseToTarget(source, target)
    if not DoesPlayerExist(target) then return false end
    return #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 2.0
end

RegisterNetEvent('sb-radialmenu:trunk:server:Door', function(open, plate, door)
    TriggerClientEvent('sb-radialmenu:trunk:client:Door', -1, plate, door, open)
end)

RegisterNetEvent('sb-trunk:server:setTrunkBusy', function(plate, busy)
    trunkBusy[plate] = busy
end)

RegisterNetEvent('sb-trunk:server:KidnapTrunk', function(target, closestVehicle)
    local src = source
    if not IsCloseToTarget(src, target) then return end
    TriggerClientEvent('sb-trunk:client:KidnapGetIn', target, closestVehicle)
end)

QBCore.Functions.CreateCallback('sb-trunk:server:getTrunkBusy', function(_, cb, plate)
    if trunkBusy[plate] then cb(true) return end
    cb(false)
end)

QBCore.Commands.Add("getintrunk", Lang:t("general.getintrunk_command_desc"), {}, false, function(source)
    TriggerClientEvent('sb-trunk:client:GetIn', source)
end)

QBCore.Commands.Add("putintrunk", Lang:t("general.putintrunk_command_desc"), {}, false, function(source)
    TriggerClientEvent('sb-trunk:server:KidnapTrunk', source)
end)