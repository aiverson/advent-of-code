local g = require 'lpeg'

local passport = g.Cf(g.Ct("") * (g.Cg(g.C(g.R"az"^1) * ":" * g.C((g.P(1) - g.S" \n")^1) * g.S" \n"^-1))^0, rawset)
local inputs = g.Ct((passport * g.P"\n")^1)

local reqfields = {"byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"}

local list = inputs:match(io.read "*a")
local count = 0

for _, v in ipairs(list) do
  local flag = true
  for _, fld in ipairs(reqfields) do
    flag = flag and v[fld]
  end
  if flag then count = count + 1 end
end

print(count)
