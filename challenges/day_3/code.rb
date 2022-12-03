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

puts "The answer to the first question is #{scores.sum}"

def identify_badges(input)
  input.each_slice(3).map do |group|
    first, second, third = group
    first.chars & second.chars & third.chars
  end
end

badges = identify_badges(input)

badge_scores = score_priorities(badges)

puts "The answer to the second question is #{badge_scores.sum}"
