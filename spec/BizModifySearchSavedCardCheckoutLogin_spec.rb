#encoding: UTF-8

require 'spec_helper'

describe "BizModifySearchSavedCardCheckoutLogin" do
  it "BizModifySearchSavedCardCheckoutLogin", :js => true do

    current_page = SearchPage.new
    current_page.open_logout

    current_page = LoginPage.new
    current_page.sign_in_as('flagco@guy.com', 'monkey123')

    page.should have_link('My Account')
    select('From Airport', :from => 'service_type')
    select('2', :from => 'search_pax')
    find('#search_ride_date').click
    find('#calcurrent').click
    select('11 PM', :from => 'search_pickup_time_hour')
    fill_in 'search_pickup_place', :with => 'SFO-FBO'
    fill_in 'search_drop_off_place', :with => '1 Embarcadero Center, San Francisco, CA 94111'
    find_button('Get a quote').click
    
    current_page = SearchResultPage.new
    
    find_button('Modify Search').should be_visible
    page.should_not have_text("The ride you’ve selected is during a time of high-demand")
    #first('span.luggage_capacity').text.should == '3 bags'
    #find('p').text.should == 'exact:Service: 2 passenger, From Airport'
    page.should_not have_xpath('//span[@class="operator-phone"]')

    current_page.select_car

    page.should_not have_css('low_avail')

    current_page = SearchPage.new
    current_page.open_logout

    select('Just Drive (hourly)', :from => 'service_type')
    select('2', :from => 'search_pax')
    search = GenericSearch.new
    search.click_next_date
    select('11 PM', :from => 'search_pickup_time_hour')
    fill_in 'search_pickup_place', :with => '1 Embarcadero Center, San Francisco, CA'
    find_button('Get a quote').click
    page.should have_text('1 Embarcadero Center')

    current_page = LoginPage.new
    current_page.sign_in_as('nocorp@shoes.com', 'monkey123')
    
    current_page = SearchResultPage.new
    
    page.should_not have_text('The ride you’ve selected is during a time of high-demand')
    
    current_page.select_car
    
    find_button('Reserve').value.should == 'Reserve'

    current_page = CheckoutPage.new

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
    fill_in 'entered_promo_code', :with => 'MTSINAI10'
    find('#entered_promo_code').click
    find_button('Apply Discount').click
    #find('label.infoMessage').text.should == '$30 discount applied'
    page.should_not have_text('Invalid account #')

    current_page.reserve_car

    page.should_not have_text("The ride you’ve selected is during a high-demand service time. In times of high-demand service, the price and availability is subject to change and not guaranteed until confirmed by the provider.")
    page.should_not have_text("Oops! Something went wrong!")
    page.should_not have_text("Once the ride is confirmed by the provider, you will receive an email containing your confirmation. If the ride is not confirmed by the provider, your deposit will be refunded and there will be no further charges to your credit card.")
    page.should_not have_text("There was an error processing your payment - please try a different card.")
    page.should_not have_text("We are actively working to confirm your request with the provider you have selected. Please note, If we are unable to confirm your ride as requested, one of our representatives will contact you within 24 hours of booking, to discuss your options.")
    page.should_not have_text("Thank you! Your request has been submitted.")
    page.should_not have_text("Ride Request Details")
    page.should have_link("Print")
    page.should have_text("Repeat trip »")
    page.should have_text("Reverse trip »")
    page.should have_text("New trip »")
    page.should have_text("Have a great trip. Thank you.")
    page.should_not have_xpath('//div[1]/a/span')
    page.should_not have_css("#div.deposit_info")
  end
  
end