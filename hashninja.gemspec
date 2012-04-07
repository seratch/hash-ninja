# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "hash_ninja/version"

Gem::Specification.new do |s|
  s.name        = "hash-ninja"
  s.version     = HashNinja::VERSION
  s.authors     = ["Kazuhiro Sera"]
  s.email       = ["seratch@gmail.com"]
  s.homepage    = "https://github.com/seratch/hash-ninja"
  s.summary     = %q{Hash operations toolkit for Ruby Ninja}
  s.description = %q{Hash operations toolkit for Ruby Ninja}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "activesupport", ['>= 3.0.0']

end
