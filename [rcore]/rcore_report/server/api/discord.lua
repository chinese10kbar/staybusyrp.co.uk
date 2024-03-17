function sendCustomDiscordMessage(webhook,name,message,color,footer)
    footer = footer or "rcore_reports | rcore.cz"
    color = color or SConfig.DiscordColors.Grey
    local embeds = {
        {
            ["title"] = name,
            ["description"] = message,
            ["type"] = "rich",
            ["color"] = color,
            ["footer"] = {
                ["text"] = footer,
            },
        }
    }

    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = name, embeds = embeds }), { ['Content-Type'] = 'application/json' })
end

local function findDiscordIdentifier(source)
    local discordId
    for _, id in ipairs(GetPlayerIdentifiers(source)) do
        if string.match(id, "discord:") then
            discordId = string.gsub(id, "discord:", "")
        end
    end
    return discordId
end

local function getNiceName(playerId)
    local discordLicense = findDiscordIdentifier(playerId)
    if discordLicense then
        return string.format('%s <@%s>', getPlayerName(playerId), discordLicense)
    end

    return nil
end

function getQuickReportWebhook(title)
    return SConfig.QuickReportsCustomWebhooks[title]
end

function sendDiscordReportLog(report, playerId, isQuickReport)
    local quickReportWebhook = nil

    if isQuickReport then
        quickReportWebhook = getQuickReportWebhook(report.title)
    end
    local hasWebhook = SConfig.DiscordReportsLogWebhook ~= nil and SConfig.DiscordReportsLogWebhook ~= 'WEBHOOK'
    if not hasWebhook and quickReportWebhook == nil then
        return
    end

    local webhook = SConfig.DiscordReportsLogWebhook
    if quickReportWebhook then
        webhook = quickReportWebhook
    end

    local message = string.format("Title: %s\n", report.title)
    message = message .. string.format("Author: %s", getNiceName(playerId) or report.author.name)

    sendCustomDiscordMessage(
        webhook, 'RCORE_REPORT', message
    )
end

function sendDiscordReportLogWithFirstMessage(report, playerId, text, isQuickReport)
    local quickReportWebhook = nil

    if isQuickReport then
        quickReportWebhook = getQuickReportWebhook(report.title)
    end
    local hasWebhook = SConfig.DiscordReportsLogWebhook ~= nil and SConfig.DiscordReportsLogWebhook ~= 'WEBHOOK'
    if not hasWebhook and quickReportWebhook == nil then
        return
    end

    local webhook = SConfig.DiscordReportsLogWebhook
    if quickReportWebhook then
        webhook = quickReportWebhook
    end

    local message = string.format("**Title**\n%s\n\n", report.title)
    message = message .. string.format("**Author**\n%s\n\n", getNiceName(playerId) or report.author.name)
    message = message .. string.format("**Message**\n%s", text)

    sendCustomDiscordMessage(
        webhook, 'RCORE_REPORT', message
    )
end

function generateReportTranscript(report)
    local path = string.format('transcripts/%s_%s_report-transcript.html', report.id, getCurrentDateTimeWithoutSpaces())
    SaveResourceFile(
        GetCurrentResourceName(),
        path,
        getTranscriptHtml(report)
    )
    TriggerEvent('rcore_report:sendDiscordFile', '/'..path, string.format('**REPORT_TRANSCRIPT**\n%s (ID %s)', report.title, report.id), SConfig.DiscordReportsTranscriptWebhook)
end