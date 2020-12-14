

local g = require 'lpeg'

local P, S, R = g.P, g.S, g.R

local function filter(a, b)
  local res = {}
  for k, v in pairs(a) do res[k] = v and b[k] end
  return res
end

local answer = g.C(R"az")
local form = g.Cf(g.Ct"" * g.Cg(answer * g.Cc(true))^1, rawset)
local group = g.Ct((form * "\n")^1)
local inputpat = g.Ct((group * "\n")^1)

local groups = inputpat:match(io.read"*a")

local sum = 0
for _, group in ipairs(groups) do
  local set = nil
  for _, form in ipairs(group) do
    set = set and filter(set, form) or form
  end
  local count = 0
  for q, _ in pairs(set) do
    count = count + 1
  end
  sum = sum + count
end

print(sum )
