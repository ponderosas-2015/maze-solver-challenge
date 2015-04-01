class MazeSolver
  attr_reader :map, :width, :height
  def initialize(filename)
    @map = File.read(filename)
    @width = @map.index("\n") + 1
    # @height = @map.scan(/\n/).length
  end

# do i need this at all?
  def row_column(index)
    row = index/width
    column = index%width
    [row, column]
  end

  def on_map?(index)
    index >= 0 && index <= (@map.length - 1)
  end

  def open_space?(index)
    # might be able to get rid of the check for the * and just check for .
    @map[index] == "." || @map[index] == "*"
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
    neighbor_indices(index).select {|n_index| valid?(n_index)}
  end

  def walk(index, visited = [])
    neighbors = valid_neighbor_indices(index)
    return "solvable" if @map[index] == "*"
    visited << index
    non_visited_neighbors = neighbors - visited
    non_visited_neighbors.each do |neighbor_index|
      return "solvable" if walk(neighbor_index, visited) == "solvable"
    end
  end

  def run!
    if walk(0) == "solvable"
      return "solvable"
    else
      return "not solvable"
    end
  end

end
