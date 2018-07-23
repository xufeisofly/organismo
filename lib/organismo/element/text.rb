require 'cgi'

module Organismo
  class Element::Text < Element
    attr_reader :raw_text, :location

    def initialize(text, location)
      @raw_text = CGI.escapeHTML(text)
      @location = location
    end

    def convert_to_html
      "<p>#{raw_text}</p>"
    end
  end
end
