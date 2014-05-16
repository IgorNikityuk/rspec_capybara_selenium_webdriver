require 'spec_helper'
require 'support/generic_search.rb'

class SearchPage < GenericSearch
  include Capybara::DSL

	def open_logout
	  visit Capybara.default_host + '/logout'
	end

end