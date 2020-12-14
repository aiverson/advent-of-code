

local g = require 'lpeg'

local line = g.C(g.S"LRFNSEW")*g.C(g.R"09"^1)/function(ins, arg) return {ins = ins, arg = tonumber(arg)} end
local inputpat = g.Ct(line * (g.P"\n" * line)^0)

local directions = inputpat:match(io.read "*a")

local function rotate(dir)
  return {-dir[2], dir[1]}
end
local function move(ins, arg, pos, dir)
  if ins == "L" then
    for i = 1, 4 - (arg / 90) do
      dir = rotate(dir)
    end
  elseif ins == "R" then
    for i =1, arg / 90 do
      dir = rotate(dir)
    end
  elseif ins == "F" then
    pos = {pos[1] + arg * dir[1], pos[2] + arg * dir[2]}
  elseif ins == "N" then
    pos = {pos[1] + arg, pos[2]}
  elseif ins == "E" then
    pos = {pos[1], pos[2] + arg}
  elseif ins == "S" then
    pos = {pos[1] - arg, pos[2]}
  elseif ins == "W" then
    pos = {pos[1], pos[2] - arg}
  end
  return pos, dir
end

local function run(prog)
  local pos, dir = {0, 0}, {0, 1}
  for _, v in ipairs(directions) do
    pos, dir = move(v.ins, v.arg, pos, dir)
    print(pos[1], pos[2], dir[1], dir[2])
  end
  return pos, dir
end

local endpos = run(directions)
print(math.abs(endpos[1]) + math.abs(endpos[2]))
