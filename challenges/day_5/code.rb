def instructions
  File.read("instructions.txt").split("\n").map do |line|
    line.scan(/\d+/).map(&:to_i)
  end
end

def stacks
  raw_text = File.read("stacks.txt").split("\n")
  raw_stacks = raw_text.pop
  stack_headings = raw_stacks.split.map(&:to_i)
  stack_positions = raw_stacks.chars.map.with_index do |char, index|
    if char == " "
      nil
    else
      index
    end
  end.compact
  stack_headings.map.with_index do |_stack_heading, index|
    raw_text.map { |line| line[stack_positions[index]] }.compact.reject { |char| char == " " }
  end
end

def first_question_solution
  stacks = stacks()
  instructions = instructions()
  instructions.each_with_index do |instruction, index|
    items_to_move = instruction[0]
    origin = instruction[1] - 1
    destination = instruction[2] - 1
    items_to_move.times do
      in_transit = stacks[origin].shift
      stacks[destination].unshift in_transit
    end
  end
  stacks.map { |stack| stack[0] }.join
end

def second_question_solution
  stacks = stacks()
  instructions = instructions()
  instructions.each_with_index do |instruction, index|
    items_to_move = instruction[0]
    origin = instruction[1] - 1
    destination = instruction[2] - 1
    in_transit = stacks[origin].shift(items_to_move)
    stacks[destination].unshift(in_transit).flatten!
  end
  stacks.map { |stack| stack[0] }.join
end

puts "the answer to the first question is #{first_question_solution}"
puts "the answer to the second question is #{second_question_solution}"
