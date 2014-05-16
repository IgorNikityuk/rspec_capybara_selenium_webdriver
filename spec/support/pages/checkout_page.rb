require 'spec_helper'
require 'support/generic_search.rb'

class CheckoutPage < GenericSearch
  include Capybara::DSL
  
  #function for clicking on button RESERVE
	def reserve_car
      
      find('#reservation_request_submit').click
      
      while (page.has_css?('.centered.horiz>img') == true)
        sleep(1)
      end
      
	end

end