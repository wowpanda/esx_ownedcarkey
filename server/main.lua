ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_ownedcarkey:ismycar', function (source, cb, plate)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE @plate = plate and @owner = owner', 
			{
				['@plate'] = plate,
				['@owner'] = xPlayer.getIdentifier(),
			}, function (result)
			if (result[1] ~= nil) then
				cb(true)
			else
				cb(false)
			end
		end)
end)


ESX.RegisterUsableItem('carkey', function(source)
    local _source = source
		TriggerClientEvent('esx_ownedcarkey:keyuse', _source)
end)