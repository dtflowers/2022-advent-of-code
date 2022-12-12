def input
  File.read("example.txt").split("\n")
end
#Consider a rope with a knot at each end; these knots mark the head and the tail of the rope. If the head moves far enough away from the tail, the tail is pulled toward the head.

#Due to nebulous reasoning involving Planck lengths, you should be able to model the positions of the knots on a two-dimensional grid. Then, by following a hypothetical series of motions (your puzzle input) for the head, you can determine how the tail will move.

# Due to the aforementioned Planck lengths, the rope must be quite short; in fact, the head (H) and tail (T) must always be touching (diagonally adjacent and even overlapping both count as touching):

# ....
# .TH.
# ....

# ....
# .H..
# ..T.
# ....

# ...
# .H. (H covers T)
# ...
# If the head is ever two steps directly up, down, left, or right from the tail, the tail must also move one step in that direction so it remains close enough:

# .....    .....    .....
# .TH.. -> .T.H. -> ..TH.
# .....    .....    .....

# ...    ...    ...
# .T.    .T.    ...
# .H. -> ... -> .T.
# ...    .H.    .H.
# ...    ...    ...
# Otherwise, if the head and tail aren't touching and aren't in the same row or column, the tail always moves one step diagonally to keep up:

# .....    .....    .....
# .....    ..H..    ..H..
# ..H.. -> ..... -> ..T..
# .T...    .T...    .....
# .....    .....    .....

# .....    .....    .....
# .....    .....    .....
# ..H.. -> ...H. -> ..TH.
# .T...    .T...    .....
# .....    .....    .....
# You just need to work out where the tail goes as the head follows a series of motions. Assume the head and the tail both start at the same position, overlapping.

# For example:

# R 4
# U 4
# L 3
# D 1
# R 4
# D 1
# L 5
# R 2
# This series of motions moves the head right four steps, then up four steps, then left three steps, then down one step, and so on. After each step, you'll need to update the position of the tail if the step means the head is no longer adjacent to the tail. 

# method that will parse the input into an array of hashes where each hash has two attributes, :direction and :distance, which represent the direction and distance to move the head of the rope
def head_moves
  head_moves = input.map do |line|
    direction = line[0]
    distance = line[1..].to_i
    { direction: direction, distance: distance, head_positions: [] }
  end
  head_position = { x: 0, y: 0 }
  head_moves.each do |head_move|
    head_move[:head_positions] << [head_position[:x], head_position[:y]]
    case head_move[:direction]
    when "U"
      head_move[:distance].times do
        head_position[:y] += 1
        head_move[:head_positions] << [head_position[:x], head_position[:y]]
      end
    when "D"
      head_move[:distance].times do
        head_position[:y] -= 1
        head_move[:head_positions] << [head_position[:x], head_position[:y]]
      end
    when "R"
      head_move[:distance].times do
        head_position[:x] += 1
        head_move[:head_positions] << [head_position[:x], head_position[:y]]
      end
    when "L"
      head_move[:distance].times do
        head_position[:x] -= 1
        head_move[:head_positions] << [head_position[:x], head_position[:y]]
      end
    end
  end
  head_moves
end

pp head_moves
