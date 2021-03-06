require 'progressive_render/rack'

require 'progressive_render/fragment_name_iterator'

# Root namespace for the gem
module ProgressiveRender
  if defined?(::Rails) && Gem::Requirement.new('>= 3.1').satisfied_by?(Gem::Version.new(::Rails.version))
    require 'progressive_render/rails'
  else
    logger.warn 'progressive_render gem has not been installed due to missing dependencies'
  end
end
