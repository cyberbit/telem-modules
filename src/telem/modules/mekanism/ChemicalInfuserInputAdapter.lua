return function (api)
    local fn = api.vendor.fluent.fn

    local base = api.require 'mekanism.BaseMekanismInputAdapter'

    local ChemicalInfuserInputAdapter = base.mintAdapter('ChemicalInfuserInputAdapter')

    function ChemicalInfuserInputAdapter:beforeRegister ()
        self.prefix = 'mekcheminfuse:'

        self.queries = {
            basic = {
                input_left_item_count           = fn():call('getLeftInputItem'):get('count'):with('unit', 'item'),
                input_left_filled_percentage    = fn():call('getLeftInputFilledPercentage'),
                input_right_filled_percentage   = fn():call('getRightInputFilledPercentage'),
                input_right_item_count          = fn():call('getRightInputItem'):get('count'):with('unit', 'item'),
                output_filled_percentage        = fn():call('getOutputFilledPercentage'),
                output_item_count               = fn():call('getOutputItem'):get('count'):with('unit', 'item'),
                energy_usage                    = fn():call('getEnergyUsage'):joulesToFE():energyRate(),
            },
            input = {
                input_left                      = fn():call('getLeftInput'):get('amount'):div(1000):fluid(),
                input_left_capacity             = fn():call('getLeftInputCapacity'):div(1000):fluid(),
                input_left_needed               = fn():call('getLeftInputNeeded'):div(1000):fluid(),
                input_right                     = fn():call('getRightInput'):get('amount'):div(1000):fluid(),
                input_right_capacity            = fn():call('getRightInputCapacity'):div(1000):fluid(),
                input_right_needed              = fn():call('getRightInputNeeded'):div(1000):fluid(),
            },
            output = {
                output                          = fn():call('getOutput'):get('amount'):div(1000):fluid(),
                output_capacity                 = fn():call('getOutputCapacity'):div(1000):fluid(),
                output_needed                   = fn():call('getOutputNeeded'):div(1000):fluid(),
            }
        }
        
        self:withGenericMachineQueries()

        -- getDirection
        -- getRedstoneMode
    end

    return ChemicalInfuserInputAdapter
end