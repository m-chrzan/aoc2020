require 'set'

sections = File.read('input.txt').split "\n\n"

fields = sections[0].split "\n"
my_ticket_line = sections[1].split("\n")[1]
my_ticket = my_ticket_line.split(',').map {|n| n.to_i}
ticket_lines = sections[2].split("\n")
tickets = ticket_lines.slice(1, ticket_lines.size).map {|t| t.split(',').map {|n| n.to_i}}

valid_values = {}
valid_all = {}

fields.each do |field|
  f, range1, range2 = field.split(/: | or /)
  valid_values[f] = []
  [range1, range2].each do |range|
    from, to = range.split('-').map {|n| n.to_i}
    valid_values[f].push (from..to)
    (from..to).each do |n|
      valid_all[n] = true
    end
  end
end

candidates = []
my_ticket.each do
  candidates.push(Set.new valid_values.keys())
end

tickets = tickets.filter do |ticket|
  ticket.all? { |n| valid_all[n] }
end

tickets.each do |ticket|
  ticket.each_with_index do |n, i|
    valid_values.each do |field, valid|
      if !(valid[0].include?(n) || valid[1].include?(n))
        candidates[i].delete(field)
      end
    end
  end
end

decided = Set.new
mapping = {}
changed = true
while changed
  changed = false
  new_decided = candidates.find do |c|
    if c.size == 1
      f = c.to_a[0]
      !decided.member? f
    else
      false
    end 
  end
  if new_decided
    index = candidates.find_index new_decided
    field = new_decided.to_a[0]
    decided.add field
    mapping[field] = index
    changed = true
    candidates.each do |c|
      c.delete(field)
    end
  end
end

product = 1
mapping.each do |field, index|
  if field =~ /departure/
    product *= my_ticket[index]
  end
end
puts product
