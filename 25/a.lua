card_pkey = 8421034
door_pkey = 15993936
modulus = 20201227

function step(value, subject)
    return (value * subject) % modulus
end

function reverse(pkey, subject)
    value = 1
    steps = 0
    while value ~= pkey do
        value = step(value, subject)
        steps = steps + 1
    end

    return steps
end

function transform(subject, loop)
    value = 1
    for i = 1, loop do
        value = step(value, subject)
    end

    return value
end

card_steps = reverse(card_pkey, 7)

encryption_key = transform(door_pkey, card_steps)

print(encryption_key)
