require 'rspec'
require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'pry'

#require files
require 'support/generic_search.rb'
require 'support/pages/login_page.rb'

RSpec.configure do |config|
  config.include Capybara::DSL
  config.before(:all) do
	  @login_page = LoginPage.new
  end
end

Capybara.default_driver = :selenium
Capybara.default_host = 'http://www.limos.com/'
Capybara.default_wait_time = 10
