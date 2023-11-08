class Service
  attr_accessor :name, :base_price, :options

  def initialize(name, base_price, options = {})
    @name = name
    @base_price = base_price
    @options = options
  end

end
