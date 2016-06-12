# ProgressiveRender [![Gem Version](https://badge.fury.io/rb/progressive_render.svg)](http://badge.fury.io/rb/progressive_render) #

![ProgressiveRender Demo](http://g.recordit.co/NsoKrtutzi.gif) 

Slow content got you down? Load it later! Use this gem to defer loading of portions of your page until after load. They will be fetched via AJAX and placed on the page when ready.

## Why? ##
You wrote all your code and it got a bit slow with all that production data. Or perhaps you have less important content that you want on the view, but it's not worth blocking the entire page for. With this gem there's almost no developer work to make this happen. All requests go through your controller and your normal filters so you're permissions are respected. The only added overhead is an additional round-trip for each partial and duplicated rendering of the main view. 

## State of Project ##
[![Build Status](https://travis-ci.org/johnsonj/progressive_render.svg?branch=master)](https://travis-ci.org/johnsonj/progressive_render) [![Code Climate](https://codeclimate.com/github/johnsonj/progressive_load/badges/gpa.svg)](https://codeclimate.com/github/johnsonj/progressive_load) [![Test Coverage](https://codeclimate.com/github/johnsonj/progressive_load/badges/coverage.svg)](https://codeclimate.com/github/johnsonj/progressive_load/coverage)

This gem follows semantic versioning. The important part of that being the API will not make breaking changes except for major version numbers. Please use released versions via RubyGems for production applications. Old versions do not have a maintenance plan. [See open issues](https://github.com/johnsonj/progressive_render/issues). Report any issues you have!

## Installation ##

Add this line to your application's Gemfile and run `bundle install`

```ruby
gem 'progressive_render'
```

Then add the following to your `application.js`:

```javascript
//= require progressive_render
```

If you plan on using the default placeholder, add this to your `application.css`:

```css
/*
 *= require progressive_render
 */
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

```erb
<%=progressive_render placeholder: 'shared/loading' do %>
	<h1>Content!</h1>
	<% sleep 5 %>
<% end %>
```

The placeholder defaults to rendering the partial `progressive_render/placeholder` so if you'd like to override it globally create the file `app/views/progressive_render/_placeholder.html.erb`. It will also work at the controller level, eg, `app/views/users/progresive_render/_placeholder.html.erb`

## Development ##

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rspec` to run the tests. There is a dummy application located in `spec/dummy/` that demonstrates a sample integration and can be used for interactive testing.

## CI Environment ##

Travis.ci is used to validate changes to the github project. The CI build runs the gem against multiple versions of rails/ruby. When making a change to any dependencies or the version number of the application, be sure to run `appraisal` to update the dependent Gemfile.locks.

## Contributing ##

Bug reports and pull requests are welcome on [GitHub](https://github.com/johnsonj/progressive_render). Any contribution should not decrease test coverage significantly. Please feel free to [reach out](johnsonjeff@gmail.com) if you have an issues contributing.

## License ##

[MIT License](http://opensource.org/licenses/MIT).
