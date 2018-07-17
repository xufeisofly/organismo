RSpec.describe Organismo::Document do
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
      html = Organismo::Document.new('* h1 \n ** h2').to_html
      expect(html).to eq '<h1>h1</h1><h2>h2</h2>'
    end
  end
end
