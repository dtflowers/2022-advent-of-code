def input
  File.read("input.txt")
end

def find_marker(string)
  string.chars.each_with_index do |_char, index|
    return index + 4 if string[index..index + 3].chars.uniq.length == 4
  end
end

def find_message(string)
  string.chars.each_with_index do |_char, index|
    return index + 14 if string[index..index + 13].chars.uniq.length == 14
  end
end

puts "The answer to the first question is #{find_marker(input)}"

puts "The answer to the second question is #{find_message(input)}"
