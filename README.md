# ProgressiveRender [![Gem Version](https://badge.fury.io/rb/progressive_render.svg)](http://badge.fury.io/rb/progressive_render) #

![ProgressiveRender Demo](http://g.recordit.co/NsoKrtutzi.gif) 

Slow content got you down? Load it later! Use this gem to defer loading of portions of your page until after load. They will be fetched via AJAX and placed on the page when ready.

## State of Project ##
[![Build Status](https://travis-ci.org/johnsonj/progressive_render.svg?branch=master)](https://travis-ci.org/johnsonj/progressive_render) [![Code Climate](https://codeclimate.com/github/johnsonj/progressive_load/badges/gpa.svg)](https://codeclimate.com/github/johnsonj/progressive_load) [![Test Coverage](https://codeclimate.com/github/johnsonj/progressive_load/badges/coverage.svg)](https://codeclimate.com/github/johnsonj/progressive_load/coverage)

This gem is young, please use released versions via RubyGems as master is not guarenteed to be stable until 1.0.0 is released. [See open issues](https://github.com/johnsonj/progressive_render/issues). Report any issues you have!

## Installation ##

Add this line to your application's Gemfile and run `bundle install`

```ruby
gem 'progressive_render'
```

Then add the following to your application.js:

```javascript
//=progressive_render
```

## Basic Usage ##

Wrap slow content in your view with a call to `progressive_render`:

```erb
<%=progressive_render do %>
	<h1>Content!</h1>
	<% sleep 5 %>
<% end %>
```

In the controller action, end it with:

```ruby
def action
    # your code here
    progressive_render
end
```

## Example Application ##

For a more indepth example, see the test application located within this repository in `spec/dummy`

## Customizing the Placeholder ##

Each `progressive_render` call in the view can specify its own placeholder by providing a path to the partial you'd like to initially display to the user:

```ruby
<%=progressive_render placeholder: 'shared/loading' do %>
	<h1>Content!</h1>
	<% sleep 5 %>
<% end %>
```

The placeholder defaults to rendering the partial `progressive_render/placeholder` so if you'd like to override it globally create the file `app/views/progressive_render/_placeholder.html.erb`. It will also work at the controller level, eg, `app/views/users/progresive_render/_placeholder.html.erb`

## Development ##

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rspec` to run the tests. There is a dummy application located in `spec/dummy/` that demonstrates a sample integration and can be used for interactive testing.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org/gems/progressive_render).

## Contributing ##

Bug reports and pull requests are welcome on [GitHub](https://github.com/johnsonj/progressive_render). 

## License ##

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
