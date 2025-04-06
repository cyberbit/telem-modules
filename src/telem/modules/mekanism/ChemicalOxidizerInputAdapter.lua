return function (api)
    local fn = api.vendor.fluent.fn

    local base = api.require 'mekanism.BaseMekanismInputAdapter'

    local ChemicalOxidizerInputAdapter = base.mintAdapter('ChemicalOxidizerInputAdapter')

    function ChemicalOxidizerInputAdapter:beforeRegister ()
        self.prefix = 'mekoxidizer:'

        self.queries = {
            basic = {
                input_count                 = fn():call('getInput'):get('count'):with('unit', 'item'),
                output_filled_percentage    = fn():call('getOutputFilledPercentage'),
                output_item_count           = fn():call('getOutputItem'):get('count'):with('unit', 'item'),
                energy_usage                = fn():call('getEnergyUsage'):joulesToFE():energyRate(),
            },
            output = {
                output                      = fn():call('getOutput'):get('amount'):div(1000):fluid(),
                output_capacity             = fn():call('getOutputCapacity'):div(1000):fluid(),
                output_needed               = fn():call('getOutputNeeded'):div(1000):fluid(),
            }
        }
        
        self:withGenericMachineQueries()
            :withRecipeProgressQueries()

        -- getDirection
        -- getRedstoneMode
    end

    return ChemicalOxidizerInputAdapter
end