require 'spec_helper'

describe "CCCBizChangePassenger" do
  it "CCCBizChangePassenger", :js => true do

    @search_page.open_logout
    @login_page.sign_in_as('joyce2@limos.com', 'password')
    @admin_page.choose_category('Start Search')
    @admin_make_reservation_page.find_customers_by({:email => 'baba@aol.com'})

    select('From Airport', :from => 'service_type')
    fill_in 'time_pickup', :with => '11:00pm'
    fill_in 'search_pickup_place', :with => 'SFO'
    fill_in 'search_drop_off_place', :with => '1 Embarcadero Center, San Francisco, CA 94111'
    select('1', :from => 'search_pax')
    @search.click_next_date
    find_button('See Prices').click

    @search_result_page.wait_for_page_load
    @search_result_page.verify_user_details
    @search_result_page.select_car
	@checkout_page.add_new_passenger
    @checkout_page.verify_user_details 
    @checkout_page.fill_cc

    fill_in 'dropoff_address_street1', :with => '123 main'
    select 'American Airlines', :from => 'reservation_request_flight_airline'
    fill_in 'reservation_request_flight_number', :with => '2457'

    @checkout_page.reserve_car
    @reservation_confirmation_page.verify_reservation_passed

    find_link('Back to homepage').click
    page.should have_link('Exit & Return to ADMIN Home')
  end
  
end
