require 'sinatra'
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
    
    begin
      # Read data from the services.json file
      services_data = JSON.parse(File.read('./mocks/services.json'))
      # Replace 'services.json' with the actual path to your JSON file
  
      # Return the parsed data as a JSON response
      services_data.to_json
    rescue JSON::ParserError, Errno::ENOENT
      status 500
      { error: 'Error reading services data.' }.to_json
    end
  end

  # Endpoint to Calculate a selected service and it's total price
  # based on quantity and additional options
  # request example: GET __URL__/calculate_single_service?quantity=5&extras=add_watermark,background_removal&service=photo_retouching
  get '/calculate_single_service' do
    begin
      service = ServiceEnum.const_get(params['service'].upcase)
      klass = Object.const_get(service).new
      quantity = params['quantity'].to_i

      # ensure no white space in between extras provided
      options = params['extras'].split(',').map { |opt| opt.strip }
      total = klass.total_price(quantity, options)

      "Services quote: #{klass.name}, Total Price: $#{total}"
    rescue => error
      # TODO: handle this 
      puts "oh oh"
      puts error.message
    end
  end

  # Endpoint to calculated the total pricing of services required with a JSON object
  post '/quote_pricing' do
    content_type :json
    requested_services = JSON.parse(request.body.read)

    subtotal = 0
    discount = 0  # hardcoded for now
    services_unavailable = []

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

      rescue 
        services_unavailable << requested_service["service"]
      end
    end
    {
      line_items: line_items,
      line_items_count: line_items.count,
      subtotal: subtotal,
      currency: "AUD", # hardcoded for now
      discount: discount, # hardcoded for now
      total: subtotal - discount,
      services_unavailable: services_unavailable
    }.to_json
    
  end

end