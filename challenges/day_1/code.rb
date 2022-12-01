elves = File.readlines("input.txt", "\n\n").map{ |s| s.rstrip.split("\n") }

summed = elves.map do |elf|
  elf.sum(&:to_i)
end

question_1_solution = summed.max

puts "The answer to the first question is #{question_1_solution}."

question_2_solution = summed.sort.pop(3).sum

puts "The answer to the second question is #{question_2_solution}."
