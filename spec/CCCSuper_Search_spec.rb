require 'spec_helper'

describe "CCCSuper_Search" do
  it "CCCSuper_Search", :js => true do
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
    fill_in 'time_dropoff', :with => '11:00pm'
    fill_in 'search_pickup_place', :with => '1710 Union St, San Francisco, CA'
    select('4', :from => 'search_pax')
    search = GenericSearch.new
    search.click_next_date
    find_button('See Prices').click
    find_link('Super Search').click
    page.should_not have_text('Oops! Something went wrong!')
    
    current_page = SearchResultPage.new
    current_page.wait_for_page_load
    current_page.select_car
    
    current_page = CheckoutPage.new

    select('Leo Pekker', :from => 'passengers_list')
    fill_in 'pickup_address_street1', :with => '123 test st'
    
    current_page.reserve_car
    
    current_page = ReservationConfirmationPage.new
    current_page.verify_reservation_passed
    find('#pickup_place').text.should == "123 test st, Sf, CA, 94123"
    page.should_not have_text('Alert')
  end
end
