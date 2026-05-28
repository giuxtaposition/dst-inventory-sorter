name = "Inventory Sorter"
description = "Press a key to sort your inventory by category and name."
author = "giuxtaposition"
version = "1.0.3"
icon_atlas = "modicon.xml"
icon = "modicon.tex"

api_version = 10

dst_compatible = true
client_only_mod = false

all_clients_require_mod = true

configuration_options = {
	{
		name = "SORT_KEY",
		label = "Sort Key",
		hover = "Key to press to sort your inventory. Configured per player.",
		options = {
			{ description = "A", data = "KEY_A" },
			{ description = "B", data = "KEY_B" },
			{ description = "C", data = "KEY_C" },
			{ description = "D", data = "KEY_D" },
			{ description = "E", data = "KEY_E" },
			{ description = "F", data = "KEY_F" },
			{ description = "G", data = "KEY_G" },
			{ description = "H", data = "KEY_H" },
			{ description = "I", data = "KEY_I" },
			{ description = "J", data = "KEY_J" },
			{ description = "K", data = "KEY_K" },
			{ description = "L", data = "KEY_L" },
			{ description = "M", data = "KEY_M" },
			{ description = "N", data = "KEY_N" },
			{ description = "O", data = "KEY_O" },
			{ description = "P", data = "KEY_P" },
			{ description = "Q", data = "KEY_Q" },
			{ description = "R", data = "KEY_R" },
			{ description = "S", data = "KEY_S" },
			{ description = "T", data = "KEY_T" },
			{ description = "U", data = "KEY_U" },
			{ description = "V", data = "KEY_V" },
			{ description = "W", data = "KEY_W" },
			{ description = "X", data = "KEY_X" },
			{ description = "Y", data = "KEY_Y" },
			{ description = "Z", data = "KEY_Z" },
			{ description = "F1", data = "KEY_F1" },
			{ description = "F2", data = "KEY_F2" },
			{ description = "F3", data = "KEY_F3" },
			{ description = "F4", data = "KEY_F4" },
			{ description = "F5", data = "KEY_F5" },
			{ description = "F6", data = "KEY_F6" },
			{ description = "F7", data = "KEY_F7" },
			{ description = "F8", data = "KEY_F8" },
			{ description = "F9", data = "KEY_F9" },
			{ description = "F10", data = "KEY_F10" },
			{ description = "F11", data = "KEY_F11" },
			{ description = "F12", data = "KEY_F12" },
		},
		default = "KEY_Z",
	},
}
