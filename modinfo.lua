name = "Inventory Sorter"
description = "Press a key to sort your inventory by category and name."
author = "giuxtaposition"
version = "1.0"

api_version = 10

dst_compatible = true
client_only_mod = false

all_clients_require_mod = false

configuration_options = {
    {
        name = "SORT_KEY",
        label = "Sort Key",
        hover = "Key to press to sort inventory",
        options = {
            {description = "Z",  data = "KEY_Z"},
            {description = "Y",  data = "KEY_Y"},
            {description = "X",  data = "KEY_X"},
            {description = "N",  data = "KEY_N"},
            {description = "M",  data = "KEY_M"},
            {description = "P",  data = "KEY_P"},
            {description = "F5", data = "KEY_F5"},
            {description = "F6", data = "KEY_F6"},
            {description = "F7", data = "KEY_F7"},
            {description = "F8", data = "KEY_F8"},
            {description = "F9", data = "KEY_F9"},
        },
        default = "KEY_Z",
    },
}
