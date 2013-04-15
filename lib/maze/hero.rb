module Maze
  class Hero

    attr_reader :x, :y

    BASE_SPEED = 1.8
    SPRINT_BOOST = 1.5
    BOUNDING_RADIUS = 5
    Z_INDEX = 2
    FLASHLIGHT_Z = 3
    FLASHLIGHT_IMAGE = File.join(File.dirname(__FILE__), '..', '..', 'media', 'flashlight.png')
    COLOR = Gosu::Color.new(0xFF0000B8)

    def initialize(window, x, y)
      @window = window
      @x, @y = x + Maze::X_OFFSET, y + Maze::Y_OFFSET
    end

    def load_flashlight!
      @flashlight = Gosu::Image.new(@window, FLASHLIGHT_IMAGE, false, 0, 0, 320, 320)
    end

    def wall_collide?(new_x = nil, new_y = nil)
      return false if $noclip
      new_x ||= @x
      new_y ||= @y
      @window.walls.each do |wall|
        wall.bounding_boxes.each do |box|
          next if (box.horiz_range.to_a & ((new_x - BOUNDING_RADIUS).to_i..(new_x + BOUNDING_RADIUS).to_i).to_a).empty?
          next if (box.vert_range.to_a & ((new_y - BOUNDING_RADIUS).to_i..(new_y + BOUNDING_RADIUS).to_i).to_a).empty?
          return true
        end
      end
      false
    end

    def robot_collide?
      @window.robots.each do |robot|
        box = robot.bounding_box
        next if (box.horiz_range.to_a & ((@x - BOUNDING_RADIUS).to_i..(@x + BOUNDING_RADIUS).to_i).to_a).empty?
        next if (box.vert_range.to_a & ((@y - BOUNDING_RADIUS).to_i..(@y + BOUNDING_RADIUS).to_i).to_a).empty?
        return true
      end
      false
    end

    def sprinting?
      @window.button_down? Gosu::KbLeftShift
    end

    def num_movement_keys
      [Gosu::KbW, Gosu::KbS, Gosu::KbA, Gosu::KbD].inject(0) do |total, key|
        total += 1 if @window.button_down? key; total
      end || 1
    end

    def speed
      return (BASE_SPEED / num_movement_keys) * SPRINT_BOOST if sprinting?
      (BASE_SPEED / num_movement_keys)
    end

    def move!(dir)
      x_move = y_move = 0
      case dir
        when :forward
          x_move = Math.cos(mouse_angle) * speed
          y_move = Math.sin(mouse_angle) * speed
        when :back
          x_move = Math.cos(mouse_angle) * speed * -1.0
          y_move = Math.sin(mouse_angle) * speed * -1.0
        when :left
          x_move = Math.sin(mouse_angle) * speed
          y_move = Math.cos(mouse_angle) * speed * -1.0
        when :right
          x_move = Math.sin(mouse_angle) * speed * -1.0
          y_move = Math.cos(mouse_angle) * speed
      end
      unless wall_collide?(@x + x_move)
        @x += x_move
        @window.camera_x -= x_move
      end
      unless wall_collide?(nil, @y + y_move)
        @y += y_move
        @window.camera_y -= y_move
      end
    end

    def render
      @window.rotate(mouse_angle * 180 / Math::PI, @x, @y) do
        @window.draw_triangle(
                @x - 5,
                @y - 10,
                COLOR,
                @x + 20,
                @y,
                COLOR,
                @x - 5,
                @y + 10,
                COLOR,
                Z_INDEX
        )
      end
      @flashlight.draw(@x - 160, @y - 160, FLASHLIGHT_Z)
    end

    def mouse_angle
      Math.atan2(@window.mouse_y - @y - @window.camera_y, @window.mouse_x - @x - @window.camera_x)
    end

    def exit_distance
      Math.hypot(@window.level_exit.x - @window.hero.x, @window.level_exit.y - @window.hero.y)
    end

    def shoot!
      @window.add_laser(Laser.new(@window, @x, @y, mouse_angle))
    end

  end
end