return function (api)
    local fn = api.vendor.fluent.fn

    local base = api.require 'mekanism.BaseMekanismInputAdapter'

    local CompressingFactoryInputAdapter = base.mintAdapter('CompressingFactoryInputAdapter')

    function CompressingFactoryInputAdapter:beforeRegister ()
        self.prefix = 'mekcompress:'

        local factorySize = self:getFactorySize()

        self.queries = {
            basic = {
                chemical_item_count         = fn():call('getChemicalItem'):get('count'):with('unit', 'item'),
                chemical_filled_percentage  = fn():call('getChemicalFilledPercentage'),
                input_count_sum             = base.mintSlotCountQuery(factorySize, 'getInput'):with('unit', 'item'),
                output_count_sum            = base.mintSlotCountQuery(factorySize, 'getOutput'):with('unit', 'item'),
                energy_usage                = fn():call('getEnergyUsage'):joulesToFE():energyRate(),
            },
            advanced = {
                auto_sort                   = fn():call('isAutoSortEnabled'):toFlag(),
            },
            input = {
                chemical                    = fn():call('getChemical'):get('amount'):div(1000):fluid(),
                chemical_capacity           = fn():call('getChemicalCapacity'):div(1000):fluid(),
                chemical_needed             = fn():call('getChemicalNeeded'):div(1000):fluid(),
            },
        }
        
        self:withGenericMachineQueries()
            :withRecipeProgressQueries(factorySize)

        -- getDirection
        -- getRedstoneMode
    end

    return CompressingFactoryInputAdapter
end