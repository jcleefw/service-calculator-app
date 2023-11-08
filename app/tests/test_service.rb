require 'minitest/autorun'
require 'rack/test'
require_relative '../modals/service'

class ServiceTest < Minitest::Test
  include Rack::Test::Methods

  def setup
    @service = Service.new("Service Name", 10.0, { option1: 5.0, option2: 7.5 })
  end

  def test_total_price_with_default_quantity_and_no_options
    assert_equal 10.0, @service.total_price
  end

  def test_total_price_with_quantity_and_no_options
    assert_equal 20.0, @service.total_price(2)
  end

  def test_total_price_with_selected_options
    selected_options = [:option1, :option2]
    assert_equal 22.5, @service.total_price(1, selected_options)
  end

  def test_total_price_with_quantity_and_selected_options
    selected_options = [:option1]
    assert_equal 45.0, @service.total_price(3, selected_options)
  end

  def test_total_price_with_invalid_option
    selected_options = [:option1, :invalid_option]
    assert_equal 45.0, @service.total_price(3, selected_options)
  end
end