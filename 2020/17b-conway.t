
local function nextstate(grid, dim)
  local res = {}
  for x = dim.x[1], dim.x[2] do
    res[x] = {}
    for y = dim.y[1], dim.y[2] do
      res[x][y] = {}
      for z = dim.z[1], dim.z[2] do
        res[x][y][z] = {}
        for w = dim.w[1], dim.w[2] do
          local count = 0
          for dx = -1, 1 do
            for dy = -1, 1 do
              for dz = -1, 1 do
                for dw = -1, 1 do
                  if grid[x + dx] and grid[x + dx][y + dy] and grid[x + dx][y + dy][z + dz] and grid[x + dx][y + dy][z + dz][w + dw] then
                    count = count + 1
                  end
                end
              end
            end
          end
          res[x][y][z][w] = count == 3 or (count == 4 and grid[x][y][z][w])
        end
      end
    end
  end
  return res
end

local function countcells(grid, dim)
  local count = 0
  for x = dim.x[1], dim.x[2] do
    for y = dim.y[1], dim.y[2] do
      for z = dim.z[1], dim.z[2] do
        for w = dim.w[1], dim.w[2] do
          if grid[x][y][z][w] then count = count + 1 end
        end
      end
    end
  end
  return count
end

local inputpat
do
  local g = require 'lpeg'
  local cell = g.P"."*g.Cc(false) + g.P"#"*g.Cc(true)
  local function nsepseq(pat, sep) return pat * (sep * pat) ^ 0 end
  local row = g.Ct(cell^1)
  local grid = g.Ct(nsepseq(row, "\n"))
  inputpat = grid / function(rawgrid)
    local width, height = #rawgrid, #rawgrid[1]
    local res = {}
    for x = 1, width + 20 do
      res[x] = {}
      for y = 1, height + 20 do
        res[x][y] = {}
        for z = 1, 20 do
          res[x][y][z] = {}
        end
      end
    end
    for i = 1, width do
      for j = 1, height do
        res[i+10][j+10][10][10] = rawgrid[i][j]
      end
    end
    return {grid = res, dim = {x = {1, width + 20}, y = {1, height + 20}, z = {1, 20}, w = {1, 20}}}
                    end
end

local input = inputpat:match(io.read "*a")
local grid, dim = input.grid, input.dim

print(countcells(grid, dim))
for i = 1, 6 do
  grid = nextstate(grid, dim)
  print(countcells(grid, dim))
end
