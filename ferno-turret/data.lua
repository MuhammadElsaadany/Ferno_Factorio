local ferno_turret_prototype = table.deepcopy(data.raw["ammo-turret"]["gun-turret"])

ferno_turret_prototype.name = "ferno-turret"
ferno_turret_prototype.icons = {
	{
    icon = ferno_turret_prototype.icon,
    icon_size = ferno_turret_prototype.icon_size,
    tint = {r=1,g=0,b=0,a=0.3}
	},
}

local turret_range = settings.startup["ferno-turret-turret-range"].value
if type(turret_range) ~= "number" then return end

ferno_turret_prototype.attack_parameters.range = turret_range
ferno_turret_prototype.attack_parameters.ammo_consumption_modifier = 0
ferno_turret_prototype.attack_parameters.cooldown = 0.05
ferno_turret_prototype.minable.result = "ferno-turret"

--
local ferno_turret_item = table.deepcopy(data.raw["item"]["gun-turret"])

ferno_turret_item.name = "ferno-turret"
ferno_turret_item.icons = {
	{
    icon = ferno_turret_prototype.icon,
    icon_size = ferno_turret_prototype.icon_size,
    tint = {r=1,g=0,b=0,a=0.3}
	},
}
ferno_turret_item.place_result = "ferno-turret"



--
local recipe = {
	type = "recipe",
	name = "ferno-turret",
	enabled = false,
	energy_required = 60,
	ingredients = {
		{type = "item", name = "copper-plate", amount = 50},
		{type = "item", name = "iron-plate", amount = 200}
  	},
	results = {{type = "item", name = "ferno-turret", amount = 1}}
}

table.insert(data.raw.technology["gun-turret"].effects,
	{ type = "unlock-recipe", recipe = "ferno-turret" })

data:extend{ferno_turret_prototype, ferno_turret_item, recipe}
