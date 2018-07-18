module Organismo
  class Element::Code < Element
    attr_reader :content, :location

    def initialize(text, location)
      @content = text_without_wrapper(text)
      @location = location
    end

    def convert_to_html
      "<pre>#{content}</pre>"
    end

    private

    def text_without_wrapper(text)
      text.split("\n")[1..-2].join("\n")
    end
  end
end
