RegisterNetEvent(triggerName('playSound'))
AddEventHandler(triggerName('playSound'), function()
    PlaySoundFrontend(-1, 'COLLECTED', 'HUD_AWARDS')
end)