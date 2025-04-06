return function (api)
    local fn = api.vendor.fluent.fn

    local base = api.require 'mekanism.BaseMekanismInputAdapter'

    local SolarGeneratorInputAdapter = base.mintAdapter('SolarGeneratorInputAdapter')

    function SolarGeneratorInputAdapter:beforeRegister ()
        self.prefix = 'meksolargen:'

        self.queries = {
            basic = {
                sees_sun = fn():call('canSeeSun'):toFlag(),
            },
        }
        
        self:withGenericMachineQueries()
            :withGeneratorQueries()

        -- getDirection
        -- getRedstoneMode
    end

    return SolarGeneratorInputAdapter
end