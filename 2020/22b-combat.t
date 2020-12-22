

local g = require 'lpeg'
local function nsepseq(pat, sep) return pat * (sep * pat) ^ 0 end

local deck = g.Ct(nsepseq(g.C(g.R"09"^1)/tonumber, "\n"))
local inputpat = g.P"Player 1:\n" * deck * "\n\nPlayer 2:\n" * deck

local p1, p2 = inputpat:match(io.read "*a")

p1.top, p1.bottom = 1, #p1 + 1
p2.top, p2.bottom = 1, #p2 + 1

local function draw(deck)
  local card = deck[deck.top]
  deck[deck.top] = nil
  deck.top = deck.top + 1
  return card
end

local function emplace(deck, card)
  deck[deck.bottom] = card
  deck.bottom = deck.bottom + 1
end

local function empty(deck)
  return deck.top == deck.bottom
end

local function size(deck)
  return deck.bottom - deck.top
end

local function clone_n(deck, n)
  local res = {top = 1, bottom = n + 1}
  for i = 1, n do
    res[i] = deck[deck.top + i - 1]
  end
  return res
end

local function step_cache(store, key)
  local s = store[key]
  if s then
    return s
  else
    s = {}
    store[key] = s
    return s
  end
end


local function iter_deck(deck)
  local i = deck.top
  return function()
    if i == deck.bottom then return nil end
    local res = deck[i]
    i = i + 1
    return res
  end
end

local function recursive_combat(p1, p2)
  local cache = {}
  while not empty(p1) and not empty(p2) do
    local cache_k = cache
    for card in iter_deck(p1) do
      cache_k = step_cache(cache_k, card)
    end
    cache_k = step_cache(cache_k, "p2")
    for card in iter_deck(p2) do
      cache_k = step_cache(cache_k, card)
    end
    if cache_k.used == true then
      -- print "game ended"
      return 1, p1
    else
      cache_k.used = true
    end
    local c1, c2 = draw(p1), draw(p2)
    -- print("round", c1, c2)
    local recursive, winner = false, 0
    -- print("sizes", size(p1), size(p2))
    if c1 <= size(p1) and c2 <= size(p2) then
      -- print("recursing")
      winner = recursive_combat(clone_n(p1, c1), clone_n(p2, c2))
      -- print("subgame winner", winner)
      recursive = true
    end
      
    -- print(recursive, winner)
    if (recursive and winner == 1) or not recursive and c1 > c2 then
      emplace(p1, c1)
      emplace(p1, c2)
      -- print("p1 wins round")
    elseif (recursive and winner == 2) or not recursive and c2 > c1 then
      emplace(p2, c2)
      emplace(p2, c1)
      -- print "p2 wins round"
    else
      error "tie!"
    end
  end
  -- print "game ended"
  if empty(p1) then
    return 2, p2
  else
    return 1, p1
  end
end

local id, winner = recursive_combat(p1, p2)

local sum = 0
for i = winner.bottom-1, winner.top, -1 do
  print(winner[i], winner.bottom - i)
  sum = sum + winner[i] * (winner.bottom - i)
end
print(sum)
