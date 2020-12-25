code = []

File.readlines('input.txt').each do |line|
  instruction, number = line.split
  code.push [instruction, number.to_i]
end

visited = {}
current_line = 0
acc = 0

while !visited[current_line]
  visited[current_line] = true
  case code[current_line][0]
  when 'nop'
    current_line += 1
  when 'acc'
    acc += code[current_line][1]
    current_line += 1
  when 'jmp'
    current_line += code[current_line][1]
  end
end

puts acc
