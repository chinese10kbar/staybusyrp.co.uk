if Config.VehicleGarages ~= "qs-advancedgarages" then
    return
end

function getVehsByPlate(source, cb, plate)
    local src = source
    MySQL.Async.fetchAll(
        "SELECT * FROM " .. Config.vehiclesTable .. " WHERE TRIM(`plate`) LIKE CONCAT('%', TRIM(@plate), '%')",
        { ["@plate"] = plate },
        function(results)
            veh_datastore = {}
            for key, value in ipairs(results) do
                table.insert(
                    veh_datastore,
                    {
                        ["plate"] = value["plate"],
                        ["owner"] = value["owner"] or value["citizenid"],
                        ["type"] = value["type"],
                        ["model"] = Config.Framework == 'qb' and value["vehicle"] or json.decode(value["vehicle"]).model,
                    }
                )
            end
            cb(veh_datastore)
        end
    )
end

RegisterServerCallback("qs-dispatch:getVehsByPlate", getVehsByPlate)
function getCars(identifier)

    local query = "SELECT plate, vehicle, owner FROM " .. Config.vehiclesTable .. " WHERE `owner` = @cid"

    if Config.Framework == 'qb' then
        query = "SELECT plate, vehicle, citizenid as owner FROM " .. Config.vehiclesTable .. " WHERE `citizenid` = @cid"
    end

    local results = MySQL.query.await(query, { ["@cid"] = identifier })
    local vehicles = {}
    for key, value in ipairs(results) do
        table.insert(
            vehicles,
            {
                ["plate"] = value["plate"],
                ["owner"] = value["owner"] or value["citizenid"],
                ["type"] = value["type"],
                ["model"] = Config.Framework == 'qb' and value["vehicle"] or json.decode(value["vehicle"]).model,
            }
        )
    end
    return vehicles
end

-- RegisterServerCallback("qs-dispatch:getCars", getCars)