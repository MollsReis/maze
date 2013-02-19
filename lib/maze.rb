require 'bundler/setup'
Bundler.setup :default

$:.unshift File.join(File.dirname(__FILE__), 'maze')

%w[core grid wall].each do |klass|
  require klass
end