module Organismo
  module Converter
    class Html
      def self.convert(tree)
        # element: <Organismo::Element::Header @text=hi, @location=1, @level=3 >
        tree.elements.reduce('') do |output, element|
          output += element.convert_to_html
        end
      end
    end
  end
end
