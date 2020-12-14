
local g = require 'lpeg'
local bint = dofile('./bint.lua')(256)

local function nsepseq(pat, sep) return pat * (sep * pat)^0 end
local num = g.C(g.R"09"^1)/function(str) return bint(str) end

local inputpat = num * "\n" * g.Ct(nsepseq(num + "x"*g.Cc(false), ","))

local time, ids = inputpat:match(io.read "*a")

local n, a = {}, {}
for i, v in ipairs(ids) do
  if v then
    -- n[#n+1], a[#a+1] = v, -(v+i-1)%v
      print(v, -(v+i-1)%v)
    n[#n+1], a[#a+1] = bint(v), bint(-(v+i-1)%v)
  end
end
for _,v  in ipairs(n) do print(n) end
-- print(table.concat(n, ", "))
-- print(table.concat(a, ", "))

function prodf(a, ...) return a and a * prodf(...) or 1 end
function prodt(t) return prodf(table.unpack(t)) end
 
function mulInv(a, b)
    local b0 = b
    local x0 = bint(0)
    local x1 = bint(1)
 
    if b == 1 then
        return 1
    end
 
    while a > 1 do
        local q, amb = bint.tdivmod(a, b)
        a = b
        b = amb
        local xqx = x1 - q * x0
        x1 = x0
        x0 = xqx
    end
 
    if x1 < 0 then
        x1 = x1 + b0
    end
 
    return x1
end
 
function chineseRemainder(n, a)
    local prod = prodt(n)
 
    local p
    local sm = 0
    for i=1,#n do
        p = prod / n[i]
        sm = sm + a[i] * mulInv(p, n[i]) * p
    end
 
    return bint.tmod(sm, prod)
end


local res = chineseRemainder(n, a)
print(chineseRemainder({3, 5, 7}, {2, 3, 2}))

print(res)
