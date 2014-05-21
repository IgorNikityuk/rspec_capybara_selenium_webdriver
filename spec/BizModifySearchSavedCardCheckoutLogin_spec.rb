require 'spec_helper'

describe "BizModifySearchSavedCardCheckoutLogin" do
  it "BizModifySearchSavedCardCheckoutLogin", :js => true do
    
    @search_page.open_logout
    @login_page.sign_in_as('flagco@guy.com', 'monkey123')

    page.should have_link('My Account')
    select('From Airport', :from => 'service_type')
    select('2', :from => 'search_pax')
    @search.click_next_date
    select('11 PM', :from => 'search_pickup_time_hour')
    fill_in 'search_pickup_place', :with => 'SFO-FBO'
    fill_in 'search_drop_off_place', :with => '1 Embarcadero Center, San Francisco, CA 94111'
    find_button('Get a quote').click
    
    @search_result_page.wait_for_page_load
    
    #page.should_not have_text("The ride you’ve selected is during a time of high-demand")
    #first('span.luggage_capacity').text.should == '3 bags'
    #find('p').text.should == 'exact:Service: 2 passenger, From Airport'
    page.should_not have_xpath('//span[@class="operator-phone"]')

    @search_result_page.select_car

    page.should_not have_css('low_avail')

    @search_result_page.open_logout
    
    select('Just Drive (hourly)', :from => 'service_type')
    select('2', :from => 'search_pax')
    @search.click_next_date
    select('11 PM', :from => 'search_pickup_time_hour')
    fill_in 'search_pickup_place', :with => '1 Embarcadero Center, San Francisco, CA'
    find_button('Get a quote').click
    page.should have_text('1 Embarcadero Center')

    @login_page.sign_in_as('nocorp@shoes.com', 'monkey123')
    #page.should_not have_text('The ride you’ve selected is during a time of high-demand')
    
    @search_result_page.wait_for_page_load
    @search_result_page.select_car    
    find_button('Reserve').value.should == 'Reserve'

    @checkout_page.fill_cc
    @checkout_page.enter_promo_code

    page.should_not have_text('Invalid account #')

    @checkout_page.reserve_car

    page.should have_text('Reservation Request')
    #page.should_not have_text("The ride you’ve selected is during a high-demand service time. In times of high-demand service, the price and availability is subject to change and not guaranteed until confirmed by the provider.")
    page.should_not have_text("Oops! Something went wrong!")
    page.should_not have_text("Once the ride is confirmed by the provider, you will receive an email containing your confirmation. If the ride is not confirmed by the provider, your deposit will be refunded and there will be no further charges to your credit card.")
    page.should_not have_text("There was an error processing your payment - please try a different card.")
    page.should_not have_text("We are actively working to confirm your request with the provider you have selected. Please note, If we are unable to confirm your ride as requested, one of our representatives will contact you within 24 hours of booking, to discuss your options.")
    page.should_not have_text("Thank you! Your request has been submitted.")
    page.should_not have_text("Ride Request Details")
    page.should have_link("Print")
    #page.should have_text("Repeat trip »")
    #page.should have_text("Reverse trip »")
    #page.should have_text("New trip »")
    page.should have_text("Have a great trip. Thank you.")
    page.should_not have_xpath('//div[1]/a/span')
    page.should_not have_css("#div.deposit_info")
  end
  
end