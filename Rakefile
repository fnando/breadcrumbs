require "jeweler"
require "rake/testtask"
require "rake/rdoctask"
require "lib/breadcrumbs/version"

task :default => :test

Rake::TestTask.new do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
end

Rake::RDocTask.new do |rdoc|
  rdoc.main = "README.rdoc"
  rdoc.rdoc_dir = "doc"
  rdoc.title = "Breadcrumbs"
  rdoc.options += %w[ --line-numbers --inline-source --charset utf-8 ]
  rdoc.rdoc_files.include("README.rdoc")
  rdoc.rdoc_files.include("lib/**/*.rb")
end

JEWEL = Jeweler::Tasks.new do |gem|
  gem.name = "breadcrumbs"
  gem.email = "fnando.vieira@gmail.com"
  gem.homepage = "http://github.com/fnando/breadcrumbs"
  gem.authors = ["Nando Vieira"]
  gem.version = Breadcrumbs::Version::STRING
  gem.summary = "Breadcrumbs is a simple plugin that adds a `breadcrumbs` object to controllers and views."
  gem.description = "Breadcrumbs is a simple plugin that adds a `breadcrumbs` object to controllers and views."
  gem.files =  FileList["README.rdoc", "{lib,test}/**/*"]
end

Jeweler::GemcutterTasks.new