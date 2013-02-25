module Maze
  class Grid

    def initialize(top_left, bottom_right)
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
      yield Wall.new([@wall_cord, @min_y], [@wall_cord, @max_y], true, to_s)
      Grid.new([@min_x, @min_y], [@wall_cord, @max_y]).bisect { |w| yield w } unless @wall_cord - 1 == @min_x
      Grid.new([@wall_cord, @min_y], [@max_x, @max_y]).bisect { |w| yield w } unless @wall_cord + 1 == @max_x
    end

    def horizontal_bisect
      @wall_cord = random_wall_coord(:horizontal)
      yield Wall.new([@min_x, @wall_cord], [@max_x, @wall_cord], true, to_s)
      Grid.new([@min_x, @min_y], [@max_x, @wall_cord]).bisect { |w| yield w } unless @wall_cord - 1 == @min_y
      Grid.new([@min_x, @wall_cord], [@max_x, @max_y]).bisect { |w| yield w } unless @wall_cord + 1 == @max_y
    end

    def vertical_wall?
      return [true, false].sample if @width == @height
      @width > @height ? true : false
    end

    def random_wall_coord(orientation)
      return [*@min_x + 1 .. @max_x - 1].sample if orientation == :vertical
      [*@min_y + 1 .. @max_y - 1].sample
    end

    def to_s
      "GRID: (#{@min_x},#{@min_y}) -> (#{@max_x},#{@max_y}) WALL COORD: #{@wall_cord}"
    end

  end
end