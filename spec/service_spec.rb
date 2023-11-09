require 'rack/test'
require_relative '../app/services/service'

RSpec.describe Service do
  include Rack::Test::Methods

  before(:each) do
    @service = Service.new("Service Name", 10.0, { option1: 5.0, option2: 7.5 })
  end

  describe '#total_price' do
    it 'calculates total price with default quantity and no options' do
      expect(@service.total_price).to eq(10.0)
    end

    it 'calculates total price with quantity and no options' do
      expect(@service.total_price(2)).to eq(20.0)
    end

    it 'calculates total price with selected options' do
      selected_options = [:option1, :option2]
      expect(@service.total_price(1, selected_options)).to eq(22.5)
    end

    it 'calculates total price with quantity and selected options' do
      selected_options = [:option1]
      expect(@service.total_price(3, selected_options)).to eq(45.0)
    end

    it 'calculates total price with invalid option' do
      selected_options = [:option1, :invalid_option]
      expect(@service.total_price(3, selected_options)).to eq(45.0)
    end
  end
end
