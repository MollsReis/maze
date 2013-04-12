module Maze
  module Entity

    class Robot

      Z_INDEX = 2
      BOUNDING_RADIUS = 10
      COLOR = Gosu::Color.new(0xFFCCCCCC)

      def initialize(window, size)
        @window, @size = window, size
        grid_x, grid_y = (@size/5..@size).to_a.sample, (@size/5..@size).to_a.sample
        @x = Maze::X_OFFSET - (Maze::Wall::WIDTH / 2) + (Maze::Wall::WIDTH * grid_x)
        @y = Maze::Y_OFFSET - (Maze::Wall::WIDTH / 2) + (Maze::Wall::WIDTH * grid_y)
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