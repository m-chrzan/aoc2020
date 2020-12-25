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

max_v = 0
max_h = 0

for line in io.lines('input.txt') do
    local tile = parse_tile(line)
    local v = 0
    local h = 0

    for _, direction in pairs(tile) do
        v, h = navigate(v, h, direction)
    end

    if math.abs(v) > max_v then max_v = math.abs(v) end
    if math.abs(h) > max_h then max_h = math.abs(h) end

    if not tiles[v] then tiles[v] = {} end
    if not tiles[v][h] then tiles[v][h] = 0 end

    tiles[v][h] = (tiles[v][h] + 1) % 2
end

function black(tiles, v, h)
    if not tiles[v] then return false end
    return tiles[v][h] == 1
end

for i = 1, 100 do
    max_v = max_v + 1
    max_h = max_h + 1

    local count = 0
    local new_tiles = {}
    for v = -max_v, max_v do
        for h = -max_h, max_h do
            if not new_tiles[v] then new_tiles[v] = {} end
            local count_black = 0
            for _, direction in pairs(directions) do
                local v1, h1 = navigate(v, h, direction)
                if black(tiles, v1, h1) then
                    count_black = count_black + 1
                end
            end

            if black(tiles, v, h) then
                if count_black == 0 or count_black > 2 then
                    new_tiles[v][h] = 0
                else
                    count = count + 1
                    new_tiles[v][h] = 1
                end
            else
                if count_black == 2 then
                    count = count + 1
                    new_tiles[v][h] = 1
                else
                    new_tiles[v][h] = 0
                end
            end
        end
    end

    tiles = new_tiles
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
