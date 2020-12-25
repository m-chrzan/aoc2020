candidates = {}
appearances = {}

function intersect(t1, t2)
    t = {}
    for k, _ in pairs(t1) do
        if t2[k] then
            t[k] = true
        end
    end

    return t
end

for line in io.lines('input.txt') do
    allergens_index = line:find('(', 1, true)
    ingredients = {}
    for ingredient in line:sub(1, allergens_index-2):gmatch("%a+") do
        ingredients[ingredient] = true
        if not appearances[ingredient] then
            appearances[ingredient] = 0
        end
        appearances[ingredient] = appearances[ingredient] + 1
    end

    for allergen in line:sub(allergens_index+10, -2):gmatch("%a+") do
        if not candidates[allergen] then
            candidates[allergen] = ingredients
        else
            candidates[allergen] = intersect(candidates[allergen], ingredients)
        end
    end
end

changed = true
mapping = {}
decided = {}

while changed do
    changed = false
    for allergen, ingredients in pairs(candidates) do
        if not mapping[allergen] then
            size = 0
            last_ingredient = nil
            for ingredient, candidate in pairs(ingredients) do
                if candidate and not decided[ingredient] then
                    last_ingredient = ingredient
                    size = size + 1
                end
            end

            if size == 1 then
                mapping[allergen] = last_ingredient
                decided[last_ingredient] = true
                changed = true
            end
        end
    end
end

list = {}
for allergen, ingredient in pairs(mapping) do
    table.insert(list, { allergen, ingredient })
end

table.sort(list, function (a, b)
    return a[1] < b[1]
end)

for i, pair in pairs(list) do
    io.write(pair[2])
    io.write(',')
end
