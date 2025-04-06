return function (api)
    local fn = api.vendor.fluent.fn

    local base = api.require 'mekanism.BaseMekanismInputAdapter'

    local ElectrolyticSeparatorInputAdapter = base.mintAdapter('ElectrolyticSeparatorInputAdapter')

    function ElectrolyticSeparatorInputAdapter:beforeRegister ()
        self.prefix = 'mekseparator:'

        self.queries = {
            basic = {
                input_filled_percentage         = fn():call('getInputFilledPercentage'),
                input_item_count                = fn():call('getInputItem'):get('count'):with('unit', 'item'),
                output_left_filled_percentage   = fn():call('getLeftOutputFilledPercentage'),
                output_left_item_count          = fn():call('getLeftOutputItem'):get('count'):with('unit', 'item'),
                output_right_filled_percentage  = fn():call('getRightOutputFilledPercentage'),
                output_right_item_count         = fn():call('getRightOutputItem'):get('count'):with('unit', 'item'),
                energy_usage                    = fn():call('getEnergyUsage'):joulesToFE():energyRate(),
            },
            input = {
                input                           = fn():call('getInput'):get('amount'):div(1000):fluid(),
                input_capacity                  = fn():call('getInputCapacity'):div(1000):fluid(),
                input_needed                    = fn():call('getInputNeeded'):div(1000):fluid(),
            },
            output = {
                output_left                     = fn():call('getLeftOutput'):get('amount'):div(1000):fluid(),
                output_left_capacity            = fn():call('getLeftOutputCapacity'):div(1000):fluid(),
                output_left_needed              = fn():call('getLeftOutputNeeded'):div(1000):fluid(),
                output_right                    = fn():call('getRightOutput'):get('amount'):div(1000):fluid(),
                output_right_capacity           = fn():call('getRightOutputCapacity'):div(1000):fluid(),
                output_right_needed             = fn():call('getRightOutputNeeded'):div(1000):fluid(),
            },
        }
        
        self:withGenericMachineQueries()

        -- getDirection
        -- getRedstoneMode
    end

    return ElectrolyticSeparatorInputAdapter
end