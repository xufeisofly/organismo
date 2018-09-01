require 'organismo/parser/org'

module Organismo
  class Document
    attr_reader :source, :element_collection

    def initialize(source)
      @source = source
      @element_collection = document_parser.parse(source)
    end

    def to_html
      require 'organismo/converter/html'
      Organismo::Converter::Html.convert(element_collection)
    end

    private

    def document_parser
      Organismo::Parser::Org.new
    end
  end
end
