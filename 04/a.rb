file = File.read('input.txt')
records = file.split "\n\n"

fields = [ 'byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid' ]

count = 0
records.each do |record|
  fields_seen = 0
  entries = record.split
  entries.each do |entry|
    f, _ = entry.split ':' 
    if fields.include?(f)
      fields_seen += 1
    end
  end
  if fields_seen == 7
    count += 1
  end
end
puts count
