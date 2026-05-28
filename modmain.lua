local EQUIPSLOTS = GLOBAL.EQUIPSLOTS

-- Priority: 1=weapon, 2=tool, 3=equip, 4=food, 5=other
local function GetCategory(item)
    if item:HasTag("weapon") then return 1 end
    if item:HasTag("tool") then return 2 end

    local equip = item.components and item.components.equippable
    if equip then
        local slot = equip.equipslot
        if slot == EQUIPSLOTS.BODY or slot == EQUIPSLOTS.HEAD then
            return 3
        end
    end
    if item:HasTag("armor") then return 3 end

    if item:HasTag("food") or item:HasTag("cookable") then return 4 end

    return 5
end

local function SortItems(a, b)
    local ca = GetCategory(a)
    local cb = GetCategory(b)
    if ca ~= cb then return ca < cb end
    return a.prefab < b.prefab
end

local function SortPlayerInventory(player)
    if not (player and player.components and player.components.inventory) then return end

    local inv = player.components.inventory
    local numSlots = inv.maxslots

    local items = {}
    for i = 1, numSlots do
        if inv.itemslots[i] then
            local item = inv:RemoveItemBySlot(i)
            if item then items[#items + 1] = item end
        end
    end

    if #items == 0 then return end

    table.sort(items, SortItems)

    for i, item in ipairs(items) do
        inv:GiveItem(item, i)
    end
end

-- Server-side: handles RPC from dedicated-server clients
AddModRPCHandler("inventory_sorter", "SortInventory", function(player)
    print("[InvSorter] RPC received, player=", player)
    SortPlayerInventory(player)
end)

-- Client-side key handler registration.
-- Tried twice to cover both contexts:
--   - Immediately: works for clients joining a dedicated server (TheInput ready at load)
--   - AddGamePostInit: works for listen servers (TheInput not ready at load)
local key_handler_registered = false

local function RegisterKeyHandler()
    print("[InvSorter] RegisterKeyHandler called, registered=", key_handler_registered,
        " TheInput=", GLOBAL.TheInput ~= nil,
        " IsDedicated=", GLOBAL.TheNet:IsDedicated())

    if key_handler_registered then return end
    if not GLOBAL.TheInput then return end
    if GLOBAL.TheNet:IsDedicated() then return end

    key_handler_registered = true
    print("[InvSorter] Key handler registered")

    local sort_key = GLOBAL[GetModConfigData("SORT_KEY") or "KEY_Z"]

    GLOBAL.TheInput:AddKeyUpHandler(sort_key, function()
        local player = GLOBAL.ThePlayer
        print("[InvSorter] Key pressed, ThePlayer=", player ~= nil)

        if player == nil then return end
        if player.HUD and player.HUD:HasInputFocus() then return end

        local has_components = player.components and player.components.inventory ~= nil
        print("[InvSorter] has_components=", has_components)

        if has_components then
            print("[InvSorter] Sorting directly (listen server / solo)")
            SortPlayerInventory(player)
        else
            print("[InvSorter] Sending RPC to server (dedicated server client)")
            SendModRPCToServer(GetModRPC("inventory_sorter", "SortInventory"))
        end
    end)
end

print("[InvSorter] modmain loaded, IsServer=", GLOBAL.TheNet:GetIsServer(),
    " IsDedicated=", GLOBAL.TheNet:IsDedicated())

RegisterKeyHandler()          -- fires for dedicated server clients
AddGamePostInit(RegisterKeyHandler)  -- fires for listen servers / solo
