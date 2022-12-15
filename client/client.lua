local QBCore = exports['qb-core']:GetCoreObject()
if Config.Command ~= nil or Config.Command ~= 'nil' then
	RegisterCommand(Config.Command,function(source, args)
		local ped = PlayerPedId()
		local veh = GetVehiclePedIsIn(ped)

		if veh == 0 or veh == nil then
			QBCore.Functions.Notify('Du musst dafür in ein Fahrzeug sitzen!', "error", 5000)
			return
		end

		vehhash = GetEntityModel(veh)

		local type = CreateDialog("Gib den Fahrzeug Typ an")
		local name = CreateDialog("Gib den Fahrzeug Label an")

		if tostring(type) == nil or tostring(type) == "" then
			return
		end

		if tostring(name) == nil or tostring(name) == "" then
			return
		end

		TriggerServerEvent('vCAD-Sync:InsertConfigVehicle', vehhash, type, name)

	end, false)
end