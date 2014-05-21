require 'spec_helper'

describe "CreateAirportSearch" do
  it "CreateAirportSearch", :js => true do
    
    @search_page.open_logout

    select('To Airport', :from => 'service_type')
    select('2', :from => 'search_pax')
    find('#search_ride_date').click
    find('#calcurrent').click
    select('11 PM', :from => 'search_pickup_time_hour')
    fill_in 'search_pickup_place', :with => '94111'
    fill_in 'search_drop_off_place', :with => 'OAK'    
    find_button('Get a quote').click    
    find('.ride-number>span').text.should == 'RIDE #:'
  end
  
end
