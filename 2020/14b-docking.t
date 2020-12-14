
local C = terralib.includecstring[[
#include <stdio.h>
]]
local g = require 'lpeg'

local function nsepseq(pat, sep) return pat * (sep * pat)^0 end
local mask = g.C(g.S"01X"^0) / function(str) return {mask1 = tonumber(str:gsub("X",  "0"), 2), mask0 = tonumber(str:gsub("1", "X"):gsub("0", "1"):gsub("X", "0"), 2)} end
local num = g.C(g.R"09"^1)/tonumber
local ins = g.P"mask = " * mask / function(mask) return {tag = "mask", mask} end
+ g.P"mem["*num*"] = "*num / function(addr, val) return {tag = "mem", addr, val} end
local progpat = g.Ct(nsepseq(ins, "\n"))
  
local prog = progpat:match(io.read "*a")
-- print(ins:match("mem[8] = 11")[2])
-- print(#prog)

local terra apply_mask(val: uint64, mask0: uint64, mask1: uint64)
  return not mask0 and (val or mask1)
end

local terra next_addr(addr: uint64, count: uint64, mask0: uint64, mask1: uint64)
  var res = (addr or mask1)
  var maskx = (not mask0) and (not mask1) and ((1ULL<<36) - 1)
  var bitcount = 0
  var offset = 0
  -- C.printf("%Lx %d %d %Lx\n", maskx, offset, bitcount, res)
  while (maskx >> offset) ~= 0ULL do
    -- C.printf("mask offset: %Lx %d %d\n", maskx, offset, bitcount)
    if (maskx >> offset and 1ULL) == 1 then
      res = (res and not (1ULL << offset)) or ((count and (1ULL << bitcount)) << (offset - bitcount))
      bitcount = bitcount + 1
      -- C.printf("res modification: %Lx\n", res)
    end
    offset = offset + 1
  end
  count = count + 1ULL
  if count == (1ULL << bitcount) then
    count = 0
  end
  -- C.printf("%Lx %d\n", res, count)
  return res, count
end

-- print(apply_mask(6, 2, 1))

local function run(prog)
  local mask0, mask1 = 0LL, 0LL
  local mem = {}
  for _, ins in ipairs(prog) do
    -- print(ins.tag, ins[1], ins[2])
    if ins.tag == "mask" then
      mask0, mask1 = ins[1].mask0, ins[1].mask1
    elseif ins.tag == "mem" then
      local iter, addr = 0ULL, ins[1]
      repeat
        local addr_iter = next_addr(addr, iter, mask0, mask1)
        addr, iter = addr_iter._0, addr_iter._1
        -- print(addr, iter);-- os.exit()
        mem[tonumber(addr)] = ins[2]
      until iter == 0ULL
    end
  end
  return mem
end

local mem = run(prog)
local sum = 0LL
local terra add64(a: uint64, b: uint64) return a + b end
for _, v in pairs(mem) do sum = add64(sum, v); print("summing", _, v) end
print(sum)
