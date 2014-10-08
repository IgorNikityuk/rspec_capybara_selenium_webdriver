require 'spec_helper'
require 'support/generic_search.rb'

class SearchResultPage < GenericSearch
  include Capybara::DSL	

  	def wait_for_page_load
	  #(find('.sortby-price').text.should == 'Price')
  	  #sleep 3
  	end

	def select_car
<<<<<<< HEAD
	  first(:xpath, '(.//div[4])[7]')
	  links_count = page.all(:link, 'Select', :visible => true).count
	  link_number = rand(links_count) + 1
	  page.all(:link, 'Select', :visible => true)[link_number].click
	  puts "We have #{links_count} SELECT links. And I clicked on #{link_number} link"
=======
	  links_count = page.all(:link, 'Select').count
	  puts links_count
	  link_number = links_count[rand(links_count)] + 1
	  find(:xpath, "(.//a[contains(text(), 'Select')])[" + link_number.to_s + "]").click
>>>>>>> cbb59f0d9780bf4167735346e33edec4c9cb8d8b
	end

end