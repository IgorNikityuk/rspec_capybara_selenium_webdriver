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

	def fill_cc
	  if find('#card_payment_method_saved_id_0').visible? == true
	  	add_new_cc
	  else
      fill_cc
	  end
	end

	def add_new_cc
      find('#card_payment_method_saved_id_0').click
      fill_cc_fields
	end

	def fill_cc_fields
      fill_in 'card_payment_method_card_number', :with => '5200000000000007'
      fill_in 'card_payment_method_cvv', :with => '123'
      select('12', :from => 'card_payment_method_expiration_month')
      select('2015', :from => 'card_payment_method_expiration_year')
      fill_in 'card_payment_method_first_name', :with => 'Joe'
      fill_in 'card_payment_method_last_name', :with => 'George'
      fill_in 'address_street1', :with => '123 Street'
      select('Switzerland', :from => 'address_country')
      fill_in 'address_city', :with => 'zurich'
	end
end