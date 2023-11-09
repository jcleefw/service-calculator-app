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
    total = klass.total_price(req_service["quantity"], req_service["extras"])
    {
      service: req_service["service"],
      quantity: req_service["quantity"],
      total: total
    }
  end

  def populate_line_items
    line_items = []
    @requested_services.each do |requested_service|
      service_name = requested_service["service"]
      next unless service_name
  
      begin
        klass = klass_assign(service_name)
        line_item = populate_single_service(klass, requested_service)
        @subtotal += line_item[:total]
        line_items << line_item
      rescue 
        @services_unavailable << service_name
      end
    end
    line_items
  end
end