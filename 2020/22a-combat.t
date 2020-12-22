

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

while not empty(p1) and not empty(p2) do
  local c1, c2 = draw(p1), draw(p2)
  print("round", c1, c2)
  if c1 > c2 then
    emplace(p1, c1)
    emplace(p1, c2)
  elseif c2 > c1 then
    emplace(p2, c2)
    emplace(p2, c1)
  else
    error "tie!"
  end
end

local winner = empty(p1) and p2 or p1

local sum = 0
for i = winner.bottom-1, winner.top, -1 do
  print(winner[i], winner.bottom - i)
  sum = sum + winner[i] * (winner.bottom - i)
end
print(sum)
