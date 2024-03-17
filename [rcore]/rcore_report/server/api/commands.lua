RegisterCommand(Config.SaveAllReportsCommand, function(source)
    if not Config.DisableReportsSaving and hasAdminPermissions(source) then
        saveAllReports()
        sendNotification(source, _U('saved_all_reports'), NotificationType.SAVED_ALL_REPORTS)
    end
end)

RegisterCommand(Config.SaveAdminChatCommand, function(source)
    if hasAdminPermissions(source) then
        saveAdminChatMessages()
        sendNotification(source, _U('saved_admin_chat'), NotificationType.SAVED_ALL_REPORTS)
    end
end)

RegisterCommand(Config.ResetAdminCacheCommand, function(source, args)
    if hasSuperAdminPermissions(source) then
        local playerId = args[1]
        
        if playerId ~= nil then
            resetAdminCache(adminPermissionsCache, playerId)
            resetAdminCache(superAdminPermissionsCache, playerId)
        end
    end
end)