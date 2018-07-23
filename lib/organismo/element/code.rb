require 'cgi'

module Organismo
  class Element::Code < Element
    attr_reader :content, :location

    def initialize(text, location)
      @content = text_without_wrapper(text)
      @location = location
    end

    def convert_to_html
      "<div class=\"code\"><pre>#{content}</pre></div>"
    end

    private

    def text_without_wrapper(text)
      CGI.escapeHTML(text.split("\n")[1..-2].join("\n"))
    end
  end
end
