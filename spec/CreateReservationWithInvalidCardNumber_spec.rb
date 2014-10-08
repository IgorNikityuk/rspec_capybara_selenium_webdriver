require 'spec_helper'

describe 'CreateReservationWithInvalidCardNumber' do
  it 'CreateReservationWithInvalidCardNumber', :js => true do
  	
    @search_page.open_logout
    @search_page.make_search_with({ :service_type         => 'From Airport', 
                                    :passengers_count     => '3',
                                    :pick_up_time_hour    => '11 PM',
                                    :pick_up_time_minute  => ':15',
                                    :pick_up_place        => 'ZRH',
                                    :drop_off_place       => '8001 Zurich, Switzerland'})
    @search_result_page.wait_for_page_load
    @search_result_page.select_car
    @checkout_page.fill_passenger_details
    @checkout_page.fill_flight_details({:flight_airline => 'American Airlines', :flight_number => '1190'})
        
    email = find('#passenger_email').text
    select '1', :from => 'ride_pricing_number_of_stops'
    find('#ride_pricing_meet_inside').click
    fill_in 'reservation_request_special_requests', :with => 'temp@bhasin.com'
    
    @checkout_page.fill_cc_with_invalid_data

    page.should have_text('at 11:15PM for 3 people')
    page.should_not have_text('Amount Due Now:')
    
    @checkout_page.reserve_car

    find('errorMsgs').text.should == 'There was an error processing your payment - please try a different card.'
  
    @checkout_page.fill_cc
    @checkout_page.reserve_car
    @reservation_confirmation_page.verify_reservation_passed

    page.should have_text(email)
    page.should_not have_xpath('//div[1]/a/span')
  end
end