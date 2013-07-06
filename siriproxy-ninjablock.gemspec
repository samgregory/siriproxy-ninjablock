# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "siriproxy-ninjablock"
  s.version     = "0.0.1" 
  s.authors     = ["samgregory"]
  s.email       = ["sam.gregory@exemail.com.au"]
  s.homepage    = "http://www.ninjablocks.com/"
  s.summary     = %q{A Ninja Block Siri Proxy Plugin}
  s.description = %q{This plugin uses the Ninja Block ruby API to access the cloud. It is designed to be extended to other interface with people's devices. }

  s.rubyforge_project = "siriproxy-ninjablock"

  s.files         = `git ls-files 2> /dev/null`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/* 2> /dev/null`.split("\n")
  s.executables   = `git ls-files -- bin/* 2> /dev/null`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_dependency "ninja_blocks"
  s.add_dependency "addressable"	

end
