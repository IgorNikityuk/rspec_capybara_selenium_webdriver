require 'spec_helper'
require 'support/generic_search.rb'

class CheckoutPage < GenericSearch
  include Capybara::DSL
  
	def reserve_car
      find('#reservation_request_submit').click
      while (page.has_css?('.centered.horiz>img') == true)
        sleep(1)
      end
	end

  def add_new_passenger
    find_link('Add new passenger').click
    fill_passenger_details
  end

  def fill_passenger_details
    fill_in 'passenger_first_name', :with => 'Yana'
    fill_in 'passenger_last_name', :with => 'Lymar'
    fill_in 'passenger_email', :with => 'joe' + random_number.to_s + '@jackson.com'
    fill_in 'passenger_phone_num', :with => '4085150000'
  end

  def fill_cc
    verify_new_cc_radiobutton_present
    fill_cc_with_correct_data
  end

  def fill_cc_with_invalid_data
    verify_new_cc_radiobutton_present
    fill_in 'card_payment_method_card_number', :with => '40123012301299'
    fill_in 'card_payment_method_cvv', :with => '123'
    select '12', :from => 'card_payment_method_expiration_month'
    select '2014', :from => 'card_payment_method_expiration_year'
    fill_in 'card_payment_method_first_name', :with => 'Joe'
    fill_in 'card_payment_method_last_name', :with => 'George'
    fill_in 'address_street1', :with => '123 Street'
    select 'Switzerland', :from => 'address_country'
    fill_in 'address_city', :with => 'zurich'
    fill_in 'address_state_province', :with => 'Iowa'
    fill_in 'address_postal_code', :with => '55555'
  end

	def fill_cc_with_correct_data
    fill_in 'card_payment_method_card_number', :with => '5200000000000007'
    fill_in 'card_payment_method_cvv', :with => '123'
    select('12', :from => 'card_payment_method_expiration_month')
    select('2015', :from => 'card_payment_method_expiration_year')
    fill_in 'card_payment_method_first_name', :with => 'Joe'
    fill_in 'card_payment_method_last_name', :with => 'George'
    fill_in 'address_street1', :with => '123 Street'
    select 'Switzerland', :from => 'address_country'
    fill_in 'address_city', :with => 'zurich'
    fill_in 'address_state_province', :with => 'Iowa'
    fill_in 'address_postal_code', :with => '55555'
	end

  def verify_new_cc_radiobutton_present
    new_card_checkbox = first('#card_payment_method_saved_id_0')
    new_card_checkbox.click if new_card_checkbox
  end

  def enter_promo_code
    fill_in 'entered_promo_code', :with => 'MTSINAI10'
    find('#promo_code_button').click
    find('.infoMessage').text.should == "30% discount applied"
    #page.should_not have_css("tr.promo_code_discount > td.left")
  end

end