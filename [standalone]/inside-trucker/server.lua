cfg.Prefix = exports[cfg.ExportPrefix]:GetCoreObject()

ActCargo = {
	[1] = {TypeOfWork = "none", CargoWeight = "none", TrailerOwner = "none", OwnerID = nil, VehicleEntityID = nil, TrailerEntityID = nil}
}

RegisterServerEvent('inside-trucker:SendCargos')
AddEventHandler('inside-trucker:SendCargos', function()
	TriggerClientEvent('inside-trucker:SynchronizeCargo', -1, ActCargo)
end)

RegisterServerEvent('inside-trucker:ConfiscateCargo')
AddEventHandler('inside-trucker:ConfiscateCargo', function(clientTrailerOwner, clientOwnerID)
	for i = 1, #ActCargo, 1 do
		if ActCargo[i].TrailerOwner == clientTrailerOwner then
			ActCargo[i] = {TypeOfWork = ActCargo[i].TypeOfWork, CargoWeight = 0, TrailerOwner = ActCargo[i].TrailerOwner, OwnerID = ActCargo[i].OwnerID, VehicleEntityID = ActCargo[i].VehicleEntityID, TrailerEntityID = ActCargo[i].TrailerEntityID}
			TriggerClientEvent('inside-trucker:ConfiscateCargoByPolice', clientOwnerID)
		end
	end
	Wait(100)
	TriggerClientEvent('inside-trucker:SynchronizeCargo', -1, ActCargo)
end)

RegisterServerEvent('inside-trucker:AddCargo')
AddEventHandler('inside-trucker:AddCargo', function(WorkType, Weight, VehicleID, TrailerID)
	local xPlayer = cfg.Prefix.Functions.GetPlayer(source)
	local getName = xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname

	for i = 1, #ActCargo, 1 do
		if ActCargo[i].TypeOfWork == "none" and ActCargo[i].CargoWeight == "none" and ActCargo[i].TrailerOwner == "none" and ActCargo[i].VehicleEntityID == nil and ActCargo[i].TrailerEntityID == nil then
			ActCargo[i] = {TypeOfWork = WorkType, CargoWeight = Weight, TrailerOwner = getName, OwnerID = source, VehicleEntityID = VehicleID, TrailerEntityID = TrailerID}
			break
		elseif ActCargo[i].TrailerOwner == getName then
			ActCargo[i] = {TypeOfWork = WorkType, CargoWeight = Weight, TrailerOwner = getName, OwnerID = source, VehicleEntityID = VehicleID, TrailerEntityID = TrailerID}
			break
		else
			ActCargo[#ActCargo + 1] = {TypeOfWork = WorkType, CargoWeight = Weight, TrailerOwner = getName, OwnerID = source, VehicleEntityID = VehicleID, TrailerEntityID = TrailerID}
			break
		end
	end
	Wait(100)
	TriggerClientEvent('inside-trucker:SynchronizeCargo', -1, ActCargo)
end)

RegisterServerEvent('inside-trucker:RemoveCargo')
AddEventHandler('inside-trucker:RemoveCargo', function(VehicleID, TrailerID)
	local xPlayer = cfg.Prefix.Functions.GetPlayer(source)
	local getName = xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname

	for i = 1, #ActCargo, 1 do
		if ActCargo[i].TrailerOwner == getName and ActCargo[i].VehicleEntityID == VehicleID and ActCargo[i].TrailerEntityID == TrailerID then
			ActCargo[i] = {TypeOfWork = "none", CargoWeight = "none", TrailerOwner = "none", OwnerID = nil, VehicleEntityID = nil, TrailerEntityID = nil}
			break
		end
	end
	Wait(100)
	TriggerClientEvent('inside-trucker:SynchronizeCargo', -1, ActCargo)
end)

cfg.Prefix.Functions.CreateCallback('inside-trucker:CheckDeposit', function(source, cb)
	local xPlayer = cfg.Prefix.Functions.GetPlayer(source)

	if xPlayer.PlayerData.money.cash >= cfg.DepositPrice then
		cb(true)
    elseif xPlayer.PlayerData.money.bank >= cfg.DepositPrice then
        cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('inside-trucker:GetDeposit')
AddEventHandler('inside-trucker:GetDeposit', function()
	local xPlayer = cfg.Prefix.Functions.GetPlayer(source)
	
	if xPlayer.PlayerData.money.cash >= cfg.DepositPrice then
		xPlayer.Functions.RemoveMoney('cash', cfg.DepositPrice)
    elseif xPlayer.PlayerData.money.bank >= cfg.DepositPrice then
        xPlayer.Functions.RemoveMoney('bank', cfg.DepositPrice)
	end
end)

RegisterServerEvent('inside-trucker:ReturnDeposit')
AddEventHandler('inside-trucker:ReturnDeposit', function(onDuty)
	local xPlayer = cfg.Prefix.Functions.GetPlayer(source)
	
    if onDuty then
		xPlayer.Functions.AddMoney("bank", cfg.DepositPrice)
    end
end)

cfg.Prefix.Functions.CreateCallback('inside-trucker:GetSalary', function(source, cb, Weight, Work)
	local xPlayer = cfg.Prefix.Functions.GetPlayer(source)

	if Work.Name == "normal" then
		if Weight <= 24 then
			local SalaryNormal = Weight * Work.PricePerTon

			if cfg.Salary == "bank" then
				xPlayer.Functions.AddMoney("bank", SalaryNormal)
			elseif cfg.Salary == "cash" then
				xPlayer.Functions.AddMoney("cash", SalaryNormal)
			end
			cb(SalaryNormal)
		elseif Weight >= 25 then
			local IllegalTons = Weight - 24
			local SalaryNormal = 24 * Work.PricePerTon
			local SalaryExtra = IllegalTons * Work.PricePerTon * 2
			local Salary = SalaryNormal + SalaryExtra

			if cfg.Salary == "bank" then
				xPlayer.Functions.AddMoney("bank", Salary)
			elseif cfg.Salary == "cash" then
				xPlayer.Functions.AddMoney("cash", Salary)
			end
			cb(Salary)
		end
	elseif Work.Name == "wood" then
		if Weight <= 20 then
			local SalaryNormal = Weight * Work.PricePerTon

			if cfg.Salary == "bank" then
				xPlayer.Functions.AddMoney("bank", SalaryNormal)
			elseif cfg.Salary == "cash" then
				xPlayer.Functions.AddMoney("cash", SalaryNormal)
			end
			cb(SalaryNormal)
		elseif Weight >= 21 then
			local IllegalTons = Weight - 20
			local SalaryNormal = 20 * Work.PricePerTon
			local SalaryExtra = IllegalTons * Work.PricePerTon * 2
			local Salary = SalaryNormal + SalaryExtra

			if cfg.Salary == "bank" then
				xPlayer.Functions.AddMoney("bank", Salary)
			elseif cfg.Salary == "cash" then
				xPlayer.Functions.AddMoney("cash", Salary)
			end
			cb(Salary)
		end
	end
end)