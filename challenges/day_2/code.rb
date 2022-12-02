def input
  File.read("input.txt").split("\n")
end

def score(input)
  input.inject(0) do |score, line|
    opponent, player = line.split(" ")
    score += round_score(player, opponent)
  end
end

def round_score(player, opponent)
  return 1 if player == "X" && opponent == "B"
  return 2 if player == "Y" && opponent == "C"
  return 3 if player == "Z" && opponent == "A"
  return 4 if player == "X" && opponent == "A"
  return 5 if player == "Y" && opponent == "B"
  return 6 if player == "Z" && opponent == "C"
  return 7 if player == "X" && opponent == "C"
  return 8 if player == "Y" && opponent == "A"
  return 9 if player == "Z" && opponent == "B"
end

puts "The answer is #{score(input)}"
