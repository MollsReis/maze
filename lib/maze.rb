require 'bundler/setup'
Bundler.require :default

$:.unshift File.join(File.dirname(__FILE__), 'maze')
%w[core grid wall entity bounding_box window].each { |klass| require klass }

module Maze
  MAZE_COLOR = Gosu::Color.new(0xFF1EB1FA)
  HERO_COLOR = Gosu::Color.new(0xFF0000B8)
  MULTIPLIER = 40
  X_OFFSET = 125
  Y_OFFSET = 35
  THICKNESS = 2
end