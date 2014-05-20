require 'spec_helper'

class GenericSearch
  include Capybara::DSL

  def wait_for_ajax
    Timeout.timeout(Capybara.default_wait_time) do
      loop do
        active = page.evaluate_script('jQuery.active')
        break if active == 0
      end
    end
  end

	def click_next_date
    begin
      first('#search_ride_date').click
      randomDate = first('#calcurrent').text.to_i + 1 
      first(:xpath, "//*[@id='calbody']//a[contains(text(), '" + randomDate.to_s + "')]").click
    rescue
    	find('#calnext').click
      find_link('2').click
    end
	end

  def verify_user_details
    find('#info_acct').text.should == 'Acct Type: Business'
    find('#info_fname').text.should == 'First name: Leo'
    find('#info_lname').text.should == 'Last name: Pekker'
    find('#info_enter_acct_link').text.should == 'Enter Account'
  end

  def random_number
    rand 100000000
  end

end