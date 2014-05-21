require 'spec_helper'

describe "BizCanadaChangePassenger" do
  it "BizCanadaChangePassenger", :js => true do
    
    @search_page.open_logout
    @login_page.sign_in_as('flagco@guy.com', 'monkey123')

    page.should have_link('My Account')
    select('Hourly-As-Directed', :from => 'service_type')
    select('3', :from => 'search_pax')
    @search.click_next_date
    select('11 PM', :from => 'search_pickup_time_hour')
    select('5 AM', :from => 'search_drop_off_time_hour')
    fill_in 'search_pickup_place', :with => '370 King St W,Toronto, ON M5V 1J9, Canada'
    find_button('Get a quote').click
    page.should_not have_xpath("//span[@class='out_of_policy_hover tiptip']")
    
    @search_result_page.wait_for_page_load
    @search_result_page.select_car
    #sleep 200000
    @checkout_page.add_new_passenger
    @checkout_page.fill_passenger_details

    rideNumber = find('.rideNumber').text
    find('#reservation_request_dropoff_same_as_pickup').click
    fill_in 'dropoff_address_street1', :with => '123 main'
    fill_in 'dropoff_address_city', :with => 'toronto'
    fill_in 'dropoff_address_postal_code', :with => 'MV5 1J9'
    select('This cost will be reimbursed to the Company', :from => 'reservation_request_company_policy_exception_id')
    
    @checkout_page.fill_cc
    @checkout_page.enter_promo_code
    @checkout_page.reserve_car
    @reservation_confirmation_page.verify_reservation_passed

    page.should_not have_xpath('//div[1]/a/span')
    first('.fieldvalue:nth-of-type(2)').text.should == "This cost will be reimbursed to the Company"
    find('#pickup_place').text.should == "370 King St W, Toronto, ON, M5V 1J9, CA"
    find('#drop_off_place').text.should == '123 main, toronto, ON, MV5 1J9'
    page.should_not have_css("#div.deposit_info")
  end
end