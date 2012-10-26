# -*- encoding: utf-8 -*-
require File.join(File.dirname(__FILE__), 'lib', 'okubo', 'version')

Gem::Specification.new do |gem|
  gem.authors       = ["Robert Gravina"]
  gem.email         = ["robert.gravina@gmail.com"]
  gem.description   = %q{Okubo - a simple spaced-repetition system for Active Record models.}
  gem.summary       = %q{Okubo is a simple spaced-repetition system for learning items, such as words and definitions in a foreign language, which you supply as Active Record models.}
  gem.homepage      = "https://github.com/rgravina/okubo"
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "okubo"
  gem.require_paths = ["lib"]
  gem.version       = Okubo::VERSION

  gem.add_development_dependency 'activerecord'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rdoc'
  gem.add_development_dependency 'sqlite3'
  
  gem.require_path = 'lib'
  gem.files = %w(README.md Rakefile) + Dir.glob("{lib,spec}/**/*")
end
