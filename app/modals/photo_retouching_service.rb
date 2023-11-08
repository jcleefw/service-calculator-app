require_relative 'service'

class PhotoRetouchingService < Service
  attr_accessor :name, :base_price, :options

  def initialize
    super("photo retouching", 2.5, {
      :background_removal => 0.5,
      :add_watermark => 0.3
    })
  end
end
