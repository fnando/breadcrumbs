require "rubygems"
gem "test-unit"
gem "actionpack", ENV['RAILS3'] ? '~> 3.0.0' : '~> 2.3.0'

require "test/unit"
require "cgi"
require "nokogiri"
require "action_pack"
require "action_controller"
require "action_controller/test_case"
require "mocha"

require "breadcrumbs"

I18n.load_path << File.dirname(__FILE__) + "/resources/pt.yml"
I18n.locale = :pt

class TestsController < ActionController::Base
end

if ActionPack::VERSION::MAJOR == 3
  routes = ActionDispatch::Routing::RouteSet.new
  routes.draw do
    resources :tests
  end
  TestsController.send(:include, routes.url_helpers)
else
  ActionController::Routing::Routes.draw do |map|
    map.resources :tests
  end
end
