require 'spec_helper'

describe "API" do
  it "API", :js => true do
    visit 'http://apistaging.limos.com/v1/biz/search.json?search[ride_date]=12/29/2013&search[pickup_time]=06:00&search[drop_off_time]=10:00&search[pickup_place]=94111&search[service_type]=4096&search[pax]=2&api_key=G9S1-GcmLd370az&format=json'
    page.should have_text('"response_code":200')
    page.should_not have_text('"response_code":500')
    page.should_not have_text('"response_code":102')
	visit 'http://limos.com/v1/biz/search.json?search[ride_date]=12/29/2013&search[pickup_time]=06:00&search[drop_off_time]=10:00&search[pickup_place]=94111&search[service_type]=4096&search[pax]=2&api_key=G9S1-GcmLd370az&format=json'
    page.should have_text('"response_code":200')
    page.should_not have_text('"response_code":500')
    page.should_not have_text('"response_code":102')
	visit 'http://staging.limos.com/v1/biz/search.json?search[ride_date]=12/29/2013&search[pickup_time]=06:00&search[drop_off_time]=10:00&search[pickup_place]=94111&search[service_type]=4096&search[pax]=2&api_key=G9S1-GcmLd370az&format=json'
    page.should have_text('"response_code":200')
    page.should_not have_text('"response_code":500')
    page.should_not have_text('"response_code":102')
  end
  
end
