Slots = {}

-- Add the user's rockstar license or license2: and how many slots they want to have in total
-- If you are using Qbox, change license:xxxxx to license2:xxxxx

-- @ If Slots.DiscordPerm.status is false | for manuel license works
-- This does not include Config.DefaultSlots, it sets the direct slot limit of the character

Slots.List = {
    -- {license = "license:xxx", totalSlot = 9},
    -- {license = "license:xxxx2", totalSlot = 7},
    -- {license = "license:xxxx3", totalSlot = 3},
    -- {license = "license:xxxx4", totalSlot = 4},
    -- {license = "license:xxxx5", totalSlot = 1},
}


-- This structure configures extra slot allocations based on Discord roles.
-- The `Slots.DiscordPerm` structure allows you to assign additional slots to users
-- based on specific Discord roles that they possess

Slots.DiscordPerm = {
    status = true, -- Set to true to enable this feature, or false to disable it.
    role = {
        {id = "1219005013469171824", addExtraSlot = 20}, -- Example: Users with this role will have 20 + Config.DefaultSlots = 25 in total.
        {id = "1219005045685878784", addExtraSlot = 2}, -- Replace 'roleid' with your Discord role ID and specify the total extra slots.
    }
}
