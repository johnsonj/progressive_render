require 'progressive_render/rack'

require 'progressive_render/fragment_name_iterator'

module ProgressiveRender
  if defined?(::Rails) && Gem::Requirement.new('>= 3.1').satisfied_by?(Gem::Version.new(::Rails.version))
    require 'progressive_render/rails'
  else
    logger.warn 'WARNING: ProgressiveRender has not been installed due to missing dependencies'
  end
end
