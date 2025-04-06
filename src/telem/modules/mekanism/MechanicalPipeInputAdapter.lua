return function (api)
    local fn = api.vendor.fluent.fn

    local base = api.require 'mekanism.BaseMekanismInputAdapter'

    local MechanicalPipeInputAdapter = base.mintAdapter('MechanicalPipeInputAdapter')

    function MechanicalPipeInputAdapter:beforeRegister ()
        self.prefix = 'mekpipe:'

        self.queries = {
            basic = {
                filled_percentage   = fn():call('getFilledPercentage')
            },
            transfer = {
                buffer              = fn():call('getBuffer'):get('amount'):div(1000):fluid(),
                capacity            = fn():call('getCapacity'):div(1000):fluid(),
                needed              = fn():call('getNeeded'):div(1000):fluid(),
            }
        }
    end

    return MechanicalPipeInputAdapter
end