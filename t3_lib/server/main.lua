if Config.Framework == 'QB' then
    QBCore = exports['qb-core']:GetCoreObject()
    local function getFramework()
        return { Framework = QBCore, Config = Config.Framework }
    end
    exports("getFramework", getFramework)
    RegisterNetEvent("t3_lib:createCallback", function(data)
        QBCore.Functions.CreateCallback(data.cb, data.func)
    end)
    RegisterNetEvent("t3_lib:registerUsableItem", function(data)
        if Config.Inventory == 'qs' then
            exports['qs-inventory']:CreateUsableItem(data.item, data.func)
        else
            QBCore.Functions.CreateUseableItem(data.item, data.func)
        end
    end)
    RegisterNetEvent("t3_lib:addMoney", function(data)
        local src = data.target
        local Player = QBCore.Functions.GetPlayer(src)
        if data.account then
            Player.Functions.AddMoney(data.account, data.money)
        else
            Player.Functions.AddMoney('cash', data.money)
        end
    end)
    local function removeMoney(data)
        local src = data.target
        local Player = QBCore.Functions.GetPlayer(src)
        if data.account then
            local acc = Player.Functions.GetMoney(data.account)
            if acc >= data.money then
                Player.Functions.RemoveMoney(data.account, data.money)
                return true
            else
                return false
            end
        else
            local acc = Player.Functions.GetMoney('cash')
            if acc >= data.money then
                Player.Functions.RemoveMoney('cash', data.money)
                return true
            else
                return false
            end
        end
    end
    exports("removeMoney", removeMoney)
    RegisterNetEvent("t3_lib:removeMoney", function(data)
        return removeMoney(data)
    end)
    local function getMoney(data)
        local src = data.target
        local Player = QBCore.Functions.GetPlayer(src)
        local acc = Player.Functions.GetMoney(data.account)
        return acc
    end
    exports("getMoney", getMoney)
    RegisterNetEvent("t3_lib:getMoney", function(data)
        return getMoney(data)
    end)
    RegisterNetEvent("t3_lib:addItem", function(data)
        local src = data.target
        if Config.Inventory == 'ox' then
            local ox_inventory = exports['ox_inventory']
            local canCarryItem = ox_inventory:CanCarryItem(src, data.item, data.qty)
            if (canCarryItem) then
                ox_inventory:AddItem(src, data.item, data.qty, data.metadata)
            end
        elseif Config.Inventory == 'qs' then
            local canCarryItem = exports['qs-inventory']:CanCarryItem(src, data.item, data.qty)
            if (canCarryItem) then
                exports['qs-inventory']:AddItem(src, data.item, data.qty, nil, data.metadata)
            end
        elseif Config.Inventory == 'qb' then
            if data.metadata and data.metadata.image then
                data.metadata.image = data.metadata.image..".png"
            end
            local Player = QBCore.Functions.GetPlayer(src)
            Player.Functions.AddItem(data.item, data.qty, data.slot, data.metadata)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[data.item], "add")
        else
            print("ERROR: No QB compatible inventory selected")
        end
    end)
    RegisterNetEvent("t3_lib:removeItem", function(data)
        local src = data.target
        if Config.Inventory == 'ox' then
            local ox_inventory = exports['ox_inventory']
            ox_inventory:RemoveItem(src, data.item, data.qty, data.metadata, data.slot)
        elseif Config.Inventory == 'qs' then
            exports['qs-inventory']:RemoveItem(src, data.item, data.qty, data.slot)
        elseif Config.Inventory == 'qb' then
            local Player = QBCore.Functions.GetPlayer(src)
            Player.Functions.RemoveItem(data.item, data.qty, data.slot)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[data.item], "remove")
        else
            print("ERROR: No QB compatible inventory selected")
        end
    end)
    local function getItemBySlot(data)
        local src = data.target
        if Config.Inventory == 'ox' then
            local ox_inventory = exports["ox_inventory"]
            return ox_inventory:GetSlot(src, data.slot)
        elseif Config.Inventory == 'qs' then
            return exports['qs-inventory']:GetItemBySlot(src, data.slot)
        elseif Config.Inventory == 'qb' then
            local Player = QBCore.Functions.GetPlayer(src)
            return Player.Functions.GetItemBySlot(data.slot)
        else
            print("ERROR: No QB compatible inventory selected")
        end
    end
    exports("getItemBySlot", getItemBySlot)
    RegisterNetEvent("t3_lib:getItemBySlot", function(data)
        return getItemBySlot(data)
    end)
    local function getItemsByName(data)
        local src = data.target
        if Config.Inventory == 'ox' then
            local ox_inventory = exports["ox_inventory"]
            return ox_inventory:Search(src, 'slots', data.item)
        elseif Config.Inventory == 'qs' then
            return exports['qs-inventory']:GetItemsByName(src, data.item)
        elseif Config.Inventory == 'qb' then
            local Player = QBCore.Functions.GetPlayer(src)
            return Player.Functions.GetItemsByName(data.item)
        else
            print("ERROR: No QB compatible inventory selected")
        end
    end
    exports("getItemsByName", getItemsByName)
    RegisterNetEvent("t3_lib:getItemsByName", function(data)
        return getItemsByName(data)
    end)
    RegisterNetEvent("t3_lib:setMetadata", function(data)
        local src = data.target
        if Config.Inventory == 'ox' then
            local ox_inventory = exports["ox_inventory"]
            ox_inventory:SetMetadata(src, data.slot, data.metadata)
        elseif Config.Inventory == 'qs' then
            exports['qs-inventory']:SetItemMetadata(src, data.slot, data.metadata)
        elseif Config.Inventory == 'qb' then
            local Player = QBCore.Functions.GetPlayer(src)
            Player.PlayerData.items[data.slot].info = data.metadata
            Player.Functions.SetInventory(Player.PlayerData.items)
        else
            print("ERROR: No QB compatible inventory selected")
        end
    end)
    local function getIdentifier(data)
        local license = QBCore.Functions.GetIdentifier(data.target, 'license')
        return license
    end
    exports("getIdentifier", getIdentifier)
    RegisterNetEvent("t3_lib:getIdentifier", function(data)
        return getIdentifier(data)
    end)
end
