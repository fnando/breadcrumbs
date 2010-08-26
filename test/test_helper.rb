require "rubygems"
gem "test-unit"
require "test/unit"
require "cgi"
require "nokogiri"
require "action_controller"
require "action_controller/test_case"
require "mocha"

require "breadcrumbs"

I18n.load_path << File.dirname(__FILE__) + "/resources/pt.yml"
I18n.locale = :pt

class TestController < ActionController::Base

  def resources_url(*args)
    '/resources'
  end

end
