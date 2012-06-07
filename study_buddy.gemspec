# -*- encoding: utf-8 -*-
require File.expand_path('../lib/study_buddy/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ryan Golden"]
  gem.email         = ["ryan.john.golden@gmail.com"]
  gem.description   = %q{Description ADD MORE LATER}
  gem.summary       = %q{Add more later}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "study_buddy"
  gem.require_paths = ["lib"]
  gem.version       = StudyBuddy::VERSION
end
