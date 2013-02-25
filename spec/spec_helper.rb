$:.unshift File.join(File.dirname(__FILE__), '..', 'lib', 'maze')
require 'maze'
require 'logger'

$logger = Logger.new(nil)

Bundler.require :test