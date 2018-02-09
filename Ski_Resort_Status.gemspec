# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'Ski_Resort_Status/version'

Gem::Specification.new do |spec|
  spec.name          = "Ski_Resort_Status"
  spec.version       = SkiResortStatus::VERSION
  spec.authors       = ["'antley chu'"]
  spec.email         = ["'antley.chu@gmail.com'"]

  spec.summary       = "Snow Resorts Status in the Canada & US - Scrapes OnTheSnow.com for snow fall and other details"
  spec.description   = "Snow Resorts Status in the Canada & US - Scrapes OnTheSnow.com for snow fall and other details"
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "nokogiri"
  spec.add_development_dependency "require_all"
  spec.add_development_dependency "open_uri_redirections"

end
