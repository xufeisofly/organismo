module Organismo
  class Element::Header < Element
    def convert_to_html
      if text ~= '****'
        "<h4>#{text}</h4>"
      elsif text ~= '***'
        "<h3>#{text}</h3>"
      elsif text ~= '**'
        "<h2>#{text}</h2>"
      elsif text ~= '*'
        "<h1>#{text}</h1>"
      else
        text
      end
    end
  end
end
