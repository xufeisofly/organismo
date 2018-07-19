module Organismo
  class Element::Header < Element
    attr_reader :raw_text, :level, :location

    def initialize(text, location)
      @raw_text = raw_text_without_tag(text)
      @level = header_level(text)
      @location = location
    end

    def convert_to_html
      "<h#{level}>#{raw_text}</h#{level}>"
    end

    private

    def raw_text_without_tag(text)
      split_text(text).last.lstrip.rstrip
    end

    def header_level(text)
      split_text(text).first.lstrip.rstrip.size + 1
    end

    def split_text(text)
      text.split(/\* /)
    end
  end
end
