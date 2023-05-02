--===== FiveM Script =========================================
--= coke - YUPPZWORKSHOP CFX (Webhook)
--===== Developed By: ========================================
--= YUPPZWORKSHOP CFX
--= Copyright (C) YUPPZWORKSHOP CFX - All Rights Reserved
--= You are not allowed to sell this script or edit
--============================================================

local spawnedCoke = 0
local cokePlants = {}
yuppz  = GetCurrentResourceName()
local isPickingUp, isProcessing = false, false

Citizen.CreateThread(function()
	Citizen.Wait(1000)
	print("^2 YUPPZWORKSHOP : Actived ! | Supports!^1")
    print("^2 DISCORD : ^2https://discord.gg/KhnrE48Nfd")
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10000)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10000)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
	for k,zone in pairs(Config.CircleZones) do
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())
		
		if GetDistanceBetweenCoords(coords, Config.CircleZones.CokeField.coords, true) < 50 then
			SpawnCoke()
			Citizen.Wait(1000)
		else
			Citizen.Wait(1000)
		end
	end
end)

RegisterNetEvent(yuppz..'AlertNotification')
AddEventHandler(yuppz..'AlertNotification', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local nearbyObject, nearbyID
	isPickingUp = true
	for i=1, #cokePlants, 1 do
		if GetDistanceBetweenCoords(coords, GetEntityCoords(cokePlants[i]), false) < 1 then
			nearbyObject, nearbyID = cokePlants[i], i
		end
	end
	TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, false)
	Citizen.Wait(Config.Time)
	ClearPedTasks(playerPed)
	ESX.Game.DeleteObject(nearbyObject)
	table.remove(cokePlants, nearbyID)
	spawnedCoke = spawnedCoke - 1
	isPickingUp = false
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local letSleep = true
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #cokePlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(cokePlants[i]), false) < 1 then
				nearbyObject, nearbyID = cokePlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				letSleep = false
				NOTIFYPREE()
			end

			if IsControlJustReleased(0,38) and not isPickingUp then
				progressbar(source)
				if exports.yuppz_check:CheckPolice(Config.Cops) then
					TriggerServerEvent(yuppz..'pickedUpCoke')
				else
					TriggerEvent("pNotify:SendNotification", 
					{text = " ต้องการตำรวจจำนวน "..Config.Cops.." ในเมือง",
					type = "success", timeout = 5000,
					layout = "centerLeft"})
					Wait(5000)
				end
			end
		else
			if letSleep then 
				Citizen.Wait(500)
			end
		end
	end
end)

function progressbar(source)
	TriggerEvent("mythic_progbar:client:progress", {
		name = "unique_action_name",
		duration = Config.Time,
		label = Config.Text,
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
	})
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(cokePlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnCoke()
	while spawnedCoke < 25 do
		Citizen.Wait(0)
		local cokeCoords = GenerateCokeCoords()
		
		ESX.Game.SpawnLocalObject('hei_prop_hei_drug_pack_01a', cokeCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(cokePlants, obj)
			spawnedCoke = spawnedCoke + 1
		end)
	end
end

function ValidateCokeCoord(plantCoord)
	if spawnedCoke > 0 then
		local validate = true

		for k, v in pairs(cokePlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.CokeField.coords, false) > 50 then
			validate = false
		end
		
		return validate
	else
		return true
	end
end

function GenerateCokeCoords()
	while true do
		Citizen.Wait(1)

		local cokeCoordX, cokeCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-10, 10) --Distance Coke Zone

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-10, 10) --Distance Coke Zone

		cokeCoordX = Config.CircleZones.CokeField.coords.x + modX
		cokeCoordY = Config.CircleZones.CokeField.coords.y + modY
		local coord = vector3(cokeCoordX, cokeCoordY, Config.CircleZones.CokeField.coords.z)

		if ValidateCokeCoord(coord) then
			return coord
		end
	end
end


function GetCoordZ(x, y)
	local groundCheckHeights = { 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0  }
	
	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)
		if foundGround then
			return z
		end
	end
	
	return 80
end



