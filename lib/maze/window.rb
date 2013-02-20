module Maze
  class Window < ::Gosu::Window

    def initialize
      super(640, 480, false)
      self.caption = 'Maze'
    end

  end
end