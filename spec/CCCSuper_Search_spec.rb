require 'spec_helper'

describe "CCCSuper_Search" do
  it "Verify super search function", :js => true do
    visit Capybara.default_host + '/logout'
    #login as joyce2@limos.com
    login_page = LoginPage.new
    login_page.login_as('joyce2@limos.com', 'password')
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
    page.should have_text('Oops! Something went wrong!')
    first(:link, 'Select').click
    select('Leo Pekker', :from => 'passengers_list')
    fill_in 'pickup_address_street1', :with => '123 test st'
    find_button('Reserve').click
    while (page.has_css?('.centered.horiz>img') == true)
      sleep(1)
    end
    page.should have_text('Reservation Confirmation')
    page.should_not have_text('Alert')
    page.should have_text('1710 Union St, San Francisco, CA')
    page.assert_selector('#self_service_change_button')
    page.assert_selector('#self_service_cancel_button')
  end
end
