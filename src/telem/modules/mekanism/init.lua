return function (api)
    return {
        input = {
            -- machines
            apns                    = api.require 'mekanism.AntiprotonicNucleosynthesizerInputAdapter',
            bin                     = api.require 'mekanism.BinInputAdapter',
            bioGenerator            = api.require 'mekanism.BioGeneratorInputAdapter',
            boiler                  = api.require 'mekanism.ThermoelectricBoilerInputAdapter',
            chemicalCrystallizer    = api.require 'mekanism.ChemicalCrystallizerInputAdapter',
            dissolutionChamber      = api.require 'mekanism.ChemicalDissolutionChamberInputAdapter',
            chemicalInfuser         = api.require 'mekanism.ChemicalInfuserInputAdapter',
            injectionChamber        = api.require 'mekanism.ChemicalInjectionChamberInputAdapter',
            chemicalOxidizer        = api.require 'mekanism.ChemicalOxidizerInputAdapter',
            chemicalTank            = api.require 'mekanism.ChemicalTankInputAdapter',
            chemicalWasher          = api.require 'mekanism.ChemicalWasherInputAdapter',
            combiner                = api.require 'mekanism.CombinerInputAdapter',
            crusher                 = api.require 'mekanism.CrusherInputAdapter',
            digitalMiner            = api.require 'mekanism.DigitalMinerInputAdapter',
            dynamicTank             = api.require 'mekanism.DynamicTankInputAdapter',
            electricPump            = api.require 'mekanism.ElectricPumpInputAdapter',
            electrolyticSeparator   = api.require 'mekanism.ElectrolyticSeparatorInputAdapter',
            energizedSmelter        = api.require 'mekanism.EnergizedSmelterInputAdapter',
            energyCube              = api.require 'mekanism.EnergyCubeInputAdapter',
            enrichmentChamber       = api.require 'mekanism.EnrichmentChamberInputAdapter',
            fissionReactor          = api.require 'mekanism.FissionReactorInputAdapter',
            fluidTank               = api.require 'mekanism.FluidTankInputAdapter',
            fluidicPlenisher        = api.require 'mekanism.FluidicPlenisherInputAdapter',
            assemblicator           = api.require 'mekanism.FormulaicAssemblicatorInputAdapter',
            fuelwoodHeater          = api.require 'mekanism.FuelwoodHeaterInputAdapter',
            fusionReactor           = api.require 'mekanism.FusionReactorInputAdapter',
            gasGenerator            = api.require 'mekanism.GasGeneratorInputAdapter',
            heatGenerator           = api.require 'mekanism.HeatGeneratorInputAdapter',
            inductionMatrix         = api.require 'mekanism.InductionMatrixInputAdapter',
            industrialTurbine       = api.require 'mekanism.IndustrialTurbineInputAdapter',
            isotopicCentrifuge      = api.require 'mekanism.IsotopicCentrifugeInputAdapter',
            laser                   = api.require 'mekanism.LaserInputAdapter',
            laserAmplifier          = api.require 'mekanism.LaserAmplifierInputAdapter',
            laserTractorBeam        = api.require 'mekanism.LaserTractorBeamInputAdapter',
            logisticalSorter        = api.require 'mekanism.LogisticalSorterInputAdapter',
            mechanicalPipe          = api.require 'mekanism.MechanicalPipeInputAdapter',
            metallurgicInfuser      = api.require 'mekanism.MetallurgicInfuserInputAdapter',
            nutritionalLiquifier    = api.require 'mekanism.NutritionalLiquifierInputAdapter',
            oredictionificator      = api.require 'mekanism.OredictionificatorInputAdapter',
            osmiumCompressor        = api.require 'mekanism.OsmiumCompressorInputAdapter',
            paintingMachine         = api.require 'mekanism.PaintingMachineInputAdapter',
            pigmentExtractor        = api.require 'mekanism.PigmentExtractorInputAdapter',
            pigmentMixer            = api.require 'mekanism.PigmentMixerInputAdapter',
            precisionSawmill        = api.require 'mekanism.PrecisionSawmillInputAdapter',
            reactionChamber         = api.require 'mekanism.PressurizedReactionChamberInputAdapter',
            pressurizedTube         = api.require 'mekanism.PressurizedTubeInputAdapter',
            purificationChamber     = api.require 'mekanism.PurificationChamberInputAdapter',
            quantumEntangloporter   = api.require 'mekanism.QuantumEntangloporterInputAdapter',
            wasteBarrel             = api.require 'mekanism.RadioactiveWasteBarrelInputAdapter',
            resistiveHeater         = api.require 'mekanism.ResistiveHeaterInputAdapter',
            condensentrator         = api.require 'mekanism.RotaryCondensentratorInputAdapter',
            sps                     = api.require 'mekanism.SupercriticalPhaseShifterInputAdapter',
            seismicVibrator         = api.require 'mekanism.SeismicVibratorInputAdapter',
            solarGenerator          = api.require 'mekanism.SolarGeneratorInputAdapter',
            neutronActivator        = api.require 'mekanism.SolarNeutronActivatorInputAdapter',
            teleporter              = api.require 'mekanism.TeleporterInputAdapter',
            evaporationPlant        = api.require 'mekanism.ThermalEvaporationPlantInputAdapter',
            universalCable          = api.require 'mekanism.UniversalCableInputAdapter',
            windGenerator           = api.require 'mekanism.WindGeneratorInputAdapter',

            -- factories
            combiningFactory        = api.require 'mekanism.CombiningFactoryInputAdapter',
            compressingFactory      = api.require 'mekanism.CompressingFactoryInputAdapter',
            crushingFactory         = api.require 'mekanism.CrushingFactoryInputAdapter',
            enrichingFactory        = api.require 'mekanism.EnrichingFactoryInputAdapter',
            infusingFactory         = api.require 'mekanism.InfusingFactoryInputAdapter',
            injectingFactory        = api.require 'mekanism.InjectingFactoryInputAdapter',
            purifyingFactory        = api.require 'mekanism.PurifyingFactoryInputAdapter',
            sawingFactory           = api.require 'mekanism.SawingFactoryInputAdapter',
            smeltingFactory         = api.require 'mekanism.SmeltingFactoryInputAdapter',

            -- QIO
            qioDriveArray           = api.require 'mekanism.QIODriveArrayInputAdapter',
        }
    }
end