return function (api)
    local fn = api.vendor.fluent.fn

    local base = api.require 'mekanism.BaseMekanismInputAdapter'

    local BioGeneratorInputAdapter = base.mintAdapter('BioGeneratorInputAdapter')

    function BioGeneratorInputAdapter:beforeRegister ()
        self.prefix = 'mekbiogen:'

        self.queries = {
            basic = {
                bio_fuel_filled_percentage  = fn():call('getBioFuelFilledPercentage'),
                bio_fuel_item_count         = fn():call('getFuelItem'):get('count'):with('unit', 'item'),
            },
            fuel = {
                bio_fuel                    = fn():call('getBioFuel'):get('amount'):div(1000):fluid(),
                bio_fuel_capacity           = fn():call('getBioFuelCapacity'):div(1000):fluid(),
                bio_fuel_needed             = fn():call('getBioFuelNeeded'):div(1000):fluid(),
            }
        }
        
        self:withGenericMachineQueries()
            :withGeneratorQueries()
    end

    return BioGeneratorInputAdapter
end