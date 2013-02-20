require 'bundler/setup'
Bundler.require :default

$:.unshift File.join(File.dirname(__FILE__), 'maze')

%w[core grid wall window].each { |klass| require klass }