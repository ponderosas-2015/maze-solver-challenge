require_relative "maze_solver"

my_solver = MazeSolver.new("map.2.txt")
puts my_solver.run!
