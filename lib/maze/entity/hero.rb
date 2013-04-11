module Maze
  module Entity
    class Hero

      attr_reader :x, :y

      SPEED = 1.5
      BOUNDING_RADIUS = 5

      def initialize(window, x, y)
        @window = window
        @x, @y = x + Maze::X_OFFSET, y + Maze::Y_OFFSET
      end

      def wall_collide?(new_x = nil, new_y = nil)
        new_x ||= @x
        new_y ||= @y
        @window.walls.each do |wall|
          wall.bounding_boxes.each do |box|
            next if (box.horiz_range.to_a & ((new_x - BOUNDING_RADIUS).to_i..(new_x + BOUNDING_RADIUS).to_i).to_a).empty?
            next if (box.vert_range.to_a & ((new_y - BOUNDING_RADIUS).to_i..(new_y + BOUNDING_RADIUS).to_i).to_a).empty?
            #TODO check circle
            return true
          end
        end
        false
      end

      def move!(dir)
        case dir
          when :forward
            @x += Math.cos(mouse_angle) * SPEED unless wall_collide?(@x + Math.cos(mouse_angle) * SPEED)
            @y += Math.sin(mouse_angle) * SPEED unless wall_collide?(nil, @y + Math.sin(mouse_angle) * SPEED)
          when :back
            @x -= Math.cos(mouse_angle) * SPEED unless wall_collide?(@x - Math.cos(mouse_angle) * SPEED)
            @y -= Math.sin(mouse_angle) * SPEED unless wall_collide?(nil, @y - Math.sin(mouse_angle) * SPEED)
          when :left
            @x += Math.sin(mouse_angle) * SPEED unless wall_collide?(@x + Math.sin(mouse_angle) * SPEED)
            @y -= Math.cos(mouse_angle) * SPEED unless wall_collide?(nil, @y - Math.cos(mouse_angle) * SPEED)
          when :right
            @x -= Math.sin(mouse_angle) * SPEED unless wall_collide?(@x - Math.sin(mouse_angle) * SPEED)
            @y += Math.cos(mouse_angle) * SPEED unless wall_collide?(nil, @y + Math.cos(mouse_angle) * SPEED)
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