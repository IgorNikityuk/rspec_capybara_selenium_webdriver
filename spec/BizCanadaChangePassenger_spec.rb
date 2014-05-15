require 'spec_helper'

describe "BizCanadaChangePassenger" do
  it "BizCanadaChangePassenger", :js => true do
    visit 'http://staging.limos.com/logout'
    #login as joyce2@limos.com
    login_page = LoginPage.new
    login_page.login_as('flagco@guy.com', 'monkey123')
    page.should have_link('My Account')
    select('Hourly-As-Directed', :from => 'service_type')
    select('3', :from => 'search_pax')
    find('#search_ride_date').click
    find('#calcurrent').click
    select('8 PM', :from => 'search_pickup_time_hour')
    select('2 AM', :from => 'search_drop_off_time_hour')
    fill_in 'search_pickup_place', :with => '370 King St W,Toronto, ON M5V 1J9, Canada'
    find_button('Get a quote').click
    page.should_not have_xpath("//span[@class='out_of_policy_hover tiptip']")
    while (page.has_link?('Select') == false)
      sleep(1)
    end
    first(:link, 'Select').click
    find_link('Add new passenger').click
    fill_in 'passenger_first_name', :with => 'Yana'
    fill_in 'passenger_last_name', :with => 'Lymar'
    fill_in 'passenger_email', :with => 'joe1@jackson.com'
    fill_in 'passenger_phone_num', :with => '4085150000'
    rideNumber = find(:css, '.rideNumber').text
    fill_in 'passenger_first_name', :with => 'Test'
    fill_in 'reservation_request_special_requests', :with => 'joe1@jackson.com'
    fill_in 'passenger_last_name', :with => 'LastName'
    find(:css, '#reservation_request_dropoff_same_as_pickup').click
    fill_in 'dropoff_address_street1', :with => '123 main'
    fill_in 'dropoff_address_city', :with => 'toronto'
    fill_in 'dropoff_address_postal_code', :with => 'MV5 1J9'
    select('This cost will be reimbursed to the Company', :from => 'reservation_request_company_policy_exception_id')
    fill_in 'entered_promo_code', :with => 'MTSINAI10'
    find_button('Apply Discount').click
    page.should have_text("0 discount applied")
    page.should_not have_css("tr.promo_code_discount > td.left")
    find(:css, '#card_payment_method_saved_id_0').click
    fill_in 'card_payment_method_card_number', :with => '5200000000000007'
    fill_in 'card_payment_method_cvv', :with => '123'
    select('12', :from => 'card_payment_method_expiration_month')
    select('2015', :from => 'card_payment_method_expiration_year')
    fill_in 'card_payment_method_first_name', :with => 'Joe'
    fill_in 'card_payment_method_last_name', :with => 'George'
    fill_in 'address_street1', :with => '123 Street'
    select('Switzerland', :from => 'address_country')
    fill_in 'address_city', :with => 'zurich'
    fill_in 'address_state_province', :with => 'Arkansas'
    fill_in 'address_postal_code', :with => '55555'
    find_button('Reserve').click
    while (page.has_css?('.centered.horiz>img') == true)
      sleep(1)
    end
    page.should_not have_text("Oops! Something went wrong!")
    page.assert_selector('#self_service_change_button')
    page.assert_selector('#self_service_cancel_button')
    page.should_not have_content('//div[1]/a/span')
    page.should have_text("This cost will be reimbursed to the Company")
    page.should have_text("370 King St W")
    page.should have_text("123 main")
    page.should_not have_css("#div.deposit_info")
  end
  
end