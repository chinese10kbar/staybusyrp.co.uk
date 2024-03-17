function isInReport(identifier, report)
    if report.author.identifier == identifier then
        return true
    end

    for _, player in pairs(report.chatRoom.players) do
        if player.identifier == identifier then
            return true
        end
    end

    return false
end

function canInteractWithReport(source, report)
    if hasAdminPermissions(source) then
        return true
    end

    local identifier = getIdentifier(source)
    return isInReport(identifier, report)
end

function hasPermissionToSeeAllPlayersHistory(isAdminOnDuty, playerId)
    return isAdminOnDuty
end