# -*- encoding: utf-8 -*-
require "test_helper"

class BreadcrumbsTest < Test::Unit::TestCase
  def setup
    @breadcrumbs = Breadcrumbs.new
    @inline = Breadcrumbs::Render::Inline.new(@breadcrumbs)
  end

  def test_return_safe_html
    html_mock = mock
    html_mock.expects(:html_safe).once
    Breadcrumbs::Render::List.any_instance.stubs(:render).returns(html_mock)
    @breadcrumbs.render(:format => :list)
  end

  def test_add_item
    @breadcrumbs.add "Home"
    assert_equal 1, @breadcrumbs.items.count

    @breadcrumbs << "Home"
    assert_equal 2, @breadcrumbs.items.count
  end

  def test_tag
    assert_equal "<span>Hi!</span>", @inline.tag(:span, "Hi!")
  end

  def test_tag_with_attributes
    expected = %[<span class="greetings" id="hi">Hi!</span>]
    assert_equal expected, @inline.tag(:span, "Hi!", :class => "greetings", :id => "hi")
  end

  def test_tag_with_block
    assert_equal "<span>Hi!</span>", @inline.tag(:span) { "Hi!" }
  end

  def test_tag_with_block_and_attributes
    expected = %[<span class="greetings" id="hi">Hi!</span>]
    assert_equal expected, @inline.tag(:span, :class => "greetings", :id => "hi") { "Hi!" }
  end

  def test_nested_tags
    expected = %[<span class="greetings"><strong id="hi">Hi!</strong></span>]
    actual = @inline.tag(:span, :class => "greetings") { tag(:strong, "Hi!", :id => "hi") }
    assert_equal expected, actual
  end

  def test_render_as_list
    @breadcrumbs.add "Home", "/", :class => "home"
    html = Nokogiri::HTML(@breadcrumbs.render)

    assert_not_nil html.at("ul.breadcrumbs")
    assert_nil html.at("ul.breadcrumbs[format=list]")
  end

  def test_render_as_ordered_list
    @breadcrumbs.add "Home", "/"
    html = Nokogiri::HTML(@breadcrumbs.render(:format => :ordered_list))

    assert_not_nil html.at("ol.breadcrumbs")
  end

  def test_render_as_list_with_custom_attributes
    @breadcrumbs.add "Home", "/", :class => "home"
    html = Nokogiri::HTML(@breadcrumbs.render(:id => "breadcrumbs", :class => "top"))

    assert_not_nil html.at("ul.top#breadcrumbs")
  end

  def test_render_as_list_add_items
    @breadcrumbs.add "Home", "/", :class => "home"
    @breadcrumbs.add "About", "/about", :class => "about"
    @breadcrumbs.add "People"

    html = Nokogiri::HTML(@breadcrumbs.render)
    items = html.search("li")

    assert_equal 3, items.count

    assert_equal "first item-0", items[0]["class"]
    assert_equal "Home", items[0].inner_text

    link = items[0].at("a")
    assert_equal "home", link["class"]
    assert_equal "/", link["href"]

    assert_equal "item-1", items[1]["class"]
    assert_equal "About", items[1].inner_text

    link = items[1].at("a")
    assert_equal "about", link["class"]
    assert_equal "/about", link["href"]

    assert_equal "last item-2", items[2]["class"]
    assert_equal "People", items[2].inner_text
    assert_nil items[2].at("a")
    assert_not_nil items[2].at("span")
  end

  def test_render_inline
    @breadcrumbs.add "Home", "/", :class => "home"
    html = Nokogiri::HTML(@breadcrumbs.render(:format => :inline))

    assert_nil html.at("ul.breadcrumbs")
  end

  def test_render_inline_add_items
    @breadcrumbs.add "Home", "/", :class => "home"
    @breadcrumbs.add "About", "/about", :class => "about"
    @breadcrumbs.add "People"

    html = @breadcrumbs.render(:format => :inline)
    html = Nokogiri::HTML("<div>#{html}</div>")
    separator = Nokogiri::HTML("<span>&#187;</span>").at("span").inner_text

    items = html.search("div *")

    assert_equal 5, items.count

    assert_equal "a", items[0].name
    assert_equal "home first item-0", items[0]["class"]
    assert_equal "Home", items[0].inner_text
    assert_equal "/", items[0]["href"]

    assert_equal "span", items[1].name
    assert_equal "separator", items[1]["class"]
    assert_equal separator, items[1].inner_text

    assert_equal "a", items[2].name
    assert_equal "about item-1", items[2]["class"]
    assert_equal "About", items[2].inner_text
    assert_equal "/about", items[2]["href"]

    assert_equal "span", items[3].name
    assert_equal "separator", items[3]["class"]
    assert_equal separator, items[3].inner_text

    assert_equal "span", items[4].name
    assert_equal "last item-2", items[4]["class"]
    assert_equal "People", items[4].inner_text
  end

  def test_render_inline_with_custom_separator
    @breadcrumbs.add "Home", "/", :class => "home"
    @breadcrumbs.add "People"

    html = Nokogiri::HTML(@breadcrumbs.render(:format => :inline, :separator => "|"))

    assert_equal "|", html.at("span.separator").inner_text
  end

  def test_render_original_text_when_disabling_translation
    @breadcrumbs.add :home, nil, :i18n => false
    @breadcrumbs.add :people

    html = Nokogiri::HTML(@breadcrumbs.render)

    items = html.search("li")

    assert_equal "home", items[0].inner_text
    assert_equal "Nosso time", items[1].inner_text
  end

  def test_render_internationalized_text_using_default_scope
    @breadcrumbs.add :home
    @breadcrumbs.add :people

    html = Nokogiri::HTML(@breadcrumbs.render)

    items = html.search("li")

    assert_equal "Página inicial", items[0].inner_text
    assert_equal "Nosso time", items[1].inner_text
  end

  def test_render_scope_as_text_for_missing_scope
    @breadcrumbs.add :contact
    @breadcrumbs.add "Help"

    html = Nokogiri::HTML(@breadcrumbs.render)

    items = html.search("li")

    assert_equal "contact", items[0].inner_text
    assert_equal "Help", items[1].inner_text
  end

  def test_pimp_action_controller
    methods = ActionController::Base.instance_methods
    assert (methods.include?(:breadcrumbs) || methods.include?("breadcrumbs"))
  end

  def test_escape_text_when_rendering_inline
    @breadcrumbs.add "<script>alert(1)</script>"
    html = @breadcrumbs.render(:format => :inline)

    assert_equal %[<span class="first last item-0">&lt;script&gt;alert(1)&lt;/script&gt;</span>], html
  end

  def test_escape_text_when_rendering_list
    @breadcrumbs.add "<script>alert(1)</script>"
    html = @breadcrumbs.render

    assert_match /&lt;script&gt;alert\(1\)&lt;\/script&gt;/, html
  end
end
