if Config.SkinScript ~= 'illenium-appearance' then
    return
end

function putClothes(backpack)
    if getSex() == 0 then
        TriggerEvent('sb-clothing:client:loadOutfit', { outfitData = backpack.cloth['male'] })
    else
        TriggerEvent('sb-clothing:client:loadOutfit', { outfitData = backpack.cloth['female'] })
    end
end

function RemoveClothes()
    TriggerEvent('sb-clothing:client:loadOutfit', {
        outfitData = {
            ['bag'] = { item = -1, texture = 0 }
        }
    })
end
