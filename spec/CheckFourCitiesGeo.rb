#encoding: UTF-8

require 'spec_helper'

describe "CheckoutFourCities" do
  it "CheckoutFourCities", :js => true do

    visit 'http://staging.limos.com/geo'
    first(:link, 'United States').click
    first(:link, 'California').click
    first(:link, 'San Francisco').click
    page.should have_text('San Francisco Limo')  
    find_link('San Francisco Limo Services').should be_visible
    find_link('San Francisco Airport Shuttle Service').should be_visible
    find_link('San Francisco Limousine Service Reviews').should be_visible
    find_link('Things to do in San Francisco').should be_visible
    find('h1').text.should == 'San Francisco Limo Car Service, Airport Shuttle, Limo Rental'
    page.should have_css('span.ir')  
    page.should have_text('Night-on-the-Town')  
    first(:link, 'United States Limo Service').click
    find('h1').text.should == 'Find Limo Service World Wide'
    find('h2').text.should == 'Directory of Limousine Services in United States'
    find_link('California').should be_visible
    first(:link, 'Arizona').click
    find('h1').text.should == 'Offering The Best Limo Services in AZ'
    first(:link, 'Scottsdale').click
    page.should have_xpath('//li[5]/div/div/a/img')
    page.should have_css('span.ir')
    first(:link, 'United States Limo Service').click  
    page.should have_text('Directory of Limousine Services in United States')
    first(:link, 'Florida').click
    first(:link, 'Miami Beach').click
    find('h1').text.should == 'Miami Beach, FL Limo & Car Service'
    first(:xpath, '//a/img').text.should == ''
    first('span.ir').text.should == 'Business Travel »'
    page.should have_xpath('//div[2]/a/span')
    page.should have_xpath('//div[3]/a/span')
    first(:link, 'United States Limo Service').click
    find('fieldset.rounded_large.group').should be_visible
    page.should have_text('Directory of Limousine Services in United States')
    first(:link, 'New York').click
    page.should have_text('Offering The Best Limo Services in NY')
    first(:link, 'New York').click
    page.should have_text('New York')
    find('h1').text.should == 'New York Limo Private Car Service, Airport Shuttles, Limo Rental'
    find_link('New York Limo Services').should be_visible
    find_link('New York Limousine Service Reviews').should be_visible
    find_link('Things to do in New York').should be_visible
    page.should have_xpath("(//a[contains(text(),'New York Airport Shuttle Service')])[2]")
    page.should have_css('span.ir')
    page.should have_xpath('//div[2]/a/span')
    page.should have_xpath('//div[3]/a/span')
    first('h2').text.should == 'New York, the city that never sleeps, is waiting for you. Explore in style.'
  end
end