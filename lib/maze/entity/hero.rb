module Maze
  module Entity
    class Hero

      COLOR = Gosu::Color.new(0xFF0000B8)

      def initialize(window, x, y)
        @window, @x, @y = window, x, y
      end

      def draw
        # draw triangle
        # point triangle at cursor
      end

    end
  end
end