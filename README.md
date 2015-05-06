[![Code Climate](https://codeclimate.com/github/matiasleidemer/simple_filter/badges/gpa.svg)](https://codeclimate.com/github/matiasleidemer/simple_filter) [![Build Status](https://travis-ci.org/matiasleidemer/simple_filter.svg)](https://travis-ci.org/matiasleidemer/simple_filter)

# SimpleFilter

SimpleFilter is a very simple ruby _DSL_ to write filter (or search) classes for ActiveRecord scopes. It's only responsability is to map parameters to defined scopes.

It currently works with ActiveRecord 4.0 or greater.

## Instalation

Unfortunetely there's already a gem called `simple_form`, but fear not, you only need to require the lib in your Gemfile:

```ruby
gem 'simple-form', require: 'simple_form'
```

## Usage

To use search classes is pretty straightforward:

```ruby
FooSearch.new(params = {}).scoping(Model.all).search
```

`params` should be a hash containing all the desired filters, and `scope` is the current model scope that the filters will be applied into, for example:

```ruby
class CampaignsController < ApplicationController
  def index
    @campaigns = CampaignSearcher.new(search_params).scoping(Campaign.all).search
  end

  private
  
  def search_params
    params.slice(:name, :category, :whatever)
  end
end
```

The `search` method returns an `ActiveRecord::Relation`, making it easy to chain other scopes or conditions when needed.

### Filter

Filter is the class method that creates a new filter (really?!). Here's a simple example:

```ruby
class FooSearch < SimpleFilter::Base
  filter :active
  
end

# Usage
FooSearch.new(active: true).scoping(Foo.all).search

# Which is the same as
Foo.all.active
```

You can apply whatever scope needed:

```ruby
FooSearch.new(active: true).scoping(current_user.posts).search
# => current_user.posts.active
```

You can also create a filter that calls the scope method with the parameter value using the option `value_param: true`

```ruby
class FooSearch < SimpleFilter::Base
  filter :active
  filter :by_name, value_param: true
end

FooSearch.new(by_name: 'Matias').scoping(Foo.all).search
# => Foo.all.by_name('Matias')

FooSearch.new(by_name: 'Matias', active: true).scoping(Foo.all).search
# => Foo.all.active.by_name('Matias')
```

Of course you have to define those scopes in your ActiveRecord model:

```ruby
class Foo < ActiceRecord::Base
  scope :active, -> { where active: true }
  scope :by_name, -> (name) { where 'name like ?', "%#{name}%" }
end
```

### Custom filters

Lastly, you can create fully customized filters. Let's say you want to apply a specific filter only when some condition is true

```ruby
class FooSearch < SimpleFilter::Base
  filter :active
  filter :name, value_param: true
  filter :within_period
  
  def within_period
    return unless date_range?
    
    scope.where('start_at >= ? and end_at <= ?', params[:start_at], params[:end_at])
  end
    
  private
  
  def date_range?
    params[:start_at].present? && params[:end_at].present?
  end
end

FooSearch.new(start_at: '2015-05-08', end_at: '2015-05-31').scoping(Foo.all).search
```

Note that in the example above I'm using `params` and `scope` attributes. You can use it the create custom conditions and validation for your filters. It's important that your custom filters always return a `ActiveRecord::Relation` object, since it will chain it with the other filters.

It's also possible to call `super` when you define your custom filters, this happens because of the way filters are defined in the `SimpleFilter::Base` class.


```ruby
class FooSearch < SimpleFilter::Base
  filter :active
  
  def active
    super.where 'some other condition'
  end
end
```

## Todo

- Ordering
- Pagination

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/matiasleidemer/simple_filter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
