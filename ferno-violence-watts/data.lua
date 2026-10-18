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
	enabled = true,
	energy_required = 1,
	ingredients = {
		{type = "item", name = "copper-plate", amount = 200},
		{type = "item", name = "steel-plate", amount = 50}
	},
	results = {{type = "item", name = "violence-battery", amount = 1}}
}

data:extend{violence_battery_prototype, violence_battery_item, recipe}
