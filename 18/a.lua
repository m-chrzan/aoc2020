input = io.lines('input.txt')

function is_op(token)
    return token == '+' or token == '*'
end

function f_op(op)
    if op == '+' then
        return function (a, b) return a + b end
    else
        return function (a, b) return a * b end
    end
end

function is_digit(token)
    return token >= '1' and token <= '9'
end

function do_math(expression)
    stack = {}
    for i = 1, #expression do
        token = expression:sub(i, i)
        if is_op(token) then
            table.insert(stack, token)
        elseif is_digit(token) then
            if is_op(stack[#stack]) then
                op = table.remove(stack)
                n = table.remove(stack)
                table.insert(stack, f_op(op)(n, tonumber(token)))
            else
                table.insert(stack, tonumber(token))
            end
        elseif token == '(' then
            table.insert(stack, token)
        elseif token == ')' then
            res = table.remove(stack)
            table.remove(stack)
            if is_op(stack[#stack]) then
                op = table.remove(stack)
                n = table.remove(stack)
                table.insert(stack, f_op(op)(n, res))
            else
                table.insert(stack, res)
            end
        end
    end
    return stack[1]
end

sum = 0
for line in input do
    sum = sum + do_math(line)
end

print(sum)
