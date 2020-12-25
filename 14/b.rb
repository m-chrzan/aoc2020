def mask_address address, mask 
  address.chars.zip(mask.chars).map do |bit, mask_bit|
    case mask_bit
    when '0'
      bit
    when '1'
      '1'
    when 'X'
      'X'
    end
  end.join ''
end
lines = File.readlines('input.txt')

mask = ''

code = []

lines.each do |line|
  if line.slice(0, 4) == 'mask'
    mask = line.split(' = ')[1].strip
  else
    split = line.split(/\[|\] = /)
    address = split[1].to_i.to_s(2).rjust 36, '0'
    value = split[2].to_i
    code.push [mask_address(address, mask), value]
  end
end

def enumerate_addresses address
  first_x = address.index 'X'
  if !first_x
    return [address]
  end
  first_segment = address.slice(0, first_x)
  rest = address.slice(first_x + 1, address.length)
  enumerate_addresses(rest).flat_map do |a|
    [
      (first_segment + '0' + a),
      (first_segment + '1' + a)
    ]
  end
end

mem = Hash.new 0
code.each do |address, value|
  addresses = enumerate_addresses address 
  addresses.each do |a|
    mem[a] = value
  end
end

sum = 0
mem.each_value do |v|
  sum += v
end

puts sum
