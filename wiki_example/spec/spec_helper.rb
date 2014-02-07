$: << File.dirname(__FILE__) + "../lib/"

require 'rubygems'
require "bundler"

Bundler.require(:default, :development)

require 'page'
require 'page_crawler_impl'
require 'path_parser'
require 'suite_responder'
require 'page_builder'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter = 'documentation'
  config.order = 'defined'
end