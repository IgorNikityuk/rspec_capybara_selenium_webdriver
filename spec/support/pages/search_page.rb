require 'spec_helper'
require 'support/generic_search.rb'

class SearchPage < GenericSearch
  include Capybara::DSL

  def make_search_with (container)
  	fields = {:service_type 		=> 'service_type', 
  			  :passengers_count 	=> 'search_pax',
  			  :pick_up_time_hour 	=> 'search_pickup_time_hour',
  			  :pick_up_time_minute 	=> 'search_pickup_time_minute',
  			  :pick_up_place 		=> 'search_pickup_place',
  			  :drop_off_place 		=> 'search_drop_off_place'}

	container.each { |key, value| 
	  if fields.has_key? key
	  	#TODO for text fields
	  	if key == :pick_up_place || key == :drop_off_place
 		  fill_in fields[key], :with => value
 		#TODO for dropdowns fields
	  	else
	  	  select value, :from => fields[key]
		end
	  else
	    puts 'Page not consist ' + fields[key] + ' field'
	  end
	}

    click_next_date
  
  find_button('Get a quote').click
  end
end