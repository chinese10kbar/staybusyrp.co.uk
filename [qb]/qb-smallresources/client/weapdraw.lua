local weapons = {
    'WEAPON_KNIFE',
    'weapon_katana',
    'WEAPON_FLASHLIGHT',
    'WEAPON_HAMMER',
    'weapon_shiv',
    'weapon_sledgehammer',
    'weapon_karambit',
    'weapon_keyboard',
    'weapon_bfknife',
    'weapon_urbanrbfknife',
    'weapon_stainedrbfknife',
    'weapon_slaughterbfknife',
    'weapon_scorchedbfknife',
    'weapon_safaribfknife',
    'weapon_perforator',
    'weapon_huntsmanknife',
    'weapon_gutknife',
    'weapon_goldenknife',
    'weapon_forestbfknife',
    'weapon_flipknife',
    'weapon_fadebfknife',
    'weapon_crimsonbfknife',
    'weapon_chbfknife',
    'weapon_bluebfknife',
    'weapon_bayonetknife',
    'weapon_awerp',
    'weapon_glock18c',
    'weapon_glock22',
    'weapon_deagle',
    'weapon_fnx45',
    'weapon_m1911',
    'weapon_glock20',
    'weapon_glock19gen4',
    'weapon_g17',
    'weapon_pmxfm',
    'weapon_mac10',
    'weapon_miniuzi',
    'weapon_mp5temp',
    'weapon_glock17',
    'weapon_beanbagshotgun',
    'weapon_sig516',
    'weapon_g36',
    'weapon_mpx',
    'weapon_sr25',
    'weapon_m870',
    'weapon_mk47fm',
    'weapon_m6ic',
    'weapon_scarsc',
    'weapon_m4',
    'weapon_ak47',
    'weapon_ak74',
    'weapon_aks74',
    'weapon_groza',
    'weapon_scarh',
    'weapon_akm',
    'weapon_stungun',
    'weapon_ak47handmade',
    'weapon_nambu',
    'weapon_nailgun',
    'weapon_sig716'
}

local holstered = true
local canFire = true
local currWeap = `WEAPON_UNARMED`
local currHolster = nil
local currHolsterTexture = nil
local wearingHolster = nil

local function loadAnimDict(dict)
    if HasAnimDictLoaded(dict) then return end
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end

local function checkWeapon(newWeap)
    for i = 1, #weapons do
        if joaat(weapons[i]) == newWeap then
            return true
        end
    end
    return false
end

local function isWeaponHolsterable(weap)
    for i = 1, #Config.WeapDraw.weapons do
        if joaat(Config.WeapDraw.weapons[i]) == weap then
            return true
        end
    end
    return false
end

RegisterNetEvent('weapons:ResetHolster', function()
    holstered = true
    canFire = true
    currWeap = `WEAPON_UNARMED`
    currHolster = nil
    currHolsterTexture = nil
    wearingHolster = nil
end)

