

local g = require 'lpeg'


local P, S, R, C = g.P, g.S, g.R, g.C
local op = C(R"az"^1)
local num = P"+"^-1 * C(P"-"^-1*R"09"^1) / tonumber
local ws = S" \t" ^1
local ins = op * ws * num / function(op, arg) return {op = op, arg = arg} end
local prog = g.Ct((ins * "\n")^1)

local input = prog:match(io.read "*a")

local ops = {
  nop = function(state, arg) end,
  acc = function(state, arg)
    state.acc = state.acc + arg
  end,
  jmp = function(state, arg)
    state.pc = state.pc + arg - 1
  end
}

local flag = false
local state = {acc = 0, pc = 1}
while not flag do
  if input[state.pc].run then
    print(state.acc)
    return
  else
    input[state.pc].run = true
  end
  local ins = input[state.pc]
  print("running", ins.op, ins.arg, "state", state.pc, state.acc)
  ops[input[state.pc].op](state, input[state.pc].arg)
  state.pc = state.pc + 1
end
