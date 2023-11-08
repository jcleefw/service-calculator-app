require 'sinatra'
require_relative 'modals/service'
require_relative 'modals/photo_retouching_service'
require_relative 'modals/floor_plan_service.rb'
require_relative 'modals/drone_video_service.rb'

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

end