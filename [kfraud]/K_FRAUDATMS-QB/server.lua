local QBCore = GetQBVersion()
local qsDispatch = exports['qs-dispatch']

RegisterNetEvent('k_fraudatms:enterATM')
AddEventHandler('k_fraudatms:enterATM', function()
    local Player = QBCore.Functions.GetPlayer(source)
    local clonedItem = Player.Functions.GetItemByName(KonfigSH.ClonedItem)
    local randomChance = math.random(1,3) -- 1 in 3 chance to alert police
    if clonedItem ~= nil then
        if clonedItem.amount >= 1 then
            if randomChance == 3 then
                Player.Functions.RemoveItem(KonfigSH.ClonedItem, 1)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[KonfigSH.ClonedItem], "remove")
                TriggerClientEvent('QBCore:Notify', source, 'ATM: Card swallowed and authorities alerted for bank fraud', "success")
                qsDispatch:GetPlayerInfo(Player.PlayerData.citizenid, function(playerData)
                    if (not playerData) then
                        ErrorPrint("Error getting player data")
                        return
                    end
                    TriggerEvent('qs-dispatch:server:CreateDispatchCall', {
                        job = { 'police', 'sheriff', 'traffic', 'patrol' },
                        callLocation = playerData.coords,
                        callCode = { code = 'Bank Fraud', snippet = 'ATM' },
                        message = "Street 1: ".. playerData.street_1.. " Street 2: ".. playerData.street_2.. " Sex: ".. playerData.sex.. " Vehicle Label: ".. playerData.vehicle_label.. " Vehicle Colour: ".. playerData.vehicle_colour.. " Vehicle Plate: ".. playerData.vehicle_plate.. " Speed: ".. playerData.speed,
                        flashes = false,
                        image = nil,
                        blip = {
                            sprite = 488,
                            scale = 1.5,
                            colour = 1,
                            flashes = true,
                            text = 'Bank Fraud',
                            time = 20 * 1000,     -- 20 secs
                        }
                    })
                end)       
            else
                Player.Functions.RemoveItem(KonfigSH.ClonedItem, 1)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[KonfigSH.ClonedItem], "remove")
                if KonfigSV.SetAmount then
                    Player.Functions.AddMoney("cash", KonfigSV.SetAmount)
                    TriggerClientEvent('QBCore:Notify', source, 'ATM: You received: £'..KonfigSV.SetAmount, "success")
                else
                    local max = KonfigSV.CardMaxAmount
                    local min =  KonfigSV.CardMinAmount
                    local rando = math.random(min, max)
                    Player.Functions.AddMoney("cash", rando)
                    TriggerClientEvent('QBCore:Notify', source, 'ATM: You received: £'..rando, "success")
                end
            end
        else
            TriggerClientEvent('QBCore:Notify', source, 'Not sure what you\'re trying to achieve?', "error")
             -- Probably add some ban mechanism here since it's not possible to use this event without a card unless they are trying to dupe by dropping the card or something :P
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'Not sure what you\'re trying to achieve?', "error")
        -- Probably add some ban mechanism here since it's not possible to use this event without a card unless they are trying to dupe by dropping the card or something :P
    end
end)
