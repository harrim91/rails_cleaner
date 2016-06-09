# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_cleaner/version'

Gem::Specification.new do |spec|
  spec.name          = "rails_cleaner"
  spec.version       = RailsCleaner::VERSION
  spec.authors       = ["Michael Harrison", "Joseph Chin", "Elia Bardashevich", "Jack Hardy"]
  spec.email         = ["harrim91@hotmail.co.uk"]

  spec.summary       = %q{Cleans up unused auto-generated rails templates}
  spec.description   = %q{Cleans up unused auto-generated rails templates}
  spec.homepage      = "https://github.com/harrim91/rails_cleaner"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = ["rails_cleaner_init","rails_cleaner_track","rails_cleaner_sort","rails_cleaner_delete"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_runtime_dependency "colorize"
end
