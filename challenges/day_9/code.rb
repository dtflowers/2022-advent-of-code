def input
  File.read("test.txt").split("\n")
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
    { direction: direction, distance: distance, head_positions: [], tail_positions_0: [] }
  end
  head_position = { x: 0, y: 0 }
  tail_position = { x: 0, y: 0 }
  moves.each_with_index do |move, i|
    move[:head_positions] << head_position.dup
    move[:tail_positions_0] << tail_position.dup
    case move[:direction]
    when "U"
      move[:distance].times do
        starting_head_position = head_position.dup
        head_position[:y] += 1
        move[:head_positions] << head_position.dup
        tail_position = handle_tail_movement(move[:direction], starting_head_position, tail_position)
        move[:tail_positions_0] << tail_position.dup
      end
    when "D"
      move[:distance].times do
        starting_head_position = head_position.dup
        head_position[:y] -= 1
        move[:head_positions] << head_position.dup
        tail_position = handle_tail_movement(move[:direction], starting_head_position, tail_position)
        move[:tail_positions_0] << tail_position.dup
      end
    when "R"
      move[:distance].times do
        starting_head_position = head_position.dup
        head_position[:x] += 1
        move[:head_positions] << head_position.dup
        tail_position = handle_tail_movement(move[:direction], starting_head_position, tail_position)
        move[:tail_positions_0] << tail_position.dup
      end
    when "L"
      move[:distance].times do
        starting_head_position = head_position.dup
        head_position[:x] -= 1
        move[:head_positions] << head_position.dup
        tail_position = handle_tail_movement(move[:direction], starting_head_position, tail_position)
        move[:tail_positions_0] << tail_position.dup
      end
    end
  end
end

def tail_positions_count
  moves.map { |move| move[:tail_positions_0] }.flatten(1).uniq.count
end

# puts "The answer to the first question is #{tail_positions_count}"

# def add_tails
#   moves_with_tails = moves.dup
#   previous_move = nil
#   moves.each_with_index do |move, i|
#     2.times do |section|
#       previous_tail_slug = "tail_positions_#{section}".to_sym
#       current_tail_slug = "tail_positions_#{section + 1}".to_sym

#       if i == 0
#         starting_location = { x: 0, y: 0 }
#       elsif section == 0
#         starting_location = previous_move[current_tail_slug].last.dup
#       else
#         starting_location = moves_with_tails[i - 1][current_tail_slug].last.dup
#       end

#       if section == 0
#         pp "whats going on ehre?", move[previous_tail_slug].dup
#         previous_tail = move[previous_tail_slug].dup
#       else
#         pp "its always this one"
#         previous_tail = moves_with_tails[i][previous_tail_slug].dup
#       end

#       # pp "starting_location: #{starting_location}"
#       # pp "previous_tail: #{previous_tail}"
#       current_tail = previous_tail.unshift(starting_location.dup).dup
#       current_tail.pop
#       # pp "current_tail: #{current_tail}"
#       (section).times do
#         # pp "does this ever happen"
#         current_tail.unshift(starting_location.dup)
#         previous_tail.pop
#       end
#       # section.times do
#       #   current_tail.pop
#       # end

#       # if current_tail.count <= move[:distance]
#       #   (section + 1).times do
#       #     current_tail.unshift(starting_location.dup)
#       #   end
#       # end
#       moves_with_tails[i][current_tail_slug.dup] = current_tail.dup
#     end
#     previous_move = moves_with_tails[i].dup
#   end
#   moves_with_tails
# end


def add_tails
  2.times do |section|
    head_position = { x: 0, y: 0 }
    tail_position = { x: 0, y: 0 }
    moves.each_with_index do |move, i|
      previous_tail_slug = "tail_positions_#{section}".to_sym
      current_tail_slug = "tail_positions_#{section + 1}".to_sym

      head_position = move[:head_positions].last.dup
      tail_position = move[previous_tail_slug].last.dup
    end
  end
end

pp add_tails
