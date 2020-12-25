input = io.lines('input.txt')

world = {}

function copy(world)
    new_world = {}
    for x = -world.bounds[1], world.bounds[1] do
        for y = -world.bounds[2], world.bounds[2] do
            for z = -world.bounds[3], world.bounds[3] do
                for w = -world.bounds[4], world.bounds[4] do
                    set(new_world, x, y, z, w, get(world, x, y, z, w))
                end
            end
        end
    end

    new_world.bounds = {}
    for i, b in pairs(world.bounds) do
        new_world.bounds[i] = b
    end

    return new_world
end

function iterate(world, f)
    for x = -world.bounds[1], world.bounds[1] do
        for y = -world.bounds[2], world.bounds[2] do
            for z = -world.bounds[3], world.bounds[3] do
                for w = -world.bounds[4], world.bounds[4] do
                    f(x, y, z, w, get(world, x, y, z, w))
                end
            end
        end
    end
end

function set(world, x, y, z, w, value)
    if not world[x] then
        world[x] = {}
    end
    if not world[x][y] then
        world[x][y] = {}
    end
    if not world[x][y][z] then
        world[x][y][z] = {}
    end
    world[x][y][z][w] = value
    return world
end

function get(world, x, y, z, w)
    if not world[x] then
        return '.'
    elseif not world[x][y] then
        return '.'
    elseif not world[x][y][z] then
        return '.'
    elseif not world[x][y][z][w] then
        return '.'
    else
        return world[x][y][z][w]
    end
end

function step_cell(world, x, y, z, w)
    active = 0
    for dx = -1, 1 do
        for dy = -1, 1 do
            for dz = -1, 1 do
                for dw = -1, 1 do
                    if not (dx == 0 and dy == 0 and dz == 0 and dw == 0) then
                        if get(world, x+dx, y+dy, z+dz, w+dw) == '#' then
                            active = active + 1
                        end
                    end
                end
            end
        end
    end
    
    if get(world, x, y, z, w) == '#' then
        if active == 2 or active == 3 then
            return '#'
        else
            return '.'
        end
    else
        if active == 3 then
            return '#'
        else
            return '.'
        end
    end
end

i = 0
for line in input do
    for j = 1, line:len() do
       set(world, i, j, 0, 0, line:sub(j, j))
    end
    i = i + 1
end

world.bounds = { i, i, 1, 1 }

function bump(bounds)
    return { bounds[1]+1, bounds[2]+1, bounds[3]+1, bounds[4]+1 }
end

for round = 1, 6 do
    new_world = {}
    new_world.bounds = bump(world.bounds)
    iterate(new_world, function (x, y, z, w, value)
        set(new_world, x, y, z, w, step_cell(world, x, y, z, w))
    end)
    world = copy(new_world)
end

count = 0
iterate(world, function (x, y, z, w, value)
    if value == '#' then
        count = count  + 1
    end
end)

print(count)
