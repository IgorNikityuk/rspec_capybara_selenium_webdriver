require 'spec_helper'
require 'support/generic_search.rb'

class AdminPage < GenericSearch
  include Capybara::DSL
  
  #function for clicking on button RESERVE
	def choose_category (link)
	  find_link(link).click
	end

end