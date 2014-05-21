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
require 'support/deferred_garbage_collection.rb'


#Dir["support/*.rb"].each {|file| require file}

RSpec.configure do |config|
  config.include Capybara::DSL
  config.before(:all) do
    DeferredGarbageCollection.start
    @search_page                     = SearchPage.new
	  @login_page                      = LoginPage.new
	  @admin_page                      = AdminPage.new
	  @admin_make_reservation_page     = AdminMakeReservationPage.new
	  @search_result_page              = SearchResultPage.new
	  @checkout_page                   = CheckoutPage.new
	  @reservation_confirmation_page   = ReservationConfirmationPage.new
	  @search                          = GenericSearch.new

  end

  config.after(:all) do
    DeferredGarbageCollection.reconsider
  end
end

Capybara.default_driver = :selenium
Capybara.default_host = 'http://staging.limos.com/'
Capybara.default_wait_time = 30
