

local g = require 'lpeg'

local inputpat = g.Ct((g.C(g.R"09")/tonumber) ^ 1)

local input = inputpat:match(io.read "*a")

for i = 10, 1000000 do
  input[i] = i
end

local function build_linked_cups(list)
  local numbers = {}
  for i = 1, #list - 1 do
    numbers[list[i]] = list[i + 1]
  end
  numbers[list[#list]] = list[1]
  return numbers, list[1]
end

local function makemove_b(cups, current)
  local a = cups[current]
  local b = cups[a]
  local c = cups[b]
  local dest = (current - 2) % #cups + 1
  while dest == a or dest == b or dest == c do
    dest = (dest - 2) % #cups + 1
  end
  cups[current], cups[dest], cups[c] = cups[c], a, cups[dest]
  return cups[current]
end

local function printresult_b(cups)
  print(cups[1] * cups[cups[1]])
end

local function simulate_b(cups, current)
  for i = 1, 10000000 do
    current = makemove_b(cups, current)
  end
  return cups
end

printresult_b(simulate_b(build_linked_cups(input)))
