local g = require 'lpeg'

local P, S, C = g.P, g.S, g.C
local function nsepseq(pat, sep) return pat * (sep * pat)^0 end

local place = g.C(P"." + P"L" + P"#")
local row = g.Ct(place ^1)
local gridpat = g.Ct(nsepseq(row, "\n"))

local grid = gridpat:match(io.read "*a")

local function printgrid(g)
  local acc = {}
  for i = 1, #g do
    acc[i] = table.concat(g[i], "")
  end
  print(table.concat(acc, "\n"))
end

-- printgrid(grid)

local function rule(nh)
  if nh[2][2] == "." then return "." end
  local count = 0
  for i = 1, 3 do
    for j = 1, 3 do
      if nh[i][j] == "#" then count = count + 1 end
    end
  end
  if nh[2][2] == "L" and count == 0 then return "#" end
  if nh[2][2] == "#" and count >= 6 then return "L" end
  return nh[2][2]
end

local function nextstate(grid)
  local res = {}
  local nh = {{},{},{}}
  for i = 1, #grid do
    res[i] = {}
    for j = 1, #grid[i] do
      for k = 1, 3 do
        for l = 1, 3 do
          local dist = 0
          repeat
            dist = dist + 1
            nh[k][l] = grid[i+dist * (k-2)] and grid[i+dist * (k-2)][j+dist*(l-2)] or "L"
            -- if dist >= 10 then print(dist, i, j, k, l) printgrid(grid) os.exit() end
          until nh[k][l] ~= "." or (k == 2 and l == 2)
        end
      end
      res[i][j] = rule(nh)
    end
  end
  return res
end

local function grid_eq(a, b)
  if #a ~= #b then return false end
  for i = 1, #a do
    if #a[i] ~= #b[i] then return false end
    for j = 1, #a[i] do
      if a[i][j] ~= b[i][j] then
        return false
      end
    end
  end
  return true
end

local prev = grid
repeat
  prev = grid
  grid = nextstate(grid)
  -- print()
  -- printgrid(grid)
until grid_eq(grid, prev)

local count = 0
for i = 1, #grid do
  for j = 1, #grid[i] do
    if grid[i][j] == "#" then count = count + 1 end
  end
end

print(count)
