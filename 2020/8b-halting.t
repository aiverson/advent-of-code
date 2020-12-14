

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

local function run(program)
  local flag = false
  local state = {acc = 0, pc = 1}
  local log = {}
  while not flag do
    print("instruction", state.pc)
    if state.pc == #program + 1 then
      return true, state.acc
    end
    if not program[state.pc] or log[state.pc] then
      return false, state.acc
    else
      log[state.pc] = true
    end
    local ins = program[state.pc]
    print("running", ins.op, ins.arg, "state", state.pc, state.acc)
    ops[ins.op](state, ins.arg)
    state.pc = state.pc + 1
  end
end

for i = 1, #input do
  if input[i].op == "jmp" or input[i].op == "nop" then
    print("testing at", i)
    input[i].op = input[i].op == "jmp" and "nop" or "jmp"
    local ok, acc = run(input)
    print(ok, acc)
    if ok then print(acc); return end
    input[i].op = input[i].op == "jmp" and "nop" or "jmp"
  end
end
