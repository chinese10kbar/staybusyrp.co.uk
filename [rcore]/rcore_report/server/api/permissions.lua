function storeAdminCache(cache, playerId, value)
    cache[tostring(playerId)] = value
end

function getAdminCache(cache, playerId)
    return cache[tostring(playerId)]
end

function resetAdminCache(cache, playerId)
    if cache[tostring(playerId)] then
        cache[tostring(playerId)] = nil
    end
end

function isAllowedGroup(xPlayer, src, group)
    if xPlayer then
        local pGroup = xPlayer.getGroup()
        if pGroup == group then
            return true
        end
        return false
    elseif QBCore then
        return QBCore.Functions.HasPermission(src, group)
    end
    return false
end

local function hasPermissions(source, cache, groups, acePermission)
    local isAllowed = false

    if getAdminCache(cache, source) ~= nil then
        return getAdminCache(cache, source)
    end

    if Config.UseAcePermissions and Ace.Can(source, acePermission) then
        storeAdminCache(cache, source, true)
        return true
    end

    if Config.UseAcePermissions then
        return false
    end

    if source == 0 then
        return
        --Console
    end

    local xPlayer = nil

    if hasEsExtended() then
        if not ESX then
            ESX = GetSharedObjectSafe()
        end
        xPlayer = ESX.GetPlayerFromId(source)
    end

    if not QBCore and hasQBCore() then
        QBCore = GetSharedObjectSafe()
    end

    for _, gr in pairs(groups) do
        if isAllowedGroup(xPlayer, source, gr) then
            isAllowed = true
            break
        end
    end

    if xPlayer ~= nil then
        storeAdminCache(cache, source, isAllowed)
    end

    return isAllowed
end

function hasSuperAdminPermissions (source)
    return hasPermissions(source, superAdminPermissionsCache, Config.SuperAdminGroups, Permissions.OPEN_STATISTICS)
end

function hasAdminPermissions (source)
    return hasPermissions(source, adminPermissionsCache, Config.AllowedGroups, Permissions.OPEN_CONTROL)
end