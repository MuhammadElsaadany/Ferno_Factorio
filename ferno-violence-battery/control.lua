local function init_storage()
    storage.violence_batteries = storage.violence_batteries or {}
    storage.stored_damage = storage.stored_damage or {}
end


local function scan_existing()
    for _, surface in pairs(game.surfaces) do
        local entities_filtered = surface.find_entities_filtered{name = "violence-battery"}
        for _, entity in pairs(entities_filtered) do
            storage.violence_batteries[entity.unit_number] = entity
        end
    end
end


script.on_init(function()
    init_storage()
end)


script.on_configuration_changed(function(data)
    init_storage()
    scan_existing()
end)

local efficiency = settings.startup["ferno-violence-battery-violence-batteries-efficiency"].value
efficiency = tonumber(efficiency) or 1000 -- the default efficiency

local build_events = {
    defines.events.on_built_entity,
    defines.events.on_robot_built_entity,
    defines.events.script_raised_built,
    defines.events.script_raised_revive
}


local demolish_events = {
    defines.events.on_player_mined_entity,
    defines.events.on_robot_mined_entity,
    defines.events.on_entity_died,
    defines.events.script_raised_destroy
}


script.on_event(build_events, function(event)
    init_storage()
    local entity = event.entity
    if not entity or not entity.valid then return end
    if entity.name == "violence-battery" then
        storage.violence_batteries[entity.unit_number] = entity
    end
end)


script.on_event(demolish_events, function(event)
    init_storage()
    local entity = event.entity
    if not entity or not entity.valid then return end
    if entity.name == "violence-battery" then
        storage.violence_batteries[entity.unit_number] = nil
    end
end)


script.on_event(defines.events.on_entity_damaged, function(event)

    if not event.entity.valid then return end
    if not event.force or event.entity.force.name ~= "enemy" or event.force.name ~= "player" then return end
    init_storage()

    local energy_gain = event.final_damage_amount * efficiency
    local surface_index = event.entity.surface_index
    local current_stored_damage = storage.stored_damage[surface_index] or 0

    storage.stored_damage[surface_index] = current_stored_damage + energy_gain

end)


script.on_nth_tick(30, function (event)
    if not storage.violence_batteries then return end
    if not storage.stored_damage then return end


    for surface_index, damage in pairs(storage.stored_damage) do

        if damage > 0 then
            local number_of_batteries = 0

            for key, battery in pairs(storage.violence_batteries) do
                if not battery.valid then
                    storage.violence_batteries[key] = nil
                else
                    if surface_index == battery.surface_index then
                        if battery.energy < battery.electric_buffer_size then number_of_batteries = number_of_batteries + 1 end
                    end
                end
            end
            
            if number_of_batteries > 0 then
                for _, battery in pairs(storage.violence_batteries) do
                    if surface_index == battery.surface_index then
                        if battery.energy < battery.electric_buffer_size then
                            battery.energy = battery.energy + damage / number_of_batteries
                        end
                    end
                end
            end

            storage.stored_damage[surface_index] = 0
        end
    end
end)