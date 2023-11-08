require_relative 'service'

class FloorPlanService < Service
  attr_accessor :name, :base_price, :options

  def initialize
    super("floor plan", 15, {
      :"3d_layout" => 15,
      :add_furniture => 10
    })
  end
end
