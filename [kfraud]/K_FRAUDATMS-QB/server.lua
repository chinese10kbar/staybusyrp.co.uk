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
                        exports['qs-dispatch']:GetSSURL(PlayerID, function(screanshot)
                            TriggerEvent('qs-dispatch:server:CreateDispatchCall', {
                                job = { 'police'},
                                callLocation = playerData.coords,
                                callCode = { code = 'Hight Speed', snippet = 'Vehicle' },
                                message = " street_1: ".. playerData.street_1.. " street_2: ".. playerData.street_2.. " sex: ".. playerData.sex.. " vehicle_label: ".. playerData.vehicle_label.. " vehicle_colour: ".. playerData.vehicle_colour.. " vehicle_plate: ".. playerData.vehicle_plate.. " speed: ".. playerData.speed.. "",
                                flashes = false,
                                image = screanshot or nil,
                                blip = {
                                    sprite = 488,
                                    scale = 1.5,
                                    colour = 1,
                                    flashes = true,
                                    text = 'Hight Speed',
                                    time = (20 * 1000), -- 20 secs
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
