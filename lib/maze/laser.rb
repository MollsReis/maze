module Maze
  class Laser

    SPEED = 10
    LENGTH = 20
    FRONT_COLOR =  Gosu::Color.new(0xFFFF0000)
    BACK_COLOR = Gosu::Color.new(0x11FF0000)
    THICKNESS = 2
    Z_INDEX = 1

    def initialize(window, x, y, angle)
      @window, @x ,@y, @angle = window, x, y, angle
      @thickness_x_val = Math.cos(@angle + (Math::PI / 2)) * THICKNESS
      @thickness_y_val = Math.sin(@angle + (Math::PI / 2)) * THICKNESS
    end

    def move!
      x_move = Math.cos(@angle) * SPEED
      y_move = Math.sin(@angle) * SPEED
      return if check_wall_collide!(@x + x_move, @y + y_move)
      return if check_robot_collide!(@x + x_move, @y + y_move)
      @x += x_move
      @y += y_move
    end

    def check_wall_collide!(new_x, new_y)
      @window.walls.each do |wall|
        wall.bounding_boxes.each do |box|
          next if (box.horiz_range.to_a & horiz_range(new_x).to_a).empty?
          next if (box.vert_range.to_a & vert_range(new_y).to_a).empty?
          @window.lasers.delete(self)
          return true
        end
      end
      false
    end

    def check_robot_collide!(new_x, new_y)
      @window.robots.each do |robot|
        next if (robot.bounding_box.horiz_range.to_a & horiz_range(new_x).to_a).empty?
        next if (robot.bounding_box.vert_range.to_a & vert_range(new_y).to_a).empty?
        @window.robots.delete(robot)
        @window.lasers.delete(self)
        return true
      end
      false
    end

    def horiz_range(new_x)
      return (@x.to_i..new_x.to_i) if @x.to_i < new_x.to_i
      return (@x.to_i..(new_x + 1).to_i) if @x.to_i == new_x.to_i
      (new_x.to_i..@x.to_i)
    end

    def vert_range(new_y)
      return (@y.to_i..new_y.to_i) if @y.to_i < new_y.to_i
      return (@y.to_i..(new_y + 1).to_i) if @y.to_i == new_y.to_i
      (new_y.to_i..@y.to_i)
    end

    def horiz_length
      Math.cos(@angle) * LENGTH
    end

    def vert_length
      Math.sin(@angle) * LENGTH
    end

    def render
      @window.draw_quad(
              @x,
              @y,
              FRONT_COLOR,
              @x + @thickness_x_val,
              @y + @thickness_y_val,
              FRONT_COLOR,
              @x - horiz_length,
              @y - vert_length,
              BACK_COLOR,
              @x - horiz_length + @thickness_x_val,
              @y - vert_length + @thickness_y_val,
              BACK_COLOR,
              Z_INDEX
      )
    end

  end
end