local g = require 'lpeg'

local inputpat
local row = g.Ct((g.P"." * g.Cc(false) + g.P"#" * g.Cc(true))^1 * g.P"\n"^-1)
inputpat = g.Ct(row^1)

local map = inputpat:match(io.read "*a")

local trajectories = {
  {1, 1},
  {1, 3},
  {1, 5},
  {1, 7},
  {2, 1}
}

local syms = {}
local prod = 1
for t = 1, #trajectories do
  local count = 0
  for i = 1, math.floor(#map / trajectories[t][1]) do
    local row = map[1 + (i - 1) * trajectories[t][1]]
    if row[(trajectories[t][2] * i - trajectories[t][2]) % #row + 1] then
      count = count + 1
    end
  end
  prod = prod * count
end
print(prod)
