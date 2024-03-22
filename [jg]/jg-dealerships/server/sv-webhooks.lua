--
-- Discord Webhooks
--
Webhooks = {}
Webhooks.TestDrive = "https://discord.com/api/webhooks/1220573348887793745/1itnl6AvYn4ZexcUU5B6xAjWJNkppJoDPy1_oQ_rFPoXMgzQgFGcukFf_raET6gGeXgE"
Webhooks.Purchase = "https://discord.com/api/webhooks/1220573375731208193/DrBaFAe2LpeTirVL7LmOMsjgNJk0POuj7mXvZxZsxIRdwqjJOGevIH8WB4tebjVjilOB"
Webhooks.Finance = "https://discord.com/api/webhooks/1220573403635912745/h8cIyxVxS9Nbe6UF4mpXrPtWzZmdHmhqL90rzKnVHbDJGpVfEIsjUlgH6lC4wCIgmKgs"
Webhooks.Dealership = "https://discord.com/api/webhooks/1220573434593939467/7dQFtibixOO7TMg5FG20Mdc45M_zg3oOGB9rzZ_zGNhfrSV1WYQfApffVUVjoAC_AhzC"
Webhooks.Admin = "https://discord.com/api/webhooks/1220573463874637944/nivBhhHdiGN08e7cFe2xYVmS6oxpzBkkCaPusp3py4McSM49-KNRZB2YLiUqtqORsiMX"

--[[
  EXAMPLE WEBHOOK CALL

  Functions.SendWebhook(src, Webhooks.Admin, "Webhook Title", "success", {
    { key = "Data fields", value = "Data value" },
    { key = "Data fields 2", value = "Data value 2" }
  })
]]--

function Functions.SendWebhook(playerId, webhookUrl, title, type, data)
  if not webhookUrl then return end

  local player = Framework.Server.GetPlayerInfo(playerId)
  if not player then return false end

  local color = 0xff6700
  if type == "success" then color = 0x2ecc71 end
  if type == "danger" then color = 0xe74c3c end

  local fields = {
    {
      name = "Player",
      value = string.format("%s (id: %s)", player.name, tostring(playerId)),
      inline = false
    }
  }
  for _, row in pairs(data) do
    fields[#fields + 1] = {
      name = row.key,
      value = tostring(row.value),
      inline = true
    }
  end

  local body = {
    username = "JG Dealerships Webhook",
    avatar_url = "https://forum.cfx.re/user_avatar/forum.cfx.re/jgscripts/288/3621910_2.png",
    content = "",
    embeds = {
      {
        type = "rich",
        title = title,
        description = "",
        color = color,
        fields = fields
      }
    }
  }

  PerformHttpRequest(
    webhookUrl,
    function(err, text, header) end,
    "POST",
    json.encode(body),
    {["Content-Type"] = "application/json"}
  )
end

-- For sending from client files...
RegisterNetEvent("jg-dealerships:server:send-webhook", function(event, ...)
  local src = source
  Functions.SendWebhook(src, Webhooks[event], ...)
end)
