input = File.readlines('input.txt').map { |l| ".#{l.chomp}.".split '' }
input.unshift(['.'] * input[0].length)
input.push(['.'] * input[0].length)

next_map = []
input.size.times do
  row = []
  input[0].size.times do
    row.push '.'
  end
  next_map.push row
end

changed = true
current_count = 0
while changed
  current_count = 0
  changed = false
  (1...input.length-1).each do |i|
    (1...input[0].length-1).each do |j|
      if input[i][j] != '.'
        count = 0
        (-1..1).each do |di|
          (-1..1).each do |dj|
            if !(di == 0 && dj == 0)
              offset_i = i + di
              offset_j = j + dj
              while offset_i > 0 && offset_i < input.length - 1 && offset_j > 0 && offset_j < input[0].length - 1 && input[offset_i][offset_j] == '.'
                offset_i += di
                offset_j += dj 
              end

              count += input[offset_i][offset_j] == '#' ? 1 : 0
            end
          end
        end
      
        if count == 0 && input[i][j] == 'L'
          next_map[i][j] = '#'
          changed = true
        elsif count >= 5 && input[i][j] == '#'
          next_map[i][j] = 'L'
          changed = true
        else
          next_map[i][j] = input[i][j]
        end

        current_count += next_map[i][j] == '#' ? 1 : 0
      end
    end
  end

  tmp = input
  input = next_map
  next_map = tmp
end

puts current_count
