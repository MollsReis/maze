module Maze
  module Entity
    class Hero

      attr_reader :x, :y

      SPEED = 2

      def initialize(window, x, y)
        @window = window
        @x, @y = x + Maze::X_OFFSET, y + Maze::Y_OFFSET
      end

      def move!(dir)
        case dir
          when :forward
            @x += Math.cos(mouse_angle) * SPEED
            @y += Math.sin(mouse_angle) * SPEED
          when :back
            @x -= Math.cos(mouse_angle) * SPEED
            @y -= Math.sin(mouse_angle) * SPEED
          when :left
            @x += Math.sin(mouse_angle) * SPEED
            @y -= Math.cos(mouse_angle) * SPEED
          when :right
            @x -= Math.sin(mouse_angle) * SPEED
            @y += Math.cos(mouse_angle) * SPEED
        end
      end

      def render
        @window.rotate(mouse_angle * 180 / Math::PI, @x, @y) do
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
        Math.atan2(@window.mouse_y - @y, @window.mouse_x - @x)
      end

    end
  end
end