
local g = require 'lpeg'

local function nsepseq(pat, sep) return pat * (sep * pat)^0 end
local num = g.C(g.R"09"^1)/tonumber

local inputpat = num * "\n" * g.Ct(nsepseq(num + "x", ","))

local time, ids = inputpat:match(io.read "*a")

local mintime = math.huge
local res = 0
for _, id in ipairs(ids) do
  print(time, id, -time % id)
  if -time % id < mintime then
    mintime = -time % id
    res = mintime * id
  end
end

print(res)
