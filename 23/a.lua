input = '716892543'
cups = {}
for i = 1, #input do
    table.insert(cups, tonumber(input:sub(i,i)))
end

function next_target(n)
    n = n - 1
    if n == 0 then
        n = 9
    end
    return n
end

for round = 1, 100 do
    current_value = cups[1]

    next_values = {}
    for i = 2, 4 do
        next_values[cups[i]] = true
    end

    target = next_target(current_value)
    while next_values[target] do
        target = next_target(target)
    end

    target_index = 5
    while cups[target_index] ~= target do
        target_index = target_index + 1
    end

    new_cups = {}
    if target_index ~= 5 then
        for i = 5, target_index - 1 do
            table.insert(new_cups, cups[i])
        end
    end
    table.insert(new_cups, target)
    for i = 2, 4 do
        table.insert(new_cups, cups[i])
    end
    if target_index ~= 9 then
        for i = target_index + 1, 9 do
            table.insert(new_cups, cups[i])
        end
    end
    table.insert(new_cups, cups[1])
    cups = new_cups
end

one_index = 1
while cups[one_index] ~= 1 do
    one_index = one_index + 1
end

for i = one_index + 1, 9 do
    io.write(cups[i])
end
for i = 1, one_index - 1 do
    io.write(cups[i])
end
print()
