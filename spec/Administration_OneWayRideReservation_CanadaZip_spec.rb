require 'spec_helper'

describe "Administration_OneWayRideReservation_CanadaZip" do
  it "Administration_OneWayRideReservation_CanadaZip", :js => true do

    current_page = SearchPage.new
    current_page.open_logout

    current_page = LoginPage.new
    current_page.sign_in_as('joyce2@limos.com', 'password')

    current_page = AdminPage.new
    current_page.choose_category('Manage Customers')

    current_page = AdminMakeReservationPage.new
    current_page.find_customers_by({:email => 'baba@aol.com'})

    select('Point-to-Point (one-way)', :from => 'service_type')
    fill_in 'time_pickup', :with => '10:15pm'
    fill_in 'search_pickup_place', :with => '6083 McKay Ave, Burnaby, BC V5H 2W7, Canada'
    fill_in 'search_drop_off_place', :with => '7060 Kingsway,Burnaby, BC V5E 1E5, Canada'
    select('4', :from => 'search_pax')
    search = GenericSearch.new
    search.click_next_date
    find_button('See Prices').click

    current_page = SearchResultPage.new
    current_page.wait_for_page_load
    current_page.select_car

    current_page = CheckoutPage.new
    current_page.verify_user_details

    select('Leo Pekker', :from => 'passengers_list')
    rideDate = first(:xpath, "//*[@id='edit_reservation_request']/fieldset[2]//h4").text
    
    current_page = CheckoutPage.new
    current_page.reserve_car

    current_page = ReservationConfirmationPage.new
    current_page.verify_reservation_passed

    find('#your-trip').text.should == rideDate
  end
  
end
