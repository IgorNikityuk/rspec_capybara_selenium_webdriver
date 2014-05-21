#encoding: utf-8

require 'spec_helper'

describe "Contact-infoPage" do
  it "Contact-infoPage", :js => true do
    
    @search_page.open_logout

    select('Wedding', :from => 'service_type')
    select('4', :from => 'search_pax')
    @search.click_next_date
    select('11 PM', :from => 'search_pickup_time_hour')
    select(':15', :from => 'search_pickup_time_minute')
    fill_in 'search_pickup_place', :with => '1070 SAN FRANCISCO, Union Street, San Francisco, CA, United States'
    find_button('Get a quote').click

    expect(page).to have_link('Sign in to proceed.')
    page.should have_css('h3')
    page.should have_link('Modify Search')
    find('#user_passenger_info_submit').click
    first('label.error').text.should == 'Please enter first name'
    page.should have_xpath("//form[@id='new_passenger']/fieldset/fieldset/ul/li[2]/label[2]")
    page.should have_xpath("//form[@id='new_passenger']/fieldset/fieldset/ul/li[3]/label[2]")
    fill_in 'passenger_phone_num', :with => 'test'
    find('#user_passenger_info_submit').click
    page.should have_xpath("//form[@id='new_passenger']/fieldset/fieldset/ul/li[4]/label[2]")
    fill_in 'passenger_phone_num', :with => '1'
    find('#user_passenger_info_submit').click
    page.should have_xpath("//form[@id='new_passenger']/fieldset/fieldset/ul/li[4]/label[2]")
    fill_in 'passenger_phone_num', :with => '0938867865'
    fill_in 'passenger_first_name', :with => 'Yana'
    fill_in 'passenger_last_name', :with => 'Lymar'
    fill_in 'passenger_email', :with => 'igor.nikityuk@gmail.com'
    find('#user_passenger_info_submit').click
    
    @search_result_page.wait_for_page_load
    @search_result_page.select_car

    page.should have_css('h2')
  end
  
end
