require 'spec_helper'

describe "CCCAdminTestSearch" do
  it "CCCAdminTestSearch", :js => true do
    current_page = SearchPage.new
    current_page.open_logout

    current_page = LoginPage.new
    current_page.sign_in_as('joyce2@limos.com', 'password')

    find_link('Admin Test').click
    select('To Airport', :from => 'service_type')
    select('2', :from => 'search_pax')
    find(:css, '#search_ride_date').click
    find(:css, '#calcurrent').click
    select('11 PM', :from => 'search_pickup_time_hour')
    select(':45', :from => 'search_pickup_time_minute')
    fill_in 'search_pickup_place', :with => '4333 University Way Northeast, Seattle'
    fill_in 'search_drop_off_place', :with => 'SEA'
    find_button('Get a quote').click

    current_page = SearchResultPage.new
    current_page.select_car

    #page.should have_xpath("//title[contains(text(),'Limo & Car Services, Party Bus Rentals and more | Limos.com')]")
  end
  
end
