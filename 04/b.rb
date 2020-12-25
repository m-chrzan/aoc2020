file = File.read('input.txt')
records = file.split "\n\n"

fields = [ 'byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid' ]

regexes = [
  /^byr:(19[2-9]\d|200[0-2])$/,
  /^iyr:(201\d|2020)$/,
  /^eyr:(202\d|2030)$/,
  /^hgt:((1[5-8]\d|19[0-3])cm|(59|6\d|7[0-6])in)$/,
  /^hcl:#[0-9a-f]{6}$/,
  /^ecl:(amb|blu|brn|gry|grn|hzl|oth)$/,
  /^pid:\d{9}$/
]

count = 0
records.each do |record|
  fields_correct = 0
  record.split.each do |entry|
    if regexes.any? {|r| r.match?(entry)}
      fields_correct += 1
    end
  end

  if fields_correct == 7
    count += 1
  end
end
puts count
