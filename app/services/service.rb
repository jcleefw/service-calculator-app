class Service
  attr_accessor :name, :base_price, :options

  def initialize(name, base_price, options = {})
    @name = name
    @base_price = base_price
    @options = options
  end

  def total_price(quantity = 1, selected_options = [])
    total = base_price
    selected_options.each do |option|
      sym_option = option.to_sym
    
      if @options[sym_option]
        total +=  @options[sym_option]
      end
     
    end
    total *= quantity
  end
end
