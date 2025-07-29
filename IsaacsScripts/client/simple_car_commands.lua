RegisterCommand('spawn', function (source, args, rawCommand)
    local ped = GetPlayerPed(-1)

    local vehicleName = args[1] or 'frontline' -- Default to 'frontline' if no argument is provided

    -- check if the vehicle actually exists
    if not IsModelInCdimage(vehicleName) or not IsModelInCdimage(vehicleName) then
        TriggerEvent('notify:cl:notify', "Vehicle does not exist: ~r~" .. vehicleName .. "~s~")
        return
    end

    if IsPedSittingInAnyVehicle(ped) then
        local vehicle = GetVehiclePedIsIn(ped, false)
        SetEntityAsMissionEntity(vehicle, true, true)
        DeleteVehicle(vehicle)
    end

    RequestModel(vehicleName)

    while not HasModelLoaded(vehicleName) do
        Citizen.Wait(0)
    end

    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    local vehicle = CreateVehicle(vehicleName, pos.x, pos.y, pos.z, GetEntityHeading(playerPed), true, false)

    TriggerEvent('notify:cl:notify', "Spawned " .. GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))

    SetPedIntoVehicle(playerPed, vehicle, -1)

    SetVehicleEngineOn(vehicle, true, true, true)

    SetEntityAsNoLongerNeeded(vehicle)
    SetModelAsNoLongerNeeded(vehicleName)
end, false)

RegisterCommand('dv', function ()
    local ped = GetPlayerPed(-1)
    if IsPedSittingInAnyVehicle(ped) then 
        local vehicle = GetVehiclePedIsIn(ped, false)
        SetEntityAsMissionEntity(vehicle, true, true)
        DeleteVehicle(vehicle)
        TriggerEvent('notify:cl:notify', "Vehicle deleted", 4)
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
            TriggerEvent('notify:cl:notify', "Vehicle fixed", 4)
        end
    end
end, false)

RegisterCommand('vehinfo', function(source, args, rawCommand)
    -- get the players pos
    local playerPed = PlayerPedId() -- get the local player ped
    local pos = GetEntityCoords(playerPed) -- get the pos of the local player ped

    -- get the vehicle the player is in
    local vehicle = GetVehiclePedIsIn(playerPed --[[currentplayer]], false --[[lastvehicle]])

    local entityModelHash = GetEntityModel(vehicle)
    local displayName = GetDisplayNameFromVehicleModel(entityModelHash)
    local bodyHealth = GetVehicleBodyHealth(vehicle)
    local engineHealth = GetVehicleEngineHealth(vehicle)

    -- print the vehicle info to the console
    print("###################################################")
    print("Player POS: " .. pos.x .. ", " .. pos.y .. ", " .. pos.z)
    print("VehiclePedIsIn: " .. vehicle)
    print("EntityModelHash: " .. entityModelHash)
    print("DisplayNameFromModelHash: " .. displayName)
    print("VehicleBodyHealth: " .. bodyHealth)
    print("VehicleEngineHealth: " .. engineHealth)
    print("###################################################")

    TriggerEvent('notify:cl:notify', "Name: ~b~" .. displayName .. "~s~~n~Body Health: ~b~" .. bodyHealth .. "~s~~n~Engine Health: ~b~" .. engineHealth)
    TriggerEvent('notify:cl:notify', "More info pasted into console.~n~Press ~y~~h~F8~h~~s~ to open.")
end, false)

TriggerEvent('chat:addSuggestion', '/spawn', 'Spawns a vehicle', {
    { name="Model Name", help="The vehicles model name" }
})
TriggerEvent('chat:addSuggestion', '/dv', 'Deletes the current vehicle', {})
TriggerEvent('chat:addSuggestion', '/fix', 'Repairs the current vehicle', {})
TriggerEvent('chat:addSuggestion', '/vehinfo', 'Pastes debug info about the vehicle into console (F8)', {})