
local g = require 'lpeg'

local handler
do
  local P, R = g.P, g.R
  local num = R"09" ^ 1 / tonumber
  local range = num * "-" * num
  local policy = range * " " * g.C(R"az")
  local entry = policy * ": " * g.C(R"az" ^ 1) * "\n" / function(min, max, let, pass)
    local a, b = pass:sub(min, min) == let, pass:sub(max, max) == let
    return (a and not b) or (b and not a)
                                              end
  inputspec = g.Cf(g.Cc(0) * entry^0, function(a, b) return a + (b and 1 or 0) end)
end

print(inputspec:match(io.read"*a"))
