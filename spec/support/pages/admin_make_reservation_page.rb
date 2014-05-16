require 'spec_helper'
require 'support/generic_search.rb'

class AdminMakeReservationPage < GenericSearch
  include Capybara::DSL
  

  #function for clicking on button RESERVE
	def find_customers_by (container)
	  fields = {:email => 'email'}

	  container.each { |key, value| 
	    if fields.has_key? key
		  fill_in fields[key], :with => value
		  else
		  puts 'No such field on the page'
	    end
	  }
	  
	  find('#btn_find').click
	end

end