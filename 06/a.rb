groups = File.read('input.txt').split("\n\n")

total = groups.reduce(0) do |total, group|
  answers = group.split("\n")
  
  anyone = answers.reduce(Hash.new false) do |anyone, answer|
    answer.each_char do |c|
      anyone[c] = true
    end
    anyone
  end
  subtotal = anyone.size
  total + subtotal
end

puts total
