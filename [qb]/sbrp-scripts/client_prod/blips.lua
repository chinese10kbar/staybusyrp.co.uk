
local blips = {
    -- Airports --
	
    { title = "Police Garage", colour = 3, id = 473, x = 431.77, y = -1017.66, z = 28.89 },
    { title = "Police Boat Garage", colour = 36, id = 427, x = -1598.49, y = -1201.4, z = 0.82 },
    { title = "Police Boat Garage", colour = 36, id = 427, x = -765.74, y = -1421.90, z = 1.60 },
    { title = "Police Boat Garage", colour = 36, id = 427, x = -781.03, y = -1494.64, z = 1.59 },


    -- Police Helipad
    { title = "Police Helipad", colour = 38, id = 64, x = -744.98, y = -1467.92, z = 5.00 },
    { title = "Police Helipad", colour = 38, id = 64, x = -724.63, y = -1444.16, z = 5.00 },

    -- Border Patrol
    { title = "Border Patrol", colour = 26, id = 455, x = -697.08, y = -1387.27, z = 8.55 },


}

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 0.6)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
    end
end)

