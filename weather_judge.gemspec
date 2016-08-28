# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'weather_judge/version'

Gem::Specification.new do |spec|
  spec.name          = "weather_judge"
  spec.version       = WeatherJudge::VERSION
  spec.authors       = ["Makoto Scott-Hinkle"]
  spec.email         = ["makoto@teamtreehouse.com"]

  spec.summary       = %q{Scores weather forecast on given coordinates.}
  spec.description   = %q{This gem gives a score to given coordinate's weather forecast. It uses Forecast.IO as data source.}
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
