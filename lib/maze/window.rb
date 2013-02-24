module Maze
  class Window < ::Gosu::Window

    def initialize
      super(640, 480, false, 100)
      self.caption = 'Maze'
      @counter = 1
    end

    def draw
      puts $walls[@counter - 1] if $walls[@counter - 1]
      $walls.first(@counter).each(&:render)
      @counter += 1
    end

  end
end