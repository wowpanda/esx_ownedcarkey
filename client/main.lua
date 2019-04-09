ESX              = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_ownedcarkey:keyuse')
AddEventHandler('esx_ownedcarkey:keyuse', function()
	local playerPed = PlayerPedId()
	local vehicle   = ESX.Game.GetVehicleInDirection()
	if not vehicle then
		vehicle = GetVehiclePedIsIn(playerPed, false)
	end
	if vehicle ~= 0 then
		local vehdata = ESX.Game.GetVehicleProperties(vehicle)
		ESX.TriggerServerCallback('esx_ownedcarkey:ismycar', function (found)
			if found then
				local lockstate = GetVehicleDoorLockStatus(vehicle)
				if lockstate ~= 1 then
					SetVehicleDoorsLocked(vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ESX.ShowNotification(_U('doors_unlock'))
				else
					SetVehicleDoorsLocked(vehicle, 2)
					SetVehicleDoorsLockedForAllPlayers(vehicle, true)
					ESX.ShowNotification(_U('doors_lock'))
				end
			else
				ESX.ShowNotification(_U('not_your_car'))
			end
		end, vehdata.plate)
	else
		ESX.ShowNotification(_U('no_proximity_car'))
	end
end)
