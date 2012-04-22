# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sharer/version"

Gem::Specification.new do |s|
  s.name        = "sharer"
  s.version     = Sharer::VERSION
  s.authors     = ["Adam Martinik"]
  s.email       = ["a.martinik@seznam.cz"]
  s.homepage    = ""
  s.summary     = %q{}
  s.description = %q{If your application needs to count the number of shared, this gem can help you.}

  s.rubyforge_project = "sharer"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
end
