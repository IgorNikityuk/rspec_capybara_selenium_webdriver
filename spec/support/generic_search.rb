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
    	find('#search_ride_date').click
      plusOneDay = find('#calcurrent').text.to_i + 1
      find_link(plusOneDay).click
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

end