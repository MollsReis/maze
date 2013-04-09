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
      hero = Entity::Hero.new(window, 10, 10)
      window.load!(walls, hero)
      window.show
    end

  end
end