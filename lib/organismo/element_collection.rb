require 'organismo/element'

module Organismo
  class ElementCollection
    WRAPER_TAGS = %w(_QUOTE _EXAMPLE _SRC).freeze
    attr_reader :source, :elements

    def initialize(source)
      @source = source
      @elements = elements_by_source
    end

    private

    # initialize elements items
    def elements_by_source
      source_items.map.with_index do |source_item, index|
        Organismo::Element.new(source_item, index).create
      end
    end

    def source_items
      items = source.split("\n")

      result = []
      jump_to_index = -1
      items.each_with_index do |item, index|
        next if index <= jump_to_index

        # if item is begin/end wrapper
        # combine its contents to be one array item
        if is_begin_tag?(item)
          begin_tag_index = index
          end_tag_index = matched_end_tag_index_by_tag(items, index, tag_type(item))
          jump_to_index = end_tag_index

          result << items[begin_tag_index..end_tag_index].join("\n")
        else
          result << item
        end
      end
      
      result
    end

    def is_begin_tag?(text)
      !text.match(/\#\+BEGIN/).nil?
    end

    def matched_end_tag_index_by_tag(items, begin_index, tag_type)
      end_tags = items.select { |i| i[%r{END#{tag_type}}]}
      end_tag_indexes = end_tags.map { |tag| items.each_index.select { |i| items[i] == tag } }.flatten.uniq.sort
      end_tag_indexes.select { |i| i > begin_index }.first
    end

    def tag_type(text)
      WRAPER_TAGS.each do |regex|
        return regex if text.match(%r{#{regex}})
      end
    end
  end
end

