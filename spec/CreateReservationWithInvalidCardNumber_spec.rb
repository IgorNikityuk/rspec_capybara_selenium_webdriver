require 'spec_helper'

describe 'CreateReservationWithInvalidCardNumber' do
  it 'CreateReservationWithInvalidCardNumber', :js => true do
  	
    current_page = SearchPage.new
    current_page.open_logout

  	select('From Airport', :from => 'service_type')
    select('3', :from => 'search_pax')
    search = GenericSearch.new
    search.click_next_date
    select('11 PM', :from => 'search_pickup_time_hour')
    select(':15', :from => 'search_pickup_time_minute')
    fill_in 'search_pickup_place', :with => 'ZRH'
    fill_in 'search_drop_off_place', :with => '8001 Zurich, Switzerland'
    find_button('Get a quote').click

    current_page = SearchResultPage.new
    current_page.wait_for_page_load
    current_page.select_car

    current_page = CheckoutPage.new
    current_page.fill_passenger_details

    select 'American Airlines', :from => 'reservation_request_flight_airline'
    fill_in 'reservation_request_flight_number', :with => '1190'    
    find('#ride_pricing_number_of_stops').click
    select '1', :from => 'ride_pricing_number_of_stops'
    find('#ride_pricing_meet_inside').click
    fill_in 'reservation_request_special_requests', :with => 'temp@bhasin.com'
    
    current_page.fill_cc_with_invalid_data

    page.should have_text('at 11:15PM for 3 people')
    page.should_not have_text('Amount Due Now:')
    
    current_page.reserve_car

    page.should have_text('There was an error processing your payment - please try a different card.')
  
    current_page.fill_cc

    fill_in 'passenger_phone_num', :with => '503.282.0553'

    current_page = CheckoutPage.new
    current_page.reserve_car

    current_page = ReservationConfirmationPage.new
    current_page.verify_reservation_passed
    
    page.should have_text('temp@bhasin.com')
    page.should_not have_xpath('//div[1]/a/span')
  end
end