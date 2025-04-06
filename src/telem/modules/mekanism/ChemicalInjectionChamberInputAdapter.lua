return function (api)
    local fn = api.vendor.fluent.fn

    local base = api.require 'mekanism.BaseMekanismInputAdapter'

    local ChemicalInjectionChamberInputAdapter = base.mintAdapter('ChemicalInjectionChamberInputAdapter')

    function ChemicalInjectionChamberInputAdapter:beforeRegister ()
        self.prefix = 'mekinject:'

        self.queries = {
            basic = {
                chemical_filled_percentage  = fn():call('getChemicalFilledPercentage'),
                input_count                 = fn():call('getInput'):get('count'):with('unit', 'item'),
                chemical_item_count         = fn():call('getChemicalItem'):get('count'):with('unit', 'item'),
                output_count                = fn():call('getOutput'):get('count'):with('unit', 'item'),
                energy_usage                = fn():call('getEnergyUsage'):joulesToFE():energyRate(),
            },
            input = {
                chemical                    = fn():call('getChemical'):get('amount'):div(1000):fluid(),
                chemical_capacity           = fn():call('getChemicalCapacity'):div(1000):fluid(),
                chemical_needed             = fn():call('getChemicalNeeded'):div(1000):fluid(),
            }
        }
        
        self:withGenericMachineQueries()
            :withRecipeProgressQueries()

        -- getDirection
        -- getRedstoneMode
    end

    return ChemicalInjectionChamberInputAdapter
end