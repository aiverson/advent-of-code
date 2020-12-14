
local g = require 'lpeg'

local passport = g.Cf(g.Ct("") * (g.Cg(g.C(g.R"az"^1) * ":" * g.C((g.P(1) - g.S" \n")^1) * g.S" \n"^-1))^0, rawset)
local inputs = g.Ct((passport * g.P"\n")^1)

local h = g.R"09" + g.R"af"
local d = g.R"09"

local reqfields = {
  byr = g.C(d*d*d*d)*-1 / tonumber / function(x) return x <= 2002 and x >= 1920 end + g.Cc(false),
  iyr = g.C(d*d*d*d)*-1 / tonumber / function(x) return x >= 2010 and x <= 2020 end + g.Cc(false),
  eyr = g.C(d*d*d*d)*-1 / tonumber / function(x) return x >= 2020 and x <= 2030 end + g.Cc(false),
  hgt = g.C(d*d*d)*"cm"*-1 / tonumber / function(x) return x >= 150 and x <= 193 end
  +     g.C(d*d)*"in"*-1 / tonumber / function(x) return x >= 59 and x <= 76 end + g.Cc(false),
  hcl = g.P"#"*h*h*h*h*h*h*-1*g.Cc(true)+g.Cc(false),
  ecl = (g.P"amb"+"blu"+"brn"+"gry"+"grn"+"hzl"+"oth")*-1 * g.Cc(true) + g.Cc(false),
  pid = d*d*d*d*d*d*d*d*d*-1*g.Cc(true)+g.Cc(false)
}

local list = inputs:match(io.read "*a")
local count = 0

for _, v in ipairs(list) do
  local flag = true
  for fld, valid in pairs(reqfields) do
    flag = flag and v[fld] and valid:match(v[fld])
  end
  if flag then count = count + 1 end
end

print(count)
