

local largest = 0

for l in io.lines() do
  local x = tonumber(l:gsub("F", "0"):gsub("B", "1"):gsub("R", "1"):gsub("L", "0"), 2)
  -- print(x)
  largest = math.max(largest, x)
end
print(largest)
