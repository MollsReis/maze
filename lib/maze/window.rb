module Maze
  class Window < ::Gosu::Window

    def initialize
      super(640, 480, false)
      self.caption = 'Maze'
    end

    def draw
      $walls.each(&:render)
    end

  end
end