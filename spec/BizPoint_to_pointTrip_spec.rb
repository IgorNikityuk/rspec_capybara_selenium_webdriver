require 'spec_helper'

describe "BizPoint_to_pointTrip" do
  it "BizPoint_to_pointTrip", :js => true do

    current_page = SearchPage.new
    current_page.open_logout

    select('Point-to-Point (one-way)', :from => 'service_type')
    select('11 PM', :from => 'search_pickup_time_hour')
    fill_in 'search_pickup_place', :with => '1180 SAN FRANCISCO, Union Street, San Francisco, CA, United States'
    fill_in 'search_drop_off_place', :with => '1070 SAN FRANCISCO, Union Street, San Francisco, CA, United States'
    select('2', :from => 'search_pax')
    search = GenericSearch.new
    search.click_next_date
    check 'is_business'
    #find('#is_busines').set(true)
    find_button('Get a quote').click
    page.should_not have_xpath("//span[@class='out_of_policy_hover tiptip']")

    current_page = SearchResultPage.new
    current_page.wait_for_page_load
    current_page.select_car

    fill_in 'passenger_first_name', :with => 'diff22'
    fill_in 'passenger_last_name', :with => 'passenger'
    fill_in 'passenger_email', :with => 'temp@bhasin.com'
    fill_in 'passenger_phone_num', :with => '234-234-2344'
    rideNumber = find(".rideNumber").text

    current_page = CheckoutPage.new
    current_page.fill_cc
    #find('#reservation_request_dropoff_same_as_pickup').click
    current_page.reserve_car

    current_page = ReservationConfirmationPage.new
    current_page.verify_reservation_passed
    page.should have_text('temp@bhasin.com')

  end
end
