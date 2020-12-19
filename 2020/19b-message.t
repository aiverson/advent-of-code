

local g = require 'lpeg'

local P, S, R, V = g.P, g.S, g.R, g.V
local num = g.C(R"09"^1)/tonumber
local rulenum = num / function(n) return "rule_"..n end
local function nsepseq(pat, sep) return pat * (sep * pat) ^ 0 end
local rules = P {
  V"rules",
  rules = g.Cf(g.Ct"" * nsepseq(g.Cg(V"rule"), "\n"), rawset),
  rule = rulenum * ":" * " "
    * g.Cf(nsepseq(
             g.Cf(nsepseq(rulenum / V + P'"' * g.C(R"az"^0)/P * '"', " "), function(a, b) return a * b end),
             " | "
                  ), function(a, b) return a + b end)
  
} / function(ruletab)
  ruletab[1] = V"rule_0"*-1
  ruletab.rule_8 = (V"rule_42" - (V"rule_11"*-1))^1
  ruletab.rule_11 = V"rule_42" * V"rule_11"^-1 * V"rule_31"
  return P(ruletab)
    end

local inputpat = rules * "\n\n" * g.Ct(nsepseq(g.C(R"az"^0), "\n"))

local rules, messages = inputpat:match(io.read "*a")
print(rules, messages)

local count = 0
for i, v in ipairs(messages) do
  if rules:match(v) then
    count = count + 1
    end
end

print(count)
