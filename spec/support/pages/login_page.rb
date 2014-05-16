require 'spec_helper'
require 'support/generic_search.rb'

class LoginPage < GenericSearch
  include Capybara::DSL

  #function for login on site
	def sign_in_as (email, password)
      find_link('Sign In').click
      fill_in 'email', :with => email
      fill_in 'password', :with => password
      find_button('Sign-in').click
	end

end