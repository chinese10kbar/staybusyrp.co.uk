if Config.Billing ~= "esx_billing" then
    return
end

function CreateBill(amount, text)
    TriggerServerCallback("qs-dispatchh:server:esx_billing:CreateBill", function(data)
        DebugPrint(data)
    end, {
        amount = amount,
        text = text
    })
end
