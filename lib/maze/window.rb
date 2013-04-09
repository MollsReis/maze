module Maze
  class Window < ::Gosu::Window

    def initialize
      super(640, 480, false)
      self.caption = 'Maze'
    end

    def needs_cursor?
      true
    end

    def load!(walls, hero)
      @walls, @hero = walls, hero
    end

    def update
      @hero.move!(:up) if button_down? Gosu::KbW
      @hero.move!(:left) if button_down? Gosu::KbA
      @hero.move!(:down) if button_down? Gosu::KbS
      @hero.move!(:right) if button_down? Gosu::KbD
    end

    def draw
      @hero.render
      @walls.each(&:render)
    end

    def button_down(id)
      close if id == Gosu::KbEscape
    end

  end
end