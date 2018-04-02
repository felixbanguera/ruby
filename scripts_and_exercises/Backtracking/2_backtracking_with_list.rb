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
require_relative 'List'

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
# START = 0
# FINISH = 8


# For 4X4 maze
#   __________
#-> _______   |
#   |  |    __|
#   |____|  __|
# <-__________|

MAZE_SIMPLY_4x4 = {
  0 => [1],
  1 => [2,0],
  2 => [3,1],
  3 => [7,2],
  4 => [8],
  5 => [6,9],
  6 => [7,10,5],
  7 => [3,6],
  8 => [4,9],
  9 => [5,8],
  10 => [6,11,14],
  11 => [10],
  12 => [13],
  13 => [14,12],
  14 => [10,15,13],
  15 => [14]
}

# MAZE_SIMPLY = MAZE_SIMPLY_4x4
START = 0
FINISH = 12

# For 5X5 maze
#   ________________
#->    |__      |   ->
#   |  |__   |  |  |
#   |   __|  |   __|
#   |   __|  |   __|
#   |________|_____|

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
START = 0
FINISH = 8

# Defining arrays for visited places and current path
visited = []
path = []

# Defining a current point integer iitaiting at START
current = START

# Initializing path in starting point START:
path.push START

visited.push START

puts "\n1>>current: #{current}"
puts "1>>path: #{path}"
puts "1>>visited: #{visited}"
puts "1>>iter>>>>: "
puts "1>>found_outlet: "

# Define while condition:
# while last path place is different from FINISH point, and
# while path is not empty, try to go to the FINISH point
while(path.last != FINISH && !path.empty?)

  # Define the iterator as List class defined in ./List.rb

  iter = List.new(MAZE_SIMPLY[current])
  found_outlet = false

  puts "\n1>>current: #{current}"
  puts "1>>path: #{path}"
  puts "1>>visited: #{visited}"
  puts "1>>iter>>>>: #{iter.ary || nil} - #{iter.val || nil}"
  puts "1>>found_outlet: #{found_outlet}"
  puts "1>>MAZE_SIMPLY[current]: #{MAZE_SIMPLY[current]}"

  # The outlet is supposed to be another step in the...
  #... current point different from the ones visited


  # Define a while loop to find outlets or go back
  # First condition is: <if the iterations hasn't finished>
  # Second conditio is: <Not found extra step>
  while(!iter.end? && !found_outlet)
    puts "\n*>>current: #{current}"
    puts "*>>path: #{path}"
    puts "*>>visited: #{visited}"
    puts "*>>iter>>>>: #{iter.ary || nil} - #{iter.val || nil}"
    puts "*>>found_outlet: #{found_outlet}"
    puts "*>>MAZE_SIMPLY[current]: #{MAZE_SIMPLY[current]}"

    #Check if connection leads to unvisited point
    if(!visited.index(iter.val))
      puts "Found???"
      found_outlet = true;
    else
      iter.nextt
    end
  end
  if(found_outlet)# || !visited.index(iter.val))
    path.push iter.val
    visited.push iter.val
  else
    path.pop
  end

  current = path.last

  puts "\n2>>current: #{current}"
  puts "2>>path: #{path}"
  puts "2>>visited: #{visited}"
  puts "2>>iter>>>>: #{iter.ary || nil} - #{iter.val || nil}"
  puts "2>>found_outlet: #{found_outlet}"
  puts "2>>MAZE_SIMPLY[current]: #{MAZE_SIMPLY[current]}"

# sleep 1
  # return path
end

puts "3>>current: #{current}"
puts "3>>path: #{path}"
puts "3>>visited: #{visited}"


