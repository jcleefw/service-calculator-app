require 'sinatra'
require_relative 'services/service'
require_relative 'services/photo_retouching_service'
require_relative 'services/floor_plan_service.rb'
require_relative 'services/drone_video_service.rb'
require_relative 'service_enum.rb'

class App < Sinatra::Base
  get '/' do
    'Welcome to Sinatra app!'
  end

  get '/services' do
    content_type :json
    
    return {
      photo_retouching: {
        base_price: 2.50,
        options: {
          background_removal: 0.5,
          add_watermark: 0.30,
        }
      }, 
      floor_plan: {
        base_price: 15,
        options: {
          "3d_layout": 15,
          add_furniture: 10,
          add_color: 5
        }
      },
      drone_video: {
        base_price: 50,
        customer_branded: 10,
        scenic_footage: 20
      }
    }.to_json
  end

  # to calculate a photo retouching service and it's total price
  # based on quantity and additional options
  get '/calculate_single_service' do
    begin
      service = DroneVideoService.new
      total = service.total_price(1, ["something invalid"])

      "Services created: #{service.name}, Total Price: $#{total}"
    rescue => error
      # TODO: handle this 
      puts "oh oh"
      puts error.message
    end
  end

  post '/quote_pricing' do
    content_type :json
    requested_services = JSON.parse(request.body.read)

    subtotal = 0
    discount = 0  # hardcoded for now

    line_items = requested_services.map do |requested_service|
      begin
        service_name = ServiceEnum.const_get(requested_service["service"].upcase)
        klass = Object.const_get(service_name).new
        total = klass.total_price(requested_service["quantity"], requested_service["extras"])
        subtotal += total
        
        {
          service: requested_service["service"],
          quantity: requested_service["quantity"],
          total: total
        }

      rescue JSON::ParserError
        # TODO: instead of invalid, output  which service is unavailable
        status 400
        { error: 'Invalid JSON data for options.' }.to_json
      end
    end
    {
      line_items: line_items,
      line_items_count: line_items.count,
      subtotal: subtotal,
      currency: "AUD", # hardcoded for now
      discount: discount, # hardcoded for now
      total: subtotal - discount
    }.to_json
    
  end

end