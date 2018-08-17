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
      html = Organismo::Document.new("* h1 \n ** h2").to_html
      expect(html).to eq '<h1>h1</h1><h2>h2</h2>'
    end
  end

  describe 'quote' do
    it '#+QUOTE to blockquote' do
      org_text = "   #+BEGIN_QUOTE\n   分解条件表达式\n 是什么？\n  #+END_QUOTE\n"
      html = Organismo::Document.new(org_text).to_html

      expect(html).to eq '<blockquote><p>   分解条件表达式</p><p> 是什么？</p></blockquote>'
    end

    it 'multiple quotes' do
      org_text = "   #+BEGIN_QUOTE\n   分解条件表达式\n 是什么？\n  #+END_QUOTE\n  #+BEGIN_QUOTE\n   不知道\n  #+END_QUOTE\n"
      html = Organismo::Document.new(org_text).to_html

      expect(html).to eq "<blockquote><p>   分解条件表达式</p><p> 是什么？</p></blockquote><blockquote><p>   不知道</p></blockquote>"
    end
  end

  describe 'example' do
    it '#+EXAMPLE to pre' do
      org_text = "   #+BEGIN_EXAMPLE\n   这么做有两个前提，\n   一个是有很多地方用到了对customer是否为空的判断，\n   另一个是null类型的customer和正常的customer大部分行为保持一致\n   #+END_EXAMPLE\n"
      html = Organismo::Document.new(org_text).to_html

      expect(html).to eq "<div class=\"example\"><pre>   这么做有两个前提，\n   一个是有很多地方用到了对customer是否为空的判断，\n   另一个是null类型的customer和正常的customer大部分行为保持一致</pre></div>"
    end

    it 'multiple examples' do
      org_text = "   #+BEGIN_EXAMPLE\n   这么做有两个前提，\n   #+END_EXAMPLE\n  #+BEGIN_EXAMPLE\n 一个是有很多地方用到了对customer是否为空的判断，\n   另一个是null类型的customer和正常的customer大部分行为保持一致\n   #+END_EXAMPLE\n"
      html = Organismo::Document.new(org_text).to_html

      expect(html).to eq "<div class=\"example\"><pre>   这么做有两个前提，</pre></div><div class=\"example\"><pre> 一个是有很多地方用到了对customer是否为空的判断，\n   另一个是null类型的customer和正常的customer大部分行为保持一致</pre></div>"
    end
  end

  describe 'code' do
    it '#+SRC to pre' do
      org_text = "   #+BEGIN_SRC ruby\n   result += \"<h1>\#{name}</h1>\"\n     end\n   end\n   #+END_SRC\n"
      html = Organismo::Document.new(org_text).to_html

      expect(html).to eq "<div class=\"code\"><pre>   result += &quot;&lt;h1&gt;\#{name}&lt;/h1&gt;&quot;\n     end\n   end</pre></div>"
    end

    it 'multiple codes' do
      org_text = "   #+BEGIN_SRC ruby\n   class TextStatement\n     def value(name)\n       result = 'hi'\n  end\n   end\n\n  #+END_SRC\n   #+BEGIN_SRC ruby\n  class HtmlStatement\n     def value(name)\n       result = '<p>hi</p>'\n       end\n   end\n   #+END_SRC\n"
      html = Organismo::Document.new(org_text).to_html

      expect(html).to eq "<div class=\"code\"><pre>   class TextStatement\n     def value(name)\n       result = &#39;hi&#39;\n  end\n   end\n</pre></div><div class=\"code\"><pre>  class HtmlStatement\n     def value(name)\n       result = &#39;&lt;p&gt;hi&lt;/p&gt;&#39;\n       end\n   end</pre></div>"
    end
  end

  describe 'plain list' do
    it '- to li' do
      org_text = "I am just plain text\n - list1\n - list2\n I am just plain text"

      html = Organismo::Document.new(org_text).to_html

      expect(html).to eq "<p>I am just plain text</p><li> list1</li><li> list2</li><p> I am just plain text</p>"
    end
  end

  describe 'images' do
    it '[[]] to <img>' do
      org_text = "[[http://cdn.niltouch.cn/image.jpg]]"

      html = Organismo::Document.new(org_text).to_html

      expect(html).to eq "<img src='http://cdn.niltouch.cn/image.jpg'/>"
    end
  end

  describe 'org combination to html' do
    it 'combination text' do
      org_text = "重构技巧之简化条件表达式\n\n** Decompose Conditional\n   #+BEGIN_QUOTE\n   分解条件表达式\n   #+END_QUOTE\n   #+BEGIN_SRC ruby\n   if date.before(START_DATE) || date.after(END_DATE) then\n     do_something\n   end\n   #+END_SRC\n   将条件中的表达式提取出来，可以大大降低复杂程度\n   #+BEGIN_SRC ruby\n   def not_proper_time\n     date.before(START_DATE) || date.after(END_DATE)\n   end\n   #+END_SRC\n   #+BEGIN_EXAMPLE\n   有时候尽管条件代码很短，但代码意图和代码自身之间往往存在着不小的差距\n   #+END_EXAMPLE\n   \n** Consolidate Conditional Expression\n   #+BEGIN_QUOTE\n   合并条件表达式\n   当几种条件执行的行为都一样，则可以合并成一种条件\n   #+END_QUOTE\n\n** Introduce Null Object\n   #+BEGIN_QUOTE\n   引入Null对象，可以删除条件语句\n   #+END_QUOTE\n   只有大多数代码都要求空对象做出相同响应的时，使用Null对象才有意义\n   比如\n   #+BEGIN_SRC ruby\n   if deal.customer.blank? then\n     customer_name = 'occupant'\n   else\n     customer_name = customer.name\n   end\n   #+END_SRC\n   就可以单独建一个Null类\n   #+BEGIN_SRC ruby\n   class Customer::Null\n     def name\n       'occupant'\n     end\n   end\n\n   class Customer::Normal\n     def name\n       super\n     end\n   end\n   \n   class Deal\n     def customer\n       super.blank ? Customer::Null.new : Customer::Normal.new\n     end\n   end\n   #+END_SRC\n   这样就可以去掉条件语句，变成\n   #+BEGIN_SRC ruby\n   customer_name = customer.name\n   #+END_SRC\n   #+BEGIN_EXAMPLE\n   这么做有两个前提，\n   一个是有很多地方用到了对customer是否为空的判断，\n   另一个是null类型的customer和正常的customer大部分行为保持一致\n   #+END_EXAMPLE\n\n** Introduce Assertion\n   #+BEGIN_QUOTE\n   引入断言\n   #+END_QUOTE\n   这个ruby貌似没有必要\n   什么是断言，就是断言某个条件一定成立，否则抛出异常，没有必要用它，因为：\n   1. 可以使用测试代码，健壮程序，使这种可能不会发生\n   2. raise ERROR if xxx 就是这个意思啊\n"

      html = Organismo::Document.new(org_text).to_html

      expect(html).to eq "<p>重构技巧之简化条件表达式</p><p></p><h2>Decompose Conditional</h2><blockquote><p>   分解条件表达式</p></blockquote><div class=\"code\"><pre>   if date.before(START_DATE) || date.after(END_DATE) then\n     do_something\n   end</pre></div><p>   将条件中的表达式提取出来，可以大大降低复杂程度</p><div class=\"code\"><pre>   def not_proper_time\n     date.before(START_DATE) || date.after(END_DATE)\n   end</pre></div><div class=\"example\"><pre>   有时候尽管条件代码很短，但代码意图和代码自身之间往往存在着不小的差距</pre></div><p>   </p><h2>Consolidate Conditional Expression</h2><blockquote><p>   合并条件表达式</p><p>   当几种条件执行的行为都一样，则可以合并成一种条件</p></blockquote><p></p><h2>Introduce Null Object</h2><blockquote><p>   引入Null对象，可以删除条件语句</p></blockquote><p>   只有大多数代码都要求空对象做出相同响应的时，使用Null对象才有意义</p><p>   比如</p><div class=\"code\"><pre>   if deal.customer.blank? then\n     customer_name = &#39;occupant&#39;\n   else\n     customer_name = customer.name\n   end</pre></div><p>   就可以单独建一个Null类</p><div class=\"code\"><pre>   class Customer::Null\n     def name\n       &#39;occupant&#39;\n     end\n   end\n\n   class Customer::Normal\n     def name\n       super\n     end\n   end\n   \n   class Deal\n     def customer\n       super.blank ? Customer::Null.new : Customer::Normal.new\n     end\n   end</pre></div><p>   这样就可以去掉条件语句，变成</p><div class=\"code\"><pre>   customer_name = customer.name</pre></div><div class=\"example\"><pre>   这么做有两个前提，\n   一个是有很多地方用到了对customer是否为空的判断，\n   另一个是null类型的customer和正常的customer大部分行为保持一致</pre></div><p></p><h2>Introduce Assertion</h2><blockquote><p>   引入断言</p></blockquote><p>   这个ruby貌似没有必要</p><p>   什么是断言，就是断言某个条件一定成立，否则抛出异常，没有必要用它，因为：</p><p>   1. 可以使用测试代码，健壮程序，使这种可能不会发生</p><p>   2. raise ERROR if xxx 就是这个意思啊</p>"
    end
  end
end
