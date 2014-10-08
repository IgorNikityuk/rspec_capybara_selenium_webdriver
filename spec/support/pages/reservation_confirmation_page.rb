require 'spec_helper'
require 'support/generic_search.rb'

class ReservationConfirmationPage < GenericSearch
  include Capybara::DSL

  def verify_reservation_passed
  	first('h2').text.should == 'Reservation Confirmation'
  end

end