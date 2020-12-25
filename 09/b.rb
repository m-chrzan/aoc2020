sum = 400480901
lines = File.readlines('input.txt').map {|l| l.to_i}

current_list = []
current_sum = 0

lines.each do |n|
  current_sum += n
  current_list.push n

  while current_sum > sum && current_list.size > 1
    current_sum -= current_list.first
    current_list.shift
  end

  if current_sum == sum && current_list.size > 1
    puts current_list.min + current_list.max
  end
end
