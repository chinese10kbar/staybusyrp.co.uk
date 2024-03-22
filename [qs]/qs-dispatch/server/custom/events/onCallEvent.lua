local PoliceWebhookURL = 'https://discord.com/api/webhooks/1220740194467053669/i6g9_u541GaO3DSUJKsLkdeQkeYFX3JCBl8Ryn26pK6nyBstQQEDCmS_dZwAzcyqt3Xo' -- webhook URL HERE!!!!!!!!!!
local AmbulanceWebhookURL = 'https://discord.com/api/webhooks/1220740257348190278/CJa7tyDRbHH5xBvhpO-3QnY_RcdcgZ-DWde-cDEll7P6MvpPIwBZAyyQCPA1BZAgytLK' -- webhook URL HERE!!!!!!!!

function OnCallEvent(job, callLocation, callCode, message, flashes, image, ThisCount)

    if Contains(job, "police") then

        if PoliceWebhookURL == '' then return WarningPrint('You dont have a configured webhook (police), please go to "server/custom/envents/onCallEvent.lua" an set it.') end
        exports['qs-dispatch']:SendWebhook(PoliceWebhookURL, 'Police Call', '#3246a8', message, image)

    elseif Contains(job, "ambulance") then

        if AmbulanceWebhookURL == '' then return WarningPrint('You dont have a configured webhook (ambulance), please go to "server/custom/envents/onCallEvent.lua" an set it.') end
        exports['qs-dispatch']:SendWebhook(AmbulanceWebhookURL, 'Ambulance Call', '#ff0040', message, image)

    end
end


function JailEvent(job, message, image)

    -- you can implement your things here

end