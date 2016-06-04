# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/tunes/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-tunes'
  spec.version       = Fastlane::Tunes::VERSION
  spec.author        = %q{Boris Bügling}
  spec.email         = %q{boris@icculus.org}

  spec.summary       = %q{Play music using fastlane, because you can.}
  spec.homepage      = "https://github.com/neonichu/fastlane-tunes"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'fastlane', '>= 1.94.0'
end
