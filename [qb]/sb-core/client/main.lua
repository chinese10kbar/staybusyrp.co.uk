QBCore = {}
QBCore.PlayerData = {}
QBCore.Config = QBConfig
QBCore.Shared = QBShared
QBCore.ClientCallbacks = {}
QBCore.ServerCallbacks = {}

exports('GetCoreObject', function()
    return QBCore
end)

-- To use this export in a script instead of manifest method
-- Just put this line of code below at the very top of the script
-- local QBCore = exports['sb-core']:GetCoreObject()
Citizen.CreateThread(
    function()
        RequestStreamedTextureDict("regplates")
        while not HasStreamedTextureDictLoaded("regplates") do
            Citizen.Wait(1)
        end
        AddReplaceTexture("vehshare", "plate01", "regplates", "plate01")
        AddReplaceTexture("vehshare", "plate01_n", "regplates", "plate01_n")
        AddReplaceTexture("vehshare", "plate02", "regplates", "plate02")
        AddReplaceTexture("vehshare", "plate02_n", "regplates", "plate02_n")
        AddReplaceTexture("vehshare", "plate03", "regplates", "plate03")
        AddReplaceTexture("vehshare", "plate03_n", "regplates", "plate03_n")
        AddReplaceTexture("vehshare", "plate04", "regplates", "plate04")
        AddReplaceTexture("vehshare", "plate04_n", "regplates", "plate04_n")
        AddReplaceTexture("vehshare", "plate05", "regplates", "plate05")
        AddReplaceTexture("vehshare", "plate05_n", "regplates", "plate05_n")
    end
)




