require 'rubygems'
require 'bundler/setup'

require 'rspec'
require 'concealer'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
end
