module Maze
  class LevelExit

    attr_reader :x, :y

    Z_INDEX = 1
    COLOR = Gosu::Color.new(0xFF33CC33)

    def initialize(window, size)
      @window, @size = window, size
      grid_x, grid_y = (@size/3..@size).to_a.sample, (@size/3..@size).to_a.sample
      @x = Maze::X_OFFSET - (Maze::Wall::WIDTH / 2) + (Maze::Wall::WIDTH * grid_x)
      @y = Maze::Y_OFFSET - (Maze::Wall::WIDTH / 2) + (Maze::Wall::WIDTH * grid_y)
    end

    def render
      @window.draw_quad(
              @x - 10,
              @y - 10,
              COLOR,
              @x + 10,
              @y - 10,
              COLOR,
              @x - 10,
              @y + 10,
              COLOR,
              @x + 10,
              @y + 10,
              COLOR,
              Z_INDEX
      )
    end

  end
end