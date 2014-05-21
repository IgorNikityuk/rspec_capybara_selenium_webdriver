require 'spec_helper'

describe "Administration_OneWayRideReservation_CanadaZip" do
  it "Administration_OneWayRideReservation_CanadaZip", :js => true do

    @search_page.open_logout
    @login_page.sign_in_as('joyce2@limos.com', 'password')
    @admin_page.choose_category('Manage Customers')
    @admin_make_reservation_page.find_customers_by({:email => 'baba@aol.com'})

    select('Point-to-Point (one-way)', :from => 'service_type')
    fill_in 'time_pickup', :with => '10:15pm'
    fill_in 'search_pickup_place', :with => '6083 McKay Ave, Burnaby, BC V5H 2W7, Canada'
    fill_in 'search_drop_off_place', :with => '7060 Kingsway,Burnaby, BC V5E 1E5, Canada'
    select('4', :from => 'search_pax')
    @search.click_next_date
    find_button('See Prices').click

    @search_result_page.wait_for_page_load
    @search_result_page.select_car
    @checkout_page.verify_user_details

    select('Leo Pekker', :from => 'passengers_list')
    rideDate = first(:xpath, "//*[@id='edit_reservation_request']/fieldset[2]//h4").text
    
    @checkout_page.reserve_car
    @reservation_confirmation_page.verify_reservation_passed

    find('#your-trip').text.should == rideDate
  end
  
end
