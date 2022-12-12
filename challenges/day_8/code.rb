def input
  File.read("input.txt").split("\n")
end

def grid
  grid = []
  input.each do |line|
    grid << line.chars
  end
  grid
end

def perimeter
  visible_coordinates = []
  grid.each_with_index do |row, row_index|
    row.each_with_index do |_number, column_index|
      if row_index == 0 || row_index == grid.size - 1 || column_index == 0 || column_index == row.size - 1
        visible_coordinates << [row_index, column_index]
      end
    end
  end
  visible_coordinates
end

def find_visible_numbers
  visible_numbers = perimeter
  grid.each_with_index do |row, row_index|
    next if row_index == 0 || row_index == grid.size - 1

    row.each_with_index do |number, column_index|
      next if column_index == 0 || column_index == row.size - 1

      to_right = row[column_index + 1..]
      if to_right.all? { |number_to_compare| number_to_compare < number }
        visible_numbers << [row_index, column_index]
      end

      to_left = row[0...column_index]
      if to_left.all? { |number_to_compare| number_to_compare < number }
        visible_numbers << [row_index, column_index]
      end

      to_top = grid[0...row_index].map { |row| row[column_index] }
      if to_top.all? { |number_to_compare| number_to_compare < number }
        visible_numbers << [row_index, column_index]
      end

      to_bottom = grid[row_index + 1..].map { |row| row[column_index] }
      if to_bottom.all? { |number_to_compare| number_to_compare < number }
        visible_numbers << [row_index, column_index]
      end
    end
  end
  visible_numbers.uniq.size
end

puts "The solution to the first quesiton is #{find_visible_numbers}"

def find_best_viewing_distance
  ideal_candidate = {
    coordinates: nil,
    visibility: 0
  }
  grid.each_with_index do |row, row_index|
    next if row_index == 0 || row_index == grid.size - 1

    row.each_with_index do |number, column_index|
      next if column_index == 0 || column_index == row.size - 1

      to_right = row[column_index + 1..]
      distance_index = to_right.index { |number_to_compare| number_to_compare >= number }
      visibility_right = distance_index ? (distance_index + 1) : to_right.size

      to_left = row[0...column_index].reverse
      distance_index = to_left.index { |number_to_compare| number_to_compare >= number }
      visibility_left = distance_index ? (distance_index + 1) : to_left.size

      to_top = (grid[0...row_index].map { |row| row[column_index] }).reverse
      distance_index = to_top.index { |number_to_compare| number_to_compare >= number }
      visibility_top = distance_index ? (distance_index + 1) : to_top.size

      to_bottom = grid[row_index + 1..].map { |row| row[column_index] }
      distance_index = to_bottom.index { |number_to_compare| number_to_compare >= number }
      visibility_bottom = distance_index ? (distance_index + 1) : to_bottom.size

      visibility = visibility_right * visibility_left * visibility_top * visibility_bottom

      if visibility > ideal_candidate[:visibility]
        ideal_candidate[:coordinates] = [row_index, column_index]
        ideal_candidate[:visibility] = visibility
      end
    end
  end
  ideal_candidate[:visibility]
end

puts "The solution for the second question is #{find_best_viewing_distance}"
