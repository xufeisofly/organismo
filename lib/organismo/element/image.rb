module Organismo
  class Element::Image < Element
    attr_reader :content, :location

    def initialize(img_url, location)
      @content = remove_tag(img_url)
      @location = location
    end

    def convert_to_html
      "<img src='#{content}'/>"
    end

    private

    def remove_tag(img_url)
      result = img_url && img_url.strip.split(/\[\[|\]\]/).last
      CGI.escapeHTML(result)
    end
  end
end
