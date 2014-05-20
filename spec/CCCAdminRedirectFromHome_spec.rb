require 'spec_helper'

describe "CCCAdminRedirectFromHome" do
  it "CCCAdminRedirectFromHome", :js => true do
    current_page = SearchPage.new
    current_page.open_logout

    current_page = LoginPage.new
    current_page.sign_in_as('joyce2@limos.com', 'password')

    current_page = AdminPage.new
    current_page.choose_category('Start Search')

    current_page = AdminMakeReservationPage.new
    current_page.find_customers_by({:email => 'sexylimos@limos.com'})

    select('Just Drive (hourly)', :from => 'service_type')
    fill_in 'time_pickup', :with => '10:00pm'
    fill_in 'time_dropoff', :with => '11:00pm'
    fill_in 'search_pickup_place', :with => '1020 Johnson Blvd, Toiyabe National Forest, Eldorado National Forest, South Lake Tahoe, CA 96150'
    select('50', :from => 'search_pax')
    search = GenericSearch.new
    search.click_next_date
    find_button('See Prices').click

    page.should have_text('No Results Found')
  end
  
end
