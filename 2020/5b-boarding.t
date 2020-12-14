

local largest = 0
local smallest = math.huge
local present = {}

for l in io.lines() do
  local x = tonumber(l:gsub("F", "0"):gsub("B", "1"):gsub("R", "1"):gsub("L", "0"), 2)
  -- print(x)
  largest = math.max(largest, x)
  smallest = math.min(smallest, x)
  present[x] = true
end

for i = smallest, largest do
  if not present[i] then
    print(i)
  end
end
