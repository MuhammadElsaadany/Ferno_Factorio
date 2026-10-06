local ferno_nuke_prototype = table.deepcopy(data.raw["ammo"]["atomic-bomb"])

ferno_nuke_prototype.name = "ferno-nuke"
ferno_nuke_prototype.icons = {
  {
    icon = ferno_nuke_prototype.icon,
    icon_size = ferno_nuke_prototype.icon_size,
    tint = {r=1,g=0,b=0,a=0.3}
  },
}

--
local ferno_nuke_projectile = table.deepcopy(data.raw["projectile"]["atomic-rocket"])

ferno_nuke_projectile.name = "ferno-nuke-projectile"
ferno_nuke_prototype.ammo_type.action.action_delivery.projectile = "ferno-nuke-projectile"

--
local target_effects = ferno_nuke_projectile.action.action_delivery.target_effects

for _, effect in ipairs(target_effects) do
  if effect.type == "nested-result" and effect.action then
    
    if effect.action.action_delivery and effect.action.action_delivery.projectile == "atomic-bomb-wave" then
      
      effect.action.radius = 700               -- Vanilla is ~35. Double the AoE radius.
      effect.action.repeat_count = 100000       -- Increase count to fill the larger radius densely.
      
      -- Modifying the expansion speed:
      effect.action.action_delivery.starting_speed = 0.6  -- Higher = faster shockwave travel
    end
    
  end
end

--
local recipe = {
  type = "recipe",
  name = "ferno-nuke",
  enabled = true,
  energy_required = 1,
  ingredients = {
    {type = "item", name = "copper-plate", amount = 200},
    {type = "item", name = "steel-plate", amount = 50}
  },
  results = {{type = "item", name = "ferno-nuke", amount = 1}}
}

data:extend{ferno_nuke_prototype, ferno_nuke_projectile, recipe}
