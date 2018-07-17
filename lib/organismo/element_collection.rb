require 'organismo/element'

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
        Organismo::Element.new(source_item, index).create
      end
    end

    def source_items
      source.split('\n')
    end
  end
end
