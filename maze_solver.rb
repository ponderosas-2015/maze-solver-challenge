class MazeSolver
  START = "o"
  WALL = "#"
  OPEN = "."
  VISITED = "x"
  TARGET = "*"
  CLEAR_SCREEN = "\e[2J\e[f"

  attr_reader :map, :width, :height
  def initialize(filename, strategy)
    @map = File.read(filename)
    @width = @map.index("\n") + 1
    @start = @map.index(START)
    @strategy = strategy
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

  def neighbors(index)
    left_index = index - 1
    top_index = index - @width
    right_index = index + 1
    bottom_index = index + @width
    [left_index, top_index, right_index, bottom_index]
  end

  def valid_neighbor_indices(index)
    # neighbor_indices(index).select(&method(:valid?))
    neighbors(index).select {|n_index| valid?(n_index)}
  end

  def print_map(current_index)
    print CLEAR_SCREEN
    puts @map
    sleep(0.1)
  end

  def dfs_bfs
    queue_stack = []
    queue_stack.push(@start)
    while !queue_stack.empty?
      if @strategy == "bfs"
        current_index = queue_stack.shift
      else
        current_index = queue_stack.pop
      end
      return true if @map[current_index] == TARGET
      @map[current_index] = VISITED
      print_map(current_index)
      neighbors = valid_neighbor_indices(current_index)
      queue_stack.concat(neighbors)
    end
    false
  end

  def dfs_iterative
    stack = []
    stack.push(@start)
    while !stack.empty?
      current_index = stack.pop
      return true if @map[current_index] == TARGET
      @map[current_index] = VISITED
      print_map(current_index)
      neighbors = valid_neighbor_indices(current_index)
      stack.concat(neighbors)
    end
    false
  end

  def run!
    dfs_bfs ? "solvable" : "not solvable"
  end
end
