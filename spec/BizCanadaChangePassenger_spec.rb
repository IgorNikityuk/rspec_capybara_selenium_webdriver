require 'spec_helper'

describe "BizCanadaChangePassenger" do
  it "BizCanadaChangePassenger", :js => true do
    
    current_page = SearchPage.new
    current_page.open_logout

    current_page = LoginPage.new
    current_page.sign_in_as('flagco@guy.com', 'monkey123')

    page.should have_link('My Account')
    select('Hourly-As-Directed', :from => 'service_type')
    select('3', :from => 'search_pax')
    search = GenericSearch.new
    search.click_next_date
    select('8 PM', :from => 'search_pickup_time_hour')
    select('2 AM', :from => 'search_drop_off_time_hour')
    fill_in 'search_pickup_place', :with => '370 King St W,Toronto, ON M5V 1J9, Canada'
    find_button('Get a quote').click
    page.should_not have_xpath("//span[@class='out_of_policy_hover tiptip']")
    
    current_page = SearchResultPage.new
    current_page.wait_for_page_load
    current_page.select_car

    current_page = CheckoutPage.new
    current_page.add_new_passenger

    rideNumber = find('.rideNumber').text
    fill_in 'passenger_first_name', :with => 'Test'
    fill_in 'reservation_request_special_requests', :with => 'joe1@jackson.com'
    fill_in 'passenger_last_name', :with => 'LastName'
    find('#reservation_request_dropoff_same_as_pickup').click
    fill_in 'dropoff_address_street1', :with => '123 main'
    fill_in 'dropoff_address_city', :with => 'toronto'
    fill_in 'dropoff_address_postal_code', :with => 'MV5 1J9'
    select('This cost will be reimbursed to the Company', :from => 'reservation_request_company_policy_exception_id')
    fill_in 'entered_promo_code', :with => 'MTSINAI10'
    find('#promo_code_button').click
    #page.should have_text("0 discount applied")
    #page.should_not have_css("tr.promo_code_discount > td.left")
    
    current_page.fill_cc
    current_page.reserve_car

    current_page = ReservationConfirmationPage.new
    current_page.verify_reservation_passed

    page.should_not have_xpath('//div[1]/a/span')
    first('.fieldvalue:nth-of-type(2)').text.should == "This cost will be reimbursed to the Company"
    find('#pickup_place').text.should == "370 King St W, Toronto, ON, M5V 1J9, CA"
    find('#drop_off_place').text.should == '123 main, toronto, ON, MV5 1J9'
    page.should_not have_css("#div.deposit_info")
  end
  
end