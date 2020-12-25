groups = File.read('input.txt').split("\n\n")

total = groups.reduce(0) do |total, group|
  answers = group.split("\n")
  
  all = answers.reduce(Hash.new true) do |all, answer|
    new_all = {}
    answer.each_char do |c|
      if all[c]
        new_all[c] = true
      end
    end
    new_all
  end
  subtotal = all.size
  total + subtotal
end

puts total
