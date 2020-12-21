

local g = require 'lpeg'

local P, S, R, V, C = g.P, g.S, g.R, g.V, g.C

local function nsepseq(pat, sep)
  return pat * (sep * pat)^0
end

local function setadd(set, val)
  set[val] = true
  return set
end

local function setunion(a, b)
  local res = {}
  for k, v in pairs(a) do res[k] = v end
  for k, v in pairs(b) do res[k] = v end
  return res
end

local function setinters(a, b)
  local res = {}
  for k, v in pairs(a) do
    if b[k] then res[k] = b end
  end
  return res
end

local function setdiff(a, b)
  local res = {}
  for k, v in pairs(a) do
    if not b[k] then res[k] = v end
  end
  return res
end

local function setsinglet(set)
  return not next(set, next(set)) and (next(set))
end

local food = g.Cf(g.Ct"" * nsepseq(C(R"az"^1), " "), setadd) * " (contains " * g.Cf(g.Ct"" * nsepseq(C(R"az"^1), ", "), setadd) * ")"
  / function(ingredients, allergens)
    return {ingredients = ingredients, allergens = allergens}
    end

local inputpat = g.Ct(nsepseq(food, "\n"))

local input = inputpat:match(io.read "*a")

local allergens = {}
local ingredients = {}
local eliminated_ingredients = {}
for _, food in ipairs(input) do
  allergens = setunion(allergens, food.allergens)
  ingredients = setunion(ingredients, food.ingredients)
end
local remaining_allergens = allergens

local possible_sources = {}
while next(remaining_allergens) do
  for allergen in pairs(remaining_allergens) do
    -- print("considering", allergen)
    local src = ingredients
    for _, food in ipairs(input) do
      if food.allergens[allergen] then
        src = setinters(src, food.ingredients)
      end
    end
    src = setdiff(src, eliminated_ingredients)
    possible_sources[allergen] = src
    local unique = setsinglet(src)
    if unique then
      -- print("found", unique)
      eliminated_ingredients[unique] = true
      remaining_allergens = setdiff(remaining_allergens, {[allergen] = true})
    end
  end
end

local count = 0

for ingredient in pairs(setdiff(ingredients, eliminated_ingredients)) do
  -- print(ingredient)
  for _, food in ipairs(input) do
    if food.ingredients[ingredient] then count = count + 1 end
  end
end

print(count)

local allergenlist = {}
for allergen, sources in pairs(possible_sources) do
  table.insert(allergenlist, allergen)
end
table.sort(allergenlist)
local ingredientlist = {}
for i, allergen in ipairs(allergenlist) do
  for source in pairs(possible_sources[allergen]) do
    table.insert(ingredientlist, source)
  end
end
print(table.concat(ingredientlist, ","))
