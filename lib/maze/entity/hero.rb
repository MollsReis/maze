module Maze
  module Entity
    class Hero

      def initialize(window, x, y)
        @window = window
        @x, @y = x + Maze::X_OFFSET, y + Maze::Y_OFFSET
      end

      def move!(dir)
        case dir
          when :up
            @y -= 1
          when :left
            @x -= 1
          when :down
            @y += 1
          when :right
            @x += 1
        end
      end

      def render
        @window.rotate(mouse_angle, @x, @y) do
          @window.draw_triangle(
                  @x - 5,
                  @y - 10,
                  Maze::HERO_COLOR,
                  @x + 20,
                  @y,
                  Maze::HERO_COLOR,
                  @x - 5,
                  @y + 10,
                  Maze::HERO_COLOR
          )
        end
      end

      def mouse_angle
        Math.atan2(@window.mouse_y - @y, @window.mouse_x - @x) * 180 / Math::PI
      end

    end
  end
end