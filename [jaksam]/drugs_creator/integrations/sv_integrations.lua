-- You can edit the events on the right side if you for any reason don't use the default event name

EXTERNAL_EVENTS_NAMES = {
    ["esx:getSharedObject"] = nil, -- This is nil because it will be found automatically, change it to your one ONLY in the case it can't be found
}

-- If you use different names for police job, you can add/change it here, all jobs here will be used for police features (example: the alerts)
POLICE_JOBS_NAMES = {
    ["police"] = true,
    ["fbi"] = true
}

-- Skips or not if an item exists (useful with inventories that doesn't save items in database or in ESX.Items table, example ox_inventory)
SKIP_ITEM_EXISTS_CHECK = false

-- Force inventory refresh or not. Set to true if NPC selling is not working properly
FORCE_INVENTORY_REFRESH = true

--[[
    You can edit this function if you want to add second jobs or anything like that (editing this function is down to you)
    If you edit this, you WILL have also to edit the function in cl_integrations.lua file
]]
function IsPlayerJobAllowed(playerId, allowedJobs)
    if (not allowedJobs) then return true end

    local playerJob = Framework.getPlayerJobName(playerId)

    if (allowedJobs[playerJob] == true) then
        return true
    elseif (allowedJobs[playerJob]) then
        local playerJobGrade = tostring(Framework.getPlayerJobGrade(playerId))

        return allowedJobs[playerJob] and allowedJobs[playerJob][playerJobGrade]
    else
        return false
    end
end

RegisterNetEvent("drugs_creator:alertedPolice", function(coords, message)
    print("alertedPolice")
    print(message)
    TriggerEvent('qs-dispatch:server:CreateDispatchCall', {
        job = { 'police'},
        callLocation = coords,
        callCode = { code = 'Drugs Call', snippet = '10-50' },
        message = message or 'Drugs Call',
        flashes = false, -- you can set to true if you need call flashing sirens...
        image = nil,     -- Url for image to attach to the call
        --you can use the getSSURL export to get this url
        blip = {
            sprite = 488,        --blip sprite
            scale = 1.5,         -- blip scale
            colour = 1,          -- blio colour
            flashes = true,      -- blip flashes
            text = 'Drugs Call', -- blip text
            time = (20 * 1000),  --blip fadeout time (1 * 60000) = 1 minute
        }
    })
end)