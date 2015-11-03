# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bcome/version'
Gem::Specification.new do |spec|
  spec.name          = "bcome"
  spec.version       = Bcome::VERSION
  spec.authors       = ["Guillaume Roderick (Webzakimbo)"]
  spec.email         = ["guillaume@webzakimbo.com"]

  spec.summary       = %q{Toolkit for managing servers & organising the management of servers}
  spec.description   = %q{Provides a console interface for traversing a hierarchy of platforms -> environment -> servers, and exposes common administration tools for the managemenent either of individual servers, or groups or servers. System is driven from simple configuration, and is extensible. Integrates with AWS EC2 for dynamic network discovery.}
  spec.homepage      = "https://github.com/webzakimbo/bcome"
  spec.license       = "MIT"

  spec.files         =  Dir.glob("{bin,lib,filters,documentation,patches}/**/*")  #`git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) } #Dir.glob("{bin,lib}/**/*")
  spec.bindir        = "bin"
  spec.executables = ["bcome", "bcome-setup"]
  spec.require_paths = ["lib", "lib/stack"]
  spec.add_dependency 'aws-sdk', '~> 2'
  spec.add_dependency 'colorize', '0.7.7'
  spec.add_dependency 'net-scp', '~> 1.2', '>= 1.2.1'
  spec.add_dependency 'rsync', '~> 1.0'
  spec.add_dependency 'fog', '1.33.0'
end
