def input
  File.read("input.txt").split("\n")
end

def parse_ranges(input)
  input.map do |line|
    first, second = line.split(",")
    [
      first.split("-").map(&:to_i).min..first.split("-").map(&:to_i).max,
      second.split("-").map(&:to_i).min..second.split("-").map(&:to_i).max
    ]
  end
end

def contained?(first, second)
  (first.cover?(second.first) && first.cover?(second.last)) || (second.cover?(first.first) && second.cover?(first.last))
end

def count_contained(ranges)
  count = 0
  ranges.each do |pair|
    count += 1 if contained?(pair.first, pair.last)
  end
  count
end

parsed_ranges = parse_ranges(input)

puts "The answer to the first question is #{count_contained(parsed_ranges)}"

def overlapping?(first, second)
  (first.cover?(second.first) || first.cover?(second.last)) || (second.cover?(first.first) || second.cover?(first.last))
end

def count_overlapping(ranges)
  count = 0
  ranges.each do |pair|
    count += 1 if overlapping?(pair.first, pair.last)
  end
  count
end

puts "The answer to the second question is #{count_overlapping(parsed_ranges)}"
