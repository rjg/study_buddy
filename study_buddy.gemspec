# -*- encoding: utf-8 -*-
require File.expand_path('../lib/study_buddy/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ryan Golden"]
  gem.email         = ["ryan.john.golden@gmail.com"]
  gem.description   = %q{This gem allows you to easily make and take matching tests.}
  gem.summary       = %q{See the description.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "study_buddy"
  gem.require_paths = ["lib"]
  gem.version       = StudyBuddy::VERSION
end
