-------------------- THE PROTOTYPE --------------------
local violence_battery_prototype = table.deepcopy(data.raw["accumulator"]["accumulator"])

violence_battery_prototype.name = "violence-battery"
violence_battery_prototype.icons = {{
	icon = violence_battery_prototype.icon,
	tint = {r=0,g=0.5,b=0.5,a=0.3}}
,}

violence_battery_prototype.energy_source = {
	type = "electric",
	buffer_capacity = "1QJ", -- equals 1e30
	usage_priority = "primary-output",
	input_flow_limit = "0W",
	output_flow_limit = "1QW"
}

local radius_value = tostring(settings.startup["ferno-violence-watts-violence-batteries-radius"].value)
local efficiency_value = {"", tostring(settings.startup["ferno-violence-watts-violence-batteries-efficiency"].value), "%"}

violence_battery_prototype.custom_tooltip_fields = {
	{ name = {"tooltip-category.radius-label"}, value = radius_value, order = 1, quality_header = nil, quality_values = nil, show_in_factoriopedia = true, show_in_tooltip = true},
	{ name = {"tooltip-category.efficiency-label"}, value = efficiency_value, order = 2, quality_header = nil, quality_values = nil, show_in_factoriopedia = true, show_in_tooltip = true}
}

violence_battery_prototype.minable.result = "violence-battery"

-------------------- THE ITEM --------------------
local violence_battery_item = table.deepcopy(data.raw["item"]["accumulator"])

violence_battery_item.name = "violence-battery"
violence_battery_item.icons = {{
    icon = violence_battery_prototype.icon,
    tint = {r=0,g=0.5,b=0.5,a=0.3}}
,}

violence_battery_item.place_result = "violence-battery"

-------------------- THE RECIPE --------------------
local recipe = {
	type = "recipe",
	name = "violence-battery",
	enabled = false,
	energy_required = 50,
	ingredients = {
		{type = "item", name = "accumulator", amount = 5},
		{type = "item", name = "steel-plate", amount = 20},
		{type = "item", name = "advanced-circuit", amount = 10}
	},
	results = {{type = "item", name = "violence-battery", amount = 1}}
}

table.insert(data.raw.technology["electric-energy-accumulators"].effects,
	{ type = "unlock-recipe", recipe = "violence-battery" })

data:extend{violence_battery_prototype, violence_battery_item, recipe}
