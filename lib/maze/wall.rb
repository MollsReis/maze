module Maze
  class Wall

    Z_INDEX = 1
    COLOR = Gosu::Color.new(0xFF1EB1FA)
    WIDTH = 80
    THICKNESS = 4

    def initialize(window, origin, destination, interior)
      @window, @origin, @destination = window, origin, destination
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

    def bounding_boxes
      if opening_at_origin?
        [
          BoundingBox.new(
            [
                Maze::X_OFFSET + @openings[1][0] * WIDTH,
                Maze::Y_OFFSET + @openings[1][1] * WIDTH
            ],
            [
                Maze::X_OFFSET + @destination[0] * WIDTH + THICKNESS,
                Maze::Y_OFFSET + @destination[1] * WIDTH + THICKNESS,
            ]
          )
        ]
      elsif opening_at_destination?
        [
          BoundingBox.new(
            [
              Maze::X_OFFSET + @origin[0] * WIDTH,
              Maze::Y_OFFSET + @origin[1] * WIDTH,
            ],
            [
              Maze::X_OFFSET + @openings[0][0] * WIDTH + THICKNESS,
              Maze::Y_OFFSET + @openings[0][1] * WIDTH + THICKNESS,
            ]
          )
        ]
      elsif @openings
        [
          BoundingBox.new(
            [
              Maze::X_OFFSET + @origin[0] * WIDTH,
              Maze::Y_OFFSET + @origin[1] * WIDTH,
            ],
            [
              Maze::X_OFFSET + @openings[0][0] * WIDTH + THICKNESS,
              Maze::Y_OFFSET + @openings[0][1] * WIDTH + THICKNESS,
            ]
          ),
          BoundingBox.new(
            [
              Maze::X_OFFSET + @openings[1][0] * WIDTH,
              Maze::Y_OFFSET + @openings[1][1] * WIDTH,
            ],
            [
              Maze::X_OFFSET + @destination[0] * WIDTH + THICKNESS,
              Maze::Y_OFFSET + @destination[1] * WIDTH + THICKNESS,
            ]
          )
        ]
      else
        [
          BoundingBox.new(
            [
              Maze::X_OFFSET + @origin[0] * WIDTH,
              Maze::Y_OFFSET + @origin[1] * WIDTH,
            ],
            [
              Maze::X_OFFSET + @destination[0] * WIDTH + THICKNESS,
              Maze::Y_OFFSET + @destination[1] * WIDTH + THICKNESS,
            ]
          )
        ]
      end
    end

    def render
      #TODO fix sharp corners
      if opening_at_origin?
        @window.draw_quad(
            Maze::X_OFFSET + @openings[1][0] * WIDTH,
            Maze::Y_OFFSET + @openings[1][1] * WIDTH,
            COLOR,
            Maze::X_OFFSET + @openings[1][0] * WIDTH + THICKNESS,
            Maze::Y_OFFSET + @openings[1][1] * WIDTH + THICKNESS,
            COLOR,
            Maze::X_OFFSET + @destination[0] * WIDTH,
            Maze::Y_OFFSET + @destination[1] * WIDTH,
            COLOR,
            Maze::X_OFFSET + @destination[0] * WIDTH + THICKNESS,
            Maze::Y_OFFSET + @destination[1] * WIDTH + THICKNESS,
            COLOR,
            Z_INDEX
        )
      elsif opening_at_destination?
        @window.draw_quad(
            Maze::X_OFFSET + @origin[0] * WIDTH,
            Maze::Y_OFFSET + @origin[1] * WIDTH,
            COLOR,
            Maze::X_OFFSET + @origin[0] * WIDTH + THICKNESS,
            Maze::Y_OFFSET + @origin[1] * WIDTH + THICKNESS,
            COLOR,
            Maze::X_OFFSET + @openings[0][0] * WIDTH,
            Maze::Y_OFFSET + @openings[0][1] * WIDTH,
            COLOR,
            Maze::X_OFFSET + @openings[0][0] * WIDTH + THICKNESS,
            Maze::Y_OFFSET + @openings[0][1] * WIDTH + THICKNESS,
            COLOR,
            Z_INDEX
        )
      elsif @openings
        @window.draw_quad(
            Maze::X_OFFSET + @origin[0] * WIDTH,
            Maze::Y_OFFSET + @origin[1] * WIDTH,
            COLOR,
            Maze::X_OFFSET + @origin[0] * WIDTH + THICKNESS,
            Maze::Y_OFFSET + @origin[1] * WIDTH + THICKNESS,
            COLOR,
            Maze::X_OFFSET + @openings[0][0] * WIDTH,
            Maze::Y_OFFSET + @openings[0][1] * WIDTH,
            COLOR,
            Maze::X_OFFSET + @openings[0][0] * WIDTH + THICKNESS,
            Maze::Y_OFFSET + @openings[0][1] * WIDTH + THICKNESS,
            COLOR,
            Z_INDEX
        )
        @window.draw_quad(
            Maze::X_OFFSET + @openings[1][0] * WIDTH,
            Maze::Y_OFFSET + @openings[1][1] * WIDTH,
            COLOR,
            Maze::X_OFFSET + @openings[1][0] * WIDTH + THICKNESS,
            Maze::Y_OFFSET + @openings[1][1] * WIDTH + THICKNESS,
            COLOR,
            Maze::X_OFFSET + @destination[0] * WIDTH,
            Maze::Y_OFFSET + @destination[1] * WIDTH,
            COLOR,
            Maze::X_OFFSET + @destination[0] * WIDTH + THICKNESS,
            Maze::Y_OFFSET + @destination[1] * WIDTH + THICKNESS,
            COLOR,
            Z_INDEX
        )
      else
        @window.draw_quad(
            Maze::X_OFFSET + @origin[0] * WIDTH,
            Maze::Y_OFFSET + @origin[1] * WIDTH,
            COLOR,
            Maze::X_OFFSET + @origin[0] * WIDTH + THICKNESS,
            Maze::Y_OFFSET + @origin[1] * WIDTH + THICKNESS,
            COLOR,
            Maze::X_OFFSET + @destination[0] * WIDTH,
            Maze::Y_OFFSET + @destination[1] * WIDTH,
            COLOR,
            Maze::X_OFFSET + @destination[0] * WIDTH + THICKNESS,
            Maze::Y_OFFSET + @destination[1] * WIDTH + THICKNESS,
            COLOR,
            Z_INDEX
        )
      end
    end

  end
end