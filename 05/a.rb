max = 0
File.readlines('input.txt').map do |line|
  line.tr('FBLR', '0101')
end.each do |line|
  row = line.slice(0, 7).to_i 2
  seat = line.slice(7, 3).to_i 2
  id = row * 8 + seat
  max = [id, max].max
end

puts max
