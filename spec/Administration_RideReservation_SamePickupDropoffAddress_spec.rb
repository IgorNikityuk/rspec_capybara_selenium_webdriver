require 'spec_helper'

describe "Administration_RideReservation_SamePickupDropoffAddress" do
  it "Administration_RideReservation_SamePickupDropoffAddress", :js => true do
    
    @search_page.open_logout
    @login_page.sign_in_as('joyce2@limos.com', 'password')
    @admin_page.choose_category('Manage Customers')
    @admin_make_reservation_page.find_customers_by({:email => 'baba@aol.com'})

    select('Point-to-Point (one-way)', :from => 'service_type')
    fill_in 'time_pickup', :with => '10:15pm'
    fill_in 'search_pickup_place', :with => 'Embarcadero 4 Dental, Embarcadero Center, San Francisco, CA 94111'
    fill_in 'search_drop_off_place', :with => '1 Embarcadero Center, San Francisco, CA 94111'
    select('4', :from => 'search_pax')
    @search.click_next_date
    find_button('See Prices').click
    
    @search_result_page.wait_for_page_load
    @search_result_page.verify_user_details
    @search_result_page.select_car

    select('Leo Pekker', :from => 'passengers_list')
    page.should have_text('No charges now. Estimated amount due after service:')

    @checkout_page.verify_user_details
    @checkout_page.reserve_car
    @reservation_confirmation_page.verify_reservation_passed
    
    page.should_not have_content('//div[1]/a/span')
  end
  
end
