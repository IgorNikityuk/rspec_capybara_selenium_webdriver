require 'spec_helper'

describe "Administration_HourlyRideReservation_Canada3DigZip" do
  it "Administration_HourlyRideReservation_Canada3DigZip", :js => true do

    current_page = SearchPage.new
    current_page.open_logout

    current_page = LoginPage.new
    current_page.sign_in_as('joyce2@limos.com', 'password')

    current_page = AdminPage.new
    current_page.choose_category('Manage Customers')

    current_page = AdminMakeReservationPage.new
    current_page.find_customers_by({:email => 'baba@aol.com'})


    select('Hourly-As-Directed', :from => 'service_type')
    fill_in 'time_pickup', :with => '10:00pm'
    fill_in 'time_dropoff', :with => '12:00pm'
    fill_in 'search_pickup_place', :with => '6083 McKay Ave, Burnaby, BC V5H 2W7, Canada'
    select('4', :from => 'search_pax')
    search = GenericSearch.new
    search.click_next_date
    find_button('See Prices').click
        
    current_page = SearchResultPage.new
    current_page.wait_for_page_load
    first('.capacity').click
    find('.targeted-dialog.ui-dialog-content.ui-widget-content').text.should == 'close Passenger capacity is determined by the vehicle operator and may include a passenger seated in the front seat. Vehicles cannot carry more passengers than displayed. For assistance with passenger requirements please call Customer Service at 866-546-6726.'
    first('.c3_btn').click
    page.should have_text('Op Ride Value')
        
    current_page.select_car

    current_page = CheckoutPage.new
    current_page.verify_user_details

    select('Leo Pekker', :from => 'passengers_list')
    fill_in 'pickup_address_street1', :with => '123 test st'

    current_page.reserve_car

    current_page = ReservationConfirmationPage.new
    current_page.verify_reservation_passed
    
  end
end
