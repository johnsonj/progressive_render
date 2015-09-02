# PathResolver (Rails Specific) #
Status: Implemented

Resolves the full path for views/partials. Might want to give it a RequestHandler.

## Basic Syntax ##
```ruby
dtp = PathResolver.new(template_context)
dtp.path_for('')
```

## TemplateContext ##
    controller:string
    action:string
    type: :view, :controller

## Examples ##
For the Foo controller inside of the view
```ruby
dtp = PathResolver.new(controller: Foo, action: :index, type: :view)
dtp.path_for('table') == foo/_table
dtp.path_for('shared/dialogs/bar') == shared/dialogs/bar (Or should it also search foo/shared/..?)
dtp.path_for('') == InvalidPath_forException
```

For the Foo controler inside of the controller
```ruby
dtp = PathResolver.new(controller: Foo, action: :index, type: :controller)
dtp.path_for('') == foo/index
dtp.path_for('bar') == foo/bar
```

# ViewRenderer (Rails Specific) #
Status: TODO

Renders a partial to a string? Maybe. Controller vs. View may need seperate view renderers because controller needs to output the stream. Is there a difference between ActionController.render and ActionView.render?

## Basic Syntax ##
```ruby
rt = ViewRenderer.new
rt.render(full_path) # normal render
rt.render_text(content) # render plain text (or safe HTML)
rt.render_inline(content) # is this needed?
```

# RequestHandler (Rack Specific) #
Status: Implemented

Parses the request object to determine if this is the main load of the app and if not, what partial view is being requested

## Basic Syntax ##
```ruby
rh = RequestHandler.new(request)
rh.is_main_load?
rh.fragment_name
rh.load_path(fragment_name)
rh.should_render_partial?(fragment_name)
```

# RailsBuilder #
Status: TODO

Takes all necessary context and gives access to the ProgressiveRenderer

## Basic Syntax ##
```ruby
rb = RailsBuilder.new(request)
rb.view_renderer => ProgressiveRenderer
rb.controller_renderer => ProgressiveRenderer
```

# ProgresiveRenderer #
Status: TODO. Currently handled by ProgressiveLoad::Controller/View/Helpers

Applies all policies to provide a simple render interface. 

Can we get around the partial_renderer field? It determines if it should render placeholders in place of the view passed into it. 

## Basic Syntax ##
```ruby
pr = ProgressiveRenderer.new(request_handler, view_renderer, path_resolver, partial_renderer:bool)
pr.render(partial_name, &block=nil)
```

# RailsInstaller #
Status: TODO. Currently handled by ProgressiveLoad

Installs the view/controller renderer into ActionView/ActionController

## Basic Syntax ##
```ruby
RailsInstaller.mount_initializer
# Or?
RailsInstaller.mount_initializer(app)
```


# Structure #
lib/
  progressive_load.rb (version)
  rails/
    rails.rb
    installer.rb
    builder.rb
    view_renderer.rb
    path_resolver.rb
  rack/
    request_handler.rb
  progressive_renderer.rb