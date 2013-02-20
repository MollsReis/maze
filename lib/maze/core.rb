module Maze
  class Core

    def self.create_maze!
      $walls = [
          Wall.new([0,0], [0,10], false),
          Wall.new([0,0], [10,0], false),
          Wall.new([10,0], [10,10], false),
          Wall.new([0,10], [10,10], false)
      ]
      Grid.new([0,0], [10,10]).bisect { |w| $walls << w }
      $window = Window.new
      $window.show
    end

  end
end