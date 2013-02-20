require 'spec_helper'

module Maze
  describe Grid do

    describe '#initialize' do
      context 'given a top left and bottom right set of coordinates' do
        it 'calculates grid width and height' do
          grid = Grid.new([0,0], [2,3])
          grid.instance_variable_get(:@width).should eq 2
          grid.instance_variable_get(:@height).should eq 3
        end
      end
    end

    describe '#vertical_wall?' do
      context 'given width is greater than height' do
        it 'returns true' do
          grid = Grid.new([0,0], [3,2])
          grid.vertical_wall?.should be_true
        end
      end
      context 'given height is greater than width' do
        it 'returns false' do
          grid = Grid.new([0,0], [2,3])
          grid.vertical_wall?.should be_false
        end
      end
    end

    describe '#bisect' do
      context 'given a width of 1 or less' do
        it 'returns nil' do
          Grid.new([0,0],[1,10]).bisect.should be_nil
        end
      end
      context 'given a height of 1 or less' do
        it 'returns nil' do
          Grid.new([0,0],[10,1]).bisect.should be_nil
        end
      end
    end

    describe '#vertical_bisect' do
      it 'yields a random vertical wall' do
        Grid.new([0,0],[2,2]).vertical_bisect do |wall|
          wall.instance_variable_get(:@origin).should eq [1,0]
          wall.instance_variable_get(:@destination).should eq [1,2]
        end
      end
      context 'given an left subarea large enough' do
        it 'yields the result of that subarea#bisect' do
          grid = Grid.new([0,0], [5,5])
          grid.stub(:random_wall_coord => 3)
          Grid.stub(:new => double('grid', :bisect => :expected))
          Grid.should_receive(:new).with([0,0], [3,5])
          grid.vertical_bisect {}.should eq :expected
        end
      end
      context 'given an right subarea large enough' do
        it 'yields the result of that subarea#bisect' do
          grid = Grid.new([0,0], [5,5])
          grid.stub(:random_wall_coord => 3)
          Grid.stub(:new => double('grid', :bisect => :expected))
          Grid.should_receive(:new).with([3,0], [5,5])
          grid.vertical_bisect {}.should eq :expected
        end
      end
    end

    describe '#horizontal_bisect' do
      it 'yields a random horizontal wall' do
        Grid.new([0,0],[2,2]).horizontal_bisect do |wall|
          wall.instance_variable_get(:@origin).should eq [0,1]
          wall.instance_variable_get(:@destination).should eq [2,1]
        end
      end
      context 'given an top subarea large enough' do
        it 'yields the result of that subarea#bisect' do
          grid = Grid.new([0,0], [5,5])
          grid.stub(:random_wall_coord => 3)
          Grid.stub(:new => double('grid', :bisect => :expected))
          Grid.should_receive(:new).with([0,0], [5,3])
          grid.horizontal_bisect {}.should eq :expected
        end
      end
      context 'given an bottom subarea large enough' do
        it 'yields the result of that subarea#bisect' do
          grid = Grid.new([0,0], [5,5])
          grid.stub(:random_wall_coord => 3)
          Grid.stub(:new => double('grid', :bisect => :expected))
          Grid.should_receive(:new).with([0,3], [5,5])
          grid.horizontal_bisect {}.should eq :expected
        end
      end
    end

  end
end