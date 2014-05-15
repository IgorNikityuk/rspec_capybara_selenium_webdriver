require 'spec_helper'

class LoginPage
  include Capybara::DSL	
  
  #function for login on site
	def login_as (email, password)
      find_link('Sign In').click
      fill_in 'email', :with => email
      fill_in 'password', :with => password
      find_button('Sign-in').click
	end

end