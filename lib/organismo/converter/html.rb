module Organismo
  module Converter
    class Html
      # convert tree element array to html
      def self.convert(tree)
        tree.elements.reduce('') do |output, element|
          output += element.convert_to_html
        end
      end
    end
  end
end
