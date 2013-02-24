module Maze
  class Window < ::Gosu::Window

    def initialize
      super(640, 480, false)
      self.caption = 'Maze'
      @counter, @but_down = 1, false
      puts $walls[0]
    end

    def update
      if button_down?(::Gosu::KbSpace) && !@but_down
        @but_down = true
        @counter += 1
        puts $walls[@counter - 1] if $walls[@counter - 1]
      end
      @but_down = false if !button_down?(::Gosu::KbSpace)
    end

    def draw
      $walls.first(@counter).each(&:render)
    end

  end
end