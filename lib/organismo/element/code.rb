module Organismo
  class Element::Code < Element
    def convert_to_html
      if text ~= 'BEGIN_SRC'
        '<pre>'
      elsif text ~= 'END_SRC'
        '</pre>'
      else
        text
      end
    end
  end
end
