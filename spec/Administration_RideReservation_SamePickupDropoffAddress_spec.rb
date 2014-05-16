require 'spec_helper'

describe "Administration_RideReservation_SamePickupDropoffAddress" do
  it "Administration_RideReservation_SamePickupDropoffAddress", :js => true do
    
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
    fill_in 'search_pickup_place', :with => 'Embarcadero 4 Dental, Embarcadero Center, San Francisco, CA 94111'
    fill_in 'search_drop_off_place', :with => '1 Embarcadero Center, San Francisco, CA 94111'
    select('4', :from => 'search_pax')
    find('#search_ride_date').click
    find('#calcurrent').click
    find_button('See Prices').click
 
    current_page = SearchResultPage.new

    page.should have_text('Acct Type:  Business')
    page.should have_text('First name: Leo')
    page.should have_text('Last name: Pekker')
    page.should have_link('Enter Account')
    
    current_page.select_car

    select('Leo Pekker', :from => 'passengers_list')
    page.should have_text('No charges now. Estimated amount due after service:')
    page.should have_text('Acct Type:  Business')
    page.should have_text('First name: Leo')
    page.should have_text('Last name: Pekker')
    page.should have_link('Enter Account')

    current_page = CheckoutPage.new
    current_page.reserve_car

    current_page = ReservationConfirmationPage.new
        
    page.should have_text('Reservation Confirmation')
    page.assert_selector('#self_service_cancel_button')
    page.should_not have_content('//div[1]/a/span')
  end
  
end
