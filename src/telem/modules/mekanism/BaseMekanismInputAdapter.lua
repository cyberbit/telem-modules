return function (api)
    local fl = api.vendor.fluent
    local fn = fl.fn

    local BaseMekanismInputAdapter = api.mintInput('BaseMekanismInputAdapter')

    function BaseMekanismInputAdapter:constructor (peripheralName, categories)
        self:super('constructor')

        self.prefix = 'mek:'

        self.categories = categories or { 'basic' }

        ---@type table<string, table<string, cyberbit.Fluent>>
        self.queries = {}

        ---@type cyberbit.Fluent[]
        self.storageQueries = {}

        -- boot components
        self:setBoot(function ()
            self.components = {}

            self:addComponentByPeripheralID(peripheralName)
        end)()

        self:beforeRegister()

        self:register()
    end

    function BaseMekanismInputAdapter:beforeRegister ()
        -- nothing by default, should be overridden by subclasses
    end

    function BaseMekanismInputAdapter:register ()
        local allCategories = fl(self.queries):keys():result()

        if self.categories == '*' then
            self.categories = allCategories
        elseif type(self.categories) == 'table' then
            self.categories = fl(self.categories):intersect(allCategories):result()
        else
            error('categories must be a list of categories or "*"')
        end

        return self
    end

    function BaseMekanismInputAdapter:getFactorySize ()
        local _, component = next(self.components)

        return fn()
            :from({ 9, 7, 5, 3 })
            :first(function (_, v)
                return component and pcall(component.getRecipeProgress, v - 1)
            end)
            :result()
    end

    --- Adds queries for multiblock structures.
    ---
    --- Categories: formation
    function BaseMekanismInputAdapter:withMultiblockQueries ()
        self.queries.formation = self.queries.formation or {}

        -- multiblock
        self.queries.formation.formed   = fn():call('isFormed'):toFlag()
        
        -- multiblock (formed)
        self.queries.formation.height   = fn():call('getHeight'):with('unit', 'm')
        self.queries.formation.length   = fn():call('getLength'):with('unit', 'm')
        self.queries.formation.width    = fn():call('getWidth'):with('unit', 'm')

        return self
    end

    --- Adds queries for generic machines.
    ---
    --- Categories: basic, advanced, energy
    function BaseMekanismInputAdapter:withGenericMachineQueries ()
        self.queries.basic = self.queries.basic or {}
        self.queries.advanced = self.queries.advanced or {}
        self.queries.energy = self.queries.energy or {}

        self.queries.basic.energy_filled_percentage = fn():call('getEnergyFilledPercentage')

        self.queries.advanced.comparator_level      = fn():call('getComparatorLevel')

        self.queries.energy.energy                  = fn():call('getEnergy'):joulesToFE():energy()
        self.queries.energy.max_energy              = fn():call('getMaxEnergy'):joulesToFE():energy()
        self.queries.energy.energy_needed           = fn():call('getEnergyNeeded'):joulesToFE():energy()

        -- getDirection
        -- getRedstoneMode

        return self
    end

    --- Adds queries for generators.
    ---
    --- Categories: basic, energy
    function BaseMekanismInputAdapter:withGeneratorQueries ()
        self.queries.basic = self.queries.basic or {}
        self.queries.energy = self.queries.energy or {}

        self.queries.basic.production_rate      = fn():call('getProductionRate'):joulesToFE():energyRate()

        self.queries.energy.max_energy_output   = fn():call('getMaxOutput'):joulesToFE():energyRate()

        return self
    end

    --- Adds queries for machines with recipes. If `factorySize` is provided,
    --- each process will have its own recipe progress metric.
    ---
    --- Categories: recipe
    ---@param factorySize? integer Factory size
    function BaseMekanismInputAdapter:withRecipeProgressQueries (factorySize)
        self.queries.recipe = self.queries.recipe or {}

        self.queries.recipe.ticks_required  = fn():call('getTicksRequired'):with('unit', 't')
        
        if not factorySize then
            self.queries.recipe.recipe_progress = fn():call('getRecipeProgress'):with('unit', 't')
        else
            assert(type(factorySize) == 'number', 'factorySize must be a number')

            for i = 0, factorySize - 1 do
                self.queries.recipe['recipe_progress_' .. i] = fn():call('getRecipeProgress', i):with('unit', 't')
            end
        end

        return self
    end

    local function queueHelper (results, index, query)
        return function ()
            results[index] = api.Metric(query:metricable():result())
        end
    end

    function BaseMekanismInputAdapter:read ()
        self:boot()
        
        local source, component = next(self.components)

        local tempMetrics = {}
        local queue = {}

        -- execute single-metric queries from a queue
        for _, category in ipairs(self.categories) do
            for k, v in pairs(self.queries[category]) do
                table.insert(queue, queueHelper(
                    tempMetrics,
                    #queue + 1,
                    v:from(component):with('name', self.prefix .. k):with('source', source)
                ))
            end
        end

        parallel.waitForAll(table.unpack(queue))

        -- execute storage queries, which may return multiple metrics
        -- these have no category and are always included
        for k, v in pairs(self.storageQueries) do
            local tempResult = v:from(component):result()

            for _, metric in ipairs(tempResult) do
                metric.name = 'storage:' .. metric.name
                metric.source = source

                table.insert(tempMetrics, metric)
            end
        end

        return api.MetricCollection(table.unpack(tempMetrics))
    end

    ------ Static Methods ------

    function BaseMekanismInputAdapter.mintAdapter (type)
        local adapter = api.ObjectModel.class(BaseMekanismInputAdapter)
        adapter.type = type

        function adapter:constructor (peripheralName, categories)
            self:super('constructor', peripheralName, categories)
        end

        return adapter
    end

    function BaseMekanismInputAdapter.mintSlotUsageQuery (getSlotsMethodName, getSlotItemMethodName)
        local function processSlot(method, slots, component, slot)
            return function ()
                slots[slot] = component[method](slot) or false
            end
        end

        return fn()
            :transform(function (v)
                local slots = {}
                
                local queue = {}
                for i = 0, v[getSlotsMethodName]() - 1 do
                    table.insert(queue, processSlot(getSlotItemMethodName, slots, v, i))
                end

                parallel.waitForAll(table.unpack(queue))

                return slots
            end)
            :reduce(function (initial, _, v)
                if v and v.count and tonumber(v.count) > 0 then
                    return initial + 1
                else
                    return initial
                end
            end, 0)
    end

    function BaseMekanismInputAdapter.mintSlotCountQuery (slotCount, getSlotItemMethodName)
        local function processSlot(method, slots, component, slot)
            return function ()
                slots[slot] = component[method](slot) or false
            end
        end
        
        return fn()
            :transform(function (v)
                local slots = {}
                
                local queue = {}
                for i = 0, slotCount - 1 do
                    table.insert(queue, processSlot(getSlotItemMethodName, slots, v, i))
                end
        
                parallel.waitForAll(table.unpack(queue))
        
                return slots
            end)
            :sum('count')
    end

    return BaseMekanismInputAdapter
end