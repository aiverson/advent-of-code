

local entries = {}
local rlut = {}

for i in io.lines() do
  local i = tonumber(i)
  entries[#entries + 1] = i
  rlut[i] = true
  for j = 1, #entries do
    if rlut[2020 - i - entries[j]] then
      print(i * entries[j] * (2020 - i - entries[j]))
      return
    end
  end
end
