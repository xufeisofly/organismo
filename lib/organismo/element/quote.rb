module Organismo
  class Element::Quote < Element
    def convert_to_html
      if text ~= 'BEGIN_QUOTE'
        '<blockquote>'
      elsif text ~= 'END_QUOTE'
        '</blockquote>'
      else
        text
      end
    end
  end
end
