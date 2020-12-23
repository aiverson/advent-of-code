

local g = require 'lpeg'

local inputpat = g.Ct((g.C(g.R"09")/tonumber) ^ 1)

local input = inputpat:match(io.read "*a")

for i = 10, 1000000 do
  input[i] = i
end

local function build_linked_cups(list)
  local numbers = {}
  local left = nil
  local function mknod(val)
    local next = numbers[val % #list + 1]
    local prev = numbers[(val - 2) % #list + 1]
    left = {
      val = val,
      left = left,
      right = nil,
      next = next,
      prev = prev
    }
    if left.left then left.left.right = left end
    if prev then prev.next = left end
    if next then next.prev = left end
    numbers[val] = left
    return left
  end
  local first = mknod(list[1])
  for i = 2, #list - 1 do
    mknod(list[i])
  end
  local last = mknod(list[#list])
  first.left = last
  last.right = first
  numbers[1].prev = numbers[#list]
  numbers[#list].next = numbers[1]
  return first
end

local function makemove_b(current)
  if not current.right then print(current.val) end
  local a = current.right
  if not a.right then print(a.val) end
  local b = a.right
  if not b.right then print(b.val) end
  local c = b.right
  local dest = current.prev
  while dest.val == a.val or dest.val == b.val or dest.val == c.val do
    dest = dest.prev
  end
  -- print("selected dest", dest.val)
  local after = dest.right
  if not after then print(dest.val) end
  -- print("splicing between", dest.val, after.val)
  a.left.right, c.right.left = c.right, a.left
  dest.right, a.left = a, dest
  c.right, after.left = after, c
  return current.right
end

-- print(table.concat(makemove(inputpat:match"389125467", 3), " "))

local function printresult_b(cups)
  local n = 0
  while cups.val ~= 1 do
    cups = cups.right
    n = n + 1
    if n % 1000000 == 0 then print("checked", n) end
  end
  print(cups.right.val * cups.right.right.val)
end

local function simulate_b(cups)
  for i = 1, 10000000 do
    cups = makemove_b(cups)
    -- local seq, point = {}, cups
    -- for i = 1, 9 do
    --   seq[i], point = point.val, point.right
    -- end
    -- print(table.concat(seq, " "))
    -- printresult(cups)
    if i % 10000 == 0 then print("step", i) end
  end
  return cups
end

printresult_b(simulate_b(build_linked_cups(input)))
