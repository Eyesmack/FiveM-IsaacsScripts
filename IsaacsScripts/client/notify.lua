local soundsDB = SoundLibrary.Sounds

-- Don't use this event anymore, will be removed in a future update
-- Just need to find all the instances of this event and replace them with the new one
RegisterNetEvent('notify:client:notify')
AddEventHandler('notify:client:notify', function(alert)
	PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", true)
	Notify(alert)
	Notify("~r~This is a depreciated method of calling an alert!~s~")
end)

-- Don't use this event anymore, will be removed in a future update
-- Just need to find all the instances of this event and replace them with the new one
RegisterNetEvent('notify:client:notifynosound')
AddEventHandler('notify:client:notifynosound', function(alert)
	Notify(alert)
	Notify("~r~This is a depreciated method of calling an alert!~s~")
end)

-- Use the below code to call this function
-- To play a sound as well as notify use this line
-- TriggerEvent('notify:cl:notify', "[TEXT GOES HERE]", Integer)
-- To not play a sound use this line, aka, remove the second parameter
-- TriggerEvent('notify:cl:notify', "[TEXT GOES HERE]")
RegisterNetEvent('notify:cl:notify')
AddEventHandler('notify:cl:notify', function(alert, sound)
	Notify(alert)
	if sound ~= nil and sound ~= '' then
		PlaySoundFrontend(-1, soundsDB[sound].AudioName, soundsDB[sound].AudioRef, true)
	end
end)

function Notify(text)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(text)
	DrawNotification(false, false)
end

--This is two test commands to listen to the sounds ingame
--The first one is to play a sound from the library
--The second one is to play a sound from the FrontEndSound library found here: https://rebarv.com/data/frontend-sounds/
RegisterCommand('ps', function (source, args)
	local sound = tonumber(args[1])
	if sound > #soundsDB then
		print("Only " .. #soundsDB .. " sounds")
		return
	end
	PlaySoundFrontend(-1, soundsDB[sound].AudioName, soundsDB[sound].AudioRef, true)
	print("Playing sound: " .. soundsDB[sound].AudioName .. " " .. soundsDB[sound].AudioRef)
end, false)
RegisterCommand('pse', function (source, args)
	print(table.concat(args, " "))
	PlaySoundFrontend(-1, args[1], args[2], true)
end, false)

-- Colors for formating the string
-- Example usage below
-- TriggerEvent('notify:cl:notify', "~r~This text is red, ~b~this text is blue, ~s~this resets the color and needs to be at the end of the string", 1)
-- ~r~ = Red
-- ~b~ = Blue
-- ~g~ = Green
-- ~y~ = Yellow
-- ~p~ = Purple
-- ~o~ = Orange
-- ~c~ = Grey
-- ~m~ = Darker Grey
-- ~u~ = Black
-- ~n~ = New Line
-- ~s~ = Default White
-- ~h~ = Bold Text