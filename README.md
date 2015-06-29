# ProgressiveLoad

Slow partial got you down? Load it later! Use this gem to defer loading of partials till after page load. They will be fetched via AJAX and placed on the page when ready.

## State of Project

This gem is currently in proof of concept phase. It is functional but the API needs work and testing before it can be taken more seriously.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'progressive_load'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install progressive_load

You will also need to include the Javascript by adding the following to your application.js:

```javascript
//=progressive_load
```

## Usage

In the view you would like to progressively load:

```erb
<%=render_progressive_partial 'friendly_name', 'path_to_partial' %>
```

In the controller action, end it with:

```ruby
def action
    // your code here
    progressive_render 'full_path_to_view'
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/johnsonj/progressive_load. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).