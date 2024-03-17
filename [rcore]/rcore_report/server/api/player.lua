function getPlayerName(playerId)
    return GetPlayerName(playerId)
end

RegisterNetEvent(triggerName('teleportAdminToPlayer'))
AddEventHandler(triggerName('teleportAdminToPlayer'), function(targetId)
    local playerId = source

    if hasAdminPermissions(playerId) then
        local playerPed = GetPlayerPed(playerId)
        local targetPed = GetPlayerPed(targetId)
        local targetCoords = GetEntityCoords(targetPed)
        SetEntityCoords(playerPed, targetCoords)

        sendNotification(playerId, _U('teleport_admin_to_player', getPlayerName(targetId)), NotificationType.TELEPORT_ADMIN_TO_PLAYER)
    end
end)

RegisterNetEvent(triggerName('bringPlayerToAdmin'))
AddEventHandler(triggerName('bringPlayerToAdmin'), function(targetId)
    local playerId = source

    if hasAdminPermissions(playerId) then
        local playerPed = GetPlayerPed(playerId)
        local targetPed = GetPlayerPed(targetId)
        local playerCoords = GetEntityCoords(playerPed)
        SetEntityCoords(targetPed, playerCoords)

        sendNotification(playerId, _U('teleport_player_to_admin', getPlayerName(targetId)), NotificationType.TELEPORT_PLAYER_TO_ADMIN)
    end
end)

RegisterNetEvent(triggerName('freezePlayer'))
AddEventHandler(triggerName('freezePlayer'), function(targetId)
    local playerId = source

    if hasAdminPermissions(playerId) then
        local playerInfo = getPlayerInfoById(targetId)
        playerInfo.setIsFrozen(not playerInfo.isFrozen)

        if playerInfo.isFrozen then
            sendNotification(playerId, _U('freeze_player', playerInfo.name), NotificationType.FREEZE_PLAYER)
        else
            sendNotification(playerId, _U('unfreeze_player', playerInfo.name), NotificationType.UNFREEZE_PLAYER)
        end
    end
end)

RegisterNetEvent(triggerName('invulnerablePlayer'))
AddEventHandler(triggerName('invulnerablePlayer'), function(targetId)
    local playerId = source
    
    if hasAdminPermissions(playerId) then
        local playerInfo = getPlayerInfoById(targetId)
        playerInfo.setIsInvulnerable(not playerInfo.isInvulnerable)

        if playerInfo.isInvulnerable then
            sendNotification(playerId, _U('invulnerable_player', playerInfo.name), NotificationType.INVULNERABLE_PLAYER)
        else
            sendNotification(playerId, _U('vulnerable_player', playerInfo.name), NotificationType.VULNERABLE_PLAYER)
        end
    end
end)

RegisterNetEvent(triggerName('healPlayer'))
AddEventHandler(triggerName('healPlayer'), function(targetId)
    local playerId = source
    
    if hasAdminPermissions(playerId) then
        TriggerClientEvent(triggerName('healPlayer'), targetId)
        sendNotification(playerId, _U('heal_player'), NotificationType.HEAL_PLAYER)
    end
end)


RegisterNetEvent(triggerName('revivePlayer'))
AddEventHandler(triggerName('revivePlayer'), function(targetId)
    local playerId = source
    
    if hasAdminPermissions(playerId) then
        TriggerClientEvent(triggerName('revivePlayer'), targetId)
        sendNotification(playerId, _U('revive_player'), NotificationType.REVIVE_PLAYER)
    end
end)

RegisterNetEvent(triggerName('saveAdminPosition'))
AddEventHandler(triggerName('saveAdminPosition'), function()
    local playerId = source
    
    if hasAdminPermissions(playerId) then
        local adminPed = GetPlayerPed(playerId)
        adminStoredPositions[playerId] = GetEntityCoords(adminPed)
    end
end)


RegisterNetEvent(triggerName('retrieveAdminPosition'))
AddEventHandler(triggerName('retrieveAdminPosition'), function()
    local playerId = source
    
    if adminStoredPositions[playerId] and hasAdminPermissions(playerId) then
        local adminPed = GetPlayerPed(playerId)
        SetEntityCoords(adminPed, adminStoredPositions[playerId])
        adminStoredPositions[playerId] = nil
    end
end)


if not Config.UseAcePermissions then
    AddEventHandler('esx:playerLoaded', function(playerId, xPlayer, isNew) 
        onPlayerSpawn(playerId)
    end)

    AddEventHandler('QBCore:Server:PlayerLoaded', function(player)
        onPlayerSpawn(player.PlayerData.source)
    end)
end