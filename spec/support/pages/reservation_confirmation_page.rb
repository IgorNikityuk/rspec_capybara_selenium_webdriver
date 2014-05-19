require 'spec_helper'
require 'support/generic_search.rb'

class ReservationConfirmationPage < GenericSearch
  include Capybara::DSL

  def verify_reservation_passed
  	find('.extraheader>h2').text.should == 'Reservation Confirmation'
  	find('#self_service_cancel_button').text.should == 'Cancel'
  end

end