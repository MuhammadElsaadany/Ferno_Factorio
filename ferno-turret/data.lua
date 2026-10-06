local ferno_turret_prototype = table.deepcopy(data.raw["ammo-turret"]["gun-turret"])

ferno_turret_prototype.name = "ferno-turret"
ferno_turret_prototype.icons = {
  {
    icon = ferno_turret_prototype.icon,
    icon_size = ferno_turret_prototype.icon_size,
    tint = {r=1,g=0,b=0,a=0.3}
  },
}

ferno_turret_prototype.attack_parameters.range = 1000
ferno_turret_prototype.attack_parameters.ammo_consumption_modifier = 0
ferno_turret_prototype.attack_parameters.cooldown = 0.05
--ferno_turret_prototype.attack_parameters.min_range = 0
ferno_turret_prototype.max_health = 100000
ferno_turret_prototype.healing_per_tick = 100000
ferno_turret_prototype.minable.result = "ferno-turret"

--
local ferno_turret_usable_entity = table.deepcopy(data.raw["item"]["gun-turret"])

ferno_turret_usable_entity.name = "ferno-turret"
ferno_turret_usable_entity.icons = {
  {
    icon = ferno_turret_prototype.icon,
    icon_size = ferno_turret_prototype.icon_size,
    tint = {r=1,g=0,b=0,a=0.3}
  },
}
ferno_turret_usable_entity.place_result = "ferno-turret"



--
local recipe = {
  type = "recipe",
  name = "ferno-turret",
  enabled = true,
  energy_required = 1,
  ingredients = {
    {type = "item", name = "copper-plate", amount = 200},
    {type = "item", name = "steel-plate", amount = 50}
  },
  results = {{type = "item", name = "ferno-turret", amount = 1}}
}

data:extend{ferno_turret_prototype, ferno_turret_usable_entity, recipe}
