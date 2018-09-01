require 'organismo/element_collection'

module Organismo
  module Parser
    class Org
      def initialize(options = {})
        @options = {}
      end

      # parse and return an element collection item
      def parse(source)
        config_parser

        Organismo::ElementCollection.new(source)
      end

      private

      def config_parser
        # TODO config parser
      end
    end
  end
end
