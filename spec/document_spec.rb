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

  describe 'quote' do
    it '#+QUOTE to blockquote' do
      org_text = '   #+BEGIN_QUOTE\n   分解条件表达式\n 是什么？\n  #+END_QUOTE\n'
      html = Organismo::Document.new(org_text).to_html

      expect(html).to eq '<blockquote><p>   分解条件表达式</p><br \><p> 是什么？</p></blockquote>'
    end
  end

  describe 'example' do
    it '#+EXAMPLE to pre' do
      org_text = '   #+BEGIN_EXAMPLE\n   这么做有两个前提，\n   一个是有很多地方用到了对customer是否为空的判断，\n   另一个是null类型的customer和正常的customer大部分行为保持一致\n   #+END_EXAMPLE\n'
      html = Organismo::Document.new(org_text).to_html

      expect(html).to eq '<pre>   这么做有两个前提，\n   一个是有很多地方用到了对customer是否为空的判断，\n   另一个是null类型的customer和正常的customer大部分行为保持一致</pre>'
    end
  end
end
