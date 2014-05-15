require 'rspec'
require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'

#require files
require 'support/login_page.rb'

#Dir["support/*.rb"].each {|file| require file}

RSpec.configure do |config|
  config.include Capybara::DSL

end

Capybara.default_driver = :selenium
Capybara.app_host = "http://www.youtube.com"
Capybara.default_host = 'http://staging.limos.com/'
