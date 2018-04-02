# recursive_backtracking.rb

# Puzzle 3x3

# The idea is to solve a 3x3 puzzle described as follows:

#   _________
#->    _____|
#   |     __|
#   |__|_____ ->

#The maze is going to be interpredted as a 3x3 matrix so each state will be
#refereced as an index 0-8

# Starting point is 0 index
# End point is 8th index

# Initially I will store the maze data as follows:
# MAZE = {
#  index_n => [up_node, right_node, down_node, left_node]
# }

# where nodes will be nil if there are no connections

require_relative 'List'

MAZE_ALL = {
  0 => [nil, 1, 3, nil],
  1 => [nil, 2, nil, 1],
  2 => [nil, nil, nil, 2],
  3 => [0, 4, 6, nil],
  4 => [nil, 5, nil, 3],
  5 => [nil, nil, nil, 4],
  6 => [3, nil, nil, nil],
  7 => [4, 8, nil, nil],
  8 => [nil, nil, nil, 7]
}

MAZE_SIMPLY = {
  0 => [1, 3],
  1 => [2,0],
  2 => [1],
  3 => [0, 4, 6],
  4 => [5,7,3],
  5 => [4],
  6 => [3],
  7 => [4,8],
  8 => [7]
}

MAZE_SIMPLY_5x5 = {
  0 => [5],
  1 => [2],
  2 => [3,7,1],
  3 => [8,2],
  4 => [9],
  5 => [0,10],
  6 => [7],
  7 => [2,12,6],
  8 => [3,13],
  9 => [4,14],
  10 => [5,11,15],
  11 => [10],
  12 => [7,17],
  13 => [8,14,18],
  14 => [9,13],
  15 => [10,16,20],
  16 => [15],
  17 => [12,22],
  18 => [13,19,23],
  19 => [18],
  20 => [15,21],
  21 => [22,20],
  22 => [17,21],
  23 => [18,24],
  24 => [23]
}

# MAZE_SIMPLY = MAZE_SIMPLY_5x5


#Defining start and end points
START = 0
FINISH = 8

visited = []
path = []

def solve_maze(maze, start, finish, visited, path)
  sleep 0.5

  # Return the path to start if start is the same end:
  # Return of method will be in the form :
  # [bool, Array, Array]
  # [found_solution, visited, path]
  return [true, [start], [finish]] if start == finish

  visited.push(start)
  iter = List.new(MAZE_SIMPLY[start])
  puts "\n*>>start: #{start}"
  puts "*>>path: #{path}"
  puts "*>>visited: #{visited}"
  # puts "*>>maze>>>>: #{maze}\n"
  puts "*>>iter>>>>: #{iter.ary} - #{iter.val}\n"
  while(!iter.end? ) #|| !visited.index(iter.val)
    if(!visited.index(iter.val))
      try_solve = solve_maze(maze, iter.val, finish, visited, path)
      visited = try_solve[1]
      path = try_solve[2]
      puts "@>>path: #{path}"
      puts "@>>visited: #{visited}"
      if(try_solve[0])
        path.unshift(start)
        puts "@@>>path: #{path}"
        return [true, visited, path]
      end
    end
    iter.nextt
    puts "@@@>>iter: #{iter.ary} - #{iter.val}\n"
  end
  puts "\nending iteration:: #{[false, visited, path]}\n\n"
  return [false, visited, path]
end

puts "\n#{solve_maze(MAZE_SIMPLY, START, FINISH, [], [])}"