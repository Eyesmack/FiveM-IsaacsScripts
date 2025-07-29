AddEventHandler("playerSpawned", function(spawn)
	-- Setting ped to true allows the ped to shoot "friendlies" [FiveM Natives](https://docs.fivem.net/natives/?_0xB3B1CB349FF9C75D)
    SetCanAttackFriendly(GetPlayerPed(-1), true, false)

	-- [FiveM Natives](https://docs.fivem.net/natives/?_0xF808475FA571D823)
    NetworkSetFriendlyFireOption(true)
    
    print("PVP Enabled")
end)