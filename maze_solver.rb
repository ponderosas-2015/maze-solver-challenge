require_relative 'queue'
require_relative 'stack'

class MazeSolver
  START_CHAR = "o"
  END_CHAR = "*"
  AVAILABLE_CELL = "."
  WALL_CELL = "#"
  VISITED_CELL = "X"

  def initialize
    @maze = nil # ["o#........", ".#####.##.", ".......##.", "######.#*.", ".......###"]
    @store = Queue.new
  end

  def read(text_file)
    @maze = File.readlines(text_file)
    @maze.map!(&:chomp)
  end

  def add_to_store(cell)
    @store.is_a?(Queue) ? @store.enqueue(cell) : @store.push(cell)
  end

  def get_next_in_store
    @store.is_a?(Queue) ? @store.dequeue : @store.pop
  end

  def solve!
    current = find(START_CHAR)
    add_to_store(current)
    until (solved?(current) || @store.empty?)
      current = get_next_in_store
      mark_cell(current)
      # enstore or stack next edges
      find_edges(current).each do |cell|
        add_to_store(cell)
      end
      print_maze
    end
    conclusion = solved?(current) ? "SOLVABLE!" : "UNSOLVABLE"
    print_maze
    puts conclusion
  end

  def solved?(current)
    current == find(END_CHAR)
  end

  def print_maze
    clear_screen
    puts @maze.join("\n")
    sleep(0.1)
  end

  def clear_screen
    print "\e[2J\e[f"
  end

  def find(character)
    @maze.each.with_index do |row, row_index|
      row.each_char.with_index do |char, col_index|
        return [row_index, col_index] if char == character
      end
    end
    nil
  end

  def mark_cell(cell)
    @maze[cell.first][cell.last] = VISITED_CELL if @maze[cell.first][cell.last] == AVAILABLE_CELL
  end

  def find_edges(cell)
    possible_edges(cell).select do |cell|
      within_maze_bounds?(cell) && available?(cell)
    end
  end

  def within_maze_bounds?(cell)
    cell.first >= 0 && cell.last >= 0 && cell.first < @maze.length && cell.last < @maze[cell.first].length
  end

  def available?(cell)
    @maze[cell.first][cell.last] == AVAILABLE_CELL || @maze[cell.first][cell.last] == END_CHAR
  end

  def possible_edges(cell)
    row = cell.first
    col = cell.last
    [[row, col - 1], [row, col + 1], [row + 1, col], [row - 1, col]]
  end

end

text_file = "map.1.txt"
maze_solver = MazeSolver.new
maze_solver.read(text_file)
maze_solver.solve!
