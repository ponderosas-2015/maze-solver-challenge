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
    @map[index] == OPEN || @map[index] == TARGET || @map[index] == START
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

  def print_map(current_index, steps)
    print CLEAR_SCREEN
    puts @map
    puts "Steps: #{steps}"
    sleep(0.1)
  end

  def dfs_bfs
    steps = 0
    queue_stack = []
    queue_stack.push(@start)
    while !queue_stack.empty?
      if @strategy == "bfs"
        current_index = queue_stack.shift
      else
        current_index = queue_stack.pop
      end
      if valid?(current_index)
        return true if @map[current_index] == TARGET
        @map[current_index] = VISITED
        print_map(current_index, steps)
        steps += 1
        queue_stack.concat(neighbors(current_index))
      end
    end
    false
  end

  def run!
    dfs_bfs ? "solvable" : "not solvable"
  end
end
