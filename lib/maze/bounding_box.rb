module Maze
  class BoundingBox

    def initialize(top_left, bottom_right)
      @min_x, @min_y = top_left[0], top_left[1]
      @max_x, @max_y = bottom_right[0], bottom_right[1]
    end

    def corners
      [
        [@min_x, @min_y],
        [@min_x, @max_y],
        [@max_x, @min_y],
        [@max_x, @max_y]
      ]
    end

    def nearest_corner(x, y)
      closest, min_dist = nil
      corners.each do |point|
        dist = Math.hypot(point[0] - x, point[1] - y)
        closest, min_dist = point, dist if !closest || min_dist > dist
      end
      closest
    end

    def horiz_range
      (@min_x.to_i..@max_x.to_i)
    end

    def vert_range
      (@min_y.to_i..@max_y.to_i)
    end

  end
end