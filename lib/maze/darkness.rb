module Maze
  class Darkness

    Z_INDEX = 3
    MAX_LIGHT_RADIUS = 160
    UMBRA_COLOR = Gosu::Color.new(0xFF000000)
    PENUMBRA_COLOR = Gosu::Color.new(0x55000000)

    def initialize(window)
      @window = window
      @flashlight = Gosu::Image.new(@window,
                                    '../media/flashlight.png',
                                    false, 0, 0, 320, 320)
    end

    def render
      @flashlight.draw(@window.hero.x - 160, @window.hero.y - 160, Z_INDEX)
    end

  end
end