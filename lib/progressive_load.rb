require "progressive_load/version"

# TODO: Extend ActionController, it's too clunky to have to include it everywhere
module ProgressiveLoad
  if defined?(::Rails) and Gem::Requirement.new('>= 3.1').satisfied_by?(Gem::Version.new ::Rails.version)
    module Rails
      class Engine < ::Rails::Engine
        initializer "progressive_load.assets.precompile" do |app|
          app.config.assets.precompile += %w( progressive_load.gif progressive_load.js.coffee progressive_load.css.scss )
        end
      end
    end
  end

  def self.included(base)
    # Register helpers?
  end

  #
  # Use when the content we're progressive loading can be cached. 
  # If the content is in the cache, we will skip the progressive render
  #
  # TODO: Make a single render interface that can be cached or not 
  def render_cached_progressive_partial(name, path, keys={}, cache_options={})
    progressive_load_content(name, is_main_load?) do
      cache_key = [name, path, keys] 
      cached = Rails.cache.read(cache_key)

      # It's already in the store so send it without progressive loading
      return render inline: cached.html_safe if cached

      if is_main_load? 
        render partial: 'progressive_load/placeholder'
      elsif is_loading_this_partial?(name)
        content = (render_to_string partial: path).html_safe
        Rails.cache.write(cache_key, content, cache_options)
        render inline: content
      else
        render text: ""
      end
    end
  end

  # TODO: Name can't seem to handle / in the path. Likely remove this interface anyways.
  def render_progressive_partial(name, path=nil, options={})
    path = name if path.nil?
    progressive_load_content(name, is_main_load?) do
      if is_main_load?
        render partial: 'progressive_load/placeholder'
      elsif is_loading_this_partial?(name)
        render ({partial: path}).merge(options)
      else
        # Another progressive partial on this page but not the one we've been asked to render
        render text: ""
      end
    end
  end

 def progressive_render(template)
    if is_main_load?
      render template
    else
      content = render_to_string template: template, layout: false
      stripped = Nokogiri::HTML(content).at_css("div##{params[:load_partial]}_progressive_load")
      render text: stripped
    end
  end

  private
  def progressive_load_content(name, placeholder=true)
    content_tag(:div, id: "#{name}_progressive_load", data: {progressive_load_placeholder: placeholder, progressive_load_path: progressive_load_path(request, name)}) do
      yield
    end
  end

  def progressive_load_path(req, name)
    # Append the param to the URL. Nasty I know.
    req.fullpath + "#{req.fullpath.include?('?') ? '&' : '?'}load_partial=#{name}" 
  end

  def is_main_load?
    !is_progressive_load?
  end

  def is_progressive_load?
    params[:load_partial]
  end

  def is_loading_this_partial?(name)
    params[:load_partial] == name
  end
end
