require 'bundler/setup'
Bundler.require :default

$:.unshift File.join(File.dirname(__FILE__), 'maze')
%w[core grid wall entity darkness bounding_box window].each { |klass| require klass }

module Maze
  X_OFFSET = 175
  Y_OFFSET = 85
end