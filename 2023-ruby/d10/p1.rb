# frozen_string_literal: true

VALID_UP = ['|', '7', 'F'].freeze
VALID_DOWN = ['|', 'J', 'L'].freeze
VALID_LEFT = ['-', 'F', 'L'].freeze
VALID_RIGHT = ['-', 'J', '7'].freeze
# MOVES = { up: [-1, 0], down: [1, 0], left: [0, -1], right: [0, 1] }.freeze
MOVES = { [-1, 0] => :up, [1, 0] => :down, [0, -1] => :left, [0, 1] => :right }.freeze
OPPOSITE_MOVE = { up: :down, down: :up, left: :right, right: :left }.freeze
VALID_MOVES = { '-' => %i[left right],
                '|' => %i[up down],
                '7' => %i[left down],
                'J' => %i[left up],
                'L' => %i[up right],
                'F' => %i[down right] }.freeze

def get_cell_value(cell)
  $maze[cell[0]][cell[1]]
end

def find_start
  $maze.each.with_index do |row, r|
    next unless row.include? 'S'

    return [r, row.index('S')]
  end
end

def find_first_move(start)
  current_row, current_col = start

  up = [current_row - 1, current_col]
  down = [current_row + 1, current_col]
  left = [current_row, current_col - 1]
  right = [current_row, current_col + 1]

  return up if !current_row != 0 && VALID_UP.include?($maze[up[0]][up[1]])
  return right if current_col != $max_row && VALID_RIGHT.include?($maze[right[0]][right[1]])
  return down if current_row != $max_row && VALID_DOWN.include?($maze[down[0]][down[1]])
  return left if !current_col != 0 && VALID_LEFT.include?($maze[left[0]][left[1]])

  nil
end

def find_next_move(current, previous)
  current_row, current_col = current
  previous_row, previous_col = previous

  current_symbol = get_cell_value(current)

  move = [current_row - previous_row, current_col - previous_col]
  moved = MOVES[move]
  opposite = OPPOSITE_MOVE[moved]
  valid = VALID_MOVES[current_symbol]
  next_move = valid.reject { |m| m == opposite }.first
  print "P: #{previous} C: #{current} (#{current_symbol}) M: #{move} (#{moved}) O: #{opposite} V: #{valid} --> #{next_move}\n"
  case next_move
  when :up
    [current_row - 1, current_col]
  when :down
    [current_row + 1, current_col]
  when :left
    [current_row, current_col - 1]
  when :right
    [current_row, current_col + 1]
  end
end

$maze = File.readlines(ARGV[0]).map(&:chomp)
$maze.each { |r| p r.split('') }

$maze_width = $maze.first.length
$max_col = $maze_width - 1
$maze_height = $maze.length
$max_row = $maze_height - 1

start = find_start

print "Maze width: #{$maze_width}\n"
print "Maze height: #{$maze_height}\n"
print "Start: #{start}\n"

path = [start]
first = find_first_move(start)
print "First: #{first}\n"
path << first

previous = start
current = first
loop do
  # print "Location: #{current} #{$maze[current[0]][current[1]]}\n"
  next_location = find_next_move(current, previous)
  # print "Location: #{next_location}, <#{maze[next_location[0][next_location[1]]]}>\n"
  break if next_location == start

  path << next_location
  # p path
  previous = current
  current = next_location
end
p path.length / 2
