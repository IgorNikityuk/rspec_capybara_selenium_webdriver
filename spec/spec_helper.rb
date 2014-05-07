require 'rspec'
require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'

RSpec.configure do |config|
	config.include Capybara::DSL
end

Capybara.default_driver = :selenium
Capybara.app_host = "http://www.youtube.com"
