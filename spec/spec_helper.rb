require 'rspec'
require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'

#require files
require 'support/generic_search.rb'
require 'support/pages/admin_page.rb'
require 'support/pages/admin_make_reservation_page.rb'
require 'support/pages/login_page.rb'
require 'support/pages/search_page.rb'
require 'support/pages/search_result_page.rb'
require 'support/pages/checkout_page.rb'
require 'support/pages/reservation_confirmation_page.rb'

#Dir["support/*.rb"].each {|file| require file}

RSpec.configure do |config|
  config.include Capybara::DSL
end

Capybara.default_driver = :selenium
Capybara.default_host = 'http://staging.limos.com/'
Capybara.default_wait_time = 3
