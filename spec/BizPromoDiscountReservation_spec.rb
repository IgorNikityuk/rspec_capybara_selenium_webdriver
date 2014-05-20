require 'spec_helper'

describe "BizPromoDiscountReservation" do
  it "BizPromoDiscountReservation", :js => true do

    current_page = SearchPage.new
    current_page.open_logout

    current_page = LoginPage.new
    current_page.sign_in_as('flagco@guy.com', 'monkey123')

    page.should have_link('My Account')
    select('Hourly-As-Directed', :from => 'service_type')
    select('3', :from => 'search_pax')
    search = GenericSearch.new
    search.click_next_date
    select('11 PM', :from => 'search_pickup_time_hour')
    select('5 AM', :from => 'search_drop_off_time_hour')
    fill_in 'search_pickup_place', :with => '1950 Ortega St, San Francisco, CA 94122'
    find_button('Get a quote').click
    
    current_page = SearchResultPage.new
    current_page.wait_for_page_load
    current_page.select_car

    current_page = CheckoutPage.new
    current_page.add_new_passenger

    fill_in 'reservation_request_special_requests', :with => 'Biz Promo Discount Reservation'
    find('#reservation_request_dropoff_same_as_pickup').click
    fill_in 'dropoff_address_street1', :with => '123 main'
    fill_in 'dropoff_address_city', :with => 'SanRamon'
    fill_in 'dropoff_address_postal_code', :with => '94582'
    fill_in 'entered_promo_code', :with => 'MTSINAI10'
    find('#promo_code_button').click
    #page.should have_text("0 discount applied")
    #page.should_not have_css("tr.promo_code_discount > td.left")
    
    current_page.fill_cc
    current_page.reserve_car

    current_page = ReservationConfirmationPage.new
    current_page.verify_reservation_passed

    page.should_not have_xpath('//div[1]/a/span')
  end
  
end