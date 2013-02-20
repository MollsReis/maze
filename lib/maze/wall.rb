module Maze
  class Wall
    
    def initialize(origin, destination, interior = true)
      @origin, @destination = origin, destination
      create_opening! if interior
    end

    def create_opening!
      if @origin[0] == @destination[0]
        coord = (@origin[1]..@destination[1] - 1).to_a.sample
        @openings = [[@origin[0], coord], [@origin[0], coord + 1]]
      else
        coord = (@origin[0]..@destination[0] - 1).to_a.sample
        @openings = [[coord, @origin[1]], [coord + 1, @origin[1]]]
      end
    end

    def render
      if @openings
        $window.draw_quad(
            Maze::X_OFFSET + @origin[0] * Maze::MUILTIPLIER,
            Maze::Y_OFFSET + @origin[1] * Maze::MUILTIPLIER,
            Maze::COLOR,
            Maze::X_OFFSET + @origin[0] * Maze::MUILTIPLIER + Maze::THICKNESS,
            Maze::Y_OFFSET + @origin[1] * Maze::MUILTIPLIER + Maze::THICKNESS,
            Maze::COLOR,
            Maze::X_OFFSET + @openings[0][0] * Maze::MUILTIPLIER,
            Maze::Y_OFFSET + @openings[0][1] * Maze::MUILTIPLIER,
            Maze::COLOR,
            Maze::X_OFFSET + @openings[0][0] * Maze::MUILTIPLIER + Maze::THICKNESS,
            Maze::Y_OFFSET + @openings[0][1] * Maze::MUILTIPLIER + Maze::THICKNESS,
            Maze::COLOR
        )
        $window.draw_quad(
            Maze::X_OFFSET + @openings[1][0] * Maze::MUILTIPLIER,
            Maze::Y_OFFSET + @openings[1][1] * Maze::MUILTIPLIER,
            Maze::COLOR,
            Maze::X_OFFSET + @openings[1][0] * Maze::MUILTIPLIER + Maze::THICKNESS,
            Maze::Y_OFFSET + @openings[1][1] * Maze::MUILTIPLIER + Maze::THICKNESS,
            Maze::COLOR,
            Maze::X_OFFSET + @destination[0] * Maze::MUILTIPLIER,
            Maze::Y_OFFSET + @destination[1] * Maze::MUILTIPLIER,
            Maze::COLOR,
            Maze::X_OFFSET + @destination[0] * Maze::MUILTIPLIER + Maze::THICKNESS,
            Maze::Y_OFFSET + @destination[1] * Maze::MUILTIPLIER + Maze::THICKNESS,
            Maze::COLOR
        )
      else
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
    end

    def to_s
      "(#{@origin[0]},#{@origin[1]}) -> (#{@destination[0]},#{@destination[1]})"
    end

  end
end