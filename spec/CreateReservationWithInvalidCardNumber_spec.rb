require 'spec_helper'

describe 'CreateReservationWithInvalidCardNumber' do
  it 'CreateReservationWithInvalidCardNumber', :js => true do
  	visit Capybara.default_host + '/logout'
  	select('From Airport', :from => 'service_type')
    select('3', :from => 'search_pax')
    find('#search_ride_date').click
    find('#calcurrent').click
    select('11 PM', :from => 'search_pickup_time_hour')
    select(':15', :from => 'search_pickup_time_minute')
    fill_in 'search_pickup_place', :with => 'ZRH'
    fill_in 'search_drop_off_place', :with => '8001 Zurich, Switzerland'
    find_button('Get a quote').click
    while (page.has_link?('Select') == false)
      sleep(1)
    end
    first(:link, 'Select').click
    fill_in 'passenger_first_name', :with => 'selenium'
    fill_in 'passenger_last_name', :with => 'user'
    fill_in 'passenger_email', :with => 'temp@bhasin.com'
    fill_in 'passenger_phone_num', :with => '432-852-3333'
    select 'American Airlines', :from => 'reservation_request_flight_airline'
    fill_in 'reservation_request_flight_number', :with => '1190'    
    find('#ride_pricing_number_of_stops').click
    select '1', :from => 'ride_pricing_number_of_stops'
    find('#ride_pricing_meet_inside').click
    fill_in 'reservation_request_special_requests', :with => 'temp@bhasin.com'
    fill_in 'card_payment_method_card_number', :with => '40123012301299'
    fill_in 'card_payment_method_cvv', :with => '123'
    select '12', :from => 'card_payment_method_expiration_month'
    select '2014', :from => 'card_payment_method_expiration_year'
    fill_in 'card_payment_method_first_name', :with => 'Joe'
    fill_in 'card_payment_method_last_name', :with => 'George'
    fill_in 'address_street1', :with => '123 Street'
    fill_in 'address_city', :with => 'SanRamon'
    select 'Iowa', :from => 'select_state_province'
    fill_in 'address_postal_code', :with => '55555'
    page.should have_text('at 11:15PM for 3 people')
    page.should_not have_text('Amount Due Now:')
    find('#reservation_request_submit').click
    while (page.has_css?('.centered.horiz>img') == true)
      sleep(1)
    end
    page.should have_text('There was an error processing your payment - please try a different card.')
	select 'selenium user', :from => 'passenger_list'
	fill_in 'card_payment_method_card_number', :with => '5167138311657643'
    fill_in 'card_payment_method_cvv', :with => '123'
    select 'Iowa', :from => 'select_state_province'
    fill_in 'address_postal_code', :with => '55555'
    select '12', :from => 'card_payment_method_expiration_month'
    select '2014', :from => 'card_payment_method_expiration_year'
    fill_in 'passenger_phone_num', :with => '503.282.0553'
    find('#reservation_request_submit').click
    while (page.has_css?('.centered.horiz>img') == true)
      sleep(1)
    end
    page.should have_text('temp@bhasin.com')
    page.should_not have_xpath('//div[1]/a/span')
  end
end