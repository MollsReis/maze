module Maze
  module Entity
    class Hero

      attr_reader :x, :y

      SPEED = 1.8
      BOUNDING_RADIUS = 5
      Z_INDEX = 2
      COLOR = Gosu::Color.new(0xFF0000B8)

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
        x_move = y_move = 0
        case dir
          when :forward
            x_move = Math.cos(mouse_angle) * SPEED
            y_move = Math.sin(mouse_angle) * SPEED
          when :back
            x_move = Math.cos(mouse_angle) * SPEED * -1.0
            y_move = Math.sin(mouse_angle) * SPEED * -1.0
          when :left
            x_move = Math.sin(mouse_angle) * SPEED
            y_move = Math.cos(mouse_angle) * SPEED * -1.0
          when :right
            x_move = Math.sin(mouse_angle) * SPEED * -1.0
            y_move = Math.cos(mouse_angle) * SPEED
        end
        unless wall_collide?(@x + x_move)
          @x += x_move
          @window.camera_x -= x_move
        end
        unless wall_collide?(nil, @y + y_move)
          @y += y_move
          @window.camera_y -= y_move
        end
      end

      def render
        @window.rotate(mouse_angle * 180 / Math::PI, @x, @y) do
          @window.draw_triangle(
                  @x - 5,
                  @y - 10,
                  COLOR,
                  @x + 20,
                  @y,
                  COLOR,
                  @x - 5,
                  @y + 10,
                  COLOR,
                  Z_INDEX
          )
        end
      end

      def mouse_angle
        Math.atan2(@window.mouse_y - @y - @window.camera_y, @window.mouse_x - @x - @window.camera_x)
      end

    end
  end
end