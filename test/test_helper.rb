require "test/unit"
require "cgi"
require "nokogiri"
require "action_controller"
require "mocha"

require "breadcrumbs"

I18n.load_path << File.dirname(__FILE__) + "/resources/pt.yml"
I18n.locale = :pt
