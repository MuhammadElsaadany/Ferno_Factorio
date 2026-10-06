-- auto load atomic bombs to new placed ferno turrets, but can be used to dupe ammo if you keep picking it up
local build_events = {
  defines.events.on_built_entity,
  defines.events.on_robot_built_entity,
  defines.events.script_raised_built,
  defines.events.script_raised_revive
}

script.on_event(build_events, function(event)
  local entity = event.entity
  if not entity or not entity.valid then return end

  if entity.name == "ferno-turret" then
    local inventory = entity.get_inventory(defines.inventory.turret_ammo)
    if inventory then
      inventory.insert({name = "firearm-magazine", count = 1})
    end
  end
end)
