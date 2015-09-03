# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'progressive_render/version'

Gem::Specification.new do |spec|
  spec.name          = "progressive_render"
  spec.version       = ProgressiveRender::VERSION
  spec.authors       = ["Jeff Johnson"]
  spec.email         = ["johnsonjeff@gmail.com"]

  spec.summary       = %q{Progressively load static or dynamic content on page load}
  spec.description   = %q{For large or expensive pages, use this gem to load less critical portions of the page. Especially useful for large queries or content that's hidden from the user on load. The best solution may be to optimize your content, but there's not always time for that.}
  spec.homepage      = "https://github.com/johnsonj/progressive_render"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rails", "4.2.2"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "codeclimate-test-reporter"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "pry-byebug"

  spec.add_dependency "sass-rails"
  spec.add_dependency "uglifier"
  spec.add_dependency "coffee-rails"
  spec.add_dependency "railties"
  spec.add_dependency "jquery-rails"
  spec.add_dependency "rails"
end
