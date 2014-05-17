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

	def add_new_cc (container)
      
	end

	def verify_cc_present
	  if find('#card_payment_method_saved_id_0') == false
	  	
	  else
	  	
	  end
	end

	def fill_cc_fields
	  verify_cc_present.is_nil?
	end

end