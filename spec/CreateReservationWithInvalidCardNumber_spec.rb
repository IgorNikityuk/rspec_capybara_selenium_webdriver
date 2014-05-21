require 'spec_helper'

describe 'CreateReservationWithInvalidCardNumber' do
  it 'CreateReservationWithInvalidCardNumber', :js => true do
  	
    @search_page.open_logout

  	select('From Airport', :from => 'service_type')
    select('3', :from => 'search_pax')
    @search.click_next_date
    select('11 PM', :from => 'search_pickup_time_hour')
    select(':15', :from => 'search_pickup_time_minute')
    fill_in 'search_pickup_place', :with => 'ZRH'
    fill_in 'search_drop_off_place', :with => '8001 Zurich, Switzerland'
    find_button('Get a quote').click

    @search_result_page.wait_for_page_load
    @search_result_page.select_car
    @checkout_page.fill_passenger_details

    email = find('#passenger_email').text
    select 'American Airlines', :from => 'reservation_request_flight_airline'
    fill_in 'reservation_request_flight_number', :with => '1190'    
    find('#ride_pricing_number_of_stops').click
    select '1', :from => 'ride_pricing_number_of_stops'
    find('#ride_pricing_meet_inside').click
    fill_in 'reservation_request_special_requests', :with => 'temp@bhasin.com'
    
    @checkout_page.fill_cc_with_invalid_data

    page.should have_text('at 11:15PM for 3 people')
    page.should_not have_text('Amount Due Now:')
    
    @checkout_page.reserve_car

    page.should have_text('There was an error processing your payment - please try a different card.')
  
    @checkout_page.fill_cc

    fill_in 'passenger_phone_num', :with => '503.282.0553'

    @checkout_page.reserve_car
    @reservation_confirmation_page.verify_reservation_passed

    page.should have_text(email)
    page.should_not have_xpath('//div[1]/a/span')
  end
end