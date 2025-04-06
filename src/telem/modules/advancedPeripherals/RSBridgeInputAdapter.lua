return function (api)
    local fn = api.vendor.fluent.fn

    local base = api.require 'advancedPeripherals.BaseAdvancedPeripheralsInputAdapter'

    local RSBridgeInputAdapter = base.mintAdapter('RSBridgeInputAdapter')

    function RSBridgeInputAdapter:beforeRegister (peripheralName, categories)
        self.prefix = 'aprsbridge:'

        self.queries = {
            basic = {
                energy_usage                = fn():call('getEnergyUsage'):energyRate(),
            },
            energy = {
                energy                      = fn():call('getEnergyStorage'):energy(),
                max_energy                  = fn():call('getMaxEnergyStorage'):energy(),
            },
            storage = {
                item_disk_capacity          = fn():call('getMaxItemDiskStorage'):with('unit', 'item'),
                item_external_capacity      = fn():call('getMaxItemExternalStorage'):with('unit', 'item'),
                fluid_disk_capacity         = fn():call('getMaxFluidDiskStorage'):div(1000):with('unit', 'B'),

                -- TODO not sure what is compatible with this
                fluid_external_capacity     = fn():call('getMaxFluidExternalStorage'):div(1000):with('unit', 'B'),
            },
        }

        self.storageQueries = {
            -- items
            fn():call('listItems'):mapValues(function (v)
                return api.Metric{ name = v.name, value = v.amount, unit = 'item' }
            end),
            
            -- fluids
            fn():call('listFluids'):mapValues(function (v)
                return api.Metric{ name = v.name, value = v.amount / 1000, unit = 'B' }
            end),
        }
    end

    return RSBridgeInputAdapter
end