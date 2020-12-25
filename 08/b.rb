code = []

File.readlines('input.txt').each do |line|
  instruction, number = line.split
  code.push [instruction, number.to_i]
end

visited = {}
current_line = 0
acc = 0

code.size.times do |i|
  code_copy = code.map {|e| e.slice(0, 2)}
  case code_copy[i][0]
  when 'jmp'
    code_copy[i][0] = 'nop'
  when 'nop'
    code_copy[i][0] = 'jmp'
  end


  visited = {}
  current_line = 0
  acc = 0

  while !visited[current_line]
    if current_line == code.size
      puts acc
      break
    elsif current_line > code.size
      puts 'incorrect run'
      break
    end

    visited[current_line] = true
    case code_copy[current_line][0]
    when 'nop'
      current_line += 1
    when 'acc'
      acc += code_copy[current_line][1]
      current_line += 1
    when 'jmp'
      current_line += code_copy[current_line][1]
    end
  end
end
