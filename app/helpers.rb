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
