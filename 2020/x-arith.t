

local nums = {1, 4, 4, 6, 6}
local goal = 324
-- local nums = {1, 2}
-- local goal = 3

local ops = {
  {name = "+", op = function(a, b) return a+b end},
  {name = "-", op = function(a, b) return a-b end},
  {name = "*", op = function(a, b) return a*b end},
  {name = "/", op = function(a, b) return a/b end}
}

local function copyseq(seq)
  local res = {}
  for i, v in ipairs(seq) do res[i] = v end
  return res
end

local state = copyseq(nums)
for i = 1, #nums - 1 do state[#state+1] = "_" end

local function evaluate(state, offset, stack)
  if #stack == 1 and stack[1] == goal then
    local prog = table.concat(state, " ", 1, offset - 1)
    -- print("found", prog, stack[1], offset)
    return true, prog
  end
  if state[offset] == nil then return false end
  if type(state[offset]) == "number" then
    -- print("pushing", state[offset])
    stack[#stack+1] = state[offset]
    return evaluate(state, offset+1, stack)
  else
    if #stack < 2 then return false end
    for _, v in ipairs(ops) do
      state[offset] = v.name
      local s2 = copyseq(stack)
      -- print("operating", v.name, table.concat(stack, " "))
      s2[#s2-1], s2[#s2] = v.op(s2[#s2], s2[#s2-1]), nil
      local succeed, res = evaluate(state, offset + 1, s2)
      if succeed then return succeed, res end
    end
  end
  return false
end

local function generate(k, seq)
  if k == 1 then
    -- print("evaluating", table.concat(seq, " "))
    local succeed, res = evaluate(seq, 1, {})
    if succeed then print(res); debug.debug(); os.exit() end
  else
    generate(k-1, seq)
    for i = 1, k-1 do
      if k % 2 == 0 then
        seq[i], seq[k] = seq[k], seq[i]
      else
        seq[1], seq[k] = seq[k], seq[1]
      end
      generate(k-1, seq)
    end
  end
end

generate(#state, state)
