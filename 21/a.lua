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

unsafe = {}
for _, ingredients in pairs(candidates) do
    for ingredient in pairs(ingredients) do
        unsafe[ingredient] = true
    end
end

count = 0

for ingredient, appearances in pairs(appearances) do
    if not unsafe[ingredient] then
        count = count + appearances
    end
end

print(count)
