# Organismo

Organismo is a useful tool for converting org-mode text(in .org file) to html structure.
Currently Organismo supports some very common org convertions:

1. org headers

   ** header 2

2. org examples

   BEGIN_EXAMPLE ... END_EXAMPLE

3. org code blocks

   BEGIN_SRC ruby ... END_SRC

4. org images links

   [[https:://image_url.jpg]]

5. org outer links

   [[https://www.niltouch.cn][Norris' blog]]

6. org unordered lists

   \- item1
   \- item2

7. org quotes

   BEGIN_QUOTE ... END_QUOTE

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'organismo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install organismo

## Usage

The way to use organismo is quite simple as there is only one API.

``` ruby
html_text = Organismo::Document.new(org_text).to_html
```

Then you can just render html_text to your .html file. 
However, Organismo will not generate CSS code which you need to write on your own to give it a better looking.

Considering XSS, the html that already in your org_text before will be escaped after convertions.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/organismo. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Organismo project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/organismo/blob/master/CODE_OF_CONDUCT.md).
