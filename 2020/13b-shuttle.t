
local g = require 'lpeg'
local gmp = dofile './gmp.lua' ('/nix/store/cd54crzq54qnh8sr27gnkk7zkd3cd8wn-gmp-6.2.0/lib/libgmp.so')
local mpz = gmp.types.z

local function nsepseq(pat, sep) return pat * (sep * pat)^0 end
local num = g.C(g.R"09"^1)/function(str) local n = mpz(); gmp.z_init_set_str(n, str, 10); return n end

local inputpat = num * "\n" * g.Ct(nsepseq(num + "x"*g.Cc(false), ","))

local time, ids = inputpat:match(io.read "*a")

local n, a = {}, {}
for i, v in ipairs(ids) do
  if v then
    -- n[#n+1], a[#a+1] = v, -(v+i-1)%v
    local im = mpz()
    gmp.z_init_set_d(im, i)
    n[#n+1], a[#a+1] = v, im
  end
end
for _,v  in ipairs(n) do print(n) end
-- print(table.concat(n, ", "))
-- print(table.concat(a, ", "))

-- Taken from https://www.rosettacode.org/wiki/Sum_and_product_of_an_array#Lua
function prodf(a, ...)
  local res = mpz()
  if a then
    gmp.z_mul(res, a, prodf(...))
    return res
  else
    gmp.z_init_set_d(res, 1)
    return res
  end
end
function prodt(t) return prodf(unpack(t)) end
 
function mulInv(a, b)
    local b0 = b
    local x0 = mpz()
    gmp.z_init_set_d(x0, 0)
    local x1 = mpz()
    gmp.z_init_set_d(x1, 1)
 
    if gmp.z_cmp_d(b, 1) == 0 then
      local res = mpz()
      gmp.z_init_set_d(res, 1)
        return res
    end
 
    while gmp.z_cmp_d(a, 1) > 0 do
      local q, amb = mpz(), mpz()
      gmp.z_fdiv_qr(q, amb, a, b)
      a = b
      b = amb
      local xqx = mpz()
      local im = mpz()
      gmp.z_mul(im, q, x0)
      gmp.z_sub(xqx, x1, im)
      x1 = x0
      x0 = xqx
    end
 
    if gmp.z_cmp_d(x1, 0) < 0 then
      local im = mpz()
      gmp.z_add(im, x1, b0)
        x1 = im
    end
 
    return x1
end
 
function chineseRemainder(n, a)
    local prod = prodt(n)
 
    local p
    local sm = mpz()
    gmp.z_init_set_d(sm, 0)
    for i=1,#n do
      local im0 = mpz()
      gmp.z_fdiv_q(im0, prod, n[i])
      p = im0
      im0 = mpz()
      local im1, im2 = mpz(), mpz()
      gmp.z_mul(im0, mulInv(p, n[i]))
      gmp.z_mul(im1, a[i], im0)
      gmp.z_add(im2, sm, im1)
      sm = im2
    end

    local res = mpz()
    gmp.z_fdiv_r(res, sm, prod)
    return res
end


local res = chineseRemainder(n, a)

gmp.printf("%d", res)
