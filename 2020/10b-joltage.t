
local adapters = {}
for l in io.lines() do
  table.insert(adapters, tonumber(l))
end

table.sort(adapters)

local combinations = setmetatable({}, {__index = function() return 0 end})
combinations[1] = 1

table.insert(adapters, 1, 0)
table.insert(adapters, adapters[#adapters]+3)

for i, j in ipairs(adapters) do
  for k = 1, 3 do
    if adapters[i+k] and adapters[i+k] <= j + 3 then
      combinations[i+k] = combinations[i+k] + combinations[i]
    end
  end
end

print(combinations[#adapters])
