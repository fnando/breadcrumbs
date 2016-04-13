# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "breadcrumbs/version"

Gem::Specification.new do |s|
  s.name        = "breadcrumbs"
  s.version     = Breadcrumbs::Version::STRING
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nando Vieira"]
  s.email       = ["fnando.vieira@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/breadcrumbs"
  s.summary     = "Breadcrumbs is a simple plugin that adds a `breadcrumbs` object to controllers and views."
  s.description = s.summary

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "i18n"

  s.add_development_dependency "nokogiri"
  s.add_development_dependency "actionpack"
  s.add_development_dependency "mocha"
  s.add_development_dependency "rake"
  s.add_development_dependency "bundler"
  s.add_development_dependency "minitest-utils"
end
