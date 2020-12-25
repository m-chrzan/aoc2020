lines = File.readlines('input.txt').map { |l| l.to_i }
lines.sort!
lines.unshift(0)
lines.push(lines.last + 3)
diffs = Hash.new 0
lines.each_cons 2 do |chargers|
  diffs[chargers[1]  - chargers[0]] += 1
end

puts diffs[1] * diffs[3]
