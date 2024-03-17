if Config.Billing ~= "????" then
    return
end

function getBills(a, cb, data)
    MySQL.Async.fetchAll(
        'SELECT * FROM billing WHERE identifier = @identifier AND target_type = @society ORDER BY id DESC LIMIT 100;', {
            ['@identifier'] = data.identifier,
            ['@target_type'] = ('society_' .. GetJobName(a)) or ''
        }, function(results)
            local bills = {}
            for key, value in ipairs(results) do
                table.insert(
                    bills,
                    {
                        ["author_name"] = value["sender"] or 'Not defined',
                        ["timestamp"] = value["id"] or os.time(os.date("!*t")),
                        ["status"] = value["create_date"] == 1 and 'paid' or 'unpaid',
                        ["item"] = value["label"] or 'Not defined',
                    }
                )
            end
            DebugPrint(bills)
            cb(bills)
        end)
end

RegisterServerCallback("qs-dispatch:server:getBills", getBills)
-- rcore_billing



function CreateBill(target, label, amount)
    local ident = GetPlayerIdentifier(target)

    MySQL.Async.execute(
        'INSERT INTO billing (identifier, sender, label, amount, target_type) VALUES (@identifier, @sender, @label, @amount, @target_type)',
        {
            ['@identifier'] = ident,
            ['@sender'] = ident,
            ['@label'] = label,
            ['@amount'] = amount,
            ['@target_type'] = ('society_police') or ''
        }
    )
end
