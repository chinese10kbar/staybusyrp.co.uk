if not Framework.QBCore() then return end

local client = client

-- Backwards Compatible Events

RegisterNetEvent("sb-clothing:client:openMenu", function()
    local config = GetDefaultConfig()
    config.ped = true
    config.headBlend = true
    config.faceFeatures = true
    config.headOverlays = true
    config.components = true
    config.props = true
    config.tattoos = true
    OpenShop(config, true, "all")
end)

RegisterNetEvent("sb-clothing:client:openOutfitMenu", function()
    OpenMenu(nil, "outfit")
end)

RegisterNetEvent("sb-clothing:client:loadOutfit", LoadJobOutfit)

RegisterNetEvent("sb-multicharacter:client:chooseChar", function()
    client.setPedTattoos(cache.ped, {})
    ClearPedDecorations(cache.ped)

    TriggerServerEvent("illenium-appearance:server:resetOutfitCache")
end)
