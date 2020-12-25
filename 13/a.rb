earliest, notes = File.readlines('input.txt')
earliest = earliest.to_i
ids = notes.split(',').filter_map do |id|
  if id != 'x'
    id.to_i
  end
end

best_wait = ids.max + 1
best_id = 0
ids.each do |id|
  wait = id - (earliest % id)
  if  wait < best_wait
    best_wait = wait
    best_id = id
  end
end

puts best_wait * best_id
