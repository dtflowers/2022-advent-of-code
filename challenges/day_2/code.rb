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

puts "The first answer is #{score(input)}"

def throwing_score(input)
  input.inject(0) do |throwing_score, line|
    opponent, player = line.split(" ")
    throwing_score += throwing_round_score(opponent, player)
  end
end

def throwing_round_score(opponent, player)
  return 1 if opponent == "B" && player == "X"
  return 2 if opponent == "C" && player == "X"
  return 3 if opponent == "A" && player == "X"
  return 4 if opponent == "A" && player == "Y"
  return 5 if opponent == "B" && player == "Y"
  return 6 if opponent == "C" && player == "Y"
  return 7 if opponent == "C" && player == "Z"
  return 8 if opponent == "A" && player == "Z"
  return 9 if opponent == "B" && player == "Z"
end

puts "The second answer is #{throwing_score(input)}"
