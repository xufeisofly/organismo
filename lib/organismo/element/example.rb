module Organismo
  class Element::Example < Element
    def convert_to_html
      if text.match /BEGIN_EXAMPLE/
        '<pre>'
      elsif text.match /END_EXAMPLE/
        '</pre>'
      else
        text
      end
    end
  end
end
