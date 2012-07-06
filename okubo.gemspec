# -*- encoding: utf-8 -*-
require File.expand_path('../lib/okubo/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Robert Gravina"]
  gem.email         = ["robert@gravina.com"]
  gem.description   = %q{Okubo - a simple spaced-repetition gem.}
  gem.summary       = %q{Okubo is a simple spaced-repetition gem for learning words and definitions in a foreign language.}
  gem.homepage      = ""
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "okubo"
  gem.require_paths = ["lib"]
  gem.version       = Okubo::VERSION
end
