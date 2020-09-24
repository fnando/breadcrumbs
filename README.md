# Breadcrumbs

[![Travis-CI](https://travis-ci.org/fnando/breadcrumbs.svg)](https://travis-ci.org/fnando/breadcrumbs)
[![Code Climate](https://codeclimate.com/github/fnando/breadcrumbs/badges/gpa.svg)](https://codeclimate.com/github/fnando/breadcrumbs)
[![Gem](https://img.shields.io/gem/v/breadcrumbs.svg)](https://rubygems.org/gems/breadcrumbs)
[![Gem](https://img.shields.io/gem/dt/breadcrumbs.svg)](https://rubygems.org/gems/breadcrumbs)

Breadcrumbs is a simple plugin that adds a `breadcrumbs` object to controllers
and views.

## Instalation

Just run `gem install breadcrumbs`. Or add `gem "breadcrumbs"` to your Gemfile.

## Usage

On your controller (optional):

```ruby
class ApplicationController < ActionController::Base
  before_filter :add_initial_breadcrumbs

  private
  def add_initial_breadcrumbs
    breadcrumbs.add "Home", root_path
  end
end

class ThingsController < ApplicationController
  def index
    breadcrumbs.add "Things", things_path
  end
end
```

You don't need to provide an URL; in that case, a span will be generated instead
of a link:

```ruby
breadcrumbs.add "Some page"
```

You can set additional HTML attributes if you need to:

```ruby
breadcrumbs.add "Home", root_path, id: "home", title: "Go to the home page"
```

On your view (possibly application.html.erb):

```erb
<%= breadcrumbs.render %>
```

You can render as ordered list.

```erb
<%= breadcrumbs.render(format: :ordered_list) %>
```

You can render as inline links.

```erb
<%= breadcrumbs.render(format: :inline) %>
```

You can set your own separator:

```erb
<p>
  You are here: <%= breadcrumbs.render(format: :inline, separator: "|") %>
</p>
```

You can also define your own formatter. Just create a class that implements a
`render` instance method and you're good to go.

```ruby
class Breadcrumbs::Render::Dl
  def render
    # return breadcrumbs wrapped in a <dl> tag
  end
end
```

To use your new format, just provide the `:format` option.

```ruby
breadcrumbs.render(format: :dl)
```

### I18n

Breadcrumbs is integrated with I18n. You can set translations like:

```yaml
en:
  breadcrumbs:
    home: "Home"
```

And then you just call

```ruby
breadcrumbs.add :home
```

In fact, you can provide any scope you want.

```ruby
breadcrumbs.add :"titles.home"
```

If you don't want to translate a label, just pass the option `:i18n` as `false`.

```ruby
breadcrumbs.add :home, nil, i18n: false
```

## Maintainer

- Nando Vieira - http://nandovieira.com

## License

(The MIT License)

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the 'Software'), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
