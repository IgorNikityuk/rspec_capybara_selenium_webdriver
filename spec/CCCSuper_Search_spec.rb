require 'spec_helper'
describe "CCCSuper_Search" do
  it "Verify super search function", :js => true do
    visit 'http://staging.limos.com'
    find_link('Sign In').click
    fill_in 'email', :with => 'joyce2@limos.com'
    fill_in 'password', :with => 'password'
    find_button('Sign-in').click
    find_link('Manage Customers').click
    fill_in 'email', :with => 'baba@aol.com'
    find('#btn_find').click
    select('Hourly-As-Directed', :from => 'service_type')
    fill_in 'time_pickup', :with => '10:00pm'
    fill_in 'time_dropoff', :with => '11:00pm'
    fill_in 'search_pickup_place', :with => '1710 Union St, San Francisco, CA'
    select('4', :from => 'search_pax')
    find('#search_ride_date').click
    find('#calcurrent').click
    find_button('See Prices').click
    find_link('Super Search').click
    first(:link, 'Select').click
    select('Leo Pekker', :from => 'passengers_list')
    fill_in 'pickup_address_street1', :with => '123 test st'
    find_button('Reserve').click
    while (page.has_css?('.centered.horiz>img') == true)
      sleep(1)
    end
    page.should have_text('Reservation Confirmation')
    page.assert_selector('#self_service_change_button')
    page.assert_selector('#self_service_cancel_button')

  end
  
end
