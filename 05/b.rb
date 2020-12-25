missing = 0
File.readlines('input.txt').map do |line|
  line.tr('FBLR', '0101')
end.map do |line|
  row = line.slice(0, 7).to_i 2
  seat = line.slice(7, 3).to_i 2
  row * 8 + seat
end.sort.reduce do |last_seen, current|
  if current - 1 != last_seen
    missing = current - 1
  end
  current
end

puts missing
