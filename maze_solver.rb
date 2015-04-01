class MazeSolver
  START = "o"
  WALL = "#"
  OPEN = "."
  VISITED = "x"
  TARGET = "*"
  CLEAR_SCREEN = "\e[2J\e[f"

  attr_reader :map, :width, :height
  def initialize(filename)
    @map = File.read(filename)
    @width = @map.index("\n") + 1
    @start = @map.index(START)
  end

  def on_map?(index)
    index >= 0 && index <= (@map.length - 1)
  end

  def open_space?(index)
    # might be able to get rid of the check for the * and just check for .
    @map[index] == OPEN || @map[index] == TARGET
  end

  def valid?(index)
    return on_map?(index) && open_space?(index)
  end

  def neighbor_indices(index)
    left_index = index - 1
    top_index = index - @width
    right_index = index + 1
    bottom_index = index + @width
    [left_index, top_index, right_index, bottom_index]
  end

  def valid_neighbor_indices(index)
    # neighbor_indices(index).select(&method(:valid?))
    neighbor_indices(index).select {|n_index| valid?(n_index)}
  end

  def print_map(current_index)
    print CLEAR_SCREEN
    @map[current_index] = VISITED
    puts @map
    sleep(0.1)
  end

  def dfs(index, visited = [])
    return true if @map[index] == TARGET
    print_map(index)
    sleep(0.1)
    neighbors = valid_neighbor_indices(index)
    visited << index
    non_visited_neighbors = neighbors - visited
    non_visited_neighbors.each do |neighbor_index|
      return true if dfs(neighbor_index, visited)
    end
    false
  end

  def bfs
    queue = []
    queue.push(@start)
    while !queue.empty?
      current_index = queue.shift
      return true if @map[current_index] == TARGET
      print_map(current_index)
      neighbors = valid_neighbor_indices(current_index)
      queue.concat(neighbors)
    end
    false
  end

  def dfs_iterative
    stack = []
    stack.push(@start)
    while !stack.empty?
      current_index = stack.pop
      return true if @map[current_index] == TARGET
      print_map(current_index)
      neighbors = valid_neighbor_indices(current_index)
      stack.concat(neighbors)
    end
    false
  end

  def run!
    # puts "please enter the strategy you would like to use (dfs or bfs):"
    # response = gets.chomp
    strategy  = ARGV[0]
    if strategy == "dfs"
      dfs_iterative ? "solvable" : "not solvable"
      # dfs(@start) ? "solvable" : "not solvable"
    else
      bfs ? "solvable" : "not solvable"
    end
  end
end
