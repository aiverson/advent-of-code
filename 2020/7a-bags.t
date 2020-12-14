

local g = require 'lpeg'

local function nsepseq(pat, sep) return pat * (sep * pat)^0 end
local P, S, R = g.P, g.S, g.R
local contains = P" bags contain "
local color = g.C(((R"az"+" ") - " bag")^1)
local num = g.C(R"09"^1)/tonumber
local rule = color * contains * g.Ct(nsepseq(num*" "*color*" bag"*(P"s"^-1)/function(n, c) return {n = n, c = c} end, P", ") + "no other bags")*"." /
function (c, lst) return {c = c, lst =lst} end
local rules = g.Ct(nsepseq(rule, "\n"))

-- print((color * contains * num * " " * color *" bag, "* num * color * " bags."):match "light red bags contain 1 bright white bag, 2 muted yellow bags.")
local input = rules:match(io.read"*a")
-- print(input)

local cur, prev = {}, {}

local function contains(lst, c)
  for _, v in ipairs(lst) do
    if v.c == c then return true end
  end
  return false
end

local function all_containing(rules, c)
  local res = {}
  for i, v in ipairs(rules) do
    -- print("checking", v.c, "against", c)
    if contains(v.lst, c) then
      res[v.c] = true
    end
  end
  return res
end

local function override(a, b)
  local res = {}
  for k, v in pairs(a) do res[k] = v end
  for k, v in pairs(b) do res[k] = v end
  return res
end

local flag = true
while flag do
  local next = {}
  for k, v in pairs(cur) do
    -- print("checking for", k, v)
    next = override(next, all_containing(input, k))
  end
  next = override(next, all_containing(input, "shiny gold"))

  flag = false
  print "next round"
  for k, v in pairs(next) do
    print("has: ", k)
    if not prev[k] == v then
      flag = true
    end
  end
  prev = cur
  cur = next
end

local count = 0
for k, v in pairs(cur) do print("final", k, v) count = count + 1 end
print(count)
