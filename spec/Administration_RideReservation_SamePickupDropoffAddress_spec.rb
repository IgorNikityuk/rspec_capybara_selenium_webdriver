require 'spec_helper'

describe "Administration_RideReservation_SamePickupDropoffAddress" do
  it "Administration_RideReservation_SamePickupDropoffAddress", :js => true do
    visit Capybara.default_host + '/logout'
    #login as joyce2@limos.com
    login_page = LoginPage.new
    login_page.login_as('joyce2@limos.com', 'password')
    find_link('Manage Customers').click
    fill_in 'email', :with => 'baba@aol.com'
    find('#btn_find').click
    select('Point-to-Point (one-way)', :from => 'service_type')
    fill_in 'time_pickup', :with => '10:15pm'
    fill_in 'search_pickup_place', :with => 'Embarcadero 4 Dental, Embarcadero Center, San Francisco, CA 94111'
    fill_in 'search_drop_off_place', :with => '1 Embarcadero Center, San Francisco, CA 94111'
    select('4', :from => 'search_pax')
    find('#search_ride_date').click
    find('#calcurrent').click
    find_button('See Prices').click
    while (page.has_link?('Select') == false)
      sleep(1)
    end
    page.should have_text('Acct Type:  Business')
    page.should have_text('First name: Leo')
    page.should have_text('Last name: Pekker')
    page.should have_link('Enter Account')
    first(:link, 'Select').click
    select('Leo Pekker', :from => 'passengers_list')
    page.should have_text('No charges now. Estimated amount due after service:')
    page.should have_text('Acct Type:  Business')
    page.should have_text('First name: Leo')
    page.should have_text('Last name: Pekker')
    page.should have_link('Enter Account')
    find_button('Reserve').click
    while (page.has_css?('.centered.horiz>img') == true)
      sleep(1)
    end
    page.should have_text('Reservation Confirmation')
    page.assert_selector('#self_service_change_button')
    page.assert_selector('#self_service_cancel_button')
    page.should_not have_content('//div[1]/a/span')
  end
  
end
