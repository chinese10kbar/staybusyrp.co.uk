function Get_Discord_Avatar(discord_id)
    local endpoint = "users/" .. discord_id
    local user = DiscordRequest("GET", endpoint, {})
    if user.code == 200 then
        local data = json.decode(user.data)
        if data.avatar then
            local avatarURL = "https://cdn.discordapp.com/avatars/" .. discord_id .. "/" .. data.avatar .. ".png"
            return avatarURL
        end
    end
    return nil
end
