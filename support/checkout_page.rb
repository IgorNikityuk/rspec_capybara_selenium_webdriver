require 'spec_helper'

class CheckoutPage
  include Capybara::DSL
  
  #function for clicking reserve button and waiting for reservation confirmation page
	def reserve_car
      find_button('Reserve').click
      while (page.has_css?('.centered.horiz>img') == true)
        sleep(1)
      end
	end

end