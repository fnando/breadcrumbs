# frozen_string_literal: true

require "simplecov"
SimpleCov.start

require "bundler/setup"
require "minitest/utils"
require "minitest/autorun"
require "cgi"
require "nokogiri"
require "action_controller"

require "breadcrumbs"

I18n.load_path << "#{File.dirname(__FILE__)}/support/pt-BR.yml"
I18n.locale = "pt-BR"
