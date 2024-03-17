-- if you want to ignore some notifications you could set it here with 'type'
-- all notifications type are located in shared/const/notifications.lua
local IGNORED_NOTIFICATIONS = {
    -- NotificationType.REPORT_CREATED
}

function basicNotification(source, msg)
    if hasEsExtended() then
        TriggerClientEvent('esx:showNotification', source, msg)
    elseif hasQBCore() then
        TriggerClientEvent('QBCore:Notify', source, msg, 'success', 5000)
    end
end

function sendNotification(playerId, message, type, report)
    if isInTable(IGNORED_NOTIFICATIONS, type) then
        return
    end

    if Config.PlaySoundWhenNewNotificationArrives then
        TriggerClientEvent(triggerName('playSound'), playerId)
    end

    if Config.UseBasicNotifications then
        basicNotification(playerId, message)
    else
        TriggerEvent(triggerName('sendNotification'), playerId, message, type)
    end
end