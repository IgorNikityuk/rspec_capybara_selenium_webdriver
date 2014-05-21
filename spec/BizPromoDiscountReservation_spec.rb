require 'spec_helper'

describe "BizPromoDiscountReservation" do
  it "BizPromoDiscountReservation", :js => true do

    @search_page.open_logout
    @login_page.sign_in_as('flagco@guy.com', 'monkey123')

    page.should have_link('My Account')
    select('Hourly-As-Directed', :from => 'service_type')
    select('3', :from => 'search_pax')
    @search.click_next_date
    select('11 PM', :from => 'search_pickup_time_hour')
    select('5 AM', :from => 'search_drop_off_time_hour')
    fill_in 'search_pickup_place', :with => '1950 Ortega St, San Francisco, CA 94122'
    find_button('Get a quote').click
    
    @search_result_page.wait_for_page_load
    @search_result_page.select_car
    @checkout_page.add_new_passenger

    fill_in 'reservation_request_special_requests', :with => 'Biz Promo Discount Reservation'
    find('#reservation_request_dropoff_same_as_pickup').click
    fill_in 'dropoff_address_street1', :with => '123 main'
    fill_in 'dropoff_address_city', :with => 'SanRamon'
    fill_in 'dropoff_address_postal_code', :with => '94582'
        
    @checkout_page.fill_cc
    @checkout_page.enter_promo_code
    @checkout_page.reserve_car
    @reservation_confirmation_page.verify_reservation_passed

    page.should_not have_xpath('//div[1]/a/span')
  end
end