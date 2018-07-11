module Organismo
  class Element
    def initialize(source_item, location)
      @text = source_item
      @location = location
    end

    def create(source_item, location)
      if source_item.match(/\_QUOTE/)
        Organismo::Element::Quote.new(source_item, location)
      elsif source_item.match(/\_SRC/)
        Organismo::Element::Code.new(source_item, location)
      elsif source_item.match(/\_EXAMPLE/)
        Organismo::Element::Example.new(source_item, location)
      elsif source_item.match(/\*/)
        Organismo::Element::Header.new(source_item, location)
      else
        Organismo::Element::Text.new(source_item, location)
      end
    end

    def convert_to_html
      raise 'define convert_to_html in subclasses'
    end
  end
end
