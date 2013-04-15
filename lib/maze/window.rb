module Maze
  class Window < ::Gosu::Window

    attr_accessor :camera_x, :camera_y
    attr_reader :walls, :hero, :level_exit, :robots, :lasers, :font

    def initialize
      super(640, 480, false)
      self.caption = 'Maze'
      @font = Gosu::Font.new(self, Gosu::default_font_name, 15)
      @camera_x, @camera_y  = 50.0, 50.0
    end

    def needs_cursor?
      true
    end

    def load!(walls, hero, level_exit, robots, meter)
      @walls, @hero, @level_exit, @robots = walls, hero, level_exit, robots
      @lasers, @meter = [], meter
    end

    def add_laser(laser)
      @lasers << laser
    end

    def update
      exit if @hero.exit_distance < 10
      #TODO YOU WIN!

      exit if @hero.robot_collide?
      #TODO YOU DIE!

      @hero.move!(:forward) if button_down? Gosu::KbW
      @hero.move!(:back) if button_down? Gosu::KbS
      @hero.move!(:left) if button_down? Gosu::KbA
      @hero.move!(:right) if button_down? Gosu::KbD
      #TODO add strafing

      @robots.each { |robot| robot.move! if robot.see_hero? }
      @lasers.each(&:move!)
    end

    def sprint?
    end

    def draw
      clip_to(0, 0, 640, 480) do

        if $debug
          @font.draw('X: ' + @hero.x.round(2).to_s, 10, 10, 100)
          @font.draw('X-Speed: ' + Math.cos(@hero.mouse_angle).round(2).to_s, 10, 20, 100)
          @font.draw('Y: ' + @hero.y.round(2).to_s, 10, 30, 100)
          @font.draw('Y-Speed: ' + Math.sin(@hero.mouse_angle).round(2).to_s, 10, 40, 100)
          @font.draw('Angle: ' + @hero.mouse_angle.round(2).to_s, 10, 50, 100)
          @font.draw('Exit Distance: ' + @hero.exit_distance.round(2).to_s, 10, 60, 100)
          @font.draw('Laser Count: ' + @lasers.size.to_s, 10, 70, 100)
        end

        @meter.render

        clip_to(@hero.x + @camera_x - 155, @hero.y + @camera_y - 155, 315, 315) do
          translate(@camera_x, @camera_y) do
            @hero.render
            @walls.each(&:render)
            @level_exit.render
            @robots.each(&:render)
          end
        end
        translate(@camera_x, @camera_y) { @lasers.each(&:render) }

      end
    end

    def button_down(id)
      close if id == Gosu::KbEscape
      @hero.shoot! if id == Gosu::MsLeft
    end

  end
end