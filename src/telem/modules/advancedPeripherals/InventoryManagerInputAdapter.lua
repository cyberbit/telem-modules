return function (api)
    local fn = api.vendor.fluent.fn

    local base  = api.require 'advancedPeripherals.BaseAdvancedPeripheralsInputAdapter'

    local InventoryManagerInputAdapter = base.mintAdapter('InventoryManagerInputAdapter')

    function InventoryManagerInputAdapter:beforeRegister (peripheralName, categories)
        self.prefix = 'apinv:'

        local armor = fn():call('getArmor')

        self.queries = {
            basic = {
                equipped                     = fn():call('isPlayerEquipped'):toFlag(),
                equipped_helmet              = armor:firstWhere('slot', 103):toFlag(),
                equipped_chestplate          = armor:firstWhere('slot', 102):toFlag(),
                equipped_leggings            = armor:firstWhere('slot', 101):toFlag(),
                equipped_boots               = armor:firstWhere('slot', 100):toFlag(),
                inventory_available          = fn():call('isSpaceAvailable'):toFlag(),
                inventory_slots_available    = fn():call('getEmptySpace'),
            },
        }

        self.storageQueries = {
            fn():call('getItems')
                :sum('count', 'name')
                :map(function (k, v) return api.Metric{ name = k, value = v, unit = 'item' } end)
                :values()
        }
    end

    return InventoryManagerInputAdapter
end