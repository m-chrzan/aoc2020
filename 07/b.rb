rules = {}
contains = {}
File.readlines('input.txt').each do |line|
  line.chomp!
  bag, contents = line.split 'bags contain' 
  bag.strip!
  rules[bag] = []
  contents.split(', ').map do |content|
    match = /^(\d+) ([\w\s]+) bags?\.?$/.match(content.strip)
    if match
      number = match[1].to_i
      color = match[2]
      rules[bag].push [color, number]
    else
      contains[bag] = 0
    end
  end
end

changed = true
while changed
  changed = false
  rules.each do |bag, productions|
    if !contains[bag]
      if productions.all? { |rule| contains[rule[0]] }
        contains[bag] = productions.reduce(0) do |bags, rule|
          bags + (1 + contains[rule[0]]) * rule[1]
        end
        changed = true
        rules.delete bag
      end
    end
  end
end

puts contains['shiny gold']
