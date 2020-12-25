instructions = File.readlines('input.txt').map do |line|
  [line.slice(0, 1), line.slice(1, line.length).to_i]
end

n = 0
e = 0
direction = 0

instructions.each do |instruction|
  case instruction[0]
  when 'N'
    n += instruction[1]
  when 'S'
    n -= instruction[1]
  when 'E'
    e += instruction[1]
  when 'W'
    e -= instruction[1]
  when 'F'
    case direction
    when 0
      e += instruction[1]
    when 90
      n += instruction[1]
    when 180
      e -= instruction[1]
    when 270
      n -= instruction[1]
    end
  when 'L'
    direction += instruction[1]
    direction %= 360
  when 'R'
    direction -= instruction[1]
    direction %= 360
  end
end

puts n.abs + e.abs
