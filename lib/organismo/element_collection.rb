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
        Organismo::Element.create(source_item, index)
      end
    end

    def source_items
      source.split('\n')
    end
  end
end
