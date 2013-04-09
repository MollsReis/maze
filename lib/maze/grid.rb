module Maze
  class Grid

    def initialize(window, top_left, bottom_right)
      @window = window
      @min_x, @min_y = top_left[0], top_left[1]
      @max_x, @max_y = bottom_right[0], bottom_right[1]
      @width, @height = @max_x - @min_x, @max_y - @min_y
    end

    def bisect
      return nil if @width <= 1 || @height <= 1
      if vertical_wall?
        vertical_bisect { |w| yield w }
      else
        horizontal_bisect { |w| yield w }
      end
    end

    def vertical_bisect
      @wall_cord = random_wall_coord(:vertical)
      yield Wall.new(@window, [@wall_cord, @min_y], [@wall_cord, @max_y], true, to_s)
      Grid.new(@window, [@min_x, @min_y], [@wall_cord, @max_y]).bisect { |w| yield w } unless @wall_cord - 1 == @min_x
      Grid.new(@window, [@wall_cord, @min_y], [@max_x, @max_y]).bisect { |w| yield w } unless @wall_cord + 1 == @max_x
    end

    def horizontal_bisect
      @wall_cord = random_wall_coord(:horizontal)
      yield Wall.new(@window, [@min_x, @wall_cord], [@max_x, @wall_cord], true, to_s)
      Grid.new(@window, [@min_x, @min_y], [@max_x, @wall_cord]).bisect { |w| yield w } unless @wall_cord - 1 == @min_y
      Grid.new(@window, [@min_x, @wall_cord], [@max_x, @max_y]).bisect { |w| yield w } unless @wall_cord + 1 == @max_y
    end

    def vertical_wall?
      return [true, false].sample if @width == @height
      @width > @height ? true : false
    end

    def random_wall_coord(orientation)
      return [*@min_x + 1 .. @max_x - 1].sample if orientation == :vertical
      [*@min_y + 1 .. @max_y - 1].sample
    end

  end
end