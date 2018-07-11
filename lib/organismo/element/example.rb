module Organismo
  class Element::Example < Element
    def convert_to_html
      if text ~= 'BEGIN_EXAMPLE'
        '<example>'
      elsif text ~= 'END_EXAMPLE'
        '</example>'
      else
        text
      end
    end
  end
end
