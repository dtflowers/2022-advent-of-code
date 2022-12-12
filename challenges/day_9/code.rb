def input
  File.read("input.txt").split("\n")
end

def handle_tail_movement(direction, starting_head_position, starting_tail_position)
  return starting_tail_position if starting_head_position == starting_tail_position

  case direction
  when "L"
    if starting_head_position[:y] == starting_tail_position[:y]
      return starting_tail_position if starting_head_position[:x] >= starting_tail_position[:x]

      starting_tail_position[:x] -= 1
      starting_tail_position.dup
    elsif starting_head_position[:x] == starting_tail_position[:x]
      starting_tail_position.dup
    elsif starting_head_position[:x] < starting_tail_position[:x]
      starting_head_position.dup
    else
      starting_tail_position.dup
    end
  when "R"
    if starting_head_position[:y] == starting_tail_position[:y]
      return starting_tail_position if starting_head_position[:x] <= starting_tail_position[:x]

      starting_tail_position[:x] += 1
      starting_tail_position.dup
    elsif starting_head_position[:x] == starting_tail_position[:x]
      starting_tail_position.dup
    elsif starting_head_position[:x] > starting_tail_position[:x]
      starting_head_position.dup
    else
      starting_tail_position.dup
    end
  when "U"
    if starting_head_position[:x] == starting_tail_position[:x]
      return starting_tail_position if starting_head_position[:y] <= starting_tail_position[:y]

      starting_tail_position[:y] += 1
      starting_tail_position.dup
    elsif starting_head_position[:y] == starting_tail_position[:y]
      starting_tail_position.dup
    elsif starting_head_position[:y] - starting_tail_position[:y] > 0
      starting_head_position.dup
    else
      starting_tail_position.dup
    end
  when "D"
    if starting_head_position[:x] == starting_tail_position[:x]
      return starting_tail_position if starting_head_position[:y] >= starting_tail_position[:y]

      starting_tail_position[:y] -= 1
      starting_tail_position.dup
    elsif starting_head_position[:y] == starting_tail_position[:y]
      starting_tail_position.dup
    elsif starting_head_position[:y] - starting_tail_position[:y] < 0
      starting_head_position.dup
    else
      starting_tail_position.dup
    end
  end
end

def moves
  moves = input.map do |line|
    direction = line[0]
    distance = line[1..].to_i
    { direction: direction, distance: distance, head_positions: [], tail_positions: [] }
  end
  head_position = { x: 0, y: 0 }
  tail_position = { x: 0, y: 0 }
  moves.each_with_index do |move, i|
    move[:head_positions] << head_position.dup
    move[:tail_positions] << tail_position.dup
    case move[:direction]
    when "U"
      move[:distance].times do
        starting_head_position = head_position.dup
        head_position[:y] += 1
        move[:head_positions] << head_position.dup
        tail_position = handle_tail_movement(move[:direction], starting_head_position, tail_position)
        move[:tail_positions] << tail_position.dup
      end
    when "D"
      move[:distance].times do
        starting_head_position = head_position.dup
        head_position[:y] -= 1
        move[:head_positions] << head_position.dup
        tail_position = handle_tail_movement(move[:direction], starting_head_position, tail_position)
        move[:tail_positions] << tail_position.dup
      end
    when "R"
      move[:distance].times do
        starting_head_position = head_position.dup
        head_position[:x] += 1
        move[:head_positions] << head_position.dup
        tail_position = handle_tail_movement(move[:direction], starting_head_position, tail_position)
        move[:tail_positions] << tail_position.dup
      end
    when "L"
      move[:distance].times do
        starting_head_position = head_position.dup
        head_position[:x] -= 1
        move[:head_positions] << head_position.dup
        tail_position = handle_tail_movement(move[:direction], starting_head_position, tail_position)
        move[:tail_positions] << tail_position.dup
      end
    end
  end
end

def tail_positions_count
  moves.map { |move| move[:tail_positions] }.flatten(1).uniq.count
end

puts "The answer to the first question is #{tail_positions_count}"
