def input
  File.read("input.txt").split("\n")
end

def score_priorities(priorities)
  priorities.map do |priority|
    letter = priority.first
    if letter =~ /[[:upper:]]/
      letter.bytes.first - 38
    else
      letter.bytes.first - 96
    end
  end
end

def identify_priorities(input)
  input.map do |rucksack|
    first, second = compartmentalize(rucksack)
    first.chars & second.chars
  end
end

def compartmentalize(string)
  string.partition(/.{#{string.size/2}}/)[1,2]
end

priorities = identify_priorities(input)

scores = score_priorities(priorities)

puts "The answer to the question is #{scores.sum}"
