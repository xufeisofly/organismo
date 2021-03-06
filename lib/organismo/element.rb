module Organismo
  class Element
    attr_reader :text, :location

    def initialize(source_item, location)
      @text = source_item
      @location = location
    end

    # require and initialize different instance
    # depending on string regex
    def create
      if text.match(/\_QUOTE/)
        require 'organismo/element/quote'
        Organismo::Element::Quote.new(text, location)
      elsif text.match(/\_SRC/)
        require 'organismo/element/code'
        Organismo::Element::Code.new(text, location)
      elsif text.match(/\_EXAMPLE/)
        require 'organismo/element/example'
        Organismo::Element::Example.new(text, location)
      elsif text.match(/\*/)
        require 'organismo/element/header'
        Organismo::Element::Header.new(text, location)
      elsif text.match(/\[\[\S*(\.png)|(\jpg)|(\.jpeg)\]\]/)
        require 'organismo/element/image'
        Organismo::Element::Image.new(text, location)
      elsif text.match(/\[\[\S*\]\]/)
        require 'organismo/element/link'
        Organismo::Element::Link.new(text, location)      
      elsif text.match(/\-/)
        require 'organismo/element/plain_list'
        Organismo::Element::PlainList.new(text, location)
      else
        require 'organismo/element/text'
        Organismo::Element::Text.new(text, location)
      end
    end

    def convert_to_html
      raise 'define convert_to_html in subclasses'
    end
  end
end
