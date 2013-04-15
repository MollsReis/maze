require 'spec_helper'

module Maze
  describe BoundingBox do

    describe '#corners' do
      it 'returns corners' do
        BoundingBox.new([0,0], [1,1]).corners.should eq [[0,0],[0,1],[1,0],[1,1]]
      end
    end

    describe '#nearest_corner' do
      context 'given a point' do
        it 'returns the nearest corner' do
          BoundingBox.new([0,0], [1,1]).nearest_corner(2,2).should eq [1,1]
        end
      end
    end

    describe '#horiz_range' do
      it 'returns the horizontal range' do
        BoundingBox.new([0,0], [15,1]).horiz_range.should eq (0..15)
      end
    end

    describe '#vert_range' do
      it 'returns the vertical range' do
        BoundingBox.new([0,2], [15,21]).vert_range.should eq (2..21)
      end
    end

  end
end
