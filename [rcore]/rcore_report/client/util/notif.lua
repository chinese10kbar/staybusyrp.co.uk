function showHelpNotification(msg, thisFrame, beep, duration)
    AddTextEntry('rcore-reports', msg)

    if thisFrame then
        DisplayHelpTextThisFrame('rcore-reports', false)
    else
        if beep == nil then beep = true end
        BeginTextCommandDisplayHelp('rcore-reports')
        EndTextCommandDisplayHelp(0, false, beep, 2000)
    end
end
