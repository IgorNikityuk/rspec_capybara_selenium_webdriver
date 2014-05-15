require 'spec_helper'

class GenericSearch
  include Capybara::DSL
  
  #function for clicking reserve button and waiting for reservation confirmation page
	def click_next_date
      begin
      	find('#search_ride_date').click
        randomDate = find('#calcurrent').text.to_i + 1 
        find_link(randomDate).click
      rescue
      	find('#calnext').click
      	find_link('2').click
      end
	end

end