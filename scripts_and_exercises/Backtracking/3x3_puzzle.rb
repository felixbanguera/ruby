# Backtraking
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

#Defining start and end points
START = 8
FINISH = 0

# Defining arrays for visited places and current path
visited = []
path = []

# Defining a current point integer iitaiting at START
current = START

# Initializing path in starting point START:
path.push START
visited.push START

# Define while condition:
# while last path place is different from FINISH point, and
# while path is not empty, try to go to the FINISH point
while(path.last != FINISH && !path.empty?)
    puts "1>>current: #{current}"
    puts "1>>path: #{path}"
    puts "1>>visited: #{visited}"

  # Define the iterator??? Not sure here
  idx_iter = 0
  iter = MAZE_SIMPLY[current][idx_iter]
  # while(visited.index(iter))
  #   idx_iter += 1
  #   iter = MAZE_SIMPLY[current][idx_iter]
  # end

  puts "iter>>>>: #{iter}"
  # The outlet is supposed to be another step in the...
  #... current point different from the ones visited
  found_outlet = false

  # Define a while loop to find outlets or go back
  # First condition is: <if the iterations hasn't finished>
  # Second conditio is: <Not found path>
  while(MAZE_SIMPLY[current].last != iter && !found_outlet)

    #Check if connection leads to unvisited point
    if(!visited.index(iter))
      found_outlet = true;
    else
      idx_iter += 1
      iter = MAZE_SIMPLY[current][idx_iter]
    end
  end
  if(found_outlet || !visited.index(iter))
    path.push iter
    visited.push iter
  else
    path.pop
  end

  current = path.last

  puts "2>>current: #{current}"
  puts "2>>path: #{path}"
  puts "2>>visited: #{visited}"
  puts "2>>iter: #{iter}"

# sleep 1
  # return path
end

puts "3>>current: #{current}"
puts "3>>path: #{path}"
puts "3>>visited: #{visited}"


