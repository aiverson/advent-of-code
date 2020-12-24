

local g = require 'lpeg'

-- hex grid, east is up-left, west is down-right, north is up-right

local P, Cc = g.P, g.Cc
local dir = P"se" * Cc{0, -1} + P"ne" * Cc{-1, 0} + P"e"*Cc{-1, -1} + P"sw"*Cc{1, 0} + P"nw"*Cc{0, 1} + P"w"*Cc{1, 1}
local path = g.Ct(dir^1)
local inputpat = g.Ct(path * (P"\n" * path)^0)

local input = inputpat:match(io.read "*a")

local function set_insert(set, pair)
  local a = set[pair[1]]
  if not a then a = {}; set[pair[1]] = a end
  a[pair[2]] = true
end

local function set_remove(set, pair)
  local a = set[pair[1]]
  if not a then return end
  a[pair[2]] = nil
  if not next(a) then
    set[pair[1]] = nil
  end
end

local function set_mem(set, pair)
  return set[pair[1]] and set[pair[1]][pair[2]]
end

local function set_iter(set)
  local pos1, row, pos2, val
  return function()
    while pos2 == nil do
      pos1, row = next(set, pos1)
      if pos1 == nil then return nil end
      pos2, val = next(row, pos2)
    end
    local pos = {pos1, pos2}
    pos2, val = next(row, pos2)
    return pos
  end
end

local function vector_add(a, b)
  return {a[1] + b[1], a[2] + b[2]}
end

local alldirs = path:match"eseswwnwne"

local function count_adjacent(floor, pos)
  local count = 0
  for _, d in ipairs(alldirs) do
    if set_mem(floor, vector_add(pos, d)) then
      count = count + 1
    end
  end
  return count
end

local function next_state(floor)
  local suc = {}
  for pos in set_iter(floor) do
    local count = count_adjacent(floor, pos)
    if count == 1 or count == 2 then
      set_insert(suc, pos)
    end
    for _, d in ipairs(alldirs) do
      local pos = vector_add(pos, d)
      if not set_mem(floor, pos) then
        local count = count_adjacent(floor, pos)
        if count == 2 then
          set_insert(suc, pos)
        end
      end
    end
  end
  return suc
end

local function count_set(set)
  local count = 0
  for p in set_iter(set) do
    count = count + 1
  end
  return count
end

local floor = {}
for _, p in ipairs(input) do
  local pos = {0, 0}
  for _, d in ipairs(p) do
    pos = vector_add(pos, d)
  end
  if not set_mem(floor, pos) then
    set_insert(floor, pos)
  else
    set_remove(floor, pos)
  end
end
print(count_set(floor))

for i = 1, 100 do
  floor = next_state(floor)
  print(i, count_set(floor))
end


print(count_set(floor))
