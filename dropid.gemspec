# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "dropid/version"

Gem::Specification.new do |s|
  s.name        = "prake"
  s.version     = Prake::VERSION
  s.authors     = ["Bill Chapman"]
  s.email       = ["wwchapman@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{ backgrounding and pid creation and monitoring for ruby processes}
  s.description = %q{ }

  s.rubyforge_project = "dropid"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "minitest"
  s.add_runtime_dependency "rake"
end
