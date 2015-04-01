require_relative "maze_solver"

describe "MazeSolver" do
  let (:solver) {MazeSolver.new("map.1.txt")}
  describe "::new(filename)" do
    it "reads in the map from a file" do
      map_string = <<-m
o#........
.#####.##.
.......##.
######.#*.
.......###
m
      expect(solver.map).to be_a String
      expect(solver.map).to eq map_string
      expect(solver.width).to eq 11
    end
  end

  describe ".row_column(index)" do
    it "returns an array with the correct row and column for the index" do
      expect(solver.row_column(0)).to eq [0,0]
      expect(solver.row_column(9)).to eq [0,9]
      expect(solver.row_column(10)).to eq [0,10]
      expect(solver.row_column(14)).to eq [1,3]
      expect(solver.row_column(53)).to eq [4,9]
    end
  end

  describe "::valid?(index)" do
    context "there is a . or * there" do
      it "returns true" do
        expect(solver.valid?(2)).to be true
        expect(solver.valid?(11)).to be true
      end
    end
    context "there is # or newline or x there" do
      it "returns false" do
        expect(solver.valid?(1)).to be false
        expect(solver.valid?(12)).to be false
        expect(solver.valid?(53)).to be false
      end
    end
    context "the index is off the map" do
      it "returns false" do
        expect(solver.valid?(-1)).to be false
        expect(solver.valid?(54)).to be false
      end
    end
  end
  describe ".valid_neighbor_indices(index)" do
    context "the index is in a corner" do
      it "returns the correct neighbor indices" do
        expect(solver.valid_neighbor_indices(9)).to eq [8, 20]
      end
    end
    context "the index is in the middle" do
      it "returns the correct neighbor indices" do
        expect(solver.valid_neighbor_indices(17)).to eq [6, 28]
      end
    end
  end
  describe "::new(filename)" do
    it "" do
    end
  end
end
