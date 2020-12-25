Tile = {}
Tile.__index = Tile

Tile.__tostring = function(self)
    string = ''
    for i = 1, 10 do
        for j = 1, 10 do
            string = string .. self:get(i, j) .. ' '
        end
        string = string .. "\n"
    end

    return string
end

function id(x, y)
    return x, y
end

function Tile:new(tile)
    local object = {}
    object.tile = tile
    object.transform = id
    return setmetatable(object, self)
end

function Tile:rotate()
    local old_transform = self.transform
    self.transform = function(x, y)
        return old_transform(y, 10 - x + 1)
    end
end

function Tile:flip()
    local old_transform = self.transform
    self.transform = function(x, y)
        return old_transform(x, 10 - y + 1)
    end
end

function Tile:get(x, y)
    x, y = self.transform(x, y)
    return self.tile[x][y]
end

function Tile:border(horizontal, index)
    first_column = 0
    first_row = 0
    last_column = 0
    last_row = 0
    if horizontal then
        first_column = 1
        last_column = 10
        first_row = index
        last_row = index
    else
        first_column = index
        last_column = index
        first_row = 1
        last_row = 10
    end

    b = ''
    for row = first_row, last_row do
        for column = first_column, last_column do
            b = b .. self:get(row, column)
        end
    end

    if (horizontal and index > 1) or (not horizontal and index == 1) then
        b = b:reverse()
    end

    return b
end

function Tile:borders()
    return {
        self:border(true, 1),
        self:border(true, 10),
        self:border(false, 1),
        self:border(false, 10)
    }
end

Board = {}
Board.__index = Board

function Board:new(corner)
    object = {}
    object.board = {}
    object.board[1] = {}
    object.board[1][1] = corner
    return setmetatable(object, self)
end

function Board:try_add(x, y, tile)
    if not self.board[x] then self.board[x] = {} end
    local reference_tile = self.board[x][y - 1]
    below = false
    if not reference_tile then
        below = true
        reference_tile = self.board[x - 1][y]
    end

    assert(reference_tile, "tried to insert tile at non-connected location")

    orientation_matches = function() return false end
    if below then
        orientation_matches = function()
            return reference_tile:border(true, 10) == tile:border(true, 1):reverse()
        end
    else
        orientation_matches = function()
            return reference_tile:border(false, 10) == tile:border(false, 1):reverse()
        end
    end

    correctly_rotated = false
    for i = 1, 4 do
        if orientation_matches() then
            correctly_rotated = true
            break
        end
        tile:rotate()
    end

    if not correctly_rotated then
        tile:flip()
        for i = 1, 4 do
            if orientation_matches() then
                correctly_rotated = true
                break
            end
            tile:rotate()
        end
    end

    if correctly_rotated then
        if not self.board[x] then
            self.board[x] = {}
        end
        self.board[x][y] = tile
    end
      
    return correctly_rotated
end

tiles = {}
current_tile_number = nil
current_tile = {}

for line in io.lines('input.txt') do
    if line == "" and current_tile_number then
        tiles[current_tile_number] = Tile:new(current_tile)
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

corner = '1327'
corner_tile = tiles[corner]
corner_tile:flip()

board = Board:new(tiles[corner])

handled = {}
handled[corner] = true

visited = {}
visited[1] = {}
visited[1][1] = true
visited[2] = {}
visited[2][1] = true
visited[1][2] = true

queue = {}
table.insert(queue, {1, 2})
table.insert(queue, {2, 1})
while #queue ~= 0 do
    current = table.remove(queue, 1)
    x = current[1]
    y = current[2]
    inserted = false
    for tile_id, tile in pairs(tiles) do
        if not handled[tile_id] then
            if board:try_add(x, y, tile) then
                assert(board.board[x][y])
                inserted = true
                handled[tile_id] = true

                if not visited[x] then visited[x] = {} end
                if not visited[x + 1] then visited[x + 1] = {} end
                if x < 12 and not visited[x + 1][y] then
                    table.insert(queue, {x + 1, y})
                    visited[x + 1][y] = true
                end
                if y < 12 and not visited[x][y + 1] then
                    table.insert(queue, {x, y + 1})
                    visited[x][y + 1] = true
                end
                break
            end
        end
    end
    if not inserted then
        print('failed')
        break
    end
end

for i = 1, 12 do
    for x = 2, 9 do
        for j = 1, 12 do
            local tile = board.board[i][j]
            for y = 2, 9 do
                io.write(tile:get(x, y))
            end
        end
        print()
    end
end
