

local g = require 'lpeg'

local num = g.C(g.R"09" ^ 1) / tonumber
local ws = g.P" "^0
local function nsepseq(pat, sep) return pat * (sep * pat)^0 end
local op = g.P"+" * g.Cc(function(a, b) return a + b end)
+ g.P"*" * g.Cc(function(a, b) return a * b end)


local evaluator = g.P {
  g.V"expr",
  expr = g.V"val" * ws * "+" * ws * g.V"expr" / function (a, b) return a + b end
  + g.V"val" * ws * "*" * ws * g.V"expr" / function(a, b) return a * b end
    + g.V"val",
  val = num + g.P"(" * g.V"expr" * ")"
}

local evaluator_ltr = g.P {
  g.V "expr",
  expr = g.Ct(nsepseq(g.V"val", ws * op * ws)) / function(tab)
    local val = tab[1]
    for i = 1, #tab / 2 - 0.5 do
      val = tab[2* i](val, tab[2*i+1])
    end
    return val
                                       end,
  val = num + g.P"(" * g.V"expr" * ")"
}

local evaluator_prec = g.P {
  g.V"expr",
  expr = g.V"factor" * ws * "*" * ws * g.V"expr" / function (a, b) return a * b end + g.V"factor",
  factor = g.V"val" * ws * "+" * ws * g.V"factor" / function(a, b) return a + b end
    + g.V"val",
  val = num + g.P"(" * g.V"expr" * ")"
}

local inputpat = g.Cf(nsepseq(evaluator_prec, "\n"), function(a, b) return a + b end)

print(string.format("%20d", inputpat:match(io.read "*a")))
