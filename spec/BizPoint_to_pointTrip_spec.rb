require 'spec_helper'

describe "BizPoint_to_pointTrip" do
  it "BizPoint_to_pointTrip", :js => true do

    @search_page.open_logout

    select('Point-to-Point (one-way)', :from => 'service_type')
    select('11 PM', :from => 'search_pickup_time_hour')
    fill_in 'search_pickup_place', :with => '1180 SAN FRANCISCO, Union Street, San Francisco, CA, United States'
    fill_in 'search_drop_off_place', :with => '1070 SAN FRANCISCO, Union Street, San Francisco, CA, United States'
    select('2', :from => 'search_pax')
    @search.click_next_date
    check 'is_business'
    find_button('Get a quote').click
    page.should_not have_xpath("//span[@class='out_of_policy_hover tiptip']")

    @search_result_page.wait_for_page_load
    @search_result_page.select_car
    @checkout_page.fill_passenger_details

    email = find('#passenger_email').text
    #find('#reservation_request_dropoff_same_as_pickup').click
    
    @checkout_page.fill_cc
    @checkout_page.reserve_car
    @reservation_confirmation_page.verify_reservation_passed

    page.should have_text(email)
  end
end
