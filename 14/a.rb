lines = File.readlines('input.txt')

one_mask = 0
zero_mask = (1 << 36) - 1

mem = Hash.new 0

lines.each do |line|
  if line.slice(0, 4) == 'mask'
    mask = line.split(' = ')[1].strip
    one_mask = 2
    zero_mask = 3
    mask.each_char do |c|
      case c
      when '1'
        one_mask += 1
      when '0'
        zero_mask -= 1
      end
      one_mask *= 2
      zero_mask *= 2
      zero_mask += 1
    end
    one_mask >>= 1
    zero_mask >>= 1
  else
    split = line.split(/\[|\] = /)
    address = split[1].to_i
    value = split[2].to_i
    actual_value = (value & zero_mask) | one_mask
    mem[address] = actual_value
  end
end

sum = 0
mem.each_value do |v|
  sum += v
  sum -= 1 << 36
end

puts sum
