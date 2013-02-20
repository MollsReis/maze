require 'bundler/setup'
Bundler.require :default

$:.unshift File.join(File.dirname(__FILE__), 'maze')

%w[core grid wall window].each { |klass| require klass }

module Maze
  COLOR = Gosu::Color.new(0xFF1EB1FA)
  MUILTIPLIER = 40
  X_OFFSET = 125
  Y_OFFSET = 35
  THICKNESS = 2
end