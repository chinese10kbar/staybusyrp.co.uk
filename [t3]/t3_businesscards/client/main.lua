RegisterNetEvent('t3_businesscards:showCard', function(data)
    CreateThread(function()
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = "show",
            data = data,
        })
    end)
end)
RegisterNUICallback("closeNUI", function()
    SetNuiFocus(false, false)
end)