module Maze
  class Core

    def self.create_maze!(size = 10)
      window = Maze::Window.new
      walls = [
          Wall.new(window, [0,0], [0,size], false),
          Wall.new(window, [0,0], [size,0], false),
          Wall.new(window, [size,0], [size,size], false),
          Wall.new(window, [0,size], [size,size], false)
      ]
      Grid.new(window, [0,0], [size,size]).bisect { |w| walls << w }
      hero = Hero.new(window, 60, 60)
      hero.load_flashlight!
      level_exit = LevelExit.new(window, size)
      robots = []
      (size*2).times { robots << Robot.new(window, size) }
      window.load!(walls, hero, level_exit, robots)
      window.show
    end

  end
end