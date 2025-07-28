RegisterCommand('spawn', function (source, args, rawCommand)
    local ped = GetPlayerPed(-1)

    if IsPedSittingInAnyVehicle(ped) then
        local vehicle = GetVehiclePedIsIn(ped, false)
        SetEntityAsMissionEntity(vehicle, true, true)
        DeleteVehicle(vehicle)
    end 

    local vehicleName = args[1] or 'POLICE'

    RequestModel(vehicleName)

    while not HasModelLoaded(vehicleName) do
        Citizen.Wait(0)
    end

    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    local vehicle = CreateVehicle(vehicleName, pos.x, pos.y, pos.z, GetEntityHeading(playerPed), true, false)

    TriggerEvent('notify:client:notifynosound', "Spawned " .. GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))

    SetPedIntoVehicle(playerPed, vehicle, -1)

    SetEntityAsNoLongerNeeded(vehicle)
    SetModelAsNoLongerNeeded(vehicleName)
end, false)

RegisterCommand('dv', function ()
    local ped = GetPlayerPed(-1)
    if IsPedSittingInAnyVehicle(ped) then 
        local vehicle = GetVehiclePedIsIn(ped, false)
        SetEntityAsMissionEntity(vehicle, true, true)
        DeleteVehicle(vehicle)
    end
end, false)

RegisterCommand('fix', function (source, args, rawCommand)
    local ped = PlayerPedId()

    if IsPedInAnyVehicle(ped, false) then
        local vehicle = GetVehiclePedIsIn(ped, false)
        if GetPedInVehicleSeat(vehicle, -1) == ped then
            SetVehicleBodyHealth(vehicle, 1000.0)
            SetVehicleEngineHealth(vehicle, 1000.00)
            SetVehicleFixed(vehicle)
        end
    end
end, false)