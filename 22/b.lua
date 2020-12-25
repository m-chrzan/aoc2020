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

function make_signature(deck1, deck2)
    return table.concat(deck1, ',') .. '#' .. table.concat(deck2, ',')
end

function copy(deck, n)
    local new_deck = {}
    for i = 1, n do
        table.insert(new_deck, deck[i])
    end
    return new_deck
end

function play_game(deck1, deck2, calculate_score)
    local winner = nil
    local previous_rounds = {}

    while not winner do
        if not previous_rounds[make_signature(deck1, deck2)] then
            previous_rounds[make_signature(deck1, deck2)] = true
            local card1 = table.remove(deck1, 1)
            local card2 = table.remove(deck2, 1)
            local one_won_round = true
            if card1 <= #deck1 and card2 <= #deck2 then
                one_won_round = play_game(copy(deck1, card1), copy(deck2, card2), false)
            else
                one_won_round = card1 > card2
            end
            if one_won_round then
                table.insert(deck1, card1)
                table.insert(deck1, card2)
            else
                table.insert(deck2, card2)
                table.insert(deck2, card1)
            end

            if #deck2 == 0 then
                winner = 1
            elseif #deck1 == 0 then
                winner = 2
            end
        else
            winner = 1
        end
    end

    if calculate_score then
        deck = deck1
        if winner == 2 then
            deck = deck2
        end

        score = 0
        for i = 1, #deck do
            score = score + i * (deck[#deck - i + 1]) 
        end

        return score
    end

    if winner == 1 then
        return true
    else
        return false
    end
end

print(play_game(deck1, deck2, true))
