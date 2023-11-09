require_relative "../app/quote"

describe Quote do
  describe '#populate_line_items' do
  let(:requested_services) do 
    [
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
  end

  let(:quote) { Quote.new(requested_services) }

    it 'when all services are valid, returns an array of line items' do
      line_items = quote.send(:populate_line_items)
      expect(line_items).to eql([
        {:quantity=>5, :service=>"photo_retouching", :total=>15.0}, 
        {:quantity=>1, :service=>"floor_plan", :total=>15}, 
        {:quantity=>1, :service=>"drone_video", :total=>50}
      ])

    end

    it 'when some services are invalid, ignore them' do
      requested_services << { "hello" => "world" }
      quote = Quote.new(requested_services)
      
      line_items = quote.send(:populate_line_items)
      expect(line_items).to eql([
        {:quantity=>5, :service=>"photo_retouching", :total=>15.0},
        {:quantity=>1, :service=>"floor_plan", :total=>15}, 
        {:quantity=>1, :service=>"drone_video", :total=>50}
      ])
      expect(quote.services_unavailable).to eql([])

      puts quote.services_unavailable
    end

    it 'when some services are not available, ignore them. And add it to the service_unavailable array' do
      requested_services << { "service" => "world" }
      quote = Quote.new(requested_services)
      
      line_items = quote.send(:populate_line_items)
      expect(line_items).to eql([
        {:quantity=>5, :service=>"photo_retouching", :total=>15.0}, 
        {:quantity=>1, :service=>"floor_plan", :total=>15}, 
        {:quantity=>1, :service=>"drone_video", :total=>50}
      ])
      expect(quote.services_unavailable).to eql(["world"])

    end

    it 'when array is empty, returns empty' do
      quote = Quote.new([])
      
      line_items = quote.send(:populate_line_items)
      expect(line_items).to be_empty
      expect(quote.services_unavailable).to be_empty

    end
  end
end