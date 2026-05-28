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

-- Server-side: called via RPC, always has components
AddModRPCHandler("inventory_sorter", "SortInventory", function(player)
    if not (player and player.components and player.components.inventory) then return end

    local inv = player.components.inventory
    local numSlots = inv.maxslots

    local items = {}
    for i = 1, numSlots do
        if inv.itemslots[i] then
            local item = inv:RemoveItemBySlot(i)
            if item then
                items[#items + 1] = item
            end
        end
    end

    if #items == 0 then return end

    table.sort(items, SortItems)

    for i, item in ipairs(items) do
        inv:GiveItem(item, i)
    end
end)

-- Client-side: key press sends RPC to server
if GLOBAL.TheInput then
    local sort_key_str = GetModConfigData("SORT_KEY") or "KEY_Z"
    local sort_key = GLOBAL[sort_key_str]

    GLOBAL.TheInput:AddKeyUpHandler(sort_key, function()
        if GLOBAL.ThePlayer == nil then return end
        if GLOBAL.ThePlayer.HUD and GLOBAL.ThePlayer.HUD:HasInputFocus() then return end
        SendModRPCToServer(GetModRPC("inventory_sorter", "SortInventory"))
    end)
end
