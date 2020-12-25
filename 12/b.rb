instructions = File.readlines('input.txt').map do |line|
  [line.slice(0, 1), line.slice(1, line.length).to_i]
end

def rotate n, e, direction
  case direction
  when 0
    [n, e]
  when 90
    [e, -n]
  when 180
    [-n, -e]
  when 270
    [-e, n]
  end
end

ship_n = 0
ship_e = 0
waypoint_n = 1
waypoint_e = 10

instructions.each do |instruction|
  case instruction[0]
  when 'N'
    waypoint_n += instruction[1]
  when 'S'
    waypoint_n -= instruction[1]
  when 'E'
    waypoint_e += instruction[1]
  when 'W'
    waypoint_e  -= instruction[1]
  when 'F'
    ship_n += waypoint_n * instruction[1]
    ship_e += waypoint_e * instruction[1]
  when 'L'
    waypoint_n, waypoint_e = rotate waypoint_n, waypoint_e, instruction[1]
  when 'R'
    waypoint_n, waypoint_e = rotate waypoint_n, waypoint_e, (-instruction[1] % 360)
  end
end

puts ship_n.abs + ship_e.abs
