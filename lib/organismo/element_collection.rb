module Organismo
  class ElementCollection
    attr_reader :source, :elements

    def initialize(source)
      @source = source
      @elements = elements_by_source
    end

    private

    def elements_by_source
      source_items.map.with_index do |source_item, index|
        Organismo::Element.new(source_item, index)
      end
    end

    def source_items_splitted_by_line_break
      source.split('\n')
    end
  end
end
