------------------------------------------------------------------------------------------------------
-------------------------------------------- WEBHOOK URLS --------------------------------------------
------------------------------------------------------------------------------------------------------


--These are disabled by default, until you enter your discord webhooks.
local ExploitLogWebhook = 'https://discord.com/api/webhooks/1220572511020781618/b29GrLQMDo4OF5SyKnl4PMQrx2e0SBlwm6Xb9HKWqR-enjELTVZ56ld4GGf6tkC6ZKnM' --If a player is found using cheat engine to change the hash of a vehicle, this will send a message on discord and kick them from the game.
local ImpoundLogWebhook = 'https://discord.com/api/webhooks/1220572546206797824/bizGx6l9lzZw7sQhCNjCpzuzQaHGhx6-5-koyoLYJXUo0O6Xpz8h-ju0JO457mQMTLcc' --When a player impounds/unimpounds a vehicle.
local TransferVehicleLogWebhook = 'https://discord.com/api/webhooks/1220572576183619596/WUE_7F0Hc_s1UM6Y1Z9YO6gLckg-vIkOYm4eoJJY9b3GLOA23QVSTBl3x46yRC9kKlG7' --When a player transfers a vehicle to another player.
local VehicleManagementLogWebhook = 'https://discord.com/api/webhooks/1220572611600449626/uUPVB5duJ37TgTD4ngWwvjxcxipHpQvBbWG_FgNs4s3jgTtX1-MEOvPoLcPbb_p5bumG' --When a staff member uses the vehicle managment commands.
local GarageSpaceLogWebhook = 'https://discord.com/api/webhooks/1220572643733012561/VOdkcrVsyNjvBb-kyCt9Xv4Ev93LXmqgCtbLsvg4VuXh84erAMaAyrZZbHfomItd4Ln9' --When a player sells a garage slot.


------------------------------------------------------------------------------------------------------
---------------------------------------------- WEBHOOKS ----------------------------------------------
------------------------------------------------------------------------------------------------------


function ExploitAlertLogs(source, plate, newmodel, oldmodel, identifier)
    if ExploitLogWebhook ~= nil and #ExploitLogWebhook > 10 then
        local message = string.format(L('logs_exploit_message'), GetPlayerName(source), plate, newmodel, oldmodel, identifier)
        PerformHttpRequest(ExploitLogWebhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
    end
end

function ImpoundVehicleLogs(source, action, vehiclelabel, vehicleplate, impoundlocation)
    if ImpoundLogWebhook ~= nil and #ImpoundLogWebhook > 10 then
        local message, color
        if action == 'impound' then
            message = string.format(L('logs_impound_message'), vehicleplate, vehiclelabel, impoundlocation, GetPlayerName(source), source, GetIdentifier(source))
            color = 16711680
        elseif action == 'unimpound' then
            message = string.format(L('logs_unimpound_message'), vehicleplate, vehiclelabel, GetPlayerName(source), source, GetIdentifier(source))
            color = 56108
        end
        local data = {{
            ['color'] = color,
            ['title'] = action:sub(1,1):upper()..action:sub(2),
            ['description'] = message,
            ['footer'] = {
                ['text'] = os.date('%c'),
                ['icon_url'] = 'https://i.imgur.com/VMPGPTQ.png',
            },
        }}
        PerformHttpRequest(ImpoundLogWebhook, function(err, text, headers) end, 'POST', json.encode({username = L('garage_title'), embeds = data}), { ['Content-Type'] = 'application/json' })
    end
end

function TransferVehicleLogs(source, target, plate, label)
    if TransferVehicleLogWebhook ~= nil and #TransferVehicleLogWebhook > 10 then
        local message = string.format(L('logs_transfer_message'), plate, label, GetPlayerName(source), source, GetIdentifier(source), GetPlayerName(target), target, GetIdentifier(target))
        local data = {{
            ['color'] = '2061822',
            ['title'] = L('logs_transfer_title'),
            ['description'] = message,
            ['footer'] = {
                ['text'] = os.date('%c'),
                ['icon_url'] = 'https://i.imgur.com/VMPGPTQ.png',
            },
        }}
        PerformHttpRequest(TransferVehicleLogWebhook, function(err, text, headers) end, 'POST', json.encode({username = L('garage_title'), embeds = data}), { ['Content-Type'] = 'application/json' })
    end
end

function VehicleManagmentLogs(source, action, plate, target, garage_type)
    if VehicleManagementLogWebhook ~= 'CHANGE_ME' and VehicleManagementLogWebhook ~= nil then
        local message, color
        if action == 'add' then
            message = string.format(L('logs_vehiclemanagment_add'), plate, garage_type, GetPlayerName(source), source, GetIdentifier(source), GetPlayerName(target), target, GetIdentifier(target))
            color = '56108'
        elseif action == 'delete' then
            message = string.format(L('logs_vehiclemanagment_delete'), plate, GetPlayerName(source), source, GetIdentifier(source))
            color = '16711680'
        elseif action == 'plate' then
            message = string.format(L('logs_vehiclemanagment_plate'), plate, target, GetPlayerName(source), source, GetIdentifier(source))
            color = '2061822'
        end
        local data = {{
            ['color'] = color,
            ['title'] = string.format(L('logs_vehiclemanagment_title'), string.upper(action)),
            ['description'] = message,
            ['footer'] = {
                ['text'] = os.date('%c'),
                ['icon_url'] = 'https://i.imgur.com/VMPGPTQ.png',
            },
        }}
        PerformHttpRequest(VehicleManagementLogWebhook, function(err, text, headers) end, 'POST', json.encode({username = L('garage_title'), embeds = data}), { ['Content-Type'] = 'application/json' })
    end
end

function GarageSpaceLogs(source, new_limit, price, target)
    if GarageSpaceLogWebhook ~= nil and #GarageSpaceLogWebhook > 10 then
        local message = string.format(L('logs_garagespace_message'), new_limit, price, GetPlayerName(source), source, GetIdentifier(source), GetPlayerName(target), target, GetIdentifier(target))
        local data = {{
            ['color'] = '2061822',
            ['title'] = L('logs_garagespace_title'),
            ['description'] = message,
            ['footer'] = {
                ['text'] = os.date('%c'),
                ['icon_url'] = 'https://i.imgur.com/VMPGPTQ.png',
            },
        }}
        PerformHttpRequest(GarageSpaceLogWebhook, function(err, text, headers) end, 'POST', json.encode({username = L('garage_title'), embeds = data}), { ['Content-Type'] = 'application/json' })
    end
end