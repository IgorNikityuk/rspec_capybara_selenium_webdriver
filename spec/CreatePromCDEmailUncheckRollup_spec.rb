require 'spec_helper'

describe "CreatePromCDEmailUncheckRollup" do
  it "CreatePromCDEmailUncheckRollup", :js => true do
    visit 'http://staging.limos.com/logout'
    select('Prom / School Event', :from => 'service_type')
    select('8', :from => 'search_pax')
    search = GenericSearch.new
    search.click_next_date
    select('11 PM', :from => 'search_pickup_time_hour')
    select(':15', :from => 'search_pickup_time_minute')
    select('6 AM', :from => 'search_drop_off_time_hour')
    select(':45', :from => 'search_drop_off_time_minute')
    fill_in 'search_pickup_place', :with => '761 Rollins Road #2 burlingame ca'
    find_button('Get a quote').click    
    
    fill_in 'passenger_first_name', :with => 'selenium'
    fill_in 'passenger_last_name', :with => 'prom'
    fill_in 'passenger_email', :with => 'igor.nikityuk@gmail.com'
    find('#user_passenger_info_submit').click
    page.should_not have_xpath("//span[@class='operator-phone']")
    page.should_not have_xpath("//span[@class='operator-email']")
    first(:link, 'Select').click
    select('selenium prom', :from => 'passenger_list')
    find('#reservation_request_dropoff_same_as_pickup').click
    fill_in 'dropoff_address_street1', :with => '14 state st'
    fill_in 'dropoff_address_city', :with => 'san mateo'
    fill_in 'dropoff_address_state_province', :with => 'ca'
    fill_in 'dropoff_address_postal_code', :with => '94001'
    rideNumber = find('.rideNumber').text
    fill_in ('reservation_request_special_requests'), :with => 'igor.nikityuk@gmail.com'
    #page.should have_text('Additional Pricing DetailsTip is already included in the total price')
    #page.should have_text('Tip is already included in the total price') 
    fill_in 'card_payment_method_card_number', :with => '5167138311657643'
    fill_in 'card_payment_method_cvv', :with => '123'
    select '12', :from => 'card_payment_method_expiration_month'
    select '2014', :from => 'card_payment_method_expiration_year'
    fill_in 'card_payment_method_first_name', :with => 'Joe'
    fill_in 'card_payment_method_last_name', :with => 'George'
    fill_in 'address_street1', :with => '123 Street'
    select 'United States', :from => 'address_country'
    fill_in 'address_city', :with => 'SanRamon'
    select 'Iowa', :from => 'select_state_province'
    fill_in 'address_postal_code', :with => '55555'
    page.should have_text('from 11:15PM to 06:45AM (7.5 hours) for 8 people')
    page.should have_text('Amount due now:')
    fill_in 'passenger_phone_num', :with => '123-233-4324'
    find('#reservation_request_submit').click
    while (page.has_css?('.centered.horiz>img') == true)
      sleep(1)
    end
    page.should have_text('igor.nikityuk@gmail.com')
    page.should have_text('from 11:15PM to 06:45AM (7.5 hours) for 8 people')
    page.should_not have_xpath('//div[1]/a/span')
    page.should_not have_text('Base Rate')
    page.should have_text('Additional Pricing Details')
    page.should have_text('Tip is already included in the total price')
  end
  
end
