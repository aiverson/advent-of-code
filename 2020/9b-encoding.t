local pos = 0
local ringbuffer = {}
local sequence = {}
local size = 25
local traces = {}
local desired_sum = 0
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
      desired_sum = x
    end
  end
  ringbuffer[pos%size + 1] = x
  sequence[pos + 1] = x
  pos = pos + 1
end

for i, v in ipairs(sequence) do
  local j = 1
  while j <= #traces do
    traces[j].sum = traces[j].sum + v
    if traces[j].sum == desired_sum then
      local min, max = math.huge, 0
      for k = traces[j].start, i do
        min, max = math.min(min, sequence[k]), math.max(max, sequence[k])
      end
      print(min + max)
      return
    end
    if traces[j].sum > desired_sum then
      table.remove(traces, j)
    else
      j = j + 1
    end
  end
  table.insert(traces, {start = i, sum = v})
end
