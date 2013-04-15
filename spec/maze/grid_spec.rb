require 'spec_helper'

module Maze
  describe Grid do

    describe '#initialize' do
      context 'given a top left and bottom right set of coordinates' do
        it 'calculates grid width and height' do
          grid = Grid.new(nil, [0,0], [2,3])
          grid.instance_variable_get(:@width).should eq 2
          grid.instance_variable_get(:@height).should eq 3
        end
      end
    end

    describe '#vertical_wall?' do
      context 'given width is greater than height' do
        it 'returns true' do
          grid = Grid.new(nil, [0,0], [3,2])
          grid.vertical_wall?.should be_true
        end
      end
      context 'given height is greater than width' do
        it 'returns false' do
          grid = Grid.new(nil, [0,0], [2,3])
          grid.vertical_wall?.should be_false
        end
      end
    end

    describe '#bisect' do
      context 'given a width of 1 or less' do
        it 'returns nil' do
          Grid.new(nil, [0,0],[1,10]).bisect.should be_nil
        end
      end
      context 'given a height of 1 or less' do
        it 'returns nil' do
          Grid.new(nil, [0,0],[10,1]).bisect.should be_nil
        end
      end
    end

    describe '#vertical_bisect' do
      it 'yields a random vertical wall' do
        Grid.new(nil, [0,0],[2,2]).vertical_bisect do |wall|
          wall.instance_variable_get(:@origin).should eq [1,0]
          wall.instance_variable_get(:@destination).should eq [1,2]
        end
      end
      context 'given a left and right subarea large enough' do
        it 'yields the result of those subareas bisected' do
          grid = Grid.new(nil, [0,0],[5,5])
          grid.stub(:random_wall_coord => 3)
          fake_grid = double('grid')
          fake_grid.should_receive(:bisect).twice.and_yield(:fake_bisected_wall)
          Grid.stub(:new => fake_grid)
          grid.vertical_bisect {}
          Grid.unstub(:new)
        end
      end
      context 'given a left subarea large enough' do
        it 'yields the result of that subarea bisected' do
          grid = Grid.new(nil, [0,0],[5,5])
          grid.stub(:random_wall_coord => 4)
          fake_grid = double('grid')
          fake_grid.should_receive(:bisect).once.and_yield(:fake_bisected_wall)
          Grid.stub(:new => fake_grid)
          grid.vertical_bisect {}
          Grid.unstub(:new)
        end
      end
      context 'given a right subarea large enough' do
        it 'yields the result of that subarea bisected' do
          grid = Grid.new(nil, [0,0],[5,5])
          grid.stub(:random_wall_coord => 1)
          fake_grid = double('grid')
          fake_grid.should_receive(:bisect).once.and_yield(:fake_bisected_wall)
          Grid.stub(:new => fake_grid)
          grid.vertical_bisect {}
          Grid.unstub(:new)
        end
      end
    end

    describe '#horizontal_bisect' do
      it 'yields a random horizontal wall' do
        Grid.new(nil, [0,0],[2,2]).horizontal_bisect do |wall|
          wall.instance_variable_get(:@origin).should eq [0,1]
          wall.instance_variable_get(:@destination).should eq [2,1]
        end
      end
      context 'given an top and bottom subarea large enough' do
        it 'yields the result of those subareas bisected' do
          grid = Grid.new(nil, [0,0],[5,5])
          grid.stub(:random_wall_coord => 3)
          fake_grid = double('grid')
          fake_grid.should_receive(:bisect).twice.and_yield(:fake_bisected_wall)
          Grid.stub(:new => fake_grid)
          grid.horizontal_bisect {}
          Grid.unstub(:new)
        end
      end
      context 'given an top subarea large enough' do
        it 'yields the result of that subarea bisected' do
          grid = Grid.new(nil, [0,0],[5,5])
          grid.stub(:random_wall_coord => 4)
          fake_grid = double('grid')
          fake_grid.should_receive(:bisect).once.and_yield(:fake_bisected_wall)
          Grid.stub(:new => fake_grid)
          grid.horizontal_bisect {}
          Grid.unstub(:new)
        end
      end
      context 'given an bottom subarea large enough' do
        it 'yields the result of that subarea bisected' do
          grid = Grid.new(nil, [0,0],[5,5])
          grid.stub(:random_wall_coord => 1)
          fake_grid = double('grid')
          fake_grid.should_receive(:bisect).once.and_yield(:fake_bisected_wall)
          Grid.stub(:new => fake_grid)
          grid.horizontal_bisect {}
          Grid.unstub(:new)
        end
      end
    end

  end
end