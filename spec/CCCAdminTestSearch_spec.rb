require 'spec_helper'

describe "CCCAdminTestSearch" do
  it "CCCAdminTestSearch", :js => true do

    @search_page.open_logout
    @login_page.sign_in_as('joyce2@limos.com', 'password')
    @admin_page.choose_category('Admin Test')
    
    select('To Airport', :from => 'service_type')
    select('2', :from => 'search_pax')
    @search.click_next_date
    select('11 PM', :from => 'search_pickup_time_hour')
    select(':45', :from => 'search_pickup_time_minute')
    fill_in 'search_pickup_place', :with => '4333 University Way Northeast, Seattle'
    fill_in 'search_drop_off_place', :with => 'SEA'
    find_button('Get a quote').click

    @search_result_page.wait_for_page_load
    @search_result_page.select_car
    
    expect(page).to have_title "Limo & Car Services, Party Bus Rentals and more | Limos.com"
  end
  
end
