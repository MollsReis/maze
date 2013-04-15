require 'spec_helper'

module Maze
  describe Laser do

    before(:each) do
      @fake_noncoll_wall = stub('wall', :bounding_boxes => [stub('box',
                                                                 :horiz_range => (50..60),
                                                                 :vert_range => (50..60))])
      @fake_coll_wall = stub('wall', :bounding_boxes => [stub('box',
                                                              :horiz_range => (1..10),
                                                              :vert_range => (1..3))])
    end

    describe '#check_wall_collide!' do
      context 'given new coordinates' do
        context 'if a wall is hit' do
          it 'returns true' do
            fake_window = stub('window', :walls => [@fake_noncoll_wall, @fake_coll_wall],
                                         :lasers => stub('lasers', :delete => nil))
            laser = Laser.new(fake_window, 0, 0, Math::PI / 4)
            laser.check_wall_collide!(7,7).should be_true
          end
          it 'removes the laser' do
            fake_lasers = stub('lasers')
            fake_window = stub('window', :walls => [@fake_noncoll_wall, @fake_coll_wall],
                                         :lasers => fake_lasers)
            laser = Laser.new(fake_window, 0, 0, Math::PI / 4)
            fake_lasers.should_receive(:delete).once
            laser.check_wall_collide!(7,7)
          end
        end
        context 'no wall is hit' do
          it 'returns false' do
            fake_window = stub('window', :walls => [@fake_noncoll_wall, @fake_noncoll_wall])
            laser = Laser.new(fake_window, 0, 0, Math::PI / 4)
            laser.check_wall_collide!(7,7).should be_false
          end
        end
      end
    end

  end
end