function parse_row(line)
    row = {}
    for i = 1, #line do
        table.insert(row, line:sub(i, i))
    end
    return row
end
Map = {}
Map.__index = Map

Map.__tostring = function(self)
    string = ''
    for i = 1, 96 do
        for j = 1, 96 do
            string = string .. self:get(i, j) .. ' '
        end
        string = string .. "\n"
    end

    return string
end

function Map:get(x, y)
    x, y = self.transform(x, y)
    return self.map[x][y]
end

function id(x, y)
    return x, y
end

function Map:new(map)
    local object = {}
    object.map = map
    object.transform = id
    return setmetatable(object, self)
end

function Map:rotate()
    local old_transform = self.transform
    self.transform = function(x, y)
        return old_transform(y, 96 - x + 1)
    end
end

function Map:flip()
    local old_transform = self.transform
    self.transform = function(x, y)
        return old_transform(x, 96 - y + 1)
    end
end

function Map:has_monster(x, y)
    if x + #monster > 96 then
        print('x too large')
        return false
    end
    if y + #monster[1] > 96 then
        print('y too large')
        return false
    end
    for i = 1, #monster do
        for j = 1, #monster[1] do
            if monster[i][j] == '#' and self:get(x+i, y+j) ~= '#' then
                return false
            end
        end
    end

    return true
end

monster = {}
monster[1] = parse_row('                  # ')
monster[2] = parse_row('#    ##    ##    ###')
monster[3] = parse_row(' #  #  #  #  #  #   ')

map = {}
for line in io.lines('combined') do
    table.insert(map, parse_row(line))
end

map = Map:new(map)
map:flip()
map:rotate()
map:rotate()
map:rotate()

count = 0
for x = 1, 96 - #monster do
    for y = 1, 96 - #monster[1] do
        if map:has_monster(x, y) then
            count = count + 1
        end
    end
end

hashes = 0
for i = 1, 96 do
    for j = 1, 96 do
        if map.map[i][j] == '#' then
            hashes = hashes + 1
        end
    end
end

result = hashes - count * 15
print(result)
