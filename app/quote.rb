require_relative 'helpers'
class Quote 

  def initialize(requested_services)
    @requested_services = requested_services
    @subtotal = 0
    @services_unavailable = []
    @currency = "AUD" 
    @line_items = populate_line_items
    @discount = 0
  end

  def currency
    @currency
  end

  def total
    @subtotal - @discount
  end

  def subtotal
    @subtotal
  end

  def line_items
    @line_items
  end

  def line_items_count
    @line_items.length
  end

  def services_unavailable
    @services_unavailable
  end

  

  private
  def populate_single_service(klass, req_service)
    total = klass.total_price(req_service[:quantity], req_service[:extras])
    
    {
      service: req_service[:service],
      quantity: req_service[:quantity],
      total: total
    }
  end

  def populate_line_items
    line_items = []

    # resets services_unavailable to empty everytime this method is called
    @services_unavailable = []
    @requested_services.each do |requested_service|
      sanitized = sanitize(requested_service)

      service_name = sanitized[:service]
      next unless service_name
  
      begin
        klass = klass_assign(service_name)

        line_item = populate_single_service(klass, sanitized)
        @subtotal += line_item[:total]
        line_items << line_item
      rescue 
        @services_unavailable << service_name
      end
    end
    line_items
  end

  def sanitize item
    # convert item to integer
    input_quantity = sanitize_to_integer item["quantity"]

    # if extras is not an array return empty array
    option = item["extras"].is_a?(Array) ? item["extras"] : []

    # ensure if service is empty string return nil
    service = item["service"].is_a?(String) && !item["service"].empty? ? item["service"] : nil
    
    return { quantity: input_quantity, extras: option, service: service}
  end
end