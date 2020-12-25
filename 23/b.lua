Node = {}
Node.__index = Node
function Node:new(value)
    object = {}
    object.value = value
    object.right = nil
    object.left = nil
    return setmetatable(object, self)
end

function Node:insert(left)
    self.left = left
    self.right = left.right
    self.right.left = self
    self.left.right = self
end

function Node:detach()
    self.left.right = self.right
    self.right.left = self.left
    self.left = nil
    self.right = nil
    return self
end

CyclicList = {}
CyclicList.__index = CyclicList

function CyclicList:new()
    object = {}
    object.head = nil
    object.last = nil
    object.index = {}
    return setmetatable(object, self)
end

function CyclicList:insert(value)
    node = Node:new(value)
    self.index[value] = node
    if self.head == nil then
        self.head = node
        node.left = node
        node.right = node
    else
        node:insert(self.head.left)
    end
end

function CyclicList:move_head(node)
    self.head = node
end

input = '716892543'
cups = CyclicList:new()
for i = 1, #input do
    cups:insert(tonumber(input:sub(i,i)))
end
for i = 10, 1000000 do
    cups:insert(i)
end

function next_target(n)
    n = n - 1
    if n == 0 then
        n = 1000000
    end
    return n
end

for round = 1, 10000000 do
    current_value = cups.head.value

    next_node = cups.head.right
    next_values = {}
    for i = 1, 3 do
        next_values[next_node.value] = true
        next_node = next_node.right
    end

    target = next_target(current_value)
    while next_values[target] do
        target = next_target(target)
    end

    target_node = cups.index[target]

    for i = 1, 3 do
        moved_node = cups.head.right:detach()
        moved_node:insert(target_node)
        target_node = moved_node
    end

    cups:move_head(cups.head.right)
end

one_node = cups.index[1]
a = one_node.right.value
b = one_node.right.right.value
print(a * b)
