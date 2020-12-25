input = File.read('input.txt').split ','

@t = 1

last_spoken = {}
last_number = 0
input.each_with_index do |n, i|
  if i > 0
    last_spoken[last_number] = i
  end
  last_number = n.to_i
end

(input.length+1..30000000).each do |turn|
  if !last_spoken[last_number]
    last_spoken[last_number] = turn - 1
    last_number = 0
  else
    new_last_number = (turn - 1) - last_spoken[last_number]
    last_spoken[last_number] = turn - 1
    last_number = new_last_number
  end
end

puts last_number
