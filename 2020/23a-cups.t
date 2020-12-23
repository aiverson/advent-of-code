

local g = require 'lpeg'

local inputpat = g.Ct((g.C(g.R"09")/tonumber) ^ 1)

local input = inputpat:match(io.read "*a")

local tinsert = table.insert

local function find(list, val)
  for i = 1, #list do
    if list[i] == val then
      return i
    end
  end
end

local function findmax(list)
  local max, pos = 0, 0
  for i = 1, #list do
    if list[i] > max then
      max, pos = list[i], i
    end
  end
  return pos
end

local function finddest(list, current)
  while current > 0 do
    current = current - 1
    local pos = find(list, current)
    if pos then return pos end
  end
  return findmax(list)
end

local function makemove(cups, current)
  local selected, rest = {}, {}
  local startpos = find(cups, current)
  for i = 1, 3 do
    selected[i] = cups[(startpos + i - 1) % #cups + 1]
  end
  print("selected", table.concat(selected, " "))
  for i = 1, #cups - 3 do
    rest[i] = cups[(startpos + i + 2) % #cups + 1]
  end
  print("rest", table.concat(rest, " "))
  local dest = finddest(rest, current)
  print("dest", dest)
  for i = 1, 3 do
    tinsert(rest, dest + i, selected[i])
  end
  print(find(rest, current), (find(rest, current)) % #rest + 1)
  return rest, rest[(find(rest, current)) % #rest + 1]
end

-- print(table.concat(makemove(inputpat:match"389125467", 3), " "))

local function printresult(cups)
  local startpos = find(cups, 1)
  local res = {}
  for i = 1, #cups - 1 do
    res[i] = cups[(startpos + i - 1) % #cups + 1]
  end
  print(table.concat(res))
end

local function simulate(cups)
  local selected = cups[1]
  for i = 1, 100 do
    cups, selected = makemove(cups, selected)
    -- for i = 1, #cups do print(cups[i]) end
    -- printresult(cups)
    print("new selected", selected)
  end
  return cups
end

printresult(simulate(input))
