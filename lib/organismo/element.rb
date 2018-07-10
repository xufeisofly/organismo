module Organismo
  class Element
    def initialize(source_item, location)
      @text = source_item
      @location = location
    end

    def convert_to_html
      raise 'define convert_to_html in subclasses'
    end
  end
end
