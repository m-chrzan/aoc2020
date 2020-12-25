rules = {}

function char(c)
    return function(s, i)
        if s:sub(i,i) == c then
            return i+1
        else
            return nil
        end
    end
end

function pick(f, g)
    return function(s, i)
        j = f(s, i)
        if j then
            return j
        else
            return g(s, i)
        end
    end
end

function chain2(fs)
    return function (s, i)
        for j = 1, #fs do
            i = rules[fs[j]](s, i)
            if not i then
                return nil
            end
        end
        
        return i
    end
end

function chain(f, g)
    return function (s, i)
        j = rules[f](s, i)
        if j then
            return rules[g](s, j)
        else
            return nil
        end
    end
end

function make_chain(rule)
    space_index = rule:find(' ')
    if space_index then
        return chain2({rule:sub(1, space_index - 1), rule:sub(space_index + 1, -1)})
    else
        return function (s, i)
            return rules[rule](s, i)
        end
    end
end

function make_function(rule)
    if rule:sub(1, 1) == '"' then
        return char(rule:sub(2, 2))
    end
    pipe_index = rule:find('|')
    if pipe_index then
        left = make_chain(rule:sub(1, pipe_index - 2))
        right = make_chain(rule:sub(pipe_index + 2, #rule))
        return pick(left, right)
    else
        return make_chain(rule)
    end
end

function parse_rule(rule)
    colon_index = rule:find(':')
    if colon_index then
        rule_number = rule:sub(1, colon_index - 1)
        rhs = rule:sub(colon_index + 2, -1)
        rules[rule_number] = make_function(rhs)
        return true
    else
        return false
    end
end

lines = io.lines('input.txt')

for line in lines do
    if not parse_rule(line) then
        break
    end
end

correct = 0
for line in lines do
    j = rules['0'](line, 1)
    if j == #line + 1 then
        correct = correct + 1
    end
end

print(correct)
