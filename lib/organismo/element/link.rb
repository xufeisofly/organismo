require 'cgi'

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

    def split_link_from(content)
      content_without_wrapper = content && content.strip.split(/\[\[|\]\]/).last
      content_without_wrapper.split(/\]\[/)
    end
  end
end
