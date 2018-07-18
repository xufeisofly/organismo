module Organismo
  class Element::Quote < Element
    attr_reader :content, :location

    def initialize(text, location)
      @content = text_without_wrapper(text)
      @location = location
    end

    def convert_to_html
      "<blockquote>#{content_with_p_tag}</blockquote>"
    end

    private

    def text_without_wrapper(text)
      text.split('\n')[1..-2].join('\n')
    end

    def content_with_p_tag
      content.split('\n').map { |c| "<p>#{c}</p>" }.join('<br \>')
    end
  end
end
