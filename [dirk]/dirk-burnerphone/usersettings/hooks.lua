local playerData = nil

RegisterNetEvent("qs-dispatch:playerInfo", function(data)
    playerData = data
end)

RegisterNetEvent("DirkBurner:OnDeal", function(outcome, data)
    if outcome == "Steal" then 
        -- Handle Steal outcome
    elseif outcome == "Failed" then 
        -- Handle Failed outcome
    elseif outcome == "Snitch" then 
        if not playerData then
            print("Error: Player data not available")
            return
        end
        -- Notify Police about drug dealing
        TriggerServerEvent('qs-dispatch:server:NotifyPolice', {
            street_1 = playerData.street_1,
            street_2 = playerData.street_2,
            sex = playerData.sex,
            pos = data.pos,
            crime = "Drug Dealing"
        })
    elseif outcome == "Success" then
        -- Handle Success outcome
    end
end)

RegisterNetEvent("DirkBurner:OnExchange", function(outcome, data)
    if outcome == "Failed" then 
        -- Handle Failed outcome
    elseif outcome == "Snitch" then 
        if not playerData then
            print("Error: Player data not available")
            return
        end
        -- Notify Police about drug dealing
        exports['qs-dispatch']:getSSURL(function(image)
            TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', {
                job = { 'police'},
                callLocation = playerData.coords,
                callCode = { code = 'Drug Dealing', snippet = 'Drug' },
                message = "street_1: " .. playerData.street_1 .. " street_2: " .. playerData.street_2 .. " sex: " .. playerData.sex,
                flashes = false,
                image = image or nil,
                blip = {
                    sprite = 51,
                    scale = 1.5,
                    colour = 1,
                    flashes = true,
                    text = 'Drug Dealing',
                    time = 20 * 1000, -- 20 seconds
                }
            })
        end)
    elseif outcome == "Fight" then 
        -- Handle Fight outcome
    elseif outcome == "Success" then
        -- Handle Success outcome
    end
end)


--[[
  data = {
    ply:ply,         -- ID of the player who sent/receiving message
    simNumber:       -- simNumber of the phone sending/receiving this message
    contactId:string,-- ID of this contact within the phone it's being sent to/from
    sender:string,   -- Player or Contact Name
    receiver:string, -- Player or Contact Name
    position: vec4,
    street: string,
    zone: string,
    message: string,

  }
]]

RegisterNetEvent("DirkBurner:MessageSent",function(simNumber, data)
  --## If you wanted to do someting when a message is sent/receieved by a phone
end)
