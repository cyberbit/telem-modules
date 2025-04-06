return function (api)
    local fn = api.vendor.fluent.fn

    local base = api.require 'mekanism.BaseMekanismInputAdapter'

    local MetallurgicInfuserInputAdapter = base.mintAdapter('MetallurgicInfuserInputAdapter')

    function MetallurgicInfuserInputAdapter:beforeRegister ()
        self.prefix = 'mekmetalinfuse:'

        self.queries = {
            basic = {
                input_count                 = fn():call('getInput'):get('count'):with('unit', 'item'),
                infuse_item_count           = fn():call('getInfuseTypeItem'):get('count'):with('unit', 'item'),
                infuse_filled_percentage    = fn():call('getInfuseTypeFilledPercentage'),
                output_count                = fn():call('getOutput'):get('count'):with('unit', 'item'),
                energy_usage                = fn():call('getEnergyUsage'):joulesToFE():energyRate(),
            },
            input = {
                infuse                      = fn():call('getInfuseType'):get('amount'):div(1000):fluid(),
                infuse_capacity             = fn():call('getInfuseTypeCapacity'):div(1000):fluid(),
                infuse_needed               = fn():call('getInfuseTypeNeeded'):div(1000):fluid(),
            }
        }
        
        self:withGenericMachineQueries()
            :withRecipeProgressQueries()

        -- getDirection
        -- getRedstoneMode
    end

    return MetallurgicInfuserInputAdapter
end