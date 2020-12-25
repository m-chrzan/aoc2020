sections = File.read('input.txt').split "\n\n"

fields = sections[0].split "\n"
tickets = sections[2].split "\n"

valid_values = Hash.new false

fields.each do |field|
  ranges = field.split(/.*: | or /).slice(1, 2)
  ranges.each do |range|
    from, to = range.split('-').map {|n| n.to_i}
    (from..to).each do |n|
      valid_values[n] = true
    end
  end
end

invalid = 0
tickets.each do |ticket|
  values = ticket.split(',').map {|n| n.to_i}
  values.each do |n|
    if !valid_values[n]
      invalid += n
    end
  end
end

puts invalid
