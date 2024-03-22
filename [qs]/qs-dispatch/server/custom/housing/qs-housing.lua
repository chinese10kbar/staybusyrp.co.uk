if Config.Housing ~= "qs-housing" then
    return
end


function GetPlayerHouses(identifier) 

    local results = MySQL.query.await("SELECT house, houseID FROM player_houses WHERE `citizenid` = @cid OR `identifier` = @cid;", { ["@cid"] = identifier })
    local houses = {}
    for key, value in ipairs(results) do
        local houseData = MySQL.single.await("SELECT coords FROM houselocations WHERE `houseID` = @houseID;", { ["@houseID"] = value["houseID"] })
        houseData = json.decode(houseData["coords"])

        table.insert(
            houses,
            {
                ["name"] = value["house"],
                ["id"] = value["houseID"],
                ["coords"] = houseData?.enter
            }
        )
    end
    DebugPrint(houses)
    return houses
end