return function (api)
    local fn = api.vendor.fluent.fn

    local base = api.require 'mekanism.BaseMekanismInputAdapter'

    local FuelwoodHeaterInputAdapter = base.mintAdapter('FuelwoodHeaterInputAdapter')

    function FuelwoodHeaterInputAdapter:beforeRegister ()
        self.prefix = 'mekfuelheater:'

        self.queries = {
            basic = {
                fuel_count                  = fn():call('getFuelItem'):get('count'):with('unit', 'item'),
                temperature                 = fn():call('getTemperature'):temp(),
            },
            advanced = {
                environmental_loss          = fn():call('getEnvironmentalLoss'),
            },
        }

        -- TODO only supports direction
        -- self:withGenericMachineQueries()

        -- getDirection
    end

    return FuelwoodHeaterInputAdapter
end