RSpec.describe Organismo::Document do
  before do
    @yaml_hash = YAML.load_file('spec/fixtures/data.yml')
  end

  describe 'header' do
    it '* to h1' do
      html = Organismo::Document.new('* Header').to_html
      expect(html).to eq '<h1>Header</h1>'
    end

    it '** to h2' do
      html = Organismo::Document.new('** Header').to_html
      expect(html).to eq '<h2>Header</h2>'
    end

    it '*** to h3' do
      html = Organismo::Document.new('*** Header').to_html
      expect(html).to eq '<h3>Header</h3>'
    end

    it '**** to h4' do
      html = Organismo::Document.new('**** Header').to_html
      expect(html).to eq '<h4>Header</h4>'
    end

    it 'complex convert' do
      html = Organismo::Document.new("* h1 \n ** h2").to_html
      expect(html).to eq '<h1>h1</h1><h2>h2</h2>'
    end
  end

  describe 'quote' do
    it '#+QUOTE to blockquote' do
      org_text = @yaml_hash.dig('quote1', 'input')

      html = Organismo::Document.new(org_text).to_html

      expect(html).to eq @yaml_hash.dig('quote1', 'output')
    end

    it 'multiple quotes' do
      org_text = @yaml_hash.dig('quote2', 'input')

      html = Organismo::Document.new(org_text).to_html

      expect(html).to eq @yaml_hash.dig('quote2', 'output')
    end
  end

  describe 'example' do
    it '#+EXAMPLE to pre' do
      org_text = @yaml_hash.dig('example1', 'input')

      html = Organismo::Document.new(org_text).to_html

      expect(html).to eq @yaml_hash.dig('example1', 'output')
    end

    it 'multiple examples' do
      org_text = @yaml_hash.dig('example2', 'input')

      html = Organismo::Document.new(org_text).to_html

      expect(html).to eq @yaml_hash.dig('example2', 'output')
    end
  end

  describe 'code' do
    it '#+SRC to pre' do
      org_text = @yaml_hash.dig('code1', 'input')

      html = Organismo::Document.new(org_text).to_html

      expect(html).to eq @yaml_hash.dig('code1', 'output')
    end

    it 'multiple codes' do
      org_text = @yaml_hash.dig('code2', 'input')

      html = Organismo::Document.new(org_text).to_html

      expect(html).to eq @yaml_hash.dig('code2', 'output')
    end
  end

  describe 'plain list' do
    it '- to li' do
      org_text = @yaml_hash.dig('list1', 'input')

      html = Organismo::Document.new(org_text).to_html

      expect(html).to eq @yaml_hash.dig('list1', 'output')
    end
  end

  describe 'images' do
    it '[[]] to <img>' do
      org_text = @yaml_hash.dig('images1', 'input')

      html = Organismo::Document.new(org_text).to_html

      expect(html).to eq @yaml_hash.dig('images1', 'output')
    end
  end

  describe 'org combination to html' do
    it 'combination text' do
      org_text = @yaml_hash.dig('combination1', 'input')

      html = Organismo::Document.new(org_text).to_html

      expect(html).to eq @yaml_hash.dig('combination1', 'output')
    end
  end
end
