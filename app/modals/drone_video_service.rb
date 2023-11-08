require_relative 'service'

class DroneVideoService < Service
  attr_accessor :name, :base_price, :options

  def initialize
    super("drone video", 50, {
      :customer_branded => 10,
      :scenic_footage => 20
    })
  end
end
