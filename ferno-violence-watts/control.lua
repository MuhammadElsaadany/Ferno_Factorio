local function init_storage()
    storage.violence_batteries = storage.violence_batteries or {}
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

local max_distance = 1000 -- will un-hardcode it later to make it into mod settings!
local max_distance_squared = max_distance * max_distance

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


script.on_event(build_events, function(event)  -- need to filter this later for optimization
    init_storage()
    local entity = event.entity
    if not entity or not entity.valid then return end
    if entity.name == "violence-battery" then
        storage.violence_batteries[entity.unit_number] = entity
    end
end)

script.on_event(demolish_events, function(event)  -- need to filter this later for optimization
    init_storage()
    local entity = event.entity
    if not entity or not entity.valid then return end
    if entity.name == "violence-battery" then
        storage.violence_batteries[entity.unit_number] = nil
    end
end)

script.on_event(defines.events.on_entity_damaged, function(event) -- need to filter this later for optimization

    if not event.entity.valid then return end
    if not event.force or event.entity.force.name ~= "enemy" or event.force.name ~= "player" then return end
    if not storage.violence_batteries then return end

    local energy_scale = event.final_damage_amount / 10 -- make this into mod settings too
    local position = event.entity.position
    local surface_index = event.entity.surface_index

    for key, battery in pairs(storage.violence_batteries) do
        if not battery.valid then
            storage.violence_batteries[key] = nil
        else
            if surface_index == battery.surface_index then
                local dx = position.x - battery.position.x
                local dy = position.y - battery.position.y
                if dx*dx + dy*dy <= max_distance_squared then battery.energy = battery.energy + energy_scale end
            end
        end
    end
end)