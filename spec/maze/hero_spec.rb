require 'spec_helper'

module Maze
  module Entity
    describe Hero do

      before(:each) do
        @fake_noncoll_wall = stub('wall', :bounding_boxes => [stub('box',
                                                                   :horiz_range => (50..60),
                                                                   :vert_range => (50..60))])
        @fake_coll_wall = stub('wall', :bounding_boxes => [stub('box',
                                                                :horiz_range => (40..70),
                                                                :vert_range => (40..70))])
      end

      describe '#wall_collide?' do
        context 'given a new x coordinate' do
          context 'given two non-colliding bounding boxes' do
            it 'returns false' do
              fake_window = stub('window', :walls => [@fake_noncoll_wall, @fake_noncoll_wall])
              hero = Hero.new(fake_window, 0, 0)
              hero.instance_variable_set(:@x, 35)
              hero.instance_variable_set(:@y, 35)
              hero.wall_collide?(40).should be_false
            end
          end
          context 'given one colliding and non-colliding bounding box' do
            it 'returns true' do
              fake_window = stub('window', :walls => [@fake_noncoll_wall, @fake_coll_wall])
              hero = Hero.new(fake_window, 0, 0)
              hero.instance_variable_set(:@x, 35)
              hero.instance_variable_set(:@y, 35)
              hero.wall_collide?(40).should be_true
            end
          end
        end
        context 'given a new y coordinate' do
          context 'given two non-colliding bounding boxes' do
            it 'returns false' do
              fake_window = stub('window', :walls => [@fake_noncoll_wall, @fake_noncoll_wall])
              hero = Hero.new(fake_window, 0, 0)
              hero.instance_variable_set(:@x, 35)
              hero.instance_variable_set(:@y, 35)
              hero.wall_collide?(nil, 40).should be_false
            end
          end
          context 'given one colliding and non-colliding bounding box' do
            it 'returns true' do
              fake_window = stub('window', :walls => [@fake_noncoll_wall, @fake_coll_wall])
              hero = Hero.new(fake_window, 0, 0)
              hero.instance_variable_set(:@x, 35)
              hero.instance_variable_set(:@y, 35)
              hero.wall_collide?(nil, 40).should be_true
            end
          end
        end
      end

    end
  end
end