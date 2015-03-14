require 'spec_helper'
require 'support/generic_search.rb'

class LoginPage < GenericSearch
  include Capybara::DSL
  include RSpec::Matchers

	def should_have_sign_in_link
		page.has_link?("Sign In").should be_true
	end

end