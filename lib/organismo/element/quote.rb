module Organismo
  class Element::Quote < Element
    def convert_to_html
      if text.match /BEGIN_QUOTE/
        '<blockquote>'
      elsif text.match /END_QUOTE/
        '</blockquote>'
      else
        text
      end
    end
  end
end
