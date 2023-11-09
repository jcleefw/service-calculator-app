require_relative 'services/photo_retouching_service'
require_relative 'services/floor_plan_service.rb'
require_relative 'services/drone_video_service.rb'
require_relative 'service_enum.rb'

# Helper method that used a string class name and convert it to declare a class
def klass_assign(class_name)
  class_conv = ServiceEnum.const_get(class_name.upcase)
  klass = Object.const_get(class_conv)
  raise ServiceUnavailableError, class_name if klass.nil?
  klass.new
end

# Helper method to calculate subtotal
def calculate_related_item_details(requested_services)
  subtotal = 0
  line_items = []
  services_unavailable = []

  requested_services.each do |requested_service|
    service_name = requested_service["service"]
    next unless service_name

    begin
      klass = klass_assign(service_name)
      line_item = populate_line_item(klass, requested_service)
      subtotal += line_item[:total]
      line_items << line_item
    rescue 
      services_unavailable << service_name
    end
  end

  [subtotal, line_items, services_unavailable]
end

# Helper method to calculate indivial service line item
def populate_line_item(klass, requested_service)
  total = klass.total_price(requested_service["quantity"], requested_service["extras"])
  {
    service: requested_service["service"],
    quantity: requested_service["quantity"],
    total: total
  }
end