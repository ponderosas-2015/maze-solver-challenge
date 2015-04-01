require_relative 'maze_solver'

describe MazeSolver do
  let(:text_file) {'map.1.txt'}
  let(:maze_solver) {MazeSolver.new}
  let(:ready_solver) do
    maze_solver.read(text_file)
    maze_solver
  end

	describe '::new' do
		it 'returns a new instance of MazeSolver' do
			expect(MazeSolver.new).to be_an_instance_of MazeSolver
		end
	end

  describe 'read(text_file)' do
    it 'reads a text file into a data structure' do
      maze_solver.read(text_file)
      expect(maze_solver.instance_variable_get(:@maze)).not_to be nil
    end
  end

  describe 'find(char)' do
    it 'finds the start index' do
      expect(ready_solver.find('o')).to eq [0,0]
    end
    it 'finds the end index' do
      expect(ready_solver.find('*')).to eq [3,8]
    end
  end

end
