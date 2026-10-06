local ferno_turret = table.deepcopy(data.raw["ammo-turret"]["rocket-turret"])

ferno_turret.name = "ferno-turret"
ferno_turret.icons = {
  {
    icon = ferno_turret.icon,
    icon_size = ferno_turret.icon_size,
    tint = {r=1,g=0,b=0,a=0.3}
  },
}

ferno_turret.attack_parameters.range = 1000
ferno_turret.attack_parameters.ammo_consumption_modifier = 0
--ferno_turret.attack_parameters.cooldown = 6
--ferno_turret.attack_parameters.min_range = 0
ferno_turret.max_health = 100000
ferno_turret.healing_per_tick = 100000
ferno_turret.minable.result = "ferno-turret"

--
local ferno_turret_usable = table.deepcopy(data.raw["item"]["rocket-turret"])

ferno_turret_usable.name = "ferno-turret"
ferno_turret_usable.icons = {
  {
    icon = ferno_turret.icon,
    icon_size = ferno_turret.icon_size,
    tint = {r=1,g=0,b=0,a=0.3}
  },
}
ferno_turret_usable.place_result = "ferno-turret"



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

data:extend{ferno_turret, ferno_turret_usable, recipe}
