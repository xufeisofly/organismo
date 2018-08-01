require 'cgi'

module Organismo
  class Element::PlainList < Element
    attr_reader :content, :location

    def initialize(text, location)
      @content = text_without_tag(text)
      @location = location
    end

    def convert_to_html
      "<li>#{content}</li>"
    end

    private

    def text_without_tag(text)
      CGI.escapeHTML(text.gsub(/^.*-/, ''))
    end
  end
end
