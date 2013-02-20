module Maze
  class Wall
    
    def initialize(origin, destination, interior = true)
      @origin, @destination = origin, destination
      create_opening! if interior
    end

    def create_opening!
      #TODO create random opening in wall
    end

    def length
      return @destination[1] - @origin[1] if @origin[0] == @destination[0]
      @destination[0] - @origin[0]
    end

    def render
      $window.draw_quad(
          Maze::X_OFFSET + @origin[0] * Maze::MUILTIPLIER,
          Maze::Y_OFFSET + @origin[1] * Maze::MUILTIPLIER,
          Maze::COLOR,
          Maze::X_OFFSET + @origin[0] * Maze::MUILTIPLIER + Maze::THICKNESS,
          Maze::Y_OFFSET + @origin[1] * Maze::MUILTIPLIER + Maze::THICKNESS,
          Maze::COLOR,
          Maze::X_OFFSET + @destination[0] * Maze::MUILTIPLIER,
          Maze::Y_OFFSET + @destination[1] * Maze::MUILTIPLIER,
          Maze::COLOR,
          Maze::X_OFFSET + @destination[0] * Maze::MUILTIPLIER + Maze::THICKNESS,
          Maze::Y_OFFSET + @destination[1] * Maze::MUILTIPLIER + Maze::THICKNESS,
          Maze::COLOR
      )
    end

    def to_s
      "(#{@origin[0]},#{@origin[1]}) -> (#{@destination[0]},#{@destination[1]})"
    end

  end
end