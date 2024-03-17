function saveAllReportsBeforeServerRestart()
    if not Config.DisableReportsSaving then
        for index, report in pairs(reports) do
            report.save()
            Wait(10)
        end
    end
end

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    if eventData.secondsRemaining == 60 then
        CreateThread(function()
            Wait(30000)
            saveAllReportsBeforeServerRestart()
        end)
    end
end)

AddEventHandler('txAdmin:events:serverShuttingDown', function()
    CreateThread(function()
        saveAllReportsBeforeServerRestart()
    end)
end)