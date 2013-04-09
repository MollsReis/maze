module Maze
  class Wall

    def initialize(window, origin, destination, interior, grid_s = '')
      @window, @origin, @destination, @grid_s = window, origin, destination, grid_s
      @grid_s = "\n#{grid_s}\n" unless grid_s.empty?
      create_opening! if interior
    end

    def create_opening!
      if @origin[0] == @destination[0]
        coord = [*@origin[1] .. @destination[1] - 1].sample
        @openings = [[@origin[0], coord], [@origin[0], coord + 1]]
      else
        coord = [*@origin[0] .. @destination[0] - 1].sample
        @openings = [[coord, @origin[1]], [coord + 1, @origin[1]]]
      end
    end

    def opening_at_origin?
      @openings && @origin[0] == @openings[0][0] && @origin[1] == @openings[0][1]
    end

    def opening_at_destination?
      @openings && @destination[0] == @openings[1][0] && @destination[1] == @openings[1][1]
    end

    def render
      if opening_at_origin?
        @window.draw_quad(
            Maze::X_OFFSET + @openings[1][0] * Maze::MULTIPLIER,
            Maze::Y_OFFSET + @openings[1][1] * Maze::MULTIPLIER,
            Maze::MAZE_COLOR,
            Maze::X_OFFSET + @openings[1][0] * Maze::MULTIPLIER + Maze::THICKNESS,
            Maze::Y_OFFSET + @openings[1][1] * Maze::MULTIPLIER + Maze::THICKNESS,
            Maze::MAZE_COLOR,
            Maze::X_OFFSET + @destination[0] * Maze::MULTIPLIER,
            Maze::Y_OFFSET + @destination[1] * Maze::MULTIPLIER,
            Maze::MAZE_COLOR,
            Maze::X_OFFSET + @destination[0] * Maze::MULTIPLIER + Maze::THICKNESS,
            Maze::Y_OFFSET + @destination[1] * Maze::MULTIPLIER + Maze::THICKNESS,
            Maze::MAZE_COLOR
        )
      elsif opening_at_destination?
        @window.draw_quad(
            Maze::X_OFFSET + @origin[0] * Maze::MULTIPLIER,
            Maze::Y_OFFSET + @origin[1] * Maze::MULTIPLIER,
            Maze::MAZE_COLOR,
            Maze::X_OFFSET + @origin[0] * Maze::MULTIPLIER + Maze::THICKNESS,
            Maze::Y_OFFSET + @origin[1] * Maze::MULTIPLIER + Maze::THICKNESS,
            Maze::MAZE_COLOR,
            Maze::X_OFFSET + @openings[0][0] * Maze::MULTIPLIER,
            Maze::Y_OFFSET + @openings[0][1] * Maze::MULTIPLIER,
            Maze::MAZE_COLOR,
            Maze::X_OFFSET + @openings[0][0] * Maze::MULTIPLIER + Maze::THICKNESS,
            Maze::Y_OFFSET + @openings[0][1] * Maze::MULTIPLIER + Maze::THICKNESS,
            Maze::MAZE_COLOR
        )
      elsif @openings
        @window.draw_quad(
            Maze::X_OFFSET + @origin[0] * Maze::MULTIPLIER,
            Maze::Y_OFFSET + @origin[1] * Maze::MULTIPLIER,
            Maze::MAZE_COLOR,
            Maze::X_OFFSET + @origin[0] * Maze::MULTIPLIER + Maze::THICKNESS,
            Maze::Y_OFFSET + @origin[1] * Maze::MULTIPLIER + Maze::THICKNESS,
            Maze::MAZE_COLOR,
            Maze::X_OFFSET + @openings[0][0] * Maze::MULTIPLIER,
            Maze::Y_OFFSET + @openings[0][1] * Maze::MULTIPLIER,
            Maze::MAZE_COLOR,
            Maze::X_OFFSET + @openings[0][0] * Maze::MULTIPLIER + Maze::THICKNESS,
            Maze::Y_OFFSET + @openings[0][1] * Maze::MULTIPLIER + Maze::THICKNESS,
            Maze::MAZE_COLOR
        )
        @window.draw_quad(
            Maze::X_OFFSET + @openings[1][0] * Maze::MULTIPLIER,
            Maze::Y_OFFSET + @openings[1][1] * Maze::MULTIPLIER,
            Maze::MAZE_COLOR,
            Maze::X_OFFSET + @openings[1][0] * Maze::MULTIPLIER + Maze::THICKNESS,
            Maze::Y_OFFSET + @openings[1][1] * Maze::MULTIPLIER + Maze::THICKNESS,
            Maze::MAZE_COLOR,
            Maze::X_OFFSET + @destination[0] * Maze::MULTIPLIER,
            Maze::Y_OFFSET + @destination[1] * Maze::MULTIPLIER,
            Maze::MAZE_COLOR,
            Maze::X_OFFSET + @destination[0] * Maze::MULTIPLIER + Maze::THICKNESS,
            Maze::Y_OFFSET + @destination[1] * Maze::MULTIPLIER + Maze::THICKNESS,
            Maze::MAZE_COLOR
        )
      else
        @window.draw_quad(
            Maze::X_OFFSET + @origin[0] * Maze::MULTIPLIER,
            Maze::Y_OFFSET + @origin[1] * Maze::MULTIPLIER,
            Maze::MAZE_COLOR,
            Maze::X_OFFSET + @origin[0] * Maze::MULTIPLIER + Maze::THICKNESS,
            Maze::Y_OFFSET + @origin[1] * Maze::MULTIPLIER + Maze::THICKNESS,
            Maze::MAZE_COLOR,
            Maze::X_OFFSET + @destination[0] * Maze::MULTIPLIER,
            Maze::Y_OFFSET + @destination[1] * Maze::MULTIPLIER,
            Maze::MAZE_COLOR,
            Maze::X_OFFSET + @destination[0] * Maze::MULTIPLIER + Maze::THICKNESS,
            Maze::Y_OFFSET + @destination[1] * Maze::MULTIPLIER + Maze::THICKNESS,
            Maze::MAZE_COLOR
        )
      end
    end

  end
end