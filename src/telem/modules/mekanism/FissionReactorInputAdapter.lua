return function (api)
    local fn = api.vendor.fluent.fn

    local base = api.require 'mekanism.BaseMekanismInputAdapter'

    local FissionReactorInputAdapter = base.mintAdapter('FissionReactorInputAdapter')

    function FissionReactorInputAdapter:beforeRegister ()
        self.prefix = 'mekfission:'

        self.queries = {
            basic = {
                status                              = fn():call('getStatus'):toFlag(),
                burn_rate                           = fn():call('getBurnRate'):div(1000):fluidRate(),
                max_burn_rate                       = fn():call('getMaxBurnRate'):div(1000):fluidRate(),
                temperature                         = fn():call('getTemperature'):temp(),
                damage_percent                      = fn():call('getDamagePercent'),
                fuel_filled_percentage              = fn():call('getFuelFilledPercentage'),
                coolant_filled_percentage           = fn():call('getCoolantFilledPercentage'),
                heated_coolant_filled_percentage    = fn():call('getHeatedCoolantFilledPercentage'),
                waste_filled_percentage             = fn():call('getWasteFilledPercentage')
            },
            advanced = {
                actual_burn_rate                    = fn():call('getActualBurnRate'):div(1000):fluidRate(),
                environmental_loss                  = fn():call('getEnvironmentalLoss'),
                heating_rate                        = fn():call('getHeatingRate'):div(1000):fluidRate(),
            },
            coolant = {
                coolant                             = fn():call('getCoolant'):get('amount'):div(1000):fluid(),
                coolant_capacity                    = fn():call('getCoolantCapacity'):div(1000):fluid(),
                coolant_needed                      = fn():call('getCoolantNeeded'):div(1000):fluid(),
                heated_coolant                      = fn():call('getHeatedCoolant'):get('amount'):div(1000):fluid(),
                heated_coolant_capacity             = fn():call('getHeatedCoolantCapacity'):div(1000):fluid(),
                heated_coolant_needed               = fn():call('getHeatedCoolantNeeded'):div(1000):fluid()
            },
            fuel = {
                fuel                                = fn():call('getFuel'):get('amount'):div(1000):fluid(),
                fuel_capacity                       = fn():call('getFuelCapacity'):div(1000):fluid(),
                fuel_needed                         = fn():call('getFuelNeeded'):div(1000):fluid()
            },
            waste = {
                waste                               = fn():call('getWaste'):get('amount'):div(1000):fluid(),
                waste_capacity                      = fn():call('getWasteCapacity'):div(1000):fluid(),
                waste_needed                        = fn():call('getWasteNeeded'):div(1000):fluid()
            },
            formation = {
                force_disabled                      = fn():call('isForceDisabled'):toFlag(),
                fuel_assemblies                     = fn():call('getFuelAssemblies'),
                fuel_surface_area                   = fn():call('getFuelSurfaceArea'):with('unit', 'm²'),
                heat_capacity                       = fn():call('getHeatCapacity'):with('unit', 'J/K'),
                boil_efficiency                     = fn():call('getBoilEfficiency'),
            }
        }

        self:withMultiblockQueries()

        -- getMinPos
        -- getRedstoneMode
        -- getMaxPos
        -- getRedstoneLogicStatus
        -- getLogicMode
    end

    return FissionReactorInputAdapter
end