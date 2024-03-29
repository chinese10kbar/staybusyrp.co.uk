if Config.Billing ~= "okokBilling" then
    return
end

function getBills(a, cb, data)
    MySQL.Async.fetchAll("SELECT * FROM okokbilling WHERE receiver_identifier = @identifier AND society IN (@society1, @society2) ORDER BY id DESC LIMIT 100;", {
        ['@identifier'] = data.identifier,
        ['@society1'] = GetJobName(a) or '',
        ['@society2'] = 'society_'..GetJobName(a)
    }, function(results)
        local bills = {}
        for _, value in ipairs(results) do
            table.insert(bills, {
                ["author_name"] = value["author_name"] or 'Not defined',
                ["timestamp"] = value["sent_date"] or os.time(),
                ["status"] = value["status"] or 'unpaid',
                ["item"] = value["item"] or 'Not defined'
            })
        end
        DebugPrint(bills)
        cb(bills)
    end)
end

RegisterServerCallback("qs-dispatch:server:getBills", getBills)

function CreateBill(target, label, amount)
    getPlayerByIdentifier(target, function(data)
        local random = math.random(10000000, 90000000)
        local refid = "QS"..random

        MySQL.Async.execute('INSERT INTO okokbilling (ref_id, receiver_identifier, receiver_name, author_identifier, author_name, society, society_name, item, invoice_value, status, sent_date) VALUES (@ref_id, @receiver_identifier, @receiver_name, @author_identifier, @author_name, @society, @society_name, @item, @invoice_value, @status, @sent_date)',
        {
            ['@ref_id'] = refid,
            ['@receiver_identifier'] = data.identifier,
            ['@receiver_name'] = data.name,
            ['@author_identifier'] = GetPlayerIdentifier(target),
            ['@author_name'] = GetPlayerName(target),
            ['@society'] = 'society_police',
            ['@society_name'] = 'society_police',
            ['@item'] = label,
            ['@invoice_value'] = amount,
            ['@status'] = 'Unpaid',
            ['@sent_date'] = os.date('%Y-%m-%d %H:%M:%S')
        })
    end)
end

