def input
  File.read("input.txt").split("\n")
end

def raw_terminal_output(input)
  commands = []
  input.each do |line|
    if line.start_with?("$")
      commands << { line[2..] => [] }
    else
      commands.last[commands.last.keys.first] << line
    end
  end
  commands
end

def build_directories(terminal_output)
  directories = {}
  current_location = nil
  terminal_output.each do |commands|
    commands.each do |command, output|
      if command.start_with?("cd")
        if command.end_with?("/")
          current_location = "/"
          directories[current_location] = output
        elsif command.end_with?("..")
          current_location = current_location[0..current_location.chop.rindex("/")]
        else
          current_location = "#{current_location}#{command.split(" ")[-1]}/"
          directories[current_location] = output
        end
      else
        output.map! do |line|
          if line.start_with?("dir ")
            "#{current_location}#{line[4..]}/"
          else
            line
          end
        end
        directories[current_location] = output
      end
    end
  end
  directories
end

def reduce_files_to_size(directories)
  directories.each do |_directory, files|
    next if files.is_a? Integer

    files.map! do |file|
      if file.is_a?(String) && file.match?(/\d/)
        file.to_i
      else
        file
      end
    end
  end
end

def reduce_directories_to_size(directories)
  directories.each do |directory, files|
    next if files.is_a? Integer

    if files.all? { |file| file.is_a? Integer }
      directories[directory] = files.sum
    end
  end
end

def replace_directory_references(directories)
  definitions = {}
  directories.each do |directory, files|
    if files.is_a? Integer
      definitions[directory] = files
    end
  end
  directories.each do |directory, files|
    next if files.is_a? Integer

    files.map! do |file|
      if file.is_a? String
        if definitions[file]
          definitions[file]
        else
          file
        end
      else
        file
      end
    end
  end
  directories
end

def calculate_values(directories)
  if directories.values.all? { |value| value.is_a? Integer }
    directories
  else
    reduced_files_to_size = reduce_files_to_size(directories)
    reduced_directories_to_size = reduce_directories_to_size(reduced_files_to_size)
    replaced_references_with_values = replace_directory_references(reduced_directories_to_size)
    calculate_values(replaced_references_with_values)
  end
end

terminal_output = raw_terminal_output(input)
directories = build_directories(terminal_output)
calculated_values = calculate_values(directories)

def solve_first_question(calculated_values)
  calculated_values.values.select { |value| value <= 100000 }.sum
end

pp "The answer to the first question is: #{solve_first_question(calculated_values)}"

def solve_second_question(calculated_values)
  current_size = calculated_values.select { |directory, value| directory == "/" }.values.first
  target = current_size + 30_000_000 - 70_000_000
  calculated_values.sort_by { |_directory, value| value }.select { |_directory, value| value > target }.first.last
end

pp "The answer to the second question is: #{solve_second_question(calculated_values)}"
