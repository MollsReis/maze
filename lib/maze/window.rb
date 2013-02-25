module Maze
  class Window < ::Gosu::Window

    def initialize
      super(640, 480, false)
      self.caption = 'Maze'
      @counter, @but_down = 1, false
      $logger.debug $walls[0] if $debug
    end

    def update
      if button_down?(::Gosu::KbSpace) && !@but_down && $debug
        @but_down = true
        @counter += 1
        $logger.debug $walls[@counter - 1] if $walls[@counter - 1]
      elsif !$debug
        @counter += 1
      end
      @but_down = false if !button_down?(::Gosu::KbSpace) && $debug
    end

    def draw
      $walls.first(@counter).each(&:render)
    end

  end
end