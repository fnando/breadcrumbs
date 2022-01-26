# frozen_string_literal: true

require "test_helper"

class BreadcrumbsTest < Minitest::Test
  def setup
    @breadcrumbs = Breadcrumbs.new
    @inline = Breadcrumbs::Render::Inline.new(@breadcrumbs)
  end

  test "returns safe html" do
    assert @breadcrumbs.render(format: "list").html_safe?
  end

  test "adds item" do
    @breadcrumbs.add "Home"
    assert_equal 1, @breadcrumbs.items.count

    @breadcrumbs << "Home"
    assert_equal 2, @breadcrumbs.items.count
  end

  test "renders tag with attributes" do
    expected = %[<span class="greetings" id="hi">Hi!</span>]
    assert_equal expected,
                 @inline.tag(:span, "Hi!", class: "greetings", id: "hi")
  end

  test "renders tag with block" do
    assert_equal "<span>Hi!</span>", @inline.tag(:span) { "Hi!" }
  end

  test "renders tag with block and attributes" do
    expected = %[<span class="greetings" id="hi">Hi!</span>]
    assert_equal expected,
                 @inline.tag(:span, class: "greetings", id: "hi") { "Hi!" }
  end

  test "renders nested tags" do
    expected = %[<span class="greetings"><strong id="hi">Hi!</strong></span>]
    actual = @inline.tag(:span, class: "greetings") do
      @inline.tag(:strong, "Hi!", id: "hi")
    end

    assert_equal expected, actual
  end

  test "renders as list" do
    @breadcrumbs.add "Home", "/", class: "home"
    html = Nokogiri::HTML(@breadcrumbs.render)

    refute_nil html.at("ul.breadcrumbs")
    assert_nil html.at("ul.breadcrumbs[format=list]")
  end

  test "renders as ordered list" do
    @breadcrumbs.add "Home", "/"
    html = Nokogiri::HTML(@breadcrumbs.render(format: "ordered_list"))

    refute_nil html.at("ol.breadcrumbs")
  end

  test "renders as list with custom attributes" do
    @breadcrumbs.add "Home", "/", class: "home"
    html = Nokogiri::HTML(@breadcrumbs.render(id: "breadcrumbs", class: "top"))

    refute_nil html.at("ul.top#breadcrumbs")
  end

  test "renders as list add items" do
    @breadcrumbs.add "Home", "/", class: "home"
    @breadcrumbs.add "About", "/about", class: "about"
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
    refute_nil items[2].at("span")
  end

  test "renders inline" do
    @breadcrumbs.add "Home", "/", class: "home"
    html = Nokogiri::HTML(@breadcrumbs.render(format: "inline"))

    assert_nil html.at("ul.breadcrumbs")
  end

  test "renders inline add items" do
    @breadcrumbs.add "Home", "/", class: "home"
    @breadcrumbs.add "About", "/about", class: "about"
    @breadcrumbs.add "People"

    html = @breadcrumbs.render(format: "inline")
    html = Nokogiri::HTML("<div>#{html}</div>")
    separator = "&#187;"

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

  test "renders inline with custom separator" do
    @breadcrumbs.add "Home", "/", class: "home"
    @breadcrumbs.add "People"

    html = Nokogiri::HTML(@breadcrumbs.render(format: "inline", separator: "|"))

    assert_equal "|", html.at("span.separator").inner_text
  end

  test "renders original text when disabling_translation" do
    @breadcrumbs.add :home, nil, i18n: false
    @breadcrumbs.add :people

    html = Nokogiri::HTML(@breadcrumbs.render)

    items = html.search("li")

    assert_equal "home", items[0].inner_text
    assert_equal "Nosso time", items[1].inner_text
  end

  test "renders internationalized text using default scope" do
    @breadcrumbs.add :home
    @breadcrumbs.add :people

    html = Nokogiri::HTML(@breadcrumbs.render)

    items = html.search("li")

    assert_equal "Página inicial", items[0].inner_text
    assert_equal "Nosso time", items[1].inner_text
  end

  test "renders scope as text for missing scope" do
    @breadcrumbs.add :contact
    @breadcrumbs.add "Help"

    html = Nokogiri::HTML(@breadcrumbs.render)
    items = html.search("li")

    assert_equal "contact", items[0].inner_text
    assert_equal "Help", items[1].inner_text
  end

  test "extends action controller" do
    methods = ActionController::Base.instance_methods
    assert(methods.include?(:breadcrumbs) || methods.include?("breadcrumbs"))
  end

  test "escapes text when rendering inline" do
    @breadcrumbs.add "<script>alert(1)</script>"
    html = Nokogiri::HTML(@breadcrumbs.render(format: "inline"))

    assert_empty html.search("script")
  end

  test "escapes text when rendering list" do
    @breadcrumbs.add "<script>alert(1)</script>"
    html = Nokogiri::HTML(@breadcrumbs.render)

    assert_empty html.search("script")
  end
end
