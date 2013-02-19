require 'spec_helper'

module Maze
  describe Wall do

    describe '#create_opening!' do
      it 'creates a random opening in the wall' do
        pending
      end
    end

    describe '#get_length!' do
      context 'given a horizontal wall' do
        it 'returns the wall length' do
          wall = Wall.new([0,0], [3,0])
          wall.length.should eq 3
        end
      end
      context 'given a vertical wall' do
        it 'returns the wall length' do
          wall = Wall.new([0,0], [0,3])
          wall.length.should eq 3
        end
      end
    end

  end
end