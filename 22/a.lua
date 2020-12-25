deck1 = {}
file = io.open('input.txt')
for line in file:lines() do
    if line:find('%d+') then
        table.insert(deck1, tonumber(line))
    elseif line == '' then
        break
    end
end
deck2 = {}
for line in file:lines() do
    if line:find('%d+') then
        table.insert(deck2, tonumber(line))
    end
end

ended = false

while #deck1 > 0 and #deck2 > 0 do
    card1 = table.remove(deck1, 1)
    card2 = table.remove(deck2, 1)
    if card1 > card2 then
        table.insert(deck1, card1)
        table.insert(deck1, card2)
    else
        table.insert(deck2, card2)
        table.insert(deck2, card1)
    end
end

deck = deck1
if #deck1 == 0 then
    deck = deck2
end

score = 0
for i = 1, #deck do
    score = score + i * (deck[#deck - i + 1]) 
end
print(score)
