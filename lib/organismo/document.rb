require 'organismo/parser/org'

module Organismo
  class Document
    attr_reader :source, :tree

    # '* Greetings \n ** hi'
    # =>
    # '<h1 id="Greetings">Greetings</h1><br \><h2 id="hi"></h2>'
    # @tree 是 ElementCollection对象，返回Element对象的集合
    def initialize(source)
      @source = source
      @tree = document_parser.parse(source)
    end

    def to_html
      require 'organismo/converter/html'
      Organismo::Converter::Html.convert(tree)
    end

    private

    def document_parser
      Organismo::Parser::Org.new
    end
  end
end
