def input
  File.read("example.txt").split("\n")
end

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

def tail_moves
  tail_position = { x: 0, y: 0 }
  head_moves.map do |head_move|
    # TODO: sort out logic for whether or not the tail will move. And if it does move, to which position it will move.
  end
end

pp tail_moves
