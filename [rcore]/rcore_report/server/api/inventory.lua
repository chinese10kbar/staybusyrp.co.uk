-- Config.OwnInventorySolution in `config.lua` must be set to `true`
function getInventoryContent(playerId, identifier)
    -- if you want to use ESX/QBCore you could use predefined function GetSharedObjectSafe
    -- local ESX = GetSharedObjectSafe()
    -- local QBCore = GetSharedObjectSafe()

    local ITEM_COUNT = 5

    return {
        {label = 'ITEM_LABEL', name = 'ITEM_NAME', value = ITEM_COUNT}
    }
end