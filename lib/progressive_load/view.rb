require 'progressive_load/helpers'

module ProgressiveLoad
  module View
    include Helpers
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
  end
end