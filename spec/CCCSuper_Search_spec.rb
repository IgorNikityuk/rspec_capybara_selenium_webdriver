require 'spec_helper'

describe "CCCSuper_Search" do
  it "CCCSuper_Search", :js => true do
    
    @search_page.open_logout
    @login_page.sign_in_as('joyce2@limos.com', 'password')
    @admin_page.choose_category('Start Search')
    @admin_make_reservation_page.find_customers_by({:email => 'baba@aol.com'})

    select('Hourly-As-Directed', :from => 'service_type')
    fill_in 'time_pickup', :with => '10:00pm'
    fill_in 'time_dropoff', :with => '11:00pm'
    fill_in 'search_pickup_place', :with => '1710 Union St, San Francisco, CA'
    select('4', :from => 'search_pax')
    @search.click_next_date
    find_button('See Prices').click
    find_link('Super Search').click
    page.should_not have_text('Oops! Something went wrong!')
    
    @search_result_page.wait_for_page_load
    @search_result_page.select_car

    select('Leo Pekker', :from => 'passengers_list')
    fill_in 'pickup_address_street1', :with => '123 test st'
    
    @checkout_page.reserve_car
    @reservation_confirmation_page.verify_reservation_passed

    find('#pickup_place').text.should == "123 test st, Sf, CA, 94123"
    page.should_not have_text('Alert')
  end
end
