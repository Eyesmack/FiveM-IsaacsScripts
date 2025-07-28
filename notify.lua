-- Use the below code to call this function
-- TriggerEvent('notify:client:notify', "[TEXT GOES HERE]")
RegisterNetEvent('notify:client:notify')
AddEventHandler('notify:client:notify', function(alert)
	--print("Got to the script")
	PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", true)
	Notify(alert)
end)

-- Use the below code to call this function
-- TriggerEvent('notify:client:notifynosound', "[TEXT GOES HERE]")
RegisterNetEvent('notify:client:notifynosound')
AddEventHandler('notify:client:notifynosound', function(alert)
	Notify(alert)
end)


function Notify(text)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(text)
	DrawNotification(false, false)
end

--This is a test command to play a sound
-- RegisterCommand('sound', function (source, args)
-- 	print(table.concat(args, " "))
-- 	PlaySoundFrontend(-1, args[1], args[2], true)
-- end, false)