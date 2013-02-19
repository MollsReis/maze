module Maze
  class Core

    def self.create_maze!
      walls = []
      Maze::Grid.new([0,0], [5,5]).bisect { |w| walls << w }
      walls
    end

  end
end