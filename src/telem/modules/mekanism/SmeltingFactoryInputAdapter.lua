return function (api)
    local fn = api.vendor.fluent.fn

    local base = api.require 'mekanism.BaseMekanismInputAdapter'

    local SmeltingFactoryInputAdapter = base.mintAdapter('SmeltingFactoryInputAdapter')

    function SmeltingFactoryInputAdapter:beforeRegister ()
        self.prefix = 'meksmelt:'

        local factorySize = self:getFactorySize()

        self.queries = {
            basic = {
                input_count_sum     = base.mintSlotCountQuery(factorySize, 'getInput'):with('unit', 'item'),
                output_count_sum    = base.mintSlotCountQuery(factorySize, 'getOutput'):with('unit', 'item'),
                energy_usage        = fn():call('getEnergyUsage'):joulesToFE():energyRate(),
            },
            advanced = {
                auto_sort           = fn():call('isAutoSortEnabled'):toFlag(),
            }
        }
        
        self:withGenericMachineQueries()
            :withRecipeProgressQueries(factorySize)

        -- getDirection
        -- getRedstoneMode
    end

    return SmeltingFactoryInputAdapter
end