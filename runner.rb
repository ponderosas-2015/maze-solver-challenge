require_relative "maze_solver"

strategy = ARGV[0]
my_solver = MazeSolver.new("map.2.txt", strategy)
puts my_solver.run!
