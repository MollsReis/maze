$:.unshift File.join(File.dirname(__FILE__), '..', 'lib', 'maze')
require 'maze'
Bundler.require :test