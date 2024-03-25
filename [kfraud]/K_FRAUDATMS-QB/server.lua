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
                -- Alert police
                qsDispatch:GetPlayerInfo(Player.PlayerData.source, function(playerData)
                    if not playerData then
                        print("Error getting player data")
                        return
                    end
                    qsDispatch:GetSSURL(Player.PlayerData.source, function(screenshot)
                        TriggerEvent('qs-dispatch:server:CreateDispatchCall', {
                            job = { 'police'},
                            callLocation = playerData.coords,
                            callCode = { code = 'Fraudulent ATM Usage', snippet = 'Alert' },
                            message = "Player attempting to use cloned card at ATM.",
                            flashes = false,
                            image = screenshot or nil,
                            blip = {
                                sprite = 161,
                                scale = 1.0,
                                colour = 1,
                                flashes = true,
                                text = 'Fraudulent ATM Usage',
                                time = 30000, -- 30 secs
                            }
                        })
                    end)
                end)
            else
                -- Proceed with regular transaction
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
