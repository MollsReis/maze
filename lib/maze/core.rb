module Maze
  class Core

    def self.create_maze!
      window = Maze::Window.new
      walls = [
          Wall.new(window, [0,0], [0,10], false),
          Wall.new(window, [0,0], [10,0], false),
          Wall.new(window, [10,0], [10,10], false),
          Wall.new(window, [0,10], [10,10], false)
      ]
      Grid.new(window, [0,0], [10,10]).bisect { |w| walls << w }
      window.load_walls!(walls)
      window.show
    end

  end
end