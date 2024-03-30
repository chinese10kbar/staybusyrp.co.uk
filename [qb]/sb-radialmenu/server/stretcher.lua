RegisterNetEvent('sb-radialmenu:server:RemoveStretcher', function(pos, stretcherObject)
    TriggerClientEvent('sb-radialmenu:client:RemoveStretcherFromArea', -1, pos, stretcherObject)
end)

RegisterNetEvent('sb-radialmenu:Stretcher:BusyCheck', function(target, type)
    local src = source
    if not IsCloseToTarget(src, target) then return end
    TriggerClientEvent('sb-radialmenu:Stretcher:client:BusyCheck', target, source, type)
end)

RegisterNetEvent('sb-radialmenu:server:BusyResult', function(isBusy, target, type)
    local src = source
    if not IsCloseToTarget(src, target) then return end
    TriggerClientEvent('sb-radialmenu:client:Result', target, isBusy, type)
end)