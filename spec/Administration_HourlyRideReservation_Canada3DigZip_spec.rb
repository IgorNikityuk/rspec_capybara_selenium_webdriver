require 'spec_helper'

describe "Administration_HourlyRideReservation_Canada3DigZip" do
  it "Verify administration hourly ride reservation", :js => true do
    visit Capybara.default_host
    #login as joyce2@limos.com
    login_page = LoginPage.new
    login_page.login_as('joyce2@limos.com', 'password')
    find_link('Manage Customers').click
    fill_in 'email', :with => 'baba@aol.com'
    find('#btn_find').click
    select('Hourly-As-Directed', :from => 'service_type')
    fill_in 'time_pickup', :with => '10:15pm'
    fill_in 'time_dropoff', :with => '12:00pm'
    fill_in 'search_pickup_place', :with => '6083 McKay Ave, Burnaby, BC V5H 2W7, Canada'
    select('4', :from => 'search_pax')
    find('#search_ride_date').click
    find('#calcurrent').click
    find_button('See Prices').click
    while (page.has_link?('Select') == false)
      sleep(1)
    end
    first(:css, '.capacity').click
    find('.targeted-dialog.ui-dialog-content.ui-widget-content').text.should == 'close Passenger capacity is determined by the vehicle operator and may include a passenger seated in the front seat. Vehicles cannot carry more passengers than displayed. For assistance with passenger requirements please call Customer Service at 866-546-6726.'
    first('.c3_btn').click
    page.should have_text('Op Ride Value')
    first(:link, 'Select').click
    page.should have_text('Acct Type:  Business')
    page.should have_text('First name: Leo')
    page.should have_text('Last name: Pekker')
    page.should have_link('Enter Account')
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
