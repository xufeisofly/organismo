module Organismo
  class Element::Link < Element
    attr_reader :link_url, :link_text, :location

    def initialize(content, location)
      @link_url, @link_text = split_link_from(content)
      @location = location
    end

    def convert_to_html
      "<a href='#{link_url}'>#{link_text || link_url}</a>"
    end

    private

    # return link_url and link_text
    def split_link_from(content)
      content && content.strip.split(/\[\[|\]\]/).last.split(/\]\[/)
    end
  end
end
