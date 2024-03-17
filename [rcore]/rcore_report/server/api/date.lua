function getCurrentDateTime()
    return os.date("%Y-%m-%d %X", os.time())
end

function getCurrentDateTimeWithoutSpaces()
    return os.date("%Y_%m_%d_%H_%M_%S", os.time())
end