

local g = require 'lpeg'

local function nsepseq(pat, sep) return pat * (sep * pat)^0 end
local num = g.C(g.R"09"^1) / tonumber
local field = g.C((g.R"az"+" ")^1) * ": " * num * "-" * num * " or " * num * "-" * num
  / function(name, min1, max1, min2, max2)
    return {
      name = name,
      range = {
        {min1, max1},
        {min2, max2}
      }
    }
    end
local ticket = g.Ct(nsepseq(num, ","))

local inputpat = g.Ct(nsepseq(field, "\n")) * "\n\nyour ticket:\n" * ticket *"\n\nnearby tickets:\n" * g.Ct(nsepseq(ticket, "\n"))

local fields, my_ticket, other_tickets = inputpat:match(io.read "*a")

local function inrange(val, min, max)
  return val >= min and val <= max
end

local function inranges(val, ranges)
  local flag = false
  for _, range in ipairs(ranges) do
    flag = flag or inrange(val, unpack(range))
  end
  return flag
end

local function find_valids(val, fields)
  local res = {}
  for _, field in ipairs(fields) do
    if inranges(val, field.range) then
      table.insert(res, field.name)
    end
  end
  return res
end

local function valid_for_any(val, fields)
  return #find_valids(val, fields) > 0
end

local sum = 0
local retained_tickets = {}
for _, ticket in ipairs(other_tickets) do
  local has_invalid = false
  for _, val in ipairs(ticket) do
    if not valid_for_any(val, fields) then
      print("found invalid", val)
      sum = sum + val
      has_invalid = true
    end
  end
  if not has_invalid then
    table.insert(retained_tickets, ticket)
  end
end

print(sum)

local function list_to_set(lst)
  local res = {}
  for _, v in ipairs(lst) do res[v] = true end
  return res
end

local function set_singlet(set)
  return not next(set, next(set)) and (next(set))
end

local function intersection(a, b)
  local res = {}
  for k, v in pairs(a) do res[k] = v and b[k] end
  return res
end

local universal_set = setmetatable({}, {__index = function(set, k) return true end})

local prod = 1
local retained_fields = fields
while #retained_fields > 0 do
  for idx = 1, #my_ticket do
    local possibilities = universal_set
    for _, ticket in ipairs(retained_tickets) do
      possibilities = intersection(list_to_set(find_valids(ticket[idx], retained_fields)), possibilities)
    --   print("handling val", ticket[idx])
  -- for k, _ in pairs(possibilities) do
  --   print(k)
  -- end
    end
    -- print("possibilities for ", idx)
    for k, _ in pairs(possibilities) do
      -- print(k)
    end
    if set_singlet(possibilities) then
      print("found field", set_singlet(possibilities), idx)
      if set_singlet(possibilities):sub(1, #"departure") == "departure" then
        prod = prod * my_ticket[idx]
      end
      local next_fields = {}
      for _, field in ipairs(retained_fields) do
        if field.name ~= set_singlet(possibilities) then
          table.insert(next_fields, field)
        end
      end
      retained_fields = next_fields
      print(#retained_fields, "remaining")
    end
  end
end
print(prod)
