

local entries = {}

for i in io.lines() do
  local i = tonumber(i)
  entries[i] = true
  if entries[2020 - i] then
    print(i * (2020 - i))
    return
  end
end
