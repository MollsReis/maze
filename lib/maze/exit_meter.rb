module Maze
  class ExitMeter

    BORDER_COLOR = Gosu::Color.new(0xffffffff)
    BORDER_WIDTH = 1
    BORDER_Z = 10

    METER_COLOR_FAR = Gosu::Color.new(0xffff0000)
    METER_COLOR_CLOSE = Gosu::Color.new(0xff00ff00)
    WIDTH = 100
    HEIGHT = 15
    METER_Z = 11

    MARKER_COLOR = Gosu::Color.new(0xffffffff)
    MARKER_WIDTH = 2
    MARKER_HEIGHT = HEIGHT + 4
    MARKER_Z = 12


    def initialize(window, x, y, size)
      @window, @x, @y, @size = window, x, y, size
    end

    def max_distance
      Math.sqrt(((Maze::Wall::WIDTH * @size) ** 2) * 2)
    end

    def proximity_offset
      (1 - (@window.hero.exit_distance / max_distance)) * WIDTH
    end

    def render
      @window.draw_quad(
              @x,
              @y,
              BORDER_COLOR,
              @x + WIDTH,
              @y,
              BORDER_COLOR,
              @x,
              @y + HEIGHT,
              BORDER_COLOR,
              @x + WIDTH,
              @y + HEIGHT,
              BORDER_COLOR,
              BORDER_Z
      )
      @window.draw_quad(
              @x + BORDER_WIDTH,
              @y + BORDER_WIDTH,
              METER_COLOR_FAR,
              @x + WIDTH - BORDER_WIDTH,
              @y + BORDER_WIDTH,
              METER_COLOR_CLOSE,
              @x + BORDER_WIDTH,
              @y + HEIGHT - BORDER_WIDTH,
              METER_COLOR_FAR,
              @x + WIDTH - BORDER_WIDTH,
              @y + HEIGHT - BORDER_WIDTH,
              METER_COLOR_CLOSE,
              METER_Z
      )
      @window.draw_quad(
              @x + proximity_offset,
              @y,
              MARKER_COLOR,
              @x + proximity_offset + MARKER_WIDTH,
              @y,
              MARKER_COLOR,
              @x + proximity_offset,
              @y + HEIGHT,
              MARKER_COLOR,
              @x + proximity_offset + MARKER_WIDTH,
              @y + HEIGHT,
              MARKER_COLOR,
              MARKER_Z
      )
      @window.font.draw('EXIT PROXIMITY', @x, @y - 15, 100)
    end

  end
end