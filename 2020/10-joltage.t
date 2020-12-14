
local adapters = {}
for l in io.lines() do
  table.insert(adapters, tonumber(l))
end

table.sort(adapters)

local ones, threes = 0, 0
local prev = 0
for _, j in ipairs(adapters) do
  local d = j - prev
  if d == 1 then ones = ones + 1 end
  if d == 3 then threes = threes + 1 end
  prev = j
end

print(ones * (threes+1))
