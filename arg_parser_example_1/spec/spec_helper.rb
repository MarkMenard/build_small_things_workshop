$: << File.dirname(__FILE__) + "../lib/"

require 'arg_parser'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter = 'documentation'
  config.order = 'defined'
end