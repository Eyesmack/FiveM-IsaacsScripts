-- A script for all my debugging and testing needs.
local pedFrequency = 1.0 -- 1.0 is normal, 0.0 is no peds
local trafficFrequency = 1.0 -- 1.0 is normal, 0.0 is no traffic

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        SetPedDensityMultiplierThisFrame(pedFrequency) -- https://runtime.fivem.net/doc/natives/#_0x95E3D6257B166CF2
        SetScenarioPedDensityMultiplierThisFrame(pedFrequency, pedFrequency) -- https://runtime.fivem.net/doc/natives/#_0x7A556143A1C03898

        SetRandomVehicleDensityMultiplierThisFrame(trafficFrequency) -- https://runtime.fivem.net/doc/natives/#_0xB3B3359379FE77D3
        SetParkedVehicleDensityMultiplierThisFrame(trafficFrequency) -- https://runtime.fivem.net/doc/natives/#_0xEAE6DCC7EEE3DB1D
        SetVehicleDensityMultiplierThisFrame(trafficFrequency) -- https://runtime.fivem.net/doc/natives/#_0x245A6883D966D537
    end 
end)

RegisterCommand('ped', function (source, args, rawCommand)
    if #args > 0 then
        local frequency = tonumber(args[1])
        if frequency ~= nil and frequency >= 0.0 then
            pedFrequency = frequency
            TriggerEvent('notify:cl:notify', "Ped density set to " .. pedFrequency)
        else
            TriggerEvent('notify:cl:notify', "Invalid ped density value. Must be more than 0.0")
        end
    else
        TriggerEvent('notify:cl:notify', "Current ped density: " .. pedFrequency)
    end
end, false)

RegisterCommand('traffic', function (source, args, rawCommand)
    if #args > 0 then
        local frequency = tonumber(args[1])
        if frequency ~= nil and frequency >= 0.0 then
            trafficFrequency = frequency
            TriggerEvent('notify:cl:notify', "Traffic density set to " .. trafficFrequency)
        else
            TriggerEvent('notify:cl:notify', "Invalid traffic density value. Must be more than 0.0")
        end
    else
        TriggerEvent('notify:cl:notify', "Current traffic density: " .. trafficFrequency)
    end
end, false)