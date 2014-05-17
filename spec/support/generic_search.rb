require 'spec_helper'

class GenericSearch
  include Capybara::DSL

  def wait_for_ajax(timeout = Capybara.default_wait_time)
    wait_until { page.evaluate_script('$.active') == 0 }
  end

  def wait_until
    Timeout.timeout(Capybara.default_wait_time) do
      sleep(0.1) until value = yield
      value
    end
  end

	def click_next_date
    begin
    	find('#search_ride_date').click
      plusOneDay = find('#calcurrent').text.to_i + 1
      find_link(plusOneDay).click
    rescue
    	find('#calnext').click
      find_link('2').click
    end
	end

end