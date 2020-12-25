preamble = 25

def has_sum hash, sum
  hash.keys.any? do |n|
    hash[sum - n] > 0
  end
end

def update array, hash, n
  hash[n] += 1
  hash[array.first] -= 1
  array.shift
  array.push n
end

lines = File.readlines('input.txt').map {|l| l.to_i}
current25 = lines.slice(0, preamble)
current25hash = Hash.new 0
current25.each do |n|
  current25hash[n] += 1
end

invalid = 0

lines.slice(preamble, lines.size).each do |n|
  if invalid == 0 && (!has_sum current25hash, n)
    invalid = n
  end 
  update current25, current25hash, n
end

puts invalid
