-- This file is a dependency for the notify script in IsaacsScripts.
-- It should also not be renamed or if it is, you will need to keep the prefixed underscore, or it will not load in the correct order.


SoundLibrary = {}

SoundLibrary.Sounds = {
	[1] = {
		AudioName = "TIMER_STOP",
		AudioRef = "HUD_MINI_GAME_SOUNDSET"
	},
	[2] = {
		AudioName = "Menu_Accept",
		AudioRef = "Phone_SoundSet_Default"
	},
	[3] = {
		AudioName = "OTHER_TEXT",
		AudioRef = "HUD_AWARDS"
	},
	[4] = {
		AudioName = "10_SEC_WARNING",
		AudioRef = "HUD_MINI_GAME_SOUNDSET"
	},
	[5] = {
		AudioName = "CHECKPOINT_NORMAL",
		AudioRef = "HUD_MINI_GAME_SOUNDSET"
	},
	[6] = {
		AudioName = "CHECKPOINT_MISSED",
		AudioRef = "HUD_MINI_GAME_SOUNDSET"
	},
	[7] = {
		AudioName = "CONFIRM_BEEP",
		AudioRef = "HUD_MINI_GAME_SOUNDSET"
	},
	[8] = {
		AudioName = "Crash",
		AudioRef = "DLC_HEIST_HACKING_SNAKE_SOUNDS"
	}
}