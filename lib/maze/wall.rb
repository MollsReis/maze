module Maze
  class Wall
    
    def initialize(origin, destination)
      @origin, @destination = origin, destination
      create_opening!
    end

    def create_opening!
      #TODO create random opening in wall
    end

    def length
      return @destination[1] - @origin[1] if @origin[0] == @destination[0]
      @destination[0] - @origin[0]
    end

    def render
      #TODO render wall on grid
    end

    def to_s
      "(#{@origin[0]},#{@origin[1]}) -> (#{@destination[0]},#{@destination[1]})"
    end

  end
end