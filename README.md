# ProgressiveLoad

![ProgressiveLoad Demo](http://g.recordit.co/WIb75XbkET.gif)

Slow content got you down? Load it later! Use this gem to defer loading of specific page sections till after page load. They will be fetched via AJAX and placed on the page when ready.

## State of Project
[![Build Status](https://travis-ci.org/johnsonj/progressive_load.svg?branch=master)](https://travis-ci.org/johnsonj/progressive_load) [![Code Climate](https://codeclimate.com/github/johnsonj/progressive_load/badges/gpa.svg)](https://codeclimate.com/github/johnsonj/progressive_load) [![Test Coverage](https://codeclimate.com/github/johnsonj/progressive_load/badges/coverage.svg)](https://codeclimate.com/github/johnsonj/progressive_load/coverage)

This gem is tracking a 1.0.0 release but should not be considered stable until then. [See open issues](https://github.com/johnsonj/progressive_load/milestones/1.0.0).

## Installation

Add this line to your application's Gemfile and run bundle

```ruby
gem 'progressive_load', github: 'johnsonj/progressive_load'
```

Then add the following to your application.js:

```javascript
//=progressive_load
```

## Usage

Wrap slow content in your view with a call to `progressive_load 'friendly_name'` where `friendly_name` is an identifier unique to that view:

```erb
<%=progressive_render 'my_slow_block' do %>
	<h1>Content!</h1>
	<% sleep 5 >
<% end %>
```

In the controller action, end it with:

```ruby
def action
    # your code here
    progressive_render
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. There is a dummy application located in spec/dummy/ that demonstrates a sample integration and can be used for interactive testing.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/johnsonj/progressive_load. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).