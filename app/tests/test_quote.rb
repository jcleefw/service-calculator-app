require 'minitest/autorun'
require_relative '../quote' # Assuming your Quote class is defined in quote.rb

describe Quote do
  before do
    # Sample requested services for testing
    @requested_services = [
      {
        "service"=> "photo_retouching",
        "extras"=> ["background_removal"],
        "quantity"=> 5
      },
      {
        "service"=> "floor_plan",
        "extras"=> [],
        "quantity"=> 1
      },
      {
        "service"=> "drone_video",
        "extras"=> ["branded", "scenic"],
        "quantity"=> 1
      }
    ]
    @quote = Quote.new(@requested_services)
  end

  describe '#populate_line_items' do
    it 'returns an array of line items' do
      line_items = @quote.send(:populate_line_items)

      line_items.must_be_instance_of Array
      line_items.length.must_equal 3

      # Adjust the expected values according to your test case
      line_items[0].must_equal({ service: 'photo_retouching', quantity: 5, total: 15.0 })
      line_items[1].must_equal({ service: 'floor_plan', quantity: 1, total: 15.0 })
      line_items[2].must_equal({ service: 'drone_video', quantity: 1, total: 50.0 })

      # Check that the subtotal is correctly calculated
      @quote.subtotal.must_equal 160.0

      # Check that services_unavailable is empty since all services are available
      @quote.services_unavailable.must_be_empty
    end
  end
end