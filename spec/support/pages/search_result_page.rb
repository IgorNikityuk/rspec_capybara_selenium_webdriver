require 'spec_helper'
require 'support/generic_search.rb'

class SearchResultPage < GenericSearch
  include Capybara::DSL	

	def select_car
      first(:link, 'Select').click
	end

end