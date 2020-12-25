lines = File.readlines('input.txt').map { |l| l.to_i }.unshift(0).sort!
arrs = Hash.new 0
arrs[0] = 1
lines.slice(1, lines.size).each do |line|
  arrs[line] += arrs[line - 1] + arrs[line - 2] + arrs[line - 3]
end
puts arrs[lines.last]
