$:.unshift File.join(File.dirname(__FILE__), 'entity')
%w[hero].each { |klass| require klass }

module Maze
  module Entity end
end