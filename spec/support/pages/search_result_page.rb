require 'spec_helper'
require 'support/generic_search.rb'

class SearchResultPage < GenericSearch
  include Capybara::DSL	

  	def wait_for_page_load
  	  find('.sortby-price').text.should == 'Price'  			
  	end

	def select_car
	  links_count = page.all(:link, 'Select').count
	  puts links_count
	  link_number = links_count[rand(links_count)] + 1
	  find(:xpath, "(.//a[contains(text(), 'Select')])[" + link_number.to_s + "]").click
	end

end