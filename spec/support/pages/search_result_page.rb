require 'spec_helper'
require 'support/generic_search.rb'

class SearchResultPage < GenericSearch
  include Capybara::DSL	

  	def wait_for_page_load
  	  find('.sortby-price').text.should == 'Price'  			
  	end

	def select_car
	  first(:link, 'Select').click
	end

end