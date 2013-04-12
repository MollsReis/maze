module Maze
  module Entity

    class Robot

      Z_INDEX = 2
      SPEED = 1.2
      LOS_RANGE = 100
      BOUNDING_RADIUS = 10
      COLOR = Gosu::Color.new(0xFFCCCCCC)

      def initialize(window, size)
        @window, @size = window, size
        grid_x, grid_y = (@size/5..@size).to_a.sample, (@size/5..@size).to_a.sample
        @x = Maze::X_OFFSET - (Maze::Wall::WIDTH / 2) + (Maze::Wall::WIDTH * grid_x)
        @y = Maze::Y_OFFSET - (Maze::Wall::WIDTH / 2) + (Maze::Wall::WIDTH * grid_y)
      end

      def wall_collide?(new_x = nil, new_y = nil)
        new_x ||= @x
        new_y ||= @y
        @window.walls.each do |wall|
          wall.bounding_boxes.each do |box|
            next if (box.horiz_range.to_a & ((new_x - BOUNDING_RADIUS).to_i..(new_x + BOUNDING_RADIUS).to_i).to_a).empty?
            next if (box.vert_range.to_a & ((new_y - BOUNDING_RADIUS).to_i..(new_y + BOUNDING_RADIUS).to_i).to_a).empty?
            return true
          end
        end
        false
      end

      def move!
        angle = Math.atan2(@y - @window.hero.y, @x - @window.hero.x)
        x_move = Math.cos(angle) * SPEED
        y_move = Math.sin(angle) * SPEED
        @x -= x_move unless wall_collide?(@x - x_move)
        @y -= y_move unless wall_collide?(nil, @y - y_move)
      end

      def see_hero?
        return false if distance_to_hero > LOS_RANGE
        true
      end

      def distance_to_hero
        Math.hypot(@x - @window.hero.x, @y - @window.hero.y)
      end

      def bounding_box
        BoundingBox.new([@x - BOUNDING_RADIUS,
                         @y - BOUNDING_RADIUS],
                        [@x + BOUNDING_RADIUS,
                         @y + BOUNDING_RADIUS])
      end

      def render
        @window.draw_quad(
                @x - BOUNDING_RADIUS,
                @y - BOUNDING_RADIUS,
                COLOR,
                @x + BOUNDING_RADIUS,
                @y - BOUNDING_RADIUS,
                COLOR,
                @x - BOUNDING_RADIUS,
                @y + BOUNDING_RADIUS,
                COLOR,
                @x + BOUNDING_RADIUS,
                @y + BOUNDING_RADIUS,
                COLOR,
                Z_INDEX
        )
      end

    end

  end
end