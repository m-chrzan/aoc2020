rules = {}
gold_producing = {}
lines = 0
File.readlines('input.txt').each do |line|
  lines += 1
  line.chomp!
  bag, contents = line.split 'bags contain' 
  bag.strip!
  rules[bag] = []
  contents.split(', ').map do |content|
    match = /^(\d+) ([\w\s]+) bags?\.?$/.match(content.strip)
    if match
      color = match[2]
      rules[bag].push color

      if color == 'shiny gold'
        gold_producing[bag] = true
      end
    end

  end
end

changed = true
while changed
  changed = false
  rules.each do |bag, productions|
    if !gold_producing[bag]
      productions.each do |subbag|
        if gold_producing[subbag]
          gold_producing[bag] = true
          changed = true
        end
      end
    end
  end
end

puts gold_producing.size