RegisterNetEvent('weapons:client:DrawWeapon', function()
    if GetResourceState('qs-inventory') == 'missing' then return end -- This part is only made to work with qb-inventory, other inventories might conflict
    local sleep
    local weaponCheck = 0
    while true do
        local ped = PlayerPedId()
        sleep = 250
        if DoesEntityExist(ped) and not IsEntityDead(ped) and not IsPedInParachuteFreeFall(ped) and not IsPedFalling(ped) and (GetPedParachuteState(ped) == -1 or GetPedParachuteState(ped) == 0) then
            sleep = 0
            if currWeap ~= GetSelectedPedWeapon(ped) then
                local pos = GetEntityCoords(ped, true)
                local rot = GetEntityHeading(ped)

                local newWeap = GetSelectedPedWeapon(ped)
                SetCurrentPedWeapon(ped, currWeap, true)
                loadAnimDict('reaction@intimidation@1h')
                loadAnimDict('reaction@intimidation@cop@unarmed')
                loadAnimDict('rcmjosh4')
                loadAnimDict('weapons@pistol@')

                local holsterVariant = GetPedDrawableVariation(ped, 8)
                if checkWeapon(newWeap) then
                    if holstered then
                        if wearingHolster then
                            --TaskPlayAnim(ped, 'rcmjosh4', 'josh_leadout_cop2', 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
                            canFire = false
                            CeaseFire()
                            currHolster = GetPedDrawableVariation(ped, 7)
                            currHolsterTexture = GetPedTextureVariation(ped, 7)
                            TaskPlayAnimAdvanced(ped, 'rcmjosh4', 'josh_leadout_cop2', pos.x, pos.y, pos.z, 0, 0, rot, 3.0, 3.0, -1, 50, 0, 0, 0)
                            Wait(300)
                            SetCurrentPedWeapon(ped, newWeap, true)

                            if isWeaponHolsterable(newWeap) then
                                SetPedComponentVariation(ped, 7, currHolster == 8 and 2 or currHolster == 1 and 3 or currHolster == 6 and 5, currHolsterTexture, 2)
                            end
                            currWeap = newWeap
                            Wait(300)
                            ClearPedTasks(ped)
                            holstered = false
                            canFire = true
                        else
                            canFire = false
                            CeaseFire()
                            TaskPlayAnimAdvanced(ped, 'reaction@intimidation@1h', 'intro', pos.x, pos.y, pos.z, 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
                            Wait(1000)
                            SetCurrentPedWeapon(ped, newWeap, true)
                            currWeap = newWeap
                            Wait(1400)
                            ClearPedTasks(ped)
                            holstered = false
                            canFire = true
                        end
                    elseif newWeap ~= currWeap and checkWeapon(currWeap) then
                        if wearingHolster then
                            canFire = false
                            CeaseFire()

                            TaskPlayAnimAdvanced(ped, 'reaction@intimidation@cop@unarmed', 'intro', pos.x, pos.y, pos.z, 0, 0, rot, 3.0, 3.0, -1, 50, 0, 0, 0)
                            Wait(500)

                            if isWeaponHolsterable(currWeap) then
                                SetPedComponentVariation(ped, 7, currHolster, currHolsterTexture, 2)
                            end

                            SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
                            currHolster = GetPedDrawableVariation(ped, 7)
                            currHolsterTexture = GetPedTextureVariation(ped, 7)

                            TaskPlayAnimAdvanced(ped, 'rcmjosh4', 'josh_leadout_cop2', pos.x, pos.y, pos.z, 0, 0, rot, 3.0, 3.0, -1, 50, 0, 0, 0)
                            Wait(300)
                            SetCurrentPedWeapon(ped, newWeap, true)

                            if isWeaponHolsterable(newWeap) then
                                SetPedComponentVariation(ped, 7, currHolster == 8 and 2 or currHolster == 1 and 3 or currHolster == 6 and 5, currHolsterTexture, 2)
                            end

                            Wait(500)
                            currWeap = newWeap
                            ClearPedTasks(ped)
                            holstered = false
                            canFire = true
                        else
                            canFire = false
                            CeaseFire()
                            TaskPlayAnimAdvanced(ped, 'reaction@intimidation@1h', 'outro', pos.x, pos.y, pos.z, 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
                            Wait(1600)
                            SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
                            TaskPlayAnimAdvanced(ped, 'reaction@intimidation@1h', 'intro', pos.x, pos.y, pos.z, 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
                            Wait(1000)
                            SetCurrentPedWeapon(ped, newWeap, true)
                            currWeap = newWeap
                            Wait(1400)
                            ClearPedTasks(ped)
                            holstered = false
                            canFire = true
                        end
                    else
                        if wearingHolster then
                            SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
                            currHolster = GetPedDrawableVariation(ped, 7)
                            currHolsterTexture = GetPedTextureVariation(ped, 7)
                            TaskPlayAnimAdvanced(ped, 'rcmjosh4', 'josh_leadout_cop2', pos.x, pos.y, pos.z, 0, 0, rot, 3.0, 3.0, -1, 50, 0, 0, 0)
                            Wait(300)
                            SetCurrentPedWeapon(ped, newWeap, true)

                            if isWeaponHolsterable(newWeap) then
                                SetPedComponentVariation(ped, 7, currHolster == 8 and 2 or currHolster == 1 and 3 or currHolster == 6 and 5, currHolsterTexture, 2)
                            end

                            currWeap = newWeap
                            Wait(300)
                            ClearPedTasks(ped)
                            holstered = false
                            canFire = true
                        else
                            SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
                            TaskPlayAnimAdvanced(ped, 'reaction@intimidation@1h', 'intro', pos.x, pos.y, pos.z, 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
                            Wait(1000)
                            SetCurrentPedWeapon(ped, newWeap, true)
                            currWeap = newWeap
                            Wait(1400)
                            ClearPedTasks(ped)
                            holstered = false
                            canFire = true
                        end
                    end
                else
                    if not holstered and checkWeapon(currWeap) then
                        if wearingHolster then
                            canFire = false
                            CeaseFire()
                            TaskPlayAnimAdvanced(ped, 'reaction@intimidation@cop@unarmed', 'intro', pos.x, pos.y, pos.z, 0, 0, rot, 3.0, 3.0, -1, 50, 0, 0, 0)
                            Wait(500)

                            if isWeaponHolsterable(currWeap) then
                                SetPedComponentVariation(ped, 7, currHolster, currHolsterTexture, 2)
                            end

                            SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
                            ClearPedTasks(ped)
                            SetCurrentPedWeapon(ped, newWeap, true)
                            holstered = true
                            canFire = true
                            currWeap = newWeap
                        else
                            canFire = false
                            CeaseFire()
                            TaskPlayAnimAdvanced(ped, 'reaction@intimidation@1h', 'outro', pos.x, pos.y, pos.z, 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
                            Wait(1400)
                            SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
                            ClearPedTasks(ped)
                            SetCurrentPedWeapon(ped, newWeap, true)
                            holstered = true
                            canFire = true
                            currWeap = newWeap
                        end
                    else
                        SetCurrentPedWeapon(ped, newWeap, true)
                        holstered = false
                        canFire = true
                        currWeap = newWeap
                    end
                end
            end
        end
        Wait(sleep)
        if currWeap == nil or currWeap == `WEAPON_UNARMED` then
            weaponCheck += 1
            if weaponCheck == 2 then
                break
            end
        end
    end
end)

function CeaseFire()
    CreateThread(function()
        if GetResourceState('qs-inventory') == 'missing' then return end -- This part is only made to work with qb-inventory, other inventories might conflict
        while not canFire do
            DisableControlAction(0, 25, true)
            DisablePlayerFiring(PlayerId(), true)
            Wait(0)
        end
    end)
end
