class MazeSolver
  START_CHAR = "o"
  END_CHAR = "*"
  AVAILABLE_CELL = "."

  def initialize
    @maze = nil # ["o#........", ".#####.##.", ".......##.", "######.#*.", ".......###"]
    @start = nil
    @end = nil
  end

  def read(text_file)
    @maze = File.readlines(text_file)
    @maze.map!(&:chomp)
  end

  def solve!
    @start = find(START_CHAR)
    @end = find(END_CHAR)
    @current = @start
    until solved || unsolvable
      # X the current cell
      # enqueue or stack next edges
      # move to any unexplored ones
    end
  end

  def solved
    @current && @current == @end
  end

  def unsolvable
    find(AVAILABLE_CELL).nil?
  end

  def find(character)
    @maze.each.with_index do |row, row_index|
      row.each_char.with_index do |char, col_index|
        return [row_index, col_index] if char == character
      end
    end
    nil
  end


end