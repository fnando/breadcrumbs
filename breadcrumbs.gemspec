# frozen_string_literal: true

require "./lib/breadcrumbs/version"

Gem::Specification.new do |s|
  s.name        = "breadcrumbs"
  s.version     = Breadcrumbs::Version::STRING
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nando Vieira"]
  s.email       = ["fnando.vieira@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/breadcrumbs"
  s.summary     = "Breadcrumbs is a simple plugin that adds a `breadcrumbs` " \
                  "object to controllers and views."
  s.description = s.summary
  s.required_ruby_version = Gem::Requirement.new(">= 2.7.0")

  github_url = "https://github.com/fnando/breadcrumbs"
  github_tree_url = "#{github_url}/tree/v#{s.version}"

  s.metadata["homepage_uri"] = s.homepage
  s.metadata["bug_tracker_uri"] = "#{github_url}/issues"
  s.metadata["source_code_uri"] = github_tree_url
  s.metadata["changelog_uri"] = "#{github_tree_url}/CHANGELOG.md"
  s.metadata["documentation_uri"] = "#{github_tree_url}/README.md"
  s.metadata["license_uri"] = "#{github_tree_url}/LICENSE.md"
  s.metadata["rubygems_mfa_required"] = "true"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`
                    .split("\n")
                    .map {|f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "actionview"
  s.add_dependency "activesupport"
  s.add_dependency "i18n"

  s.add_development_dependency "actionpack"
  s.add_development_dependency "bundler"
  s.add_development_dependency "minitest-utils"
  s.add_development_dependency "mocha"
  s.add_development_dependency "nokogiri"
  s.add_development_dependency "pry-meta"
  s.add_development_dependency "rake"
  s.add_development_dependency "rubocop"
  s.add_development_dependency "rubocop-fnando"
  s.add_development_dependency "simplecov"
end
