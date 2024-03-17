function asyncExecute(query, parametersMap)
    return MySQL.Async.execute(query, parametersMap)
end

function syncExecute(query, parametersMap)
    return MySQL.Sync.execute(query, parametersMap)
end

function syncFetchAll(query, parametersMap)
    return MySQL.Sync.fetchAll(query, parametersMap)
end

function syncInsert(query, parametersMap)
    return MySQL.Sync.insert(query, parametersMap)
end