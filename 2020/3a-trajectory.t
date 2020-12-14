

local g = require 'lpeg'

local inputpat
local row = g.Ct((g.P"." * g.Cc(false) + g.P"#" * g.Cc(true))^1 * g.P"\n"^-1)
inputpat = g.Ct(row^1)


local map = inputpat:match(io.read "*a")

local syms = {}
-- for i = 1, #map do
--   for j = 1, #map[i] do
--     syms[j] = map[i][j] and "#" or "."
--   end
--   print(table.concat(syms))
-- end

local count = 0
for i = 1, #map do
  local row = map[i]
  if row[(3 * i - 3) % #row + 1] then
    -- print(i)
    count = count + 1
  end
end

print(count)
