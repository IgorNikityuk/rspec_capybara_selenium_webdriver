require 'spec_helper'

describe 'FIRST TEST' do
  it 'Lets test it', :js => true do
    @login_page.open_logout
    @login_page.should_have_sign_in_link
  end
end