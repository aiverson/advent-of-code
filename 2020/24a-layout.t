

local g = require 'lpeg'

-- hex grid, east is up-left, west is down-right, north is up-right

local P, Cc = g.P, g.Cc
local dir = P"se" * Cc{0, -1} + P"ne" * Cc{-1, 0} + P"e"*Cc{-1, -1} + P"sw"*Cc{1, 0} + P"nw"*Cc{0, 1} + P"w"*Cc{1, 1}
local path = g.Ct(dir^1)
local inputpat = g.Ct(path * (P"\n" * path)^0)

local input = inputpat:match(io.read "*a")

local floor = {}
for _, p in ipairs(input) do
  local pos = {0, 0}
  for _, d in ipairs(p) do
    pos = {pos[1] + d[1], pos[2] + d[2]}
  end
  local idx = tostring(pos[1])..","..tostring(pos[2])
  floor[idx] = not floor[idx]
end

local count = 0
for k, v in pairs(floor) do
  print(k, v)
  if v then count = count + 1 end
end

print(count)
