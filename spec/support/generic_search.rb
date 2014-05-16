require 'spec_helper'

class GenericSearch
  include Capybara::DSL

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

end