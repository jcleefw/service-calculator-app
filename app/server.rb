require 'sinatra'
require_relative 'helpers'

class App < Sinatra::Base
  get '/' do
    'Welcome to Sinatra app!'
  end

  get '/services' do
    content_type :json
    
    begin
      # Read data from the services.json file
      services_data = JSON.parse(File.read('./mocks/services.json'))
  
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
      klass = klass_assign(params['service'])
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
  
    begin
      requested_services = JSON.parse(request.body.read)
  
      if requested_services.is_a? Array
        subtotal, line_items, services_unavailable = calculate_related_item_details(requested_services)
  
        return {
          line_items: line_items,
          line_items_count: line_items.length,
          subtotal: subtotal,
          currency: "AUD", # hardcoded for now
          discount: 0,      # hardcoded for now
          total: subtotal,
          services_unavailable: services_unavailable
        }.to_json
      else
        status 400
        { error: 'Invalid data format. Data should be an array of services' }.to_json
      end
    rescue JSON::ParserError
      status 500
      { error: 'Error reading services data.' }.to_json
    end
  end
end