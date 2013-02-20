module Maze
  class Core

    def self.create_maze!
      walls = []
      Grid.new([0,0], [5,5]).bisect { |w| walls << w }
      Window.new.show
    end

  end
end