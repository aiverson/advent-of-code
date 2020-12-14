local pos = 0
local ringbuffer = {}
local size = 25
local function issum(list, num)
  local looking = {}
  for i, v in ipairs(list) do
    if looking[v] then return true end
    looking[num - v] = true
  end
end
for l in io.lines() do
  local x = tonumber(l)
  print(pos, x)
  if pos > size then
    if not issum(ringbuffer, x) then
      print(x)
      return
    end
  end
  ringbuffer[pos%size + 1] = x
  pos = pos + 1
end
