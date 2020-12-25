tiles = {}

directions = {'se', 'sw', 'ne', 'nw', 'e', 'w'}

function navigate(v, h, direction)
    if direction == 'e' then
        return v, h+1
    elseif direction == 'w' then
        return v, h-1
    end

    local even = v % 2 == 0
    local new_v = v
    local new_h = h

    if direction:sub(1, 1) == 'n' then
        new_v = new_v - 1
    else
        new_v = new_v + 1
    end


    if even and direction:sub(2, 2) == 'e' then
        new_h = new_h + 1
    elseif not even and direction:sub(2, 2) == 'w' then
        new_h = new_h - 1
    end

    return new_v, new_h
end

function parse_tile(line)
    local vertical = ''
    local tile = {}
    for i = 1, #line do
        local current = line:sub(i, i)
        if current == 'n' or current == 's' then
            vertical = current
        else
            table.insert(tile, vertical .. current)
            vertical = ''
        end
    end

    return tile
end

for line in io.lines('input.txt') do
    local tile = parse_tile(line)
    local v = 0
    local h = 0

    for _, direction in pairs(tile) do
        v, h = navigate(v, h, direction)
    end

    if not tiles[v] then tiles[v] = {} end
    if not tiles[v][h] then tiles[v][h] = 0 end

    tiles[v][h] = tiles[v][h] + 1
end

count = 0
for _, row in pairs(tiles) do
    for _, flips in pairs(row) do
        if flips % 2 == 1 then
            count = count + 1
        end
    end
end

print(count)
