tiles = {}

current_tile_number = nil
current_tile = {}

function border(tile, horizontal, index)
    first_column = 0
    first_row = 0
    last_column = 0
    last_row = 0
    if horizontal then
        first_column = 1
        last_column = #tile[1]
        first_row = index
        last_row = index
    else
        first_column = index
        last_column = index
        first_row = 1
        last_row = #tile
    end

    b = ''
    for row = first_row, last_row do
        for column = first_column, last_column do
            b = b .. tile[row][column]
        end
    end

    if (horizontal and index > 1) or (not horizontal and index == 1) then
        b = b:reverse()
    end

    return b
end

function borders(tile)
    return {
        border(tile, true, 1),
        border(tile, true, 10),
        border(tile, false, 1),
        border(tile, false, 10)
    }
end

for line in io.lines('input.txt') do
    if line == "" and current_tile_number then
        tiles[current_tile_number] = current_tile
        current_tile = {}
    end

    space_index = line:find(' ')

    if space_index then
        current_tile_number = line:sub(space_index+1, -2)
    elseif #line > 0 then
        row = {}
        for i = 1, line:len() do
            table.insert(row, line:sub(i, i))
        end
        table.insert(current_tile, row)
    end
end

border_counts = {}
for _, tile in pairs(tiles) do
   for _, border in pairs(borders(tile)) do
       if not border_counts[border] then
            border_counts[border] = 0
        end
        border_counts[border] = border_counts[border] + 1
    end
end

corners = {}
for number,tile in pairs(tiles) do
    count_neighboorless = 0
    for _, border in pairs(borders(tile)) do
        has_flipped_neighbor = border_counts[border] > 1
        has_non_flipped_neighbor = border_counts[border:reverse()]
        if not (has_flipped_neighbor or has_non_flipped_neighbor) then
            count_neighboorless = count_neighboorless + 1
        end
    end
    if count_neighboorless == 2 then
        table.insert(corners, number)
    end
end

product = 1
for i,c in pairs(corners) do
    product = product * c
end

print(product)
