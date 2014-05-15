require 'spec_helper'

describe "DataPickerOperator" do
  it "DataPickerOperator", :js => true do
    visit Capybara.default_host + '/operators/tourist-limousine-service-tanger'
    select('From Airport', :from => 'service_type')
    select('3', :from => 'search_pax')
    find('#search_ride_date').click
    find('#calcurrent').click
    select('11 PM', :from => 'search_pickup_time_hour')
    select(':15', :from => 'search_pickup_time_minute')
    fill_in 'search_pickup_place', :with => 'MIA'
    fill_in 'search_drop_off_place', :with => '4 Grove Isle Drive, miami, fl'
    find_button('Get a quote').click
    page.should_not have_text('Please provide all information below')

  end
end
