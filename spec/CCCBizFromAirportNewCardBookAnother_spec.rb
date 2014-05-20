require 'spec_helper'

describe "CCCBizFromAirportNewCardBookAnother" do
  it "CCCBizFromAirportNewCardBookAnother", :js => true do
    current_page = SearchPage.new
    current_page.open_logout

    current_page = LoginPage.new
    current_page.sign_in_as('joyce2@limos.com', 'password')

    current_page = AdminPage.new
    current_page.choose_category('Manage Customers')

    current_page = AdminMakeReservationPage.new
    current_page.find_customers_by({:email => 'baba@aol.com'})

    select('From Airport', :from => 'service_type')
    fill_in 'time_pickup', :with => '11:00pm'
    fill_in 'search_pickup_place', :with => 'SFO'
    fill_in 'search_drop_off_place', :with => '1 Embarcadero Center, San Francisco, CA 94111'
    select('1', :from => 'search_pax')
    search = GenericSearch.new
    search.click_next_date
    find_button('See Prices').click

    current_page = SearchResultPage.new
    current_page.wait_for_page_load
    current_page.verify_user_details
    current_page.select_car

    current_page = CheckoutPage.new
	current_page.add_new_passenger
    current_page.verify_user_details 

    fill_in 'dropoff_address_street1', :with => '123 main'
    select 'American Airlines', :from => 'reservation_request_flight_airline'
    fill_in 'reservation_request_flight_number', :with => '2457'
    select '1', :from => 'ride_pricing_number_of_stops'
    select 'Curbside = no charge', :from => 'ride_pricing_meet_inside'

    current_page.fill_cc
    current_page.reserve_car
    
    current_page = ReservationConfirmationPage.new
    current_page.verify_reservation_passed

    find_link('Back to homepage').click
    
    current_page = AdminMakeReservationPage.new
    current_page.find_customers_by({:email => 'baba@aol.com'})

    select('To Airport', :from => 'service_type')
    fill_in 'time_pickup', :with => '11:00pm'
    fill_in 'search_pickup_place', :with => '1 Embarcadero Center, San Francisco, CA 94111'
    fill_in 'search_drop_off_place', :with => 'SFO'
    select('1', :from => 'search_pax')
    search = GenericSearch.new
    search.click_next_date
    find_button('See Prices').click

    current_page = SearchResultPage.new
    current_page.wait_for_page_load
    current_page.verify_user_details
    current_page.select_car

    current_page = CheckoutPage.new
	current_page.add_new_passenger
    current_page.verify_user_details 
    current_page.reserve_car

    current_page = ReservationConfirmationPage.new
    current_page.verify_reservation_passed
  end
  
end
