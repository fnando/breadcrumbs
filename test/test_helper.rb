require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require "bundler/setup"
require "minitest/utils"
require "minitest/autorun"
require "cgi"
require "nokogiri"
require "action_controller"
require "mocha/test_unit"

require "breadcrumbs"

I18n.load_path << File.dirname(__FILE__) + "/support/pt-BR.yml"
I18n.locale = "pt-BR"
