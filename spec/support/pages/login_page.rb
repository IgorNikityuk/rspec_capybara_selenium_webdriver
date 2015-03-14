require 'spec_helper'
require 'support/generic_search.rb'

class LoginPage < GenericSearch
  include Capybara::DSL
  include RSpec::Matchers

	def should_have_sign_in_link
		page.should have_link "Sign In"
	end

end